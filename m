Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616CE2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NulRZp90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616CE2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOQu-0008Cw-HE
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgOQC-0007W9-IV; Wed, 03 Jun 2020 04:06:48 -0400
Received: from mail-vi1eur05on2109.outbound.protection.outlook.com
 ([40.107.21.109]:18400 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgOQA-0008Ga-MI; Wed, 03 Jun 2020 04:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKhS6b3k02+01ZjdozNmAm9iSroWJSbZfEfJqMa5qPzgOESTl3DLvHvZoqUAi6Gwk7nkXBDpjyo3l0e1E/A7HQ3q8udJ/URNufTdGgZlSnweZ4NJtnuiChSX240g3jtsdZbFuZZBrH0Eqv0o2BRyyx4eNagLayPoSXj8+fsXINMrG0H/YJJK3ccp2aHKIMMu0nlHRx8EIn3/kJaJnE1z2XdFWJsz9mmZH2VmyiFvWRrqPySBWfyGiX2pu5wW0TyNlOsEHM5JQQHg+412CpoJpPFrQV/ndAy2gAQnJZx6HmX+dEmL/7MtEZx9IN7kywoKor5PKIQ/4IV+gD3ZFXcgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+xCV8jv0yqrz8AtfUeqD0ugMNw4Yd9akMSJIAvZ8ec=;
 b=bhw9Dgvqzjnp6dV9KV17P9T8ngcurVe/vJT52OOUZ+c1iXKodtvum8pqoNHozxpT0+gqTJ58oIqMtkQaHE/QDb664lGn5bZ739yecjsbY4scQZyk2c9VW3ZU3ZOM4Ji4iyPob1VydTU+Prxnx7d6+Dedv8wrCNSq5eN8DO2kjLEp3TZz0vvZ7PrVI2ZKcE5vEftDDAWBihCqRHXrL/G8QQIuFLOc1BCLa674hBr0M7cGQw/kvZRpeoz9F+EdzIRBvAABPo0djLfAVnwoab+f/Ih5hM0f/piyliwARZLWeSpnUYVkwwUO0X2RNKcfFzUp6doJNeKMHhBgNuhByD9HOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+xCV8jv0yqrz8AtfUeqD0ugMNw4Yd9akMSJIAvZ8ec=;
 b=NulRZp90wU51l315LDDXi4eJA3mN3AG0aM+r7f42J3jo2G5e6NiWPUlQf/2jlVeqb4Ouk0XivBJxKLrobQjIYPfNvYSKO7969ucsQuFwNVgntPAcSwgrnouuxZwEV0M5kMAYHdR2uoRUBkhehvxUdnegxrTnnsb/kCvAmMpyDzs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 08:06:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 08:06:42 +0000
Subject: Re: [PATCH v4 4/6] iotests: 194: test also migration of dirty bitmap
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20200521220648.3255-1-vsementsov@virtuozzo.com>
 <20200521220648.3255-5-vsementsov@virtuozzo.com>
 <8954b780-614c-421a-cca3-992f68d24812@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <93c99c0a-2c79-c62f-4c38-50c5c23ea4eb@virtuozzo.com>
Date: Wed, 3 Jun 2020 11:06:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <8954b780-614c-421a-cca3-992f68d24812@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0011.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.188) by
 AM0PR10CA0011.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 08:06:41 +0000
