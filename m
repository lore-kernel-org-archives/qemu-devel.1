Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213EBC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193F520714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qrGLXxhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193F520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH4WA-0001cv-8p
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH4VB-0000gM-BQ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH4VA-0004Kt-5Q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:47:17 -0400
Received: from mail-eopbgr130104.outbound.protection.outlook.com
 ([40.107.13.104]:56196 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH4V5-0004Gu-SZ; Wed, 25 Mar 2020 07:47:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7wL89agbJm1Snk5j9z4gV1S3EhA55yiYe/99uTxybYWv/nu+v5/u0KAZ5twlxzdzwDffic/wgU4LfRe7RQwk14fSUzcgKCbyRYsT3i9Vt5qnA36P2/i/ltzCD/KgY+6d5kxJpAf2a6WLUl0K8QwGLr5FEQY3AOOhOHR9jGYwq0u7w5na1rWjka18bqcY4we9mlzUrpi1alarSZ5P8TtIjiQeRShEcB0dihj68lEJM4HXWiWyC5HL4iGHk+kmO5j38sZEl2mSKOJE22G0lksS2ROJf8RSKrL4mziKBQHxIjaUYpmMk8T4EtxAzyV2KA/q702VcZwZ0CamCcS85uMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bae6lUZm9ZrKvg1fzTJY2hGl1FT19N8hXJszpGCss2w=;
 b=m5CYc5RE8yqASBy6uVy4wsT9p0odhwGqz0ZY9339DiYw6uHoxyiqQEP4HDhsxOi3S2o3r70Z89YFkdrjaVlEwDehBTFQ2CNMFsdCMjjoGIsanh0r2wa0qpNSF2DOM9PV5mqL0RsQR6IApuFUYTD+gM9yniZRKaQPtTt2WhICy1b84gMeC8913+KJiFpjzscYklosokzOwbuOr/rbvt0P/JslRQFWIjUu6ilXc3wRNSjUysZj0mwn/Hhz/wuq5JVSpWc/DUHERdmvz1jY/ZshfnMF4w1OSusZ0fbbiZ5CdHI9pihvJV0agALdUv2nET2QIHMd8b1TvjJPRlWtLFa8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bae6lUZm9ZrKvg1fzTJY2hGl1FT19N8hXJszpGCss2w=;
 b=qrGLXxhsjWCc/fBtlFNgazjS5y6SlbsDNmjlIrIZ/pcEAQIuU+tuFi+hS7UePQF/f7MIIJ1/H9rJUtqIE2acSQot/u7Jegq8YvepWLUioAKjClVHAexINRgLgYjfYfx466juIYaRumZ4g3nSEB3FHDAdt0soMdsmTM7xgDqx+qs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5336.eurprd08.prod.outlook.com (10.141.172.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Wed, 25 Mar 2020 11:47:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 11:47:09 +0000
Subject: Re: [PATCH 2/6] block/mirror: fix use after free of local_err
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-3-vsementsov@virtuozzo.com>
 <8cb2bda7-55f5-2646-3c35-d901089ccde5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200325144707052
Message-ID: <f6882909-0c4a-145b-bfb1-e4b92e788f36@virtuozzo.com>
Date: Wed, 25 Mar 2020 14:47:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <8cb2bda7-55f5-2646-3c35-d901089ccde5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.35) by
 ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Wed, 25 Mar 2020 11:47:08 +0000
X-Tagtoolbar-Keys: D20200325144707052
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfe7c712-05da-4a9c-c5a6-08d7d0b24008
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB533684D649DC5399BBA61E92C1CE0@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(346002)(376002)(39850400004)(396003)(5660300002)(86362001)(16526019)(6486002)(7416002)(316002)(36756003)(8936002)(53546011)(2616005)(8676002)(2906002)(107886003)(186003)(4326008)(31696002)(26005)(66946007)(16576012)(66556008)(31686004)(66476007)(478600001)(52116002)(81156014)(81166006)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5336;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXUqIVZeRdKCRPzOVeqHeaLrbsIIZc0G9+9771sFi9TovqJqBFg8cKU/C++nb5OrylgOsbMQw0aJNMIy/3oEN8rHv4g8PjPySkjVfWbyPvRbhJ78RltFesYgIvbfM2uYRWejBz3z9jOteqTs+k7GbhMyJaz4EJbCKhdTFPKi/3pGGV30SLJ/efsjUuCCWcL7OwuoHINeJKrF3yc5T48Ryzvy5c1VLZhux7BmROcoo9UAMhgKXvo9rwVqc0ONnFNraojp02R2Sic1bV/bquY6mX1cHyOOpDxgjSnQJM/YhEGzujiMc0axVb0A+sYQiAS23MxxOvhkjM8VkMbOtU5ryMXcpaQkajUPGo667EPDf+aOZooKTfxB06/0wlh5vRQRLTQ6g/cyB9vYp03ieOZSRBYMlh5Mv1SIYjIKnp+pyGHtZGuYMnuOin25APTtYLFc
X-MS-Exchange-AntiSpam-MessageData: Os+3XBMlqvQFpHYDYQl+OMA0jznzGawq5/Io6NXXVBrF4hxNZSkuo8qxM+bhYL3sx2ipgQMI6Gbl0VLQsOql4C2ttVmeWo/KKxecdd4rT2x9SvD5SuIsdzbEj0Q/66F5jRpb52cIjscIddQ+hIg2Dg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe7c712-05da-4a9c-c5a6-08d7d0b24008
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 11:47:09.5099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O219qUprdXRpGOnWnKpU4Jh61smeS6SU2ZKaFHdxp8Z1MQFO9M3C5kNTINgrlYB+MuO2NeE2qIgmMb2Oct5916eMwPb8E22u4pgC68fs6Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.104
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 mdroth@linux.vnet.ibm.com, den@openvz.org, marcandre.lureau@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.03.2020 14:11, Max Reitz wrote:
> On 24.03.20 16:36, Vladimir Sementsov-Ogievskiy wrote:
>> local_err is used again in mirror_exit_common() after
>> bdrv_set_backing_hd(), so we must zero it. Otherwise try to set
>> non-NULL local_err will crash.
>=20
> OK, but wouldn=92t it be better hygiene to set it to NULL every time it i=
s
> freed?  (There is a second instance of error_report_err() in this
> function.  I=92m a bit worried we might introduce another local_err use
> after that one at some point in the future, and forget to run the cocci
> script then.)

Yes, it's better. But if we now decide to fix all such things, it would be
huge series. May be too huge for 5.0..

So I decided to fix only real obvious problems now.

Hmm huge or not?

Ok, let's try with less restrictions:

--- a/scripts/coccinelle/error-use-after-free.cocci
+++ b/scripts/coccinelle/error-use-after-free.cocci
@@ -28,7 +28,7 @@ expression err;

   fn(...)
   {
-     <...
+     ... when any
  (
       error_free(err);
  +    err =3D NULL;
@@ -46,7 +46,5 @@ expression err;
  +    err =3D NULL;
  )
       ... when !=3D err =3D NULL
-         when !=3D exit(...)
-     fn2(..., err, ...)
-     ...>
+         when any
   }


on block/ directory:

spatch --sp-file scripts/coccinelle/error-use-after-free.cocci --macro-file=
 scripts/cocci-macro-file.h --in-place --no-show-diff --use-gitgrep block
git diff --stat
  scripts/coccinelle/error-use-after-free.cocci |  6 ++----
  block/block-backend.c                         |  1 +
  block/commit.c                                |  4 ++++
  block/crypto.c                                |  1 +
  block/file-posix.c                            |  5 +++++
  block/mirror.c                                |  2 ++
  block/monitor/block-hmp-cmds.c                |  4 ++++
  block/parallels.c                             |  3 +++
  block/qapi-sysemu.c                           |  2 ++
  block/qapi.c                                  |  1 +
  block/qcow.c                                  |  2 ++
  block/qcow2-cluster.c                         |  1 +
  block/qcow2-refcount.c                        |  1 +
  block/qcow2-snapshot.c                        |  3 +++
  block/qcow2.c                                 |  4 ++++
  block/replication.c                           |  1 +
  block/sheepdog.c                              | 13 +++++++++++++
  block/stream.c                                |  1 +
  block/vdi.c                                   |  2 ++
  block/vhdx.c                                  |  2 ++
  block/vmdk.c                                  |  2 ++
  block/vpc.c                                   |  2 ++
  block/vvfat.c                                 |  2 ++
  23 files changed, 61 insertions(+), 4 deletions(-)


If you want, I'll send series.

>=20
> Are the cocci scripts run regularly by someone?  E.g. as part of a pull
> to master?

I'm afraid not. I have a plan in my mind, to make python checkcode, which w=
ill
work in pair with checkpatch somehow, and will work on workdir instead of
patch. It will simplify significantly adding different code checks, includi=
ng
starting coccinelle scripts.

>=20
> Max
>=20
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/mirror.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 447051dbc6..6203e5946e 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -678,6 +678,7 @@ static int mirror_exit_common(Job *job)
>>               bdrv_set_backing_hd(target_bs, backing, &local_err);
>>               if (local_err) {
>>                   error_report_err(local_err);
>> +                local_err =3D NULL;
>>                   ret =3D -EPERM;
>>               }
>>           }
>>
>=20
>=20


--=20
Best regards,
Vladimir

