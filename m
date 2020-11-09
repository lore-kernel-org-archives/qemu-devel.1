Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47A62068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kES5N8uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47A62068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7Va-0003Zk-LC
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc7TF-0001eQ-9L; Mon, 09 Nov 2020 08:44:33 -0500
Received: from mail-eopbgr130132.outbound.protection.outlook.com
 ([40.107.13.132]:28967 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc7TB-0002Hd-Hz; Mon, 09 Nov 2020 08:44:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA5fbNd3MZ3V8z3goqJdggyAPWMZ88A0FzM93m1VX02n26FAEFV1Mpq7cpaSQUMC70mLGvI6Kceq607Sd65CzseBWSePZtoicCCpM62u3NpTOyrKiNc4XJgxoKbdRdRD6z8gI9NPAbyRoxYg6oE11EZ5wjF35g06EViedjW61fd5Io8up+HUnYdH6rF6DyWqKlGPhVk1ccHXqvjPqcoKYGsYCIb7TH/5BxCh2KkVVMh/AhV9kY56Cp7cKtlIKjve1vcVouK6EFltudr4iV4EC/+2VuQVdM9IA3gd6lzQx6vQ2gNK8HFpg/78kf/dcaL3fPRyb7YoxsfWOhqjmxYCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVA6BMWDWw9nUun4rM3ukZ7vRwqwR9UITymWVSeMxQ0=;
 b=MG6+Cc9IybG5yQW+77hY2lWEr9y3HaqBYV6bxmNe7cRZ8pIHnckR2Zz988TcziMwPNOiq6EfUg4rQ1P6S9rOl4f6tQph+AeNN/5KOBeFTrsgJBnuqqVsfGxJPEtoGqgOeazS1yuJaXlVs+w7Cak4iEvWx3byYojFwDJ5ocyCx4D56Y+k+XCzdllMUsd0M0UaFHAAFpTVBmu+okPZ1bEd1mpF53VLlFcjV7JPF3D6eA5ojWG/NpT8/xC3cYOQgjlJpm5NoZvPM6bVytF6Y460UMxFiGCZGSI6J+sc919eZTH2jjrT+Rslt3rIjBxx75xMG0to3aKR0ioY7DSSm7NTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVA6BMWDWw9nUun4rM3ukZ7vRwqwR9UITymWVSeMxQ0=;
 b=kES5N8uUVoqtSW0fppmZljEyx+nS/u9XNtvRjdVfCIpbM8ICLNbV2xvcfucWK2/PNr4lPsiai/js7ACB9mnDZYtLbkeuWYQg1v1FrEv5rSdaKkyMkt02OdO6ldQl/hSMBT50bf0drNFntV2D1H4/5ZzXxI+bpXl2NmIquIJLveg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3095.eurprd08.prod.outlook.com (2603:10a6:209:45::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 13:44:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 13:44:25 +0000
Subject: Re: [PATCH v2 4/7] block: add bdrv_refresh_perms() helper
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
 <20201106124241.16950-5-vsementsov@virtuozzo.com>
 <w51zh3u8qlx.fsf@maestria.local.igalia.com>
 <6bc178d3-8c9e-b2e9-8606-97a2b222d63a@virtuozzo.com>
Message-ID: <ced77269-b9a9-70d1-b850-ff43eaa0a7f4@virtuozzo.com>
Date: Mon, 9 Nov 2020 16:44:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <6bc178d3-8c9e-b2e9-8606-97a2b222d63a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 13:44:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4918fd5-e938-43df-8c1b-08d884b592ac
X-MS-TrafficTypeDiagnostic: AM6PR08MB3095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30953743659AD5B44568E7C8C1EA0@AM6PR08MB3095.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lglGq5PVXxzjW7aHXE/3VGz0nZnZ+OjAEGEbrg/ERKHRC5gaOyqb+0ARLU6+v2mbAmf8XliME6QpZVJYzarZ1lzmoKjfwko930bUNGJX0j3ugfE7hPL7d8BUTKlN8wRmaV0+D9r4uJy71R9EU5aCvXiJeOJ0DX1XtP0OlVyCquz3tSNQyO+tbBxEkb55VDN9Hn9O2E/X2x+H0Z1M88ZFcsitj0k+/xLOa+7c6SWgFoCysr+7qhgVzzYAcfFLpEKZ3K7UlwblJk9h2w76sOzwAUnk+JDSEnKUn9tY3jPf5BNBDsSkqjq/e4HRJ5szoj8SjkSwn0uYQA8qr4EyZXY+EKIotDwwwn0FDTP7GFxZYWohRkoa0TTwc3q37yDBF/6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39840400004)(366004)(107886003)(186003)(52116002)(31696002)(16526019)(2906002)(26005)(83380400001)(36756003)(6486002)(316002)(16576012)(478600001)(956004)(2616005)(86362001)(4326008)(8936002)(66476007)(66946007)(66556008)(5660300002)(31686004)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cHAPbzzHSRVLsCQepoC+xmxDDkAhI1ODweqD7AkVAB0qJcXtNoF2+/3w+p64bY75t+Q5olVSuY5sLLTqfoGIpFcgtIFAqP+lSB3BZ5vL/kXQA4/ungfjlG777DpbcxJLrwV/u+CndEHNwbDV8BNRHR9wnYZY6FMLHJjY45k4XelUc50TM5H2ZiYXT+SRPlYsIQYXs21mqlfj+6iLAhQD3kHtNm8lm/CBejt3rtEEqWq6zFOghv8kNBhRZhNAmKor+obUlCv3YKHxB4ksn2pkdU5b/zPiS5d9y3c1dBUvdsIFGu5r23+jgHZ1GsB8kNlJUflhJhdGL+n3ae9MRhdYGQpIJSg80mK0plB/BG0T2cTXg94MrwIT2Lv0mAwOD/JTLKdyhzR2WCFjD8oilVog4+Rh/rzzR+iiP5D1oTZ5PU4r6l4Ul2/zcGWMvWtafqczABBcKeXcUH3YjM7PiEom/K3lZ0GllZbVj5m/LCw/e2a23me3AEHJd1VeQaEcwNIr/eYW49IosziDhP1+a2cLZrl67lL8rDBi08vhBqTFFFx8u4bpWAekpchGMdb3x+FW9cPuCrfZlIGbzk7E01YL6B0u/eWinp9R+vZSXoxb3LWxGFVxlJnCGVqV5fDZxtZh6Orp9Zmy3qMTdccS1NyXEw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4918fd5-e938-43df-8c1b-08d884b592ac
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 13:44:25.9236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YO3EaxaAxBLIfCK6yfBgwZccJcNohH4xmQs6xDzyM1KqL8OG+i4DUWoVeqRr0p/PgImmMTGZoHyLSQlRNLaDw2tpy1ErJkAmqt8n1LqNLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3095
Received-SPF: pass client-ip=40.107.13.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 08:44:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.11.2020 10:04, Vladimir Sementsov-Ogievskiy wrote:
> 06.11.2020 18:14, Alberto Garcia wrote:
>> On Fri 06 Nov 2020 01:42:38 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>>> Make separate function for common pattern.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   block.c | 60 ++++++++++++++++++++++++++++-----------------------------
>>>   1 file changed, 30 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/block.c b/block.c
>>> index 77a3f8f1e2..fc7633307f 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -2321,6 +2321,23 @@ static void bdrv_child_abort_perm_update(BdrvChild *c)
>>>       bdrv_abort_perm_update(c->bs);
>>>   }
>>> +static int bdrv_refresh_perms(BlockDriverState *bs, bool *tighten_restrictions,
>>> +                              Error **errp)
>>> +{
>>> +    int ret;
>>> +    uint64_t perm, shared_perm;
>>> +
>>> +    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
>>> +    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL,
>>> errp);
>>
>> Aren't you supposed to pass tighten_restrictions here ?
>>
> 
> Oops, yes I should
> 

So, squash-in:


diff --git a/block.c b/block.c
index fc7633307f..a96dc07364 100644
--- a/block.c
+++ b/block.c
@@ -2328,7 +2328,8 @@ static int bdrv_refresh_perms(BlockDriverState *bs, bool *tighten_restrictions,
      uint64_t perm, shared_perm;
  
      bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, errp);
+    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL,
+                          tighten_restrictions, errp);
      if (ret < 0) {
          bdrv_abort_perm_update(bs);
          return ret;



(produces simple conflict when applying "block: drop tighten_restrictions")

-- 
Best regards,
Vladimir

