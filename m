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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82FAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80657206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iaLc+yd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80657206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5Bz-0001oY-PC
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw5An-00010n-S4; Thu, 16 Jul 2020 10:47:45 -0400
Received: from mail-db8eur05on2135.outbound.protection.outlook.com
 ([40.107.20.135]:24032 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw5Al-0000iJ-Oq; Thu, 16 Jul 2020 10:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/IgFGYCRcUWJoJWNFLYwKbOdjQZyeUl/JTqM1s160ldY/QdPgqaCTWDwd1GPc82wt/K+P1WbWAmZWdv09EoUaTO7Wp/LBxpTbXceC7I4zjrD7+HAaor9rt9aIwjMgI5+gah5VxmduasFsKIjd2bK5TRaCv9UjLCxsenJYj4hkluPycd3XyNRwqjnA5r09MPTwsJo70gnMthliYgXGIBve9WiJ9r6nnb7ryXduFkaH8t2UCv2pats7NDe8xUKg+QNCFhnRPuZA672QYtYZJuoi5ul1jmUdbDmXmIEEZw5jQCKT1ESMobjxekYsPGbkU2hXm/QYZgN8KTytqof44MzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiUrde5yKkBN9NqAc28xTfkJTD2IKEec5HA/0vUrq08=;
 b=BqAlVVSzUKnqI7xMuSy9UE023293CJtZ40/d5ZHFT1DtIGouwCDvPIr0sBUclZYxibk9MqUP2/ILY5CwykEMogOMNqbCFIUvbOqKNWALfZ/SjxBmz61nxsKm+ti8NFKA/JrYBuh1nTFEu79uTmYNPxIxiaL48yzSZnZfvRLbMXHULNiQZ+zxylH8UCbohmWsrmEKIW6k6pSCrO9hrQZAuhWLK4ErYaaUzbJW/5Mdh1DwSDIeoK+oFDzIX+uZ+J9Bkdtwc7XKE+TRw2TSZMM6CQopPUXbKl07vVw9Wbfzkg/j3ayrDr1slZf5zc7u2wbdpQcsC+vkT+g+lFwZ1JvjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiUrde5yKkBN9NqAc28xTfkJTD2IKEec5HA/0vUrq08=;
 b=iaLc+yd/m+Iq9l8wrKqpnNDXaKXITsotCe0y8HuFKH+P9GskOPKQChfswR5INcc+3Q9+WGgyoUmUISd85q47Zh7D3P/Ui6//Bc1+P/PsXqGjeJrRZdcEXpUUEtZIXqc13wMD58RALUYHUYMgsZ+GpeCY0Iz9ZwwDAn/WSLLJ+xk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2530.eurprd08.prod.outlook.com (2603:10a6:203:98::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 14:47:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 14:47:40 +0000
Subject: Re: [PATCH v10 08/10] qcow2.py: Introduce '-j' key to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-9-git-send-email-andrey.shinkevich@virtuozzo.com>
 <761829e6-ba9c-c8c0-8f37-976e37fcb6d0@virtuozzo.com>
 <9377dc3f-002f-6761-bb81-17a17cfafb08@virtuozzo.com>
 <c538f45c-8c00-7f60-c92e-7cc60c128376@virtuozzo.com>
 <5b661e9c-ec9b-441e-1e64-dc664ddaba17@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cc9344fe-07bc-37b4-43c4-4be0add305b6@virtuozzo.com>
Date: Thu, 16 Jul 2020 17:47:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5b661e9c-ec9b-441e-1e64-dc664ddaba17@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0016.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR02CA0016.eurprd02.prod.outlook.com (2603:10a6:208:3e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 14:47:40 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b899cd9-df91-4ee3-0da3-08d8299730ac
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB25301917E77A68173AC225FEC17F0@AM5PR0802MB2530.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkYHNusordy8rexF8lW1lfqU3O48IhvHPRgtb9TcQm4GwOQEr5eO0GCmykfSo+jcD5lXM6WbIWy/MDWEar6yMS7vn+Nd9W+gMRdLEFamDKP8XtZomppBVX1x8unYwqZ2OSZ7AAkg2N/9mAK/x9oaT3L9/dNA9Dx33eLmzzQNzdXYfrIP5Kwj2tGOgJkVoSSww41volB+aCXU2Q2GpS0/teZrp49XHFqCrCd4ugWwOQxGgVTvG/oCgShV9A/kX6dxeDLTIRAORUTfEii7EEJJ6zvQDa343AybaSZ9J03TKnrFFZWNRMXpYBhbd2DAmOAbbK0zAC7jRRsrKPpZ20JgndVhQ0ANzbz19SH6VrRntk4LcQR314i9+ILLF7+7WEFT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39840400004)(396003)(6486002)(52116002)(956004)(31686004)(2616005)(36756003)(478600001)(53546011)(83380400001)(8676002)(31696002)(26005)(316002)(66556008)(2906002)(8936002)(4326008)(66476007)(16576012)(5660300002)(107886003)(16526019)(186003)(86362001)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Nj044HWmgBHzUiZhLYsyVpaVKBLCBF2zChLFqVtRdM5huQZygyIzDM8/B4aQu9dEng2OMbBSHjsLKUGHBGwgqpTvETwJpW1yT/tIOMMYUkVqAx9cGDzM1aEtOOsxzXLXkTCMywC9A+kenSY1vkv8p71SKtOpeBBEMRUzrluEO0YCKx4/39IJwGqKQv1RcXiBr/K33xVf4a975sFHKCqCsUAgDLNKe8xV8iBoljkvqCzZAzxme+kabctRELmtQR3gWwxBPDcTS96MzP/y2K5ZsrNmcr1lUzh+Pm/D0t7Kx1EfxfpkvrVI30rk5ZNToEAxt9MXPazTNqqjgmW1Gt3KdbKtYXwk8HXiYmW7A9BAzadl+cutorw0t7vWNzKmgJtLEbNc/soLMP0BO6L2oF8XHrHpLxSByVraNicPGepgESeRCxnvLIMr+IlPmlgIdZKDzk0sMSuxxd9yCw35VQ9nIahPtaM3ZltX5yph84EfW8mW9snRuHxdP9i0tykcvSY2
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b899cd9-df91-4ee3-0da3-08d8299730ac
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 14:47:40.7462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuuHpZEhcswTshLsEZ13i9GP1va1Sk4x1RgPC5tEYVBp/kYsoukBeWyAeojhItwwfD05Ty4Sp34vM7NbTRGnE9wabr1n8h1aezbMUvZGGOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2530
Received-SPF: pass client-ip=40.107.20.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 10:47:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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

16.07.2020 17:44, Andrey Shinkevich wrote:
> On 16.07.2020 17:38, Vladimir Sementsov-Ogievskiy wrote:
>> 16.07.2020 17:36, Andrey Shinkevich wrote:
>>> On 16.07.2020 13:20, Vladimir Sementsov-Ogievskiy wrote:
>>>> 14.07.2020 00:36, Andrey Shinkevich wrote:
>>>>> Add the command key to the qcow2.py arguments list to dump QCOW2
>>>>> metadata in JSON format. Here is the suggested way to do that. The
>>>>> implementation of the dump in JSON format is in the patch that follows.
>>>>>
>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>>> ---
>>>>>   tests/qemu-iotests/qcow2.py        | 19 +++++++++++++++----
>>>>>   tests/qemu-iotests/qcow2_format.py | 16 ++++++++--------
>>>>>   2 files changed, 23 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
>>>>> index 0910e6a..7402279 100755
>>> ...
>>>>> @@ -134,6 +137,11 @@ cmds = [
>>>>>       def main(filename, cmd, args):
>>>>> +    global dump_json
>>>>> +    dump_json = '-j' in sys.argv
>>>>> +    if dump_json:
>>>>> +        sys.argv.remove('-j')
>>>>> +        args.remove('-j')
>>>>
>>>> I'd prefer to access sys.argv in one place (in "if __name__ ...").
>>>>
>>>
>>> In case we move the block
>>>
>>>      global dump_json
>>>      dump_json = '-j' in sys.argv
>>>
>>>          if dump_json:
>>>              sys.argv.remove('-j')
>>>
>>> from main() to the body of "if __name__ == '__main__'"
>>>
>>> we get the following error -
>>>
>>> "SyntaxError: name 'dump_json' is assigned to before global declaration"
>>
>> you don't need "global" declaration outside of a function
>>
>>
> 
> OK, thanks. However, if we want to parse more keys in future, will we do all that parsing in the body of "if __name__ == '__main__'"?
> 

If we are going to parse more key, we should move to ArgumentParser first. It may be in body of "if" or in a function..


-- 
Best regards,
Vladimir