X-Originating-IP: [185.215.60.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dacb0ac2-2274-4f20-b9b6-08d807950d2f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54625447B982D6C1979B3FF1C1880@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:483;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXnaiHB7/GYHVJHZTO9rnHmuizqH5TnOCxmqF3P6KwMT9Qv9gAlJITQGFtQgOj590pPMdC7xlAtEq8dKuWO2+jO1+2LAdTPX1MpRgG+qDSk0uGGFrQazymk5A7JSKZj7QgHBz0USVTddurJliW8Xhjghf5Bu3h3qmGGgl6o3AIl+6gM3hm2JYoPJeFX9T4pHlM+hCEs1RHtgKjUiIT8NTLnfZp0m9+LBWf5KVSjAaMuYycsu+O6vVqiwWt8jrXV1VkhHwbBRxK7Hblkhw4XGKErs3Monyl6iQopuxGm5CUEST1Fm/BrUd+m112mlECB5il1Y2skNZ1QLGuzjj4pr+k/6A5wD4RGAoAOLpzpzm1tpKCZA9Ih+3lmZkF2nnHer0O3z6ngs7E9Xc80Kd0g/Rmvqh4pxoTmT+fZi1nmm3VIoVtpUDznGqyuU92mUHeYMaGvQ8kV7GXBNNENBJWa5VIz5XlSQm2lRU34PlPApKaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(39830400003)(136003)(346002)(8676002)(8936002)(52116002)(16576012)(6486002)(4326008)(316002)(66946007)(5660300002)(966005)(86362001)(66556008)(66476007)(83380400001)(7416002)(956004)(16526019)(2616005)(36756003)(2906002)(186003)(31696002)(26005)(478600001)(31686004)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TngP82CpADGf4vRwV0/xuyGcIv43bAGC3rScl+EcRqfrL+wa5Ua+quHvMBM7J4rNou8wAVaV9pgWXpKmuJrhN11UsYm7/LJzFmACYVrAUaEs/0yXtIz/oFzuHBDJQAC7LeczO+C3t/Id/xYGkUT7iS7qu5IlExzRJ8xUP6iDt+Zq39fddsP+tVko9cKGHJPyfjR2Vo6vGUAEZY5i9gCyw5jZaB58t6mLNh6sbC+CZH5ENowSkttjARPIOa98CO4Pxhf9RGLfWou43GxN6gfM23Xe1MlieVFF8zOukFPO8IaDv01zLw5NYxSnAMltRe2Z46KF0ZB0RBoqwFWx809VyfCRgc/UAXoZMNlrPY9Vyq8n2yZ6uZCxJQdNNMRryhsaV6mSYFTVMlEZ9JF9iwQNicGzxsmjMx/VWkPe/uEIUeYnwOg1LrgCmZpsErhzTVhUroD7nzzHd3iHLPHchbc2lue/wwB9MpxIytUDtAWiMnd5ypAPve2+gI3rASy4FMsn
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dacb0ac2-2274-4f20-b9b6-08d807950d2f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 08:06:42.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1Y0VYt3PnqdzqojBZN2QyxkkPjTAzdvtlC8kfeWWjkCXSEPpiZsaLzCe5+1l/1NxajIcuFpqN7dE7TwRGFVEbtRv+ZA6wXZkdCAQfIFEjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Received-SPF: pass client-ip=40.107.21.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 04:06:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.06.2020 10:52, Thomas Huth wrote:
> On 22/05/2020 00.06, Vladimir Sementsov-Ogievskiy wrote:
>> Test that dirty bitmap migration works when we deal with mirror.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   tests/qemu-iotests/194     | 14 ++++++++++----
>>   tests/qemu-iotests/194.out |  6 ++++++
>>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
>   Hi!
> 
> This test broke the iotest in the gitlab CI:
> 
>   https://gitlab.com/huth/qemu/-/jobs/578520599#L3780
> 
> it works again when I revert this commit.
> 
> Could the test be reworked so that it works in CI pipelines, too?
> Otherwise, I think it's best if we disable it in the .gitlab-ci.yml file...
> 
>   Thomas
> 

Hi!

from the link you provided:

...

../configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""

...


194      fail       [06:31:15] [06:31:16]                    output mismatch (see 194.out.bad)
--- /builds/huth/qemu/tests/qemu-iotests/194.out	2020-06-03 06:18:10.000000000 +0000
+++ /builds/huth/qemu/build/tests/qemu-iotests/194.out.bad	2020-06-03 06:31:16.000000000 +0000
@@ -22,3 +22,4 @@
  Stopping the NBD server on destination...
  {"return": {}}
  [{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
+WARNING:qemu.machine:qemu received signal 6: /builds/huth/qemu/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/tmp/tmp.e9BvOjVl1W/qemudest-15756-monitor.sock -mon chardev=mon,mode=control -qtest unix:path=/tmp/tmp.e9BvOjVl1W/qemudest-15756-qtest.sock -accel qtest -nodefaults -display none -accel qtest -drive if=virtio,id=drive0,file=/builds/huth/qemu/build/tests/qemu-iotests/scratch/15756-dest.img,format=raw,cache=writeback,aio=threads -incoming unix:/tmp/tmp.e9BvOjVl1W/15756-migration.sock



- Qemu aborted. Not good. Definitely is better to fix it than just exclude the test.. I can't reproduce. Could you provide backtrace from coredump?


-- 
Best regards,
Vladimir

