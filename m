Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843EAC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E63621775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 10:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yf5CMUZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E63621775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0NUJ-0007ny-Cq
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 05:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0NTc-0006fJ-V7
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0NTb-0003NZ-Rj
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 05:36:40 -0500
Received: from mail-eopbgr60124.outbound.protection.outlook.com
 ([40.107.6.124]:40190 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j0NTZ-00035H-2K; Sat, 08 Feb 2020 05:36:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W27vmzcu1NKVYHyQz0s1TsjdGmzTU0iSo8KsOA166w4GukqZDvcEUb+wHF8ABtOVFvHgeEnQwaElLxzZe/QuVojDOHOTIyPwtu8mki6HlgvQgj5gZZbL1E3W4yxgoikDWKAPKvu5rhIly69RYRv63nKxvqbiYe1bKmc0pg2tUP47beET3xZVmwe6c5/kYl7gIepCFiIrdItaaAGj2kZC1y22gR/xiDtkVIv52K6cZGIoPg/e/DYkZS0EvfNjVUiAfItBB24UBSDrTzvuEZy7tRaf4gGwOOmadAZAymJjOnaazN1vsLLmACp26XmP/l1aUSOMXlM+wDvYjfgZuf0AAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCa4omPyS7QR2nzBtxg7IvGeRGsMO0xKVrHwca7mOkc=;
 b=Ixp7nqC8ilssWIzFTvbvxEQxVik0GxWU3kGeaCbQ6Kc+IiN9XZcT6h/n3m7a8p5/vOV1Q3ZtAPnO+VjiiaYgCA/RrxtO1LjtAsXQL+UtYLEXQxjH5gQM6uIdFhtmGrVM2W3XpGrOTwj5jJxLEwG+1ui36I7lVVYDGPZUNB3O+u/roCUrm83tyXnczHQW8i2p+177Et7FjK114poTFDpc1tQndZKXxWsnaesmdcZNp37MChVlYdZdB3cIDOHNWlpZmsUYld95JU4UXVfGaZamZN4nVaUZoT9MMzuxRlGzdadpQK/Ps/vc7TFy+YCW7935gECtIzGT8nZtoVa2MXHHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCa4omPyS7QR2nzBtxg7IvGeRGsMO0xKVrHwca7mOkc=;
 b=Yf5CMUZ3c61n6RqNxJ0/qJ218KkaIPiPj9ULUKH6OzGiOvGkKV4mGXKogupaRFA9Pdcy638Y7K8kuHuh581yf/s2DMeHjVOBdLrQMYSDuyCWP/rt/Ly3BDQbBhvzwyV9FkdVLX/1hSiqJSv14azYKHxyfdA1zfL8woDJg3d5yoc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4166.eurprd08.prod.outlook.com (20.179.1.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Sat, 8 Feb 2020 10:36:31 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.024; Sat, 8 Feb 2020
 10:36:31 +0000
Subject: Re: ping Re: [PATCH for-5.0 v2 0/3] benchmark util
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
 <e1efd3d2-b623-292b-67a9-e3cdd479f104@virtuozzo.com>
X-Tagtoolbar-Keys: D20200208133628629
Message-ID: <fca8ced2-b3c6-74db-0d70-11ac3304b273@virtuozzo.com>
Date: Sat, 8 Feb 2020 13:36:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <e1efd3d2-b623-292b-67a9-e3cdd479f104@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR09CA0081.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR09CA0081.eurprd09.prod.outlook.com (2603:10a6:7:3d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Sat, 8 Feb 2020 10:36:30 +0000
X-Tagtoolbar-Keys: D20200208133628629
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bfda370-0b7b-423e-2ea0-08d7ac82c2b3
X-MS-TrafficTypeDiagnostic: AM6PR08MB4166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4166046B02F1BD76FB1F7BECC11F0@AM6PR08MB4166.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(81156014)(2906002)(8676002)(8936002)(86362001)(31696002)(16526019)(81166006)(4326008)(52116002)(316002)(478600001)(16576012)(5660300002)(6486002)(66476007)(66556008)(36756003)(31686004)(26005)(66946007)(186003)(2616005)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4166;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF2aUnscYoshatz01hctdEbtQDysd4K/XkR8LwLaOAIB74qEG4jmbPszfVKt+GvifUo4cDGwqPLZZJo8TfQueVQLe6CXm9luCcDmzVgUT69ToeYQhOXpuH0muDvbTFWFvL04eaoD80hyd/XwYSFI0wkuQbF6G+nZgRvail1e659C5Ne5uv0Q+8tDX0RgotYn50qrG2kbiwUwbll+XoF7cq0MlnEyD+9k92By4IYNFG5kIPDeC+3nA8V2deNWtJsWym4I/kYG3/sXDHlolhj2jX0GpsAHf5eq8Q3jkgR0diLxAjOtUyBrfw/6PrFjz4XVaWveTCT7IWtM0foOaXeLBpfhMyy+4SuKPg9GFLR0Km3mOBvj1oM2DHmM2n9r/5r2QOwP2xU0bfZdGaRc0PYiLYcDR47bgFxQfENQ7yeGbXAunMrHY5Jk2WJWVmxcbjl7
X-MS-Exchange-AntiSpam-MessageData: znv77AMaCoPkmGs5/jIzoG9JipETtuzk4kFfYDTC3IeQsNivzkN1l5wWgCpXLEhBs6wDTqIkTXy/n9elV22n9vU1hTHSBN72Vb7eft63MraAhaJad+z3wKVHqWgo99GlpqiPNnPb3+yB1ogpI7MitQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfda370-0b7b-423e-2ea0-08d7ac82c2b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 10:36:31.0292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHFKdzrth9zFenQBPvUDYxCRXJxl2z4hvL8VX/TEhnsZLwoZEYulw5K2Ps8J4I54gs0TrrtPeScWwDUxLSVMHfD2ePkdcAaiMXLRhH1XSE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4166
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.124
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
Cc: kwolf@redhat.com, ehabkost@redhat.com, stefanha@gmail.com,
 mreitz@redhat.com, crosa@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pingg..

Hi! Could it be merged at all?

20.01.2020 12:10, Vladimir Sementsov-Ogievskiy wrote:
> ping
>=20
> 26.11.2019 18:48, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Here is simple benchmarking utility, to generate performance
>> comparison tables, like the following:
>>
>> ----------=C2=A0 -------------=C2=A0 -------------=C2=A0 -------------
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 backup-1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup-2=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mirror
>> ssd -> ssd=C2=A0 0.43 +- 0.00=C2=A0=C2=A0 4.48 +- 0.06=C2=A0=C2=A0 4.38 =
+- 0.02
>> ssd -> hdd=C2=A0 10.60 +- 0.08=C2=A0 10.69 +- 0.18=C2=A0 10.57 +- 0.05
>> ssd -> nbd=C2=A0 33.81 +- 0.37=C2=A0 10.67 +- 0.17=C2=A0 10.07 +- 0.07
>> ----------=C2=A0 -------------=C2=A0 -------------=C2=A0 -------------
>>
>> This is a v2, as v1 was inside
>> =C2=A0 "[RFC 00/24] backup performance: block_status + async"
>>
>> I'll use this benchmark in other series, hope someone
>> will like it.
>>
>> Vladimir Sementsov-Ogievskiy (3):
>> =C2=A0=C2=A0 python: add simplebench.py
>> =C2=A0=C2=A0 python: add qemu/bench_block_job.py
>> =C2=A0=C2=A0 python: add example usage of simplebench
>>
>> =C2=A0 python/bench-example.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 80 +++++++++++++++++++++
>> =C2=A0 python/qemu/bench_block_job.py | 115 ++++++++++++++++++++++++++++=
+
>> =C2=A0 python/simplebench.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 128 +++++++++++++++++++++++++++++++++
>> =C2=A0 3 files changed, 323 insertions(+)
>> =C2=A0 create mode 100644 python/bench-example.py
>> =C2=A0 create mode 100755 python/qemu/bench_block_job.py
>> =C2=A0 create mode 100644 python/simplebench.py
>>
>=20
>=20


--=20
Best regards,
Vladimir

