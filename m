Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE39C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2EB24670
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VyDyyajS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2EB24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7G8g-0000r8-0r
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7G70-0008Lq-0a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7G6r-0005Om-Hy
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:09:44 -0500
Received: from mail-eopbgr70113.outbound.protection.outlook.com
 ([40.107.7.113]:17031 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7G6j-0004vi-08; Thu, 27 Feb 2020 05:09:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtVWq61dXtUSSr3YUO6mZwS8EyMyuZvJiV1MSCA+lYEFBgsmwIwm5mCSOxC81TpwvyV5UaS90kEIuQ0Qp3ckW91uuoeUazLG/TJlshERWQnW8N2fBH4uhJtmumZ3psqbSCmUsH1eS7vAEV8EH9G7zpzAuanaacD5yQEpczJP/7wng7w/zWm7w9lZ3O6vi4Liai9UE6PAP7nUar5RzuI+iTE6frdF7dubEqSCsbnhKAY+nlAl5H/wPod6QHTqmHlVdN2mpLWq0x8DtwZYaQdkgfahEnCL9pGdtQN/FGK/QVOYa5Qvzjw+p2yQP9U268wFXsSxxQofyDGGOH46AujTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJXyC/GHTrK1dfBqT8P0wZnz/epuGMYPG8odCVL96WA=;
 b=kl+oPcL3TgIbOFcpukhHZBmjnywENq0vnGDUjQCQ00WolLUnZwrBCTolabgn+W59Sdji7gkjc+VQaC0nb9jivgwmUe4rcW1aEbsKAbKqz8okCVHrZ8VKtFEXb94VT9+ksiHr0M1WusLgBW1ikv0Y3RndiqhtSJvL2Tb+gpz0q7KNUcUL3EMdXYE1Q49lWs1DGuFEyWeuEYD05rbZnsecziWjf8iNjEKJoHpkDtuRIdBksLzTwHOOlHI/tcvBW0HD8rYCYVAyKMrpeoTESnYQanCpl1raKvzqyIyAJZBllFHNtU5O5s48AS7GTLIvm5440U9ScfhgQnGruotLjFyL0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJXyC/GHTrK1dfBqT8P0wZnz/epuGMYPG8odCVL96WA=;
 b=VyDyyajSTvTxdG/4eQY8jQWrXEH8WdYpD4QtWZfPsGAZJPD5M6MwMV5kskXcAdBH9gZENS6h8OvEo0tF4nN2bFS+u88b44nJMK9BESd0nQ9Bci42OKw6oz6DhHNDYKNNQ++g0baQw+XWJMguC9n95v1fXlDuvbeHYyYtzfrakYA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB2893.eurprd08.prod.outlook.com (10.170.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:09:19 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 10:09:19 +0000
Subject: Re: [PATCH v1 6/8] iotests: add "compression type" for test output
 matching
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-7-dplotnikov@virtuozzo.com>
 <8003b87c-0d0d-6b00-0065-0b227ec97221@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227130916480
Message-ID: <2e55b711-4af0-b1a0-8736-6391d81db8ab@virtuozzo.com>
Date: Thu, 27 Feb 2020 13:09:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <8003b87c-0d0d-6b00-0065-0b227ec97221@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0802CA0008.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::18) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0802CA0008.eurprd08.prod.outlook.com (2603:10a6:3:bd::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 10:09:18 +0000
X-Tagtoolbar-Keys: D20200227130916480
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df711b7e-4f91-4149-1af1-08d7bb6d1bbb
X-MS-TrafficTypeDiagnostic: VI1PR08MB2893:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2893C229187681182BDE7757C1EB0@VI1PR08MB2893.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(39840400004)(136003)(396003)(199004)(189003)(30864003)(8936002)(186003)(31696002)(86362001)(6486002)(16526019)(5660300002)(26005)(52116002)(36756003)(81166006)(81156014)(8676002)(478600001)(31686004)(4326008)(66476007)(66556008)(66946007)(316002)(956004)(2616005)(2906002)(16576012)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2893;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8GO0a4Z5h/5oOB8Rn3Xl+DCzD9M3VkDYWxrXcgntwG42DGSPGQ2QGEVjrVi1+Gafux//IioH3dRGY36u5EYXSMQu/67Z4Q2UJbatXQGKsZ4qaJRmaL9QBbT/eBjVizpA0jLBDECpStdbgQ0ueDKMfb14Gib3wf89GaDe4mVD5bUz68J9ya6GwE4OzKz1ga0kk2dVIprnMZ1/qVZl88Du1uRvAThM3oldiTeBuRBAC3Fwpb0zjo+F5G4He2DswO8mV0ZvxEvZIMZ2h7E0/IsgOZLy1+AZnsi9Tyc4ANMlJhRUhrLvszGABM3mB2djJwPZsOKtFXw2xgbdTRKeRD6+CtSgd2mLF2WiOk/pykz8+DVwfWIiRZ9W6gTVCXeT9TUTrniz9CRfBg5pHw8G5Yg+ZygUkbqOHR9ZwqIEor4oz/3GVBFp3asNr088t9cz3i1hFq5nmkbM5zU7tDxHjE8nq36SCWr8BC7Dn2hLpsnCowX390FUooQS+B/xJiGGH5R
X-MS-Exchange-AntiSpam-MessageData: iPvFFEbAQtI7kOcz0Co5rEIwpGx6Ym7UV7J7weH5PdlDtCNchVIsHdttCZZUuUO9JkqEWr3GgwaRRo7ws2mXDtlDW7+IaHpqpUPOXim1oVPojEb9IEW4ilWc2pB1E11U2S+Ya2oIgkUemgx6QrhhXw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df711b7e-4f91-4149-1af1-08d7bb6d1bbb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:09:18.9559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLMVqQ1Y3IcgVKpDJJG34xUCwfZUiBxDAixS7cDfc1WbjKG1hRVrBDJoWp/djUlHxK09uJXOFRyTD2Ev9it4MHL9NuEAqyLfZHPg0aCdkyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2893
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.113
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, den@vrtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 13:04, Vladimir Sementsov-Ogievskiy wrote:
> 27.02.2020 10:29, Denis Plotnikov wrote:
>> Affected tests: 049, 060, 061, 065, 144, 182, 242, 255
>>
>> After adding the compression type feature for qcow2, the compression typ=
e
>> is reported on image quering.
>>
>> Add the corresponding values of the "compression type" for the tests' ou=
tput
>> matching.
>=20
> And this and the following patch.
>=20
> Ideally, patch should not break any iotests. This means that all iotest u=
pdates
> should be merged to the patch which changes their output. Probably, you c=
an split
> behavior-changing patch, to reduce iotest-updates per patch, but anyway, =
big patch
> with a lot of iotests updates is better than patch which breaks iotests.

Or we can try to reduce behavior changes in case of zlib:

- keep header small in case of zlib, not adding zero field
- don't add feature table entry, if compress type is zlib
- don't report compression type on quering, if it is zlib

- then, all iotests output will be saved. And, then, if we need, we can cha=
nge
these theree points one-by-one, updating iotests outputs. But I doubt that =
we
really need it, compatible behavior seems good enough.

>=20
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>> =C2=A0 tests/qemu-iotests/049.out | 102 ++++++++++++++++++--------------=
-----
>> =C2=A0 tests/qemu-iotests/060.out |=C2=A0=C2=A0 1 +
>> =C2=A0 tests/qemu-iotests/061.out |=C2=A0=C2=A0 6 +++
>> =C2=A0 tests/qemu-iotests/065=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +++++--=
-
>> =C2=A0 tests/qemu-iotests/144.out |=C2=A0=C2=A0 4 +-
>> =C2=A0 tests/qemu-iotests/182.out |=C2=A0=C2=A0 2 +-
>> =C2=A0 tests/qemu-iotests/242.out |=C2=A0=C2=A0 5 ++
>> =C2=A0 tests/qemu-iotests/255.out |=C2=A0=C2=A0 8 +--
>> =C2=A0 8 files changed, 82 insertions(+), 66 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
>> index affa55b341..a5cfba1756 100644
>> --- a/tests/qemu-iotests/049.out
>> +++ b/tests/qemu-iotests/049.out
>> @@ -4,90 +4,90 @@ QA output created by 049
>> =C2=A0 =3D=3D 1. Traditional size parameter =3D=3D
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024b
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1k
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1K
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1G
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1T
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzl=
ib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0b
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5k
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5K
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5G
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5T
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzl=
ib
>> =C2=A0 =3D=3D 2. Specifying size via -o =3D=3D
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1024 TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1024b TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1k TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1K TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1M TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1G TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1T TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzl=
ib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1024.0 TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1024.0b TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5k TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5K TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5M TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5G TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5T TEST_DIR/t.qcow2
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzl=
ib
>> =C2=A0 =3D=3D 3. Invalid sizes =3D=3D
>> @@ -129,84 +129,84 @@ qemu-img: TEST_DIR/t.qcow2: The image size must be=
 specified only once
>> =C2=A0 =3D=3D Check correct interpretation of suffixes for cluster size =
=3D=3D
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1024 TEST_DIR/t.qcow2 =
64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1024b TEST_DIR/t.qcow2=
 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1k TEST_DIR/t.qcow2 64=
M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1K TEST_DIR/t.qcow2 64=
M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1M TEST_DIR/t.qcow2 64=
M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1048576 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1048576 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1024.0 TEST_DIR/t.qcow=
2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1024.0b TEST_DIR/t.qco=
w2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D1024 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D0.5k TEST_DIR/t.qcow2 =
64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D512 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D512 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D0.5K TEST_DIR/t.qcow2 =
64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D512 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D512 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D0.5M TEST_DIR/t.qcow2 =
64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D524288 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D524288 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 =3D=3D Check compat level option =3D=3D
>> =C2=A0 qemu-img create -f qcow2 -o compat=3D0.10 TEST_DIR/t.qcow2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.1=
0 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.1=
0 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_=
type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o compat=3D1.1 TEST_DIR/t.qcow2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1=
 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1=
 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_t=
ype=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o compat=3D0.42 TEST_DIR/t.qcow2 64M
>> =C2=A0 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.4=
2 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.4=
2 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_=
type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o compat=3Dfoobar TEST_DIR/t.qcow2 64M
>> =C2=A0 qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3Dfoo=
bar cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3Dfoo=
bar cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compressio=
n_type=3Dzlib
>> =C2=A0 =3D=3D Check preallocation option =3D=3D
>> =C2=A0 qemu-img create -f qcow2 -o preallocation=3Doff TEST_DIR/t.qcow2 =
64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D65536 preallocation=3Doff lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D65536 preallocation=3Doff lazy_refcounts=3Doff refcount_bits=3D16 compre=
ssion_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o preallocation=3Dmetadata TEST_DIR/t.q=
cow2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D65536 preallocation=3Dmetadata lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D65536 preallocation=3Dmetadata lazy_refcounts=3Doff refcount_bits=3D16 c=
ompression_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o preallocation=3D1234 TEST_DIR/t.qcow2=
 64M
>> =C2=A0 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D65536 preallocation=3D1234 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=
=3D65536 preallocation=3D1234 lazy_refcounts=3Doff refcount_bits=3D16 compr=
ession_type=3Dzlib
>> =C2=A0 =3D=3D Check encryption option =3D=3D
>> =C2=A0 qemu-img create -f qcow2 -o encryption=3Doff TEST_DIR/t.qcow2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=
=3Doff cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=
=3Doff cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compres=
sion_type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 --object secret,id=3Dsec0,data=3D123456 =
-o encryption=3Don,encrypt.key-secret=3Dsec0 TEST_DIR/t.qcow2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=
=3Don encrypt.key-secret=3Dsec0 cluster_size=3D65536 lazy_refcounts=3Doff r=
efcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=
=3Don encrypt.key-secret=3Dsec0 cluster_size=3D65536 lazy_refcounts=3Doff r=
efcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 =3D=3D Check lazy_refcounts option (only with v3) =3D=3D
>> =C2=A0 qemu-img create -f qcow2 -o compat=3D1.1,lazy_refcounts=3Doff TES=
T_DIR/t.qcow2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1=
 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1=
 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_t=
ype=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o compat=3D1.1,lazy_refcounts=3Don TEST=
_DIR/t.qcow2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1=
 cluster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.1=
 cluster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16 compression_ty=
pe=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o compat=3D0.10,lazy_refcounts=3Doff TE=
ST_DIR/t.qcow2 64M
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.1=
0 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.1=
0 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_=
type=3Dzlib
>> =C2=A0 qemu-img create -f qcow2 -o compat=3D0.10,lazy_refcounts=3Don TES=
T_DIR/t.qcow2 64M
>> =C2=A0 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with co=
mpatibility level 1.1 and above (use version=3Dv3 or greater)
>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.1=
0 cluster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.1=
0 cluster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16 compression_t=
ype=3Dzlib
>> =C2=A0 *** done
>> diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
>> index d27692a33c..3e47f537e8 100644
>> --- a/tests/qemu-iotests/060.out
>> +++ b/tests/qemu-iotests/060.out
>> @@ -17,6 +17,7 @@ virtual size: 64 MiB (67108864 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 corrupt: true
>> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
>> index cea7fedfdc..c913f02ad6 100644
>> --- a/tests/qemu-iotests/061.out
>> +++ b/tests/qemu-iotests/061.out
>> @@ -491,6 +491,7 @@ virtual size: 64 MiB (67108864 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: TEST_DIR/t.IMGFMT.data
>> @@ -511,6 +512,7 @@ virtual size: 64 MiB (67108864 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: foo
>> @@ -524,6 +526,7 @@ virtual size: 64 MiB (67108864 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file raw: false
>> @@ -538,6 +541,7 @@ virtual size: 64 MiB (67108864 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: TEST_DIR/t.IMGFMT.data
>> @@ -550,6 +554,7 @@ virtual size: 64 MiB (67108864 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: TEST_DIR/t.IMGFMT.data
>> @@ -563,6 +568,7 @@ virtual size: 64 MiB (67108864 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: TEST_DIR/t.IMGFMT.data
>> diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
>> index 6426474271..106303b5a5 100755
>> --- a/tests/qemu-iotests/065
>> +++ b/tests/qemu-iotests/065
>> @@ -88,23 +88,25 @@ class TestQMP(TestImageInfoSpecific):
>> =C2=A0 class TestQCow2(TestQemuImgInfo):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''Testing a qcow2 version 2 image'''
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D0.10'
>> -=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '0.10', 'refcount-bits'=
: 16 }
>> -=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 0.10', 'refcount bits: =
16' ]
>> +=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '0.10', 'refcount-bits'=
: 16, 'compression-type': 'zlib' }
>> +=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 0.10', 'compression typ=
e: zlib', 'refcount bits: 16' ]
>> =C2=A0 class TestQCow3NotLazy(TestQemuImgInfo):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''Testing a qcow2 version 3 image with l=
azy refcounts disabled'''
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refcou=
nts=3Doff'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '1.1', 'lazy=
-refcounts': False,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False }
>> -=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'lazy refcounts: =
false',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zl=
ib' }
>> +=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'compression type=
: zlib', 'lazy refcounts: false',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcoun=
t bits: 16', 'corrupt: false' ]
>> =C2=A0 class TestQCow3Lazy(TestQemuImgInfo):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''Testing a qcow2 version 3 image with l=
azy refcounts enabled'''
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refcou=
nts=3Don'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '1.1', 'lazy=
-refcounts': True,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False }
>> -=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'lazy refcounts: =
true',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zl=
ib' }
>> +=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'compression type=
: zlib', 'lazy refcounts: true',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcoun=
t bits: 16', 'corrupt: false' ]
>> =C2=A0 class TestQCow3NotLazyQMP(TestQMP):
>> @@ -113,7 +115,8 @@ class TestQCow3NotLazyQMP(TestQMP):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refcou=
nts=3Doff'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_options =3D 'lazy-refcounts=3Don'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compare =3D { 'compat': '1.1', 'lazy-refc=
ounts': False,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'corrupt': False }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'corrupt': False,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zlib' }
>> =C2=A0 class TestQCow3LazyQMP(TestQMP):
>> @@ -122,7 +125,8 @@ class TestQCow3LazyQMP(TestQMP):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refcou=
nts=3Don'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_options =3D 'lazy-refcounts=3Doff'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compare =3D { 'compat': '1.1', 'lazy-refc=
ounts': True,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'corrupt': False }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'corrupt': False,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zlib' }
>> =C2=A0 TestImageInfoSpecific =3D None
>> =C2=A0 TestQemuImgInfo =3D None
>> diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
>> index c7aa2e4820..885a8874a5 100644
>> --- a/tests/qemu-iotests/144.out
>> +++ b/tests/qemu-iotests/144.out
>> @@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D5368=
70912
>> =C2=A0 { 'execute': 'qmp_capabilities' }
>> =C2=A0 {"return": {}}
>> =C2=A0 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': '=
virtio0', 'snapshot-file':'TEST_DIR/tmp.IMGFMT', 'format': 'IMGFMT' } }
>> -Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D536870912 backing_f=
ile=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcou=
nts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D536870912 backing_f=
ile=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcou=
nts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 {"return": {}}
>> =C2=A0 =3D=3D=3D Performing block-commit on active layer =3D=3D=3D
>> @@ -31,6 +31,6 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D53=
6870912 backing_file=3DTEST_DIR/
>> =C2=A0 =3D=3D=3D Performing Live Snapshot 2 =3D=3D=3D
>> =C2=A0 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': '=
virtio0', 'snapshot-file':'TEST_DIR/tmp2.IMGFMT', 'format': 'IMGFMT' } }
>> -Formatting 'TEST_DIR/tmp2.qcow2', fmt=3Dqcow2 size=3D536870912 backing_=
file=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refco=
unts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/tmp2.qcow2', fmt=3Dqcow2 size=3D536870912 backing_=
file=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refco=
unts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 {"return": {}}
>> =C2=A0 *** done
>> diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
>> index a8eea166c3..ae43654d32 100644
>> --- a/tests/qemu-iotests/182.out
>> +++ b/tests/qemu-iotests/182.out
>> @@ -13,7 +13,7 @@ Is another process using the image [TEST_DIR/t.qcow2]?
>> =C2=A0 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node0', =
'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
>> =C2=A0 {"return": {}}
>> =C2=A0 {'execute': 'blockdev-snapshot-sync', 'arguments': { 'node-name':=
 'node0', 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'snapshot-node-name=
': 'node1' } }
>> -Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 size=3D197120 backin=
g_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dfile cluster_size=3D65536 lazy_refc=
ounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 size=3D197120 backin=
g_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dfile cluster_size=3D65536 lazy_refc=
ounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>> =C2=A0 {"return": {}}
>> =C2=A0 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node1', =
'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
>> =C2=A0 {"return": {}}
>> diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
>> index 7ac8404d11..091b9126ce 100644
>> --- a/tests/qemu-iotests/242.out
>> +++ b/tests/qemu-iotests/242.out
>> @@ -12,6 +12,7 @@ virtual size: 1 MiB (1048576 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 corrupt: false
>> @@ -32,6 +33,7 @@ virtual size: 1 MiB (1048576 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0]:
>> @@ -64,6 +66,7 @@ virtual size: 1 MiB (1048576 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0]:
>> @@ -104,6 +107,7 @@ virtual size: 1 MiB (1048576 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0]:
>> @@ -153,6 +157,7 @@ virtual size: 1 MiB (1048576 bytes)
>> =C2=A0 cluster_size: 65536
>> =C2=A0 Format specific information:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0]:
>> diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
>> index 348909fdef..a3c99fd62e 100644
>> --- a/tests/qemu-iotests/255.out
>> +++ b/tests/qemu-iotests/255.out
>> @@ -3,9 +3,9 @@ Finishing a commit job with background reads
>> =C2=A0 =3D=3D=3D Create backing chain and start VM =3D=3D=3D
>> -Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=3Dqcow2 size=3D134217728 clu=
ster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=3Dqcow2 size=3D134217728 clu=
ster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=
=3Dzlib
>> -Formatting 'TEST_DIR/PID-t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/PID-t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster=
_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzl=
ib
>> =C2=A0 =3D=3D=3D Start background read requests =3D=3D=3D
>> @@ -23,9 +23,9 @@ Closing the VM while a job is being cancelled
>> =C2=A0 =3D=3D=3D Create images and start VM =3D=3D=3D
>> -Formatting 'TEST_DIR/PID-src.qcow2', fmt=3Dqcow2 size=3D134217728 clust=
er_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/PID-src.qcow2', fmt=3Dqcow2 size=3D134217728 clust=
er_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3D=
zlib
>> -Formatting 'TEST_DIR/PID-dst.qcow2', fmt=3Dqcow2 size=3D134217728 clust=
er_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> +Formatting 'TEST_DIR/PID-dst.qcow2', fmt=3Dqcow2 size=3D134217728 clust=
er_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3D=
zlib
>> =C2=A0 wrote 1048576/1048576 bytes at offset 0
>> =C2=A0 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>
>=20
>=20


--=20
Best regards,
Vladimir

