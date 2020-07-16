Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352EEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F333F206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="r+Tt0UN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F333F206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw591-0006nK-86
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jw57u-0005sX-Nn; Thu, 16 Jul 2020 10:44:46 -0400
Received: from mail-eopbgr50099.outbound.protection.outlook.com
 ([40.107.5.99]:34467 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jw57s-00006L-0J; Thu, 16 Jul 2020 10:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5+NCSjZKln2T7v36ntWcDA4UvslGrP9S+2lQrGioBKY5lj9G1kuU+ewrNbBJuClgPY9hyW5lmNtzh2o44M6G2f1ZsoJphrXTOoUDWa0jdR1Bols3/Kvo/p/rGgMc7e5I44YDwx6JKtSp0QRJ9yh3FEwgZqelB1bJiI4w94WHskMAPatMlhvrmJOYLXt51B7XS0cfBJO52UBfwngXvTsvEdr0PdbfbrMMcuhA8juNuo7owEn3GEutNMlO9P8YjAPl4N8SlgGT8coxm8GDr2ALyB3SmHXl/xw6HHpsAsds3ZSsBI8DPcgOqIL2Waoy5dU4RwlxNq9LMqt7pmAi7/0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5EPZp9Q3CwLayvSP8bCaN15Y0ejliw7d/Qnh+Inj8g=;
 b=nUD3B9xxXfpppjgNIVTdeKTGxYrkIhNMrd+LzaFXbbw7zHVbrtk4AfwydJFTOcowuKYs7YwwS4U1MlSVzTpXjZXydv7D9NJf+ZfmOQ8r9E1G702vp1pSn1xu7nH91zGhkwPS/qHG/Dcb0alZVdo4IB5B9RpxE/UDLbB+c8cEEaZwusMfSsm1P5vJ/y9CBUPUE5c1Xe+4Wa9xgOIORB/PRZqk632VVxyC4Kv7BWst8BwyxcOxKTBi9cQMHNjbnHD7puLL2MS0K2zc2VKKJkWbFbaVyhe6RYBai8WqoQY7U9h/i+95vWis77HzOohfvLy8V8XnRrBN0c0KnEEc4dFQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5EPZp9Q3CwLayvSP8bCaN15Y0ejliw7d/Qnh+Inj8g=;
 b=r+Tt0UN+sl8nXfShq5hgoK9QHVT3NJOqkPD/vjRjxpPF3905DkpLymBX28buVJn82w+M0fZdIP5wlkJbYBJQcqNoUxUcM5Pvb8s/Y95dFSjDvFeyYVDlR9LUEIComGY9Ls7zm5ju2B+8ZDJgf1xro6PiahlhViOoi44HxnWgDv4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4916.eurprd08.prod.outlook.com (2603:10a6:20b:ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Thu, 16 Jul
 2020 14:44:40 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 14:44:40 +0000
Subject: Re: [PATCH v10 08/10] qcow2.py: Introduce '-j' key to dump in JSON
 format
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-9-git-send-email-andrey.shinkevich@virtuozzo.com>
 <761829e6-ba9c-c8c0-8f37-976e37fcb6d0@virtuozzo.com>
 <9377dc3f-002f-6761-bb81-17a17cfafb08@virtuozzo.com>
 <c538f45c-8c00-7f60-c92e-7cc60c128376@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <5b661e9c-ec9b-441e-1e64-dc664ddaba17@virtuozzo.com>
Date: Thu, 16 Jul 2020 17:44:37 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <c538f45c-8c00-7f60-c92e-7cc60c128376@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:205:1::47) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR07CA0034.eurprd07.prod.outlook.com (2603:10a6:205:1::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.13 via Frontend Transport; Thu, 16 Jul 2020 14:44:39 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cc69956-4240-4562-b22d-08d82996c537
X-MS-TrafficTypeDiagnostic: AM6PR08MB4916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4916C0AC6557EA660237B278F47F0@AM6PR08MB4916.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zoo0tKf/dDwrIm1ER26O6F4xlep2ftNin4fGRfVoxjjJVAky5niRl9jhmaBeY6DKMTd5KOCL3imulL6kqY9Lu/VQLPASrkQ8LcOiISTkcdmKOgqL4DC7adq9fqujnNI1KU9jXx+lKplgAv8Oe0HS1Er9Rqu+Nouzqt2SDNaWOJPMNIeyIXuH9qEUYchaeQks03Wiu14qC0AExoJK/ypcDLqDQGdadJaIyZW1tEvdQcNIKRhVAJ6JPVTThNagrywwlmHF0R4a8id5sfBCs6FK8BAyKs77QKdIGQfLpfBPRN3WdIqYnFaDpFe7oSbzM2Cw8K+PWUyFR6gbrFao4UA+iy7SWvu8xJ70/N8qjvdUntXULprzGeqN0V8TmxitJB++
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(36756003)(107886003)(2906002)(2616005)(44832011)(956004)(52116002)(5660300002)(66946007)(66556008)(66476007)(31686004)(6512007)(6506007)(53546011)(83380400001)(26005)(16526019)(186003)(86362001)(31696002)(4326008)(8676002)(6486002)(8936002)(498600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LkdzFgilMePALzTL3+VRkHQfYs17wK9xwtvKEZVfJRJB8UoAUyv1G2Cs2lJ/Vgff1Q59r+wkJqiOo6jAQ9DX0E6h/v7lYqxPnHQBspM5OaD7chnhM+Nj3YMXMMU9vtGl53UYOG00fG5sbbduYey3L7I2uLU4XAKzrqXvyx/G0gfYBskXwI11nzo9AoI6f3KXCXQnd6mZUqz3O4+C7A6vKp4PlDGUKlQpbegL/pRhgPNtNwq4hndHnzqcP4Z9XlW7yuzyqJsjl88NlMODnQzQE4Cszjz+17TXQSW+/49okkmoXJwoFyvScl35oDSZBPRAqAr2S/58aVoMZOxFEATcB1r1W2c2cF+HKiH5v/BYGdMVwRS3Shuub2IQzqSDboX9pCm+WKA6aoqrK1Q+51dUkIqf4RPMTJ5sHka7l/vZuhEW8PQd30gUnYpxZV8BYQza6xX+OA7vl51O4BBkglYl7obFPEoSKBa1zrlXIDPU/aSKDpCkXluniCcQZpDaxHuU
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc69956-4240-4562-b22d-08d82996c537
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 14:44:40.5698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUYDwsTBlPuSxcvjrX9Z4rhV5egxQnaNU4kSuWyOQhMgOsm6XdLbdAY+cJgHTLysn0Z32meE7+yZkwBpU8JGaBLM51LJevI8GGrb0u8hCUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4916
Received-SPF: pass client-ip=40.107.5.99;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 10:44:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16.07.2020 17:38, Vladimir Sementsov-Ogievskiy wrote:
> 16.07.2020 17:36, Andrey Shinkevich wrote:
>> On 16.07.2020 13:20, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.07.2020 00:36, Andrey Shinkevich wrote:
>>>> Add the command key to the qcow2.py arguments list to dump QCOW2
>>>> metadata in JSON format. Here is the suggested way to do that. The
>>>> implementation of the dump in JSON format is in the patch that 
>>>> follows.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>   tests/qemu-iotests/qcow2.py        | 19 +++++++++++++++----
>>>>   tests/qemu-iotests/qcow2_format.py | 16 ++++++++--------
>>>>   2 files changed, 23 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
>>>> index 0910e6a..7402279 100755
>> ...
>>>> @@ -134,6 +137,11 @@ cmds = [
>>>>       def main(filename, cmd, args):
>>>> +    global dump_json
>>>> +    dump_json = '-j' in sys.argv
>>>> +    if dump_json:
>>>> +        sys.argv.remove('-j')
>>>> +        args.remove('-j')
>>>
>>> I'd prefer to access sys.argv in one place (in "if __name__ ...").
>>>
>>
>> In case we move the block
>>
>>      global dump_json
>>      dump_json = '-j' in sys.argv
>>
>>          if dump_json:
>>              sys.argv.remove('-j')
>>
>> from main() to the body of "if __name__ == '__main__'"
>>
>> we get the following error -
>>
>> "SyntaxError: name 'dump_json' is assigned to before global declaration"
>
> you don't need "global" declaration outside of a function
>
>

OK, thanks. However, if we want to parse more keys in future, will we do 
all that parsing in the body of "if __name__ == '__main__'"?


Andrey


