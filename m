Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE02C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D914E20769
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MY3woRGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914E20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMq0e-0003dr-2c
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 05:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMpzH-0002eF-Fg
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMpzG-0007Ri-8Y
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:30:11 -0400
Received: from mail-eopbgr80129.outbound.protection.outlook.com
 ([40.107.8.129]:28291 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMpzC-0007MQ-0U; Fri, 10 Apr 2020 05:30:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9qwFHVbCESCwrkd/ra3YTQN6FfOqixqEtrGXT9gBV7mj/4xm0hn7heqQDXNdzR/M/IFf0AxbjC76MTZPDKLIehGBGLEnnIJQZ8vGSHEsONgyIWSy05eJ3+RENpzB/ml0mzlO3b6EdIuF3Q1qjmpuJ/bzY4pYVUgdD0JmjZA500ozKzT2fI5frz67UbRgGQJsiciwftjFZiElE9/uxGz6TgVXxrX4kUzmzzP+ROPpiDQx+hH7rCSTaqKv4fFF0KBzz043pYdUwWSbMpD3Qic07oxYMoN87oyMZxmr8vtAXDGYi/gjLFWSsAaGaZhducsHKhYXoDxg0muf7CmarX7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNflOSOakGv99aMkgYrzKnBA541yjUkhyTm4jq9Zvgo=;
 b=BYsL4SXoA5buPDTybIxeqi1QEDvOtaQE6vQ4x/7lMVFO7+mMBf70veWUJZsh5t9+gAfxE/8U+weDIiVfcVZQCt2RlaPjyv3AmFd2DuEN7NL5Vkk6KwOy4Vo4hlbkvnt78QLGgf8/iq0kcSoco4jdgFLR/1xYC0TGNa2H2BiuEls4Huu7xptZGoVTA2EMMkk6tVxsC4Y0RwMm70OCAqzCQrLFr5DapnN2Vf1fbi7BCLxI8NMk8mL5P6Jt8yMnoD6GGfZncXVEjoiDZHtrveLSqJA04m6sJiL2pqjrfv4Qt8yjZg+HXAECQY2YQzAt3ZlfTugeFFOSOkbKoR0HK5rYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNflOSOakGv99aMkgYrzKnBA541yjUkhyTm4jq9Zvgo=;
 b=MY3woRGbZHLl4P8YtfzZ19IoSHK9O6FK4BPqjXokdfQkaWtRCVeNPMW7e35wr6SJvIe2m2q270+6C20JatFD7KmhstfctZIVYPDCYqVH3gg2qyo8Jl3OvwP+dzrcKc2OR8YKvK6MbIFkaNx7bbKCTvicEy1Gu2Sbw2v22yNsK7w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5512.eurprd08.prod.outlook.com (2603:10a6:20b:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Fri, 10 Apr
 2020 09:30:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 09:30:01 +0000
Subject: Re: [PATCH v4 07/30] qcow2: Document the Extended L2 Entries feature
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
 <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200410122959690
Message-ID: <781c734c-e53c-76ae-74de-26d9e827e1a2@virtuozzo.com>
Date: Fri, 10 Apr 2020 12:29:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.134) by
 ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Fri, 10 Apr 2020 09:30:00 +0000
X-Tagtoolbar-Keys: D20200410122959690
X-Originating-IP: [185.215.60.134]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9075f97f-c70b-4db3-9c78-08d7dd31be83
X-MS-TrafficTypeDiagnostic: AM7PR08MB5512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5512CA78AD9EDE6919F19E6FC1DE0@AM7PR08MB5512.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(376002)(39840400004)(346002)(396003)(366004)(2616005)(53546011)(8676002)(81156014)(4326008)(956004)(186003)(31696002)(107886003)(86362001)(2906002)(110136005)(16576012)(8936002)(66946007)(31686004)(26005)(66476007)(478600001)(16526019)(66556008)(5660300002)(316002)(54906003)(6486002)(36756003)(52116002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9myxbiLTSsbiBF2y00NX/weQTOxZlKitjy6lAVd530Z57cNLxpCRgp5RI8I1dRLmpsiT2D4pShg8Xy5TvDK0J0Av9XFHZEk2UrwfMx84bIAO194O/zDXoep10LLwuf0iYKUYzLYfXoY5L7eDiz6LYEuW8TCfSeX2g0GRxWvkwjise4IR5hf5qe8+yrHMVoGw9LTexPKdB5Ej8JLOoegFcn6OGAv4htqokpEmgZVHZ/KVtF1W0Fab419TiOKBBR8l6W+TFOcJNUgZaIIA2k8IIJAVtQlc1+5pZTeGSohvlbRUm8v/8o5sAvZcR02chpabtTfIYWFmaxJfgYgEHCQvTev6bLF1jsy04Ir+dZQL7cFjOnC1kjYrlgm3bT1OdT/RVsMgag9PKVY86v8TUEDOHxu2mDEQ60kFOWet8yDBx8GfaeRzJC3ZRz348n9DL6u
X-MS-Exchange-AntiSpam-MessageData: gFQDyXuBUPjmMRGlDL44ik/OQEGr822mM/F8MdMMp3uBBKkeO7RSK4AW5Zo55oz+xMBlTfHW4f9iXZoIVaCmZ/F8WvO4BztX6exRiNia5h6yxwRWNe1Kpailkp77kVwcIoZAUVdJgezJ5dz41mR/Fg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9075f97f-c70b-4db3-9c78-08d7dd31be83
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 09:30:01.7040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ESGiIpnb1CJ9X6aSNjaP29KaRXloxYgOoPIhni2Lyn3/cyd82c5IGb8IiKBs7gH0eVE1IkpEc1SKsIbRUDoS+krh2eBC8Z0REfZeZSaCp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5512
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.129
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.04.2020 18:12, Eric Blake wrote:
> On 3/17/20 1:16 PM, Alberto Garcia wrote:
>> Subcluster allocation in qcow2 is implemented by extending the
>> existing L2 table entries and adding additional information to
>> indicate the allocation status of each subcluster.
>>
>> This patch documents the changes to the qcow2 format and how they
>> affect the calculation of the L2 cache size.
>>
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>> =C2=A0 docs/interop/qcow2.txt | 68 +++++++++++++++++++++++++++++++++++++=
+++--
>> =C2=A0 docs/qcow2-cache.txt=C2=A0=C2=A0 | 19 +++++++++++-
>> =C2=A0 2 files changed, 83 insertions(+), 4 deletions(-)
>>
>=20
>> +=3D=3D Extended L2 Entries =3D=3D
>> +
>> +An image uses Extended L2 Entries if bit 4 is set on the incompatible_f=
eatures
>> +field of the header.
>> +
>> +In these images standard data clusters are divided into 32 subclusters =
of the
>> +same size. They are contiguous and start from the beginning of the clus=
ter.
>> +Subclusters can be allocated independently and the L2 entry contains in=
formation
>> +indicating the status of each one of them. Compressed data clusters don=
't have
>> +subclusters so they are treated the same as in images without this feat=
ure.
>> +
>> +The size of an extended L2 entry is 128 bits so the number of entries p=
er table
>> +is calculated using this formula:
>> +
>> +=C2=A0=C2=A0=C2=A0 l2_entries =3D (cluster_size / (2 * sizeof(uint64_t)=
))
>> +
>> +The first 64 bits have the same format as the standard L2 table entry d=
escribed
>> +in the previous section, with the exception of bit 0 of the standard cl=
uster
>> +descriptor.
>> +
>> +The last 64 bits contain a subcluster allocation bitmap with this forma=
t:
>> +
>> +Subcluster Allocation Bitmap (for standard clusters):
>> +
>> +=C2=A0=C2=A0=C2=A0 Bit=C2=A0 0 -=C2=A0 31:=C2=A0=C2=A0 Allocation statu=
s (one bit per subcluster)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: the subcluster is allocate=
d. In this case the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 host cluste=
r offset field must contain a valid
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0: the subcluster is not allo=
cated. In this case
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read reques=
ts shall go to the backing file or
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return zero=
s if there is no backing file data.
>=20
> Hmm - raw external files are incompatible with backing files.=C2=A0 Shoul=
d we also document that extended L2 entries are incompatible with raw exter=
nal files?=C2=A0 (The text here reminded me about it, but it would be the t=
ext earlier at the incompatible feature bits that we edit if we want that a=
dditional restriction; compare to the restriction in the autoclear bit 1).=
=C2=A0 After all, when raw external file is enabled, the entire image is al=
located, at which point subclusters don't make much sense.

It still may cache information about zeroed subclusters: gives more detaile=
d block-status. But we should mention somehow external files. Hm. not only =
for raw external files, but it is documented that cluster can't be unalloca=
ted when an external data file is used.

>=20
> And in stating that, it looks like we have a pre-existing hole in that he=
ader bytes 8-15 don't mention the incompatibility with autoclear (when thin=
gs are incompatible, it's best to mention the restriction from both sides, =
rather than only one of the sides, to make sure the reader notices the rest=
riction regardless of which field they look up first). But tweaking that wo=
uld be a separate patch.
>=20


--=20
Best regards,
Vladimir

