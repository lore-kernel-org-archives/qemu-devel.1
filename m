Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5DFC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1E52076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aXrGprvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1E52076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8let-0001Ig-4Y
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8leE-0000n3-72; Thu, 20 Aug 2020 10:34:34 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com
 ([40.107.20.132]:3834 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8leA-0001l7-8N; Thu, 20 Aug 2020 10:34:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al9WnaNr7i3DSRF+A2LZ9AtYlEO1bbmThHC1njjHVzEAVYvIEEspXL1sG3d0dzMgKYYL6cX9fz0ifNNePr1EdACCs0u30yAuYRXXK1Wl84zX80/AckkA/gjq3fwku+oWReQ2seT8bXeOYajE3t74hwX+as/L6W/ivC3xN58AFwAq9pJQOv2ZchILf/tG3avOpevSUyA9OmZ7IA/t9N94G+CclkSJHM4Xw6XGDutJWyQiYRoUFmVWv0wwSDjUAwbpdWXm5HwwTzhomi81vs0LbTO0ZepJfBApFB4q3DtAOWNuF1hBq0CTe8dm40swyvlOqhaxrvGm5gr99Uis6AYm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3uPINskRstMyvpF7oQmc9hiJlZLi6VWSlsbwrc/aO8=;
 b=aTCoLoua0tWDhLgJdly6yqKWW2v1DtL4l0g/EL+IAntUP86Eg8+pYAs8p8ME0GR75i6t5s+T4T6qV6XB3TF7Ih9bahYhzkmO+mAG0rrcOYnJ/8XcZyG8bXUb2oLUvYqp1IdWFXnVBQx+G6T2NlqloqYVZHoncw+z3B5SW4nq5tE+psI7dfSkEcukbDzjx3UNRUzaibw/mVVvyvzCX1FsE/TjNbRxfEeDuFXyZxessEfGuJc9l6sP+nVEa4c+pvAvGtMDCIHIaNdl9N3zBACRaQzxAnVQt7qh5zK2eOcGy10BFIS97St/mDlH5uteQUOt7nwR/aHtk61Jq/91kh240w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3uPINskRstMyvpF7oQmc9hiJlZLi6VWSlsbwrc/aO8=;
 b=aXrGprvzRWOmFnYCXrCLQdChWDAynMy7ulgrmIkbuQ3/80i1+fzxkxUcaAG06n5cZ3pjo7BiR/WzfYAHHwQb2dWydJi5kaAkE/lKhJf0MpYZo0YF0ITQJ15HMH2V3ii1Jge66+GX3Ke3acKruQUENXGBFOyd/siXtK2O7hsDYws=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5383.eurprd08.prod.outlook.com (2603:10a6:20b:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 14:34:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 14:34:26 +0000
Subject: Re: [PATCH v4 2/4] iotests.py: Add wait_for_runstate()
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-3-mreitz@redhat.com>
 <753a17ec-af13-326b-1dc8-2d9881c86cd8@redhat.com>
 <20200820142330.GF2664@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <65e2c000-1de9-78f8-5ac0-6f31319e6f46@virtuozzo.com>
Date: Thu, 20 Aug 2020 17:34:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200820142330.GF2664@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0030.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR07CA0030.eurprd07.prod.outlook.com (2603:10a6:208:ac::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 14:34:25 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5e18379-8c38-4746-2b10-08d84516237e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5383B69C9553AFE1EB9B5157C15A0@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DR02S/LDrS1Bmo5eQmkjwGEf2ix/yedsIbS4/c3QtYaXfbn51f3e0EIl3uTPKlXENPgYYmaMlsZDFgpFlEy5pjeSQt0pKv9HfQu1uXCpAnmycoCnXXw+AK52WMtqYrsw/6Au65gQD4FujaN41qXl+ypAvU8iApdUFvUsvnNgl2toO0MlwLTg0NK/p2CwWgWoCMXWzxMh3CabGr8gVh2IaKXuBt39P/2RavThd8s/9FBEFtP3AvsQ1dp6gAvoI79GzAlJFi/38nhHSebEZZ4at1C3gvt21dY+R0VfQPUELv+R8tO5R8UtrRMZV+NFImN7kNBR2RoRCU+ubhnTi86JCbyKO+MELE+GxmVaPBANyKScye7nIHg86PHmoGZ8mpo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(66476007)(66556008)(8676002)(31696002)(478600001)(956004)(2616005)(66946007)(8936002)(6486002)(4326008)(31686004)(83380400001)(53546011)(86362001)(16526019)(52116002)(26005)(186003)(2906002)(5660300002)(110136005)(316002)(54906003)(36756003)(16576012)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1vRxxB6/raT69cxqlIYbkLrEamd6FDxKZp/b0ix6/qrAIaiBjm93NNT+NvzVZ5SdihC40Pt6KUvDzFgeDFFNEH+FqCmy3EzcRRduuHsN0g1FGCw10jC8wW6UdCBA1KpIdOjiSqELbn4uQ5uQrvrIlhhkjIdSh26fvdajRqRaWQQ+Gu6jHFZ1FEmZKXaLDt4e3fmrb/fNi8n9hYq7+od3IPbszECmyi2wsWWmaz1QhukHQMnYG+YRw7ZbHTiGXp1J+WMCdlBqFP9lqoerM8TZShIeNuSElBdPNK20fW+q2ubO6WYmljADk/cKd1pCHU6kyzkustrssUSCQM8OcegpcJ5DsCkxqhzx3kGfRjAIgSvJvJwgcyEvPG+8LTEntvdOFzTOc9gsQ6mWagyG6GGfY822nP04fvLF9C0sTpeghrX//Ycxn01EkTRnG2Ki/t/LtEk3sG1O+c7n/eb5TlaKcf8qdO0CfCwGuhPdfH+gkQLqRNynYEhq3af0JTvfTfS1qgi8A77WP98QqJ8/uEHFZf+S15qiaQ4RVvmFOnMxO3Lstn7MprCL5Gh9AGVQrRBKXOXshHvF4a5f8us71giZpSoYvAF2SEfSnvm4aNirZ6MBW+1ZsB+7D1koPXM11PUPnZexH++Dc4PMdG6LmNtcHg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e18379-8c38-4746-2b10-08d84516237e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 14:34:26.1048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAIQIxu5ZYWjav+Q2893RnLxRiRbAwx5M9BNr3rKZlRhwnbnVZaWO1S2/9+PbkrxwrmRDHzgJ02fq9yE3WHbjlh7fxkQz+roJMZrMZ3eIH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
Received-SPF: pass client-ip=40.107.20.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:52:08
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.08.2020 17:23, Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
>> On 8/18/20 8:32 AM, Max Reitz wrote:
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    tests/qemu-iotests/iotests.py | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>>>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>>> index 717b5b652c..ee93cf22db 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -833,6 +833,10 @@ class VM(qtest.QEMUQtestMachine):
>>>                       'Found node %s under %s (but expected %s)' % \
>>>                       (node['name'], path, expected_node)
>>> +    def wait_for_runstate(self, runstate: str) -> None:
>>> +        while self.qmp('query-status')['return']['status'] != runstate:
>>> +            time.sleep(0.2)
>>
>> This looks like it could inf-loop if we have a bug where the status never
>> changes as expected; but I guess CI bots have timeouts at higher layers that
>> would detect if such a bug sneaks in.
> 
> Although it might be useful to make sure when such a timeout lands, you
> know which state you thought you were waiting for.
> 
> Dave
> 

Timeout class is defined in iotests.py, so we can simply insert something like

  ... , timeout=60) -> None:
   with Timeout(timeout, f"Timeout waiting for '{runstate}' runstate"):
      ...


-- 
Best regards,
Vladimir

