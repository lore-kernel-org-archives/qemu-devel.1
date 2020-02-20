Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E37BC11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591F424656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h/F2yWyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591F424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4hmn-0006QF-J2
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4hm7-00060v-3w
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4hm5-00006Y-GT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:05:38 -0500
Received: from mail-eopbgr70098.outbound.protection.outlook.com
 ([40.107.7.98]:10799 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4hm4-000055-NU
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:05:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4nT/1lew7OlFXm17L5YQarIdkvk9qF/H7rO09bTO+91j6iRpG7n6eP+HRf2PoY7k6GSw8F+QyMNIm/IJMQTKtXvvJVHBTPLV+sKKVjXBr0hRyrzgRIZwQmvhvbQFErEBbwfTpuTfaVvxaHVriABbD0M6ArMwUKUnGybioa8JxhcwzA+Z3dG4zRJBtKt7aiMgaZdOxw2+UBcd7olzwGdtEkBAq1Cbp3wHLCh9ADpuQY5DuJOFUZRocify9ZiRbZ1jUDObVcXUKRoYYewIqqtyGek3UE8vkJRkzVfOG42gC0hSrnbbO7Khu8OK9umrc/PeCpEZtCPppkrMw6uowT/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAjEPMAuwmakdFSJBGkya1OOaDtJ8V89699fCsSuksM=;
 b=A5tVUZiiciWkS4C2sm7hCY+xaBwt3NcPMnjs5aBSTLwOYOr+Iiekd8JQ+RXneY957yXZTwojs2vSw1uPaQ/hJ5+gQQ18GLlNz4eu64W8gTfx16+PEhh2VQk+ECCQ5aRZJQDxO59jzEnBWusqe75nLkDS3PhPRWsC4YA19hZHbwu+7Kc9qgavqdPyub48aOapdyrpRsaJ6W8ysp2JHTgSACX/gDNpL8J74hn4VjDPhY25/jZyldvzdQRTut94QA1TsBoV150IMGi7sH/pYvlK1LaSdsUy/6MeP6FHtAHNgJyDRgMzTrvvLNOcKLtWJCKbhdVrFhcEQylHfzA8ZAuB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAjEPMAuwmakdFSJBGkya1OOaDtJ8V89699fCsSuksM=;
 b=h/F2yWyQ0W0NF5DUor95PwRUa+gbbjv7OcM5qlKmWVjEiXODCRI1uD3qoTheihhy9CiqvRJmPI5Lg6gZ9nShLn9EdtD8e149RnuOQEm1n0XRCedNLfrRfsNvmxgH60mI35qPSuEJACC8F0T8HNHAbY4CTZfeWLtT3L/l6TW80TE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3656.eurprd08.prod.outlook.com (20.177.116.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Thu, 20 Feb 2020 09:05:33 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 09:05:33 +0000
Subject: Re: Race condition in overlayed qcow2?
To: dovgaluk <dovgaluk@ispras.ru>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200220120530850
Message-ID: <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
Date: Thu, 20 Feb 2020 12:05:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <5891b48a131321be62a4a311253da44c@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0101CA0020.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Thu, 20 Feb 2020 09:05:32 +0000
X-Tagtoolbar-Keys: D20200220120530850
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e7bfb6-8e73-4c1f-3864-08d7b5e40a71
X-MS-TrafficTypeDiagnostic: AM6PR08MB3656:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3656BBAD1A8A9A8EEF3D6BF0C1130@AM6PR08MB3656.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(8676002)(2616005)(316002)(2906002)(66556008)(66946007)(81156014)(8936002)(66476007)(81166006)(956004)(52116002)(16576012)(31696002)(6486002)(31686004)(26005)(478600001)(86362001)(5660300002)(186003)(6916009)(4326008)(16526019)(36756003)(505234006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3656;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gatZTO5xM0OJHRwFY+bGln07F1rkENix+R6o7qtRsPze7dEhIuYp/CN4GU2x9BL0LepTThu7Bm3Ud0dNv8SMwg57pcsCV00+vP1pIZn3xwqnOEXS9bMcVRHsSvT3assnKMbxNjgaLPXfNfhIVa3PPVY3UBwCmcN+OH1qBy6rIFV9YwNjXrhlEs/enKjTisxh+2eAR45qYINGqm2vb8uh5hE41IPLKrMT6/sp5HE692Xeg1HTpd/vz73JMntO2TiF/4no0g5g4D0t7Wa6zpoeZbAu32PTp3PpiHooIc3oRYetuQqT7hKIJSsXupalieiOTQeGFvP4tQMPogqkRdQbjlQY02lZgMStbzZf18iUcJU9hTOT27dPD++9DmfeD0uTE1z3t2GrDY6hbTdFaKWRhzTv87XYZ4TDouyuP0DLArV6xFd7fIXPpec5zSSGKNxQ/ttaz9hXoFW08z4yziAmDQYLuuR6fVxi5R6zWjJ7MMHsjvrzqwzBq3Ty/LZEaNP3
X-MS-Exchange-AntiSpam-MessageData: mgx7rUjqZm54oRGZI3h3uKTp2euGh1UI35W+wQBn5bvhI3lEaOniGAKgL7yXfxOFfsMPABOEvDc3SKf+qrK+q5UYhvEojr+ZztlYf/ib0W06QL9DS5SGmqeg6ZuXVM2VIoxfPUWgugJpbAeP502QNA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e7bfb6-8e73-4c1f-3864-08d7b5e40a71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 09:05:33.0436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTG7L+hk/lgxwtCZ6NIV3O6xwc6GdZJDqOQ9gPf1/j5h8iQaUg8buACCdzt7+kFZ7L/lrVrwXpTMUwkkw5Eimb5edfXncuyt3bevqCVJ2Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3656
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.98
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.02.2020 11:31, dovgaluk wrote:
> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-19 19=
:07:
>> 19.02.2020 17:32, dovgaluk wrote:
>>> I encountered a problem with record/replay of QEMU execution and figure=
d out the following, when
>>> QEMU is started with one virtual disk connected to the qcow2 image with=
 applied 'snapshot' option.
>>>
>>> The patch d710cf575ad5fb3ab329204620de45bfe50caa53 "block/qcow2: introd=
uce parallel subrequest handling in read and write"
>>> introduces some kind of race condition, which causes difference in the =
data read from the disk.
>>>
>>> I detected this by adding the following code, which logs IO operation c=
hecksum. And this checksum may be different in different runs of the same r=
ecorded execution.
>>>
>>> logging in blk_aio_complete function:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("%"PRId64": b=
lk_aio_complete\n", replay_get_current_icount());
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov =3D=
 acb->rwco.iobuf;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qiov && qiov->iov)=
 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size_t i, j;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t sum =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int count =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 for (i =3D 0 ; i < qiov->niov ; ++i) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 0 ; j < qiov->iov[i].iov_len ; ++j) =
{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sum +=3D ((uint8_t*)qio=
v->iov[i].iov_base)[j];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++count;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 qemu_log("--- iobuf offset %"PRIx64" len %x sum: %"PRIx64"\n", acb->rwc=
o.offset, count, sum);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> I tried to get rid of aio task by patching qcow2_co_preadv_part:
>>> ret =3D qcow2_co_preadv_task(bs, ret, cluster_offset, offset, cur_bytes=
, qiov, qiov_offset);
>>>
>>> That change fixed a bug, but I have no idea what to debug next to figur=
e out the exact reason of the failure.
>>>
>>> Do you have any ideas or hints?
>>>
>>
>> Hi!
>>
>> Hmm, do mean that read from the disk may return wrong data? It would
>> be very bad of course :(
>> Could you provide a reproducer, so that I can look at it and debug?
>=20
> It is just a winxp-32 image. I record the execution and replay it with th=
e following command lines:
>=20
> qemu-system-i386 -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin -m 512=
M -drive file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive driv=
er=3Dblkreplay,if=3Dnone,image=3Ddevice-34-file,id=3Ddevice-34-driver -devi=
ce ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -net none
>=20
> qemu-system-i386 -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -m 512=
M -drive file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive driv=
er=3Dblkreplay,if=3Dnone,image=3Ddevice-34-file,id=3Ddevice-34-driver -devi=
ce ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -net none
>=20
> Replay stalls at some moment due to the non-determinism of the execution =
(probably caused by the wrong data read).

Hmm.. I tried it  (with x86_64 qemu and centos image). I waited for some ti=
me for a first command, than Ctrl+C it. After it replay.bin was 4M. Than st=
arted the second command. It works, not failing, not finishing. Is it bad? =
What is expected behavior and what is wrong?

>=20
>> What is exactly the case? May be you have other parallel aio
>> operations to the same region?
>=20
> As far as I understand, all aio operations, initiated by IDE controller, =
are performed one-by-one.
> I don't see anything else in the logs.
>=20
>> Ideas to experiment:
>>
>> 1. change QCOW2_MAX_WORKERS to 1 or to 2, will it help?
>=20
> 1 or 2 are ok, and 4 or 8 lead to the failures.
>=20
>> 2. understand what is the case in code: is it read from one or several
>> clusters, is it aligned,
>> what is the type of clusters, is encryption in use, compression?
>=20
> There is no encryption and I thinks compression is not enabled too.
> Clusters are read from the temporary overlay:
>=20
> blk_aio_prwv
> blk_aio_read_entry
> bdrv_co_preadv_part complete offset: 26300000 qiov_offset: 1c200 len: 1e0=
0
> bdrv_co_preadv_part complete offset: 24723e00 qiov_offset: 0 len: 1c200
> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e000
> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e000
> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e000
>=20
>=20
>> 3. understand what kind of data corruption. What we read instead of
>> correct data? Just garbage, or may be zeroes, or what..
>=20
> Most bytes are the same, but some are different:
>=20
> < 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
> < 46 49 4c 45 30 00 03 00 18 d1 33 02 00 00 00 00
> < 01 00 01 00 38 00 01 00 68 01 00 00 00 04 00 00
> < 00 00 00 00 00 00 00 00 04 00 00 00 9d 0e 00 00
> < 02 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
> ---
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00
>> 46 49 4c 45 30 00 03 00 86 78 35 03 00 00 00 00
>> 01 00 01 00 38 00 01 00 60 01 00 00 00 04 00 00
>> 00 00 00 00 00 00 00 00 04 00 00 00 a1 0e 00 00
>> 04 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
>=20
> That is strange. I could think, that it was caused by the bugs in
> deterministic CPU execution, but the first difference in logs
> occur in READ operation (I dump read/write buffers in blk_aio_complete).
>=20

Aha, yes, looks strange.

Then next steps:

1. Does problem hit into the same offset every time?
2. Do we write to this region before this strange read?

2.1. If yes, we need to check that we read what we write.. You say you dump=
 buffers
in blk_aio_complete... I think it would be more reliable to dump at start o=
f
bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may modify its bu=
ffers
during operation which would be strange but possible.

2.2 If not, hmm...


--=20
Best regards,
Vladimir

