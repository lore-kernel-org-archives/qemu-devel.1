Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34E6C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02BF206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y5KnIJbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02BF206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMcb-0007Nd-Tf
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCMbz-0006uP-M2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCMby-000656-1I
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:06:51 -0400
Received: from mail-am6eur05on2072d.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::72d]:19296
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCMbx-0005xN-Qm; Thu, 12 Mar 2020 08:06:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgJh5CDYnkkCKynLOvct+6c98k+dex3YTIqEQ7cUbudXa+40sJAaBl/fp7EZ1Q8U/p4QpDD/WxSIT3njux0OIRGtVKEx+VeLRJkqdFz1RkhrNPfRYw1A8hy3hr63tL5Bo1k+Y57YQsenqFDK6LpT8WCQfh9hiZOdAKndN6U34GQpmimYVuf+Y1773lITDVaPt55ZjPpNs7wwEd7zpreWya37gXYHW3fGyYkHEbsoJA2tgJMo3N+rSCn+ERb+iyBCHqYRNU8gxz0KMv4r87NOi+r08lOaJjIRJ1zOrfNPbVIscYoAJiEllvihPmp9xeynIPy9+JVO1ZkQpJKKjATlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f3SYoeM1V5hf/0N0m0tNn6nuVVSalPuYV+SgU1iQCg=;
 b=FJysYxZBKn7vzVQT2e9BgHhcppDRO3hAUH9qeqyI4Q1aSLwo7q7q6AEtG1Z4rIpK0aKS9Ir5V+OYfH2wqmKenEutRZ+RmERr6UIN7cxVNHQIgLFvUqORAzRXjOR8MsnrolavUlFX7i8KqVAzEtK3NyjGrljK/Pn6SXGXj4EOsVKnITkPo8KHn7IgIreBsNgyKuU7cc39/vrB8sj5Dj3ShihNIW4Zgp/94kHvYEHYx3skOtF4k6L93tFcnncJeoBfD43glL1TW2sB8juqLvAUGbGcYygvZNh4jOnjC4uww0wHNBmYVKrTuSz91+w0XS8+4dlaKw/nkMRbw++2tk4avw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f3SYoeM1V5hf/0N0m0tNn6nuVVSalPuYV+SgU1iQCg=;
 b=Y5KnIJbI8lPqJ2kZeBG3DER+CmD2zHHRCLEgCtF0iQG8LSs3DIuYuWUD0uloI3tEsia/cjeR0m37HkSOJxlhvF95zIVdVVxtYvYgcS7awlvXERU7U9ANjMiijGMvoMwq+bufkrpuBI0mTcE+87iZkwtzt/q+KNuSJyRfAV0PbBE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4753.eurprd08.prod.outlook.com (10.255.98.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 12:06:47 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2814.007; Thu, 12 Mar 2020
 12:06:47 +0000
Subject: Re: [PATCH 3/3] block: fail on open when file size is unaligned to
 request_alignment
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130152218.7600-1-vsementsov@virtuozzo.com>
 <20200130152218.7600-4-vsementsov@virtuozzo.com>
 <4fb7d692-4009-c6a7-c765-292ac8073ae3@redhat.com>
 <a36e50a8-38c5-027d-16b8-1daa10ed378c@virtuozzo.com>
X-Tagtoolbar-Keys: D20200312150644637
Message-ID: <ad885deb-6384-700e-6a26-a2dd9e1e06f9@virtuozzo.com>
Date: Thu, 12 Mar 2020 15:06:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <a36e50a8-38c5-027d-16b8-1daa10ed378c@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0236.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0236.eurprd05.prod.outlook.com (2603:10a6:3:fb::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Thu, 12 Mar 2020 12:06:46 +0000
X-Tagtoolbar-Keys: D20200312150644637
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ed7e4e8-e7c8-4f0b-c758-08d7c67dd698
X-MS-TrafficTypeDiagnostic: AM6PR08MB4753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4753E3D560915B3A6107F867C1FD0@AM6PR08MB4753.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(346002)(376002)(396003)(136003)(199004)(2616005)(31686004)(956004)(36756003)(8936002)(81156014)(81166006)(8676002)(6486002)(5660300002)(66476007)(66946007)(107886003)(66556008)(53546011)(52116002)(4326008)(16576012)(2906002)(86362001)(186003)(26005)(31696002)(16526019)(478600001)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4753;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkLA7in4La1bqjlZDk7EYXtVSJdPuYuoWJb8h6WD/GpiW9tP5n5MMeR2wu4lMoPsLxT3e48Qt7mapXYDLDuujeZ6L6u9dT7jryhX3Xf80WcPIf434yu68fB1v1RFs9lYbjjmivSNpBxxVay1eCQ4jtSffUbqbeCxTI1MgjcJ+igZFa4J2OG1Fs7xSVhoVKQt5OEqjzoEnv+c9pB60fXksdHP1Ov8X4iab9733UzJT+a8/C6IHMHO3nNZI51UhBye/Xr1IpU21rabBurkhF75oBia7EiL/AAiAqh54jkUY/nv7WCjCnC2zOQ/5oRpoSYLVsvfdyC+cFv5tbU+rlzx6T1EgsP5j2rW4C1FFgPzHARqqJI+BS1ZpCPd4HMnl5IizRp0e+QLXL8h23KayI/nJQaHB/FjTSI06l3Wn8o3E2b9Fn2tTyNTLoYu/wPQCM1G
X-MS-Exchange-AntiSpam-MessageData: aRfrdHWZ4MaD0K1GY/Tmrxfc2kBGpJwf0dySL7fGH9fJl/mhzC8apHSn0kv+0EAK9mZOFICrAyPtnNO1ujOoYlbamobU1lOunZ6EnPGQXJvCKEZiK903mP6Xpz5Ulu/mQXROFcAXTa8WE1zz9mJ+sQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed7e4e8-e7c8-4f0b-c758-08d7c67dd698
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 12:06:47.1751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBvjQN4ovZECRqH9DARkiMLyekGPYzl2EX1E/7ZFzPI49PbaF2IK4RO+Q/mc0mViJ7zy6O4kWFBZWkvkbeWIG0kJstJacabk6FL3rt1T88M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4753
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1b::72d
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.03.2020 14:59, Vladimir Sementsov-Ogievskiy wrote:
> 11.03.2020 14:06, Max Reitz wrote:
>> On 30.01.20 16:22, Vladimir Sementsov-Ogievskiy wrote:
>>> Prior to the commit the following command lead to crash:
>>>
>>> =A0=A0 ./qemu-io --image-opts -c 'write 0 512' \
>>> =A0=A0 driver=3Dblkdebug,align=3D4096,image.driver=3Dnull-co,image.size=
=3D512
>>>
>>> It failes on assertion in bdrv_aligned_pwritev:
>>> =A0=A0 "end_sector <=3D bs->total_sectors || child->perm & BLK_PERM_RES=
IZE"
>>>
>>> The problem is obvious: 512 is aligned to 4096 and becomes larger than
>>> file size. And the core bad thing is that file size is unaligned to
>>> request_alignment.
>>>
>>> Let's catch such case on bdrv_open_driver and fail.
>>
>> I think we had a discussion on this before, but I can=92t find it right
>> now.=A0 (Although I think that had more to do with something in the
>> file-posix driver, because it wasn=92t limited to alignments above 512.)
>>
>> In any case, the file itself is totally valid.=A0 Most importantly, qcow=
2
>> will regularly create files with unaligned file lengths.
>>
>> So let me create a qcow2 image on a 4k-aligned device:
>>
>> $ truncate 512M fs.img
>> $ sudo losetup -f --show -b 4096 fs.img
>> /dev/loop0
>> $ sudo mkfs.ext4 /dev/loop0
>> [...]
>> $ sudo mount /dev/loop0 /mnt/tmp
>>
>> $ sudo ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 64M
>> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 size=3D67108864
>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>> $ sudo ./qemu-io -t none -c quit /mnt/tmp/foo.qcow2
>> qemu-io: can't open device /mnt/tmp/foo.qcow2: File size is unaligned to
>> request alignment
>>
>> Which is too bad.
>=20
> What exactly is bad?
>=20
> Is it correct that create succeeded? Without new error, how would qcow2 d=
river
> read from unaligned tail of file-posix? It will crash, isn't it?

Hmm, it crashes only on write-part if don't have RESIZE permission.. So for=
 qcow2
everything is OK.

And generic read don't care about reading past-EOF because of alignment, re=
ad is passed
to driver.

>=20
>>
>> So the real solution would probably...=A0 Be to align the file size up t=
o
>> the alignment?
>=20
> On creation, you mean?
>=20
>>
>> Max
>>
>>> Note, that file size and request_alignment may become out of sync
>>> later, so this commit is not full fix of the problem, but it's better
>>> than nothing.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =A0 block.c | 7 +++++++
>>> =A0 1 file changed, 7 insertions(+)
>>>
>>> diff --git a/block.c b/block.c
>>> index ecd09dbbfd..4cfc6c33a2 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -1324,6 +1324,13 @@ static int bdrv_open_driver(BlockDriverState *bs=
, BlockDriver *drv,
>>> =A0=A0=A0=A0=A0 assert(bdrv_min_mem_align(bs) !=3D 0);
>>> =A0=A0=A0=A0=A0 assert(is_power_of_2(bs->bl.request_alignment));
>>> +=A0=A0=A0 if (bs->bl.request_alignment > 512 &&
>>> +=A0=A0=A0=A0=A0=A0=A0 !QEMU_IS_ALIGNED(bs->total_sectors, bs->bl.reque=
st_alignment / 512))
>>> +=A0=A0=A0 {
>>> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "File size is unaligned to requ=
est alignment");
>>> +=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>>> +=A0=A0=A0 }
>>> +
>>> =A0=A0=A0=A0=A0 for (i =3D 0; i < bs->quiesce_counter; i++) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (drv->bdrv_co_drain_begin) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 drv->bdrv_co_drain_begin(bs);
>>>
>>
>>
>=20
>=20


--=20
Best regards,
Vladimir

