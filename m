Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A95C35644
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5258C24653
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ryiiiltR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5258C24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j55Fs-0001v5-Iz
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 05:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j55F8-000165-3B
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j55F6-0002tQ-2i
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:09:09 -0500
Received: from mail-eopbgr60138.outbound.protection.outlook.com
 ([40.107.6.138]:16228 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j55F5-0002t6-CM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:09:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFUOjXwWRavFnAfRP1KTo9d40DJF3TiQDxxmHUdK/NSYChz0uqdCgwOlfwFEngh8fv3Ey4J8ZXwQYY3VMl09NTY/mfb3XsyaJaGAbdSMWBpXyCCuguwBFGx5Ys8+IqQ9gWvGUAyT3gvs1qUKJ6emUDXjfesFTo9F0hjz4FWlFxauHohzsFVkZxO/KQtgQzfDWCc3tcsPTilnoj6ApM9CdAs/Qsc9gi0pttPVGD2Wexvu/WKzYaeam1AjybWJcrYTXQfLP51Z6S8GhjNZhE3Lj0tWUbciDMns6lsa7CBG2QV/HwZKhZNhuA9c9EvteOOnfQf7S2zNK5zrz08b/FdAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GY2lMscKAydMgxw3FeuW6bvx5ReiiaoDgU3XbTFcQ8=;
 b=DMAX/XNYw4gMeOIeS9iztnN3wAO9w9JR2yWNGO6v0uQ2t2kmvLZzkucoLabDK1gH1GS5dDeai26l64raDCE9I7IwTOrAWOT/IUyveV7Ne3XV8niP2GvBvv/0Ig/1Onn5kRuwsV0+gEmKSJ3ztTnBmDuZia1u5OwRKfOw/kLQevZAKoNEEH1Le1gsXJHRXgdEaX3xnbzpXN+A36paijFqPrgGrhggbe+cluFFcZeu9IOkO5MZjAvvwwEiqNwOYzhTAORDjY14lPscyIP3t7fLf3GBXIYi3YoqPyCHh6F9uw09tz2bzNzeqH+LUpC5ZLR8JJyF+cYoFv6+vv4Dl0E2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GY2lMscKAydMgxw3FeuW6bvx5ReiiaoDgU3XbTFcQ8=;
 b=ryiiiltRzUWSopkYoaUw9/1eJZtcaN2vOsXqgLxGumbGO71zpXOThOkrMnut8ivJN/0UTV0mcuY+1UOVmzr09uYmjsSOj96tWQd1NUXJ64wgPvPIKf2cHtHYG/5rIn9tlIbNZjx94FHaz4B11iiTKd+53fM+SWX+7l/gRDIocrw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3477.eurprd08.prod.outlook.com (20.177.114.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 21 Feb 2020 10:09:04 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Fri, 21 Feb 2020
 10:09:04 +0000
Subject: Re: Race condition in overlayed qcow2?
To: dovgaluk <dovgaluk@ispras.ru>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
 <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
 <b3405d429e42bdf03177db1b8f7531ee@ispras.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200221130901793
Message-ID: <b5811027-388a-98db-fe73-93230b5e29ae@virtuozzo.com>
Date: Fri, 21 Feb 2020 13:09:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <b3405d429e42bdf03177db1b8f7531ee@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0202CA0001.eurprd02.prod.outlook.com (2603:10a6:3:8c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 10:09:04 +0000
X-Tagtoolbar-Keys: D20200221130901793
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57e6e851-3756-4152-5ed0-08d7b6b614ab
X-MS-TrafficTypeDiagnostic: AM6PR08MB3477:
X-Microsoft-Antispam-PRVS: <AM6PR08MB347798AF2DD20C66B17F34BAC1120@AM6PR08MB3477.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(396003)(39850400004)(136003)(199004)(189003)(5660300002)(956004)(2616005)(66946007)(186003)(6666004)(66476007)(6916009)(16526019)(52116002)(26005)(66556008)(6486002)(81166006)(4326008)(81156014)(2906002)(8676002)(86362001)(31696002)(8936002)(478600001)(316002)(16576012)(31686004)(36756003)(505234006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3477;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTGnFvVDdEcUP4BDN4zd5u5Fcg0HGgN8saU6sNyrf4maSRku1kU54POtJ5iy3Hs+4+N6Gb7kK1g2cpAXQHGKyoLJwoEUYnnQfwhJ7um1MZdDynrj9NKsl8+Z2kOuJBrdi1OChDgnZFDS/eNaoxVLBtaI6jJ2d7E54i0iUp28o+C99l2oqSYpuBnPxkYhulpDjGAZmcjFXZu9WAk6T5j/iD8SPKsSu4cBfYcn/YM5ChmLEhUNWdFxVR7TQcIPc/uEco2ZvRcFqWhWS1hQgEC+m3VRSwUf+//GgSQ/SnNXV6BXr6MCuspG44mARSuudOjBEk2/FqB0kfgfEVVVx5u7OIVjVChpgV23diJ2qzAzo7MYt5FQ8GTQBJVHCuHUBcDcn3gZyAIQYzKGf22Pik41Hl2dbN55TUuvepIKw7cx3GPEeu1qYjCQGPtOE2Ej0w9Idv6HyN30zmsCg8QshoEcdCM43L8u8YZxkfSmjfV0DOKMVlw/Bgv7ndstOi7EO5c8
X-MS-Exchange-AntiSpam-MessageData: G6BrcIW5TGxAuBwTQ+qvBQQnY8u7ZapMh1nOiNZJhZPWcpw0mvEq48mmDsDMer2rDSNJFk1tK3F12F/Yi2o6zNbSE4KAoDQNMqi4QKEGrePCjpHm1IivA5OcUjJUc3SREWgLyz95S51BQQ4e73MS0g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e6e851-3756-4152-5ed0-08d7b6b614ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 10:09:04.5101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QGXdiyl1CcovDYqbgnw93NBl4QWwDWMVxysxwV7HcbTBydEwV0HV9GrNyf/LUmLyKb76hMaYbAJP/GBQ9UFANCViYiam3HCT+gHa222CMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3477
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.138
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

21.02.2020 12:49, dovgaluk wrote:
> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-20 12=
:36:
>> 20.02.2020 12:05, Vladimir Sementsov-Ogievskiy wrote:
>>> 20.02.2020 11:31, dovgaluk wrote:
>>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-19=
 19:07:
>>>>> 19.02.2020 17:32, dovgaluk wrote:
>>>>>> I encountered a problem with record/replay of QEMU execution and fig=
ured out the following, when
>>>>>> QEMU is started with one virtual disk connected to the qcow2 image w=
ith applied 'snapshot' option.
>>>>>>
>>>>>> The patch d710cf575ad5fb3ab329204620de45bfe50caa53 "block/qcow2: int=
roduce parallel subrequest handling in read and write"
>>>>>> introduces some kind of race condition, which causes difference in t=
he data read from the disk.
>>>>>>
>>>>>> I detected this by adding the following code, which logs IO operatio=
n checksum. And this checksum may be different in different runs of the sam=
e recorded execution.
>>>>>>
>>>>>> logging in blk_aio_complete function:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("%"PRId64"=
: blk_aio_complete\n", replay_get_current_icount());
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov =
=3D acb->rwco.iobuf;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qiov && qiov->i=
ov) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 size_t i, j;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 uint64_t sum =3D 0;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int count =3D 0;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 for (i =3D 0 ; i < qiov->niov ; ++i) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 0 ; j < qiov->iov[i].iov_len ; ++=
j) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sum +=3D ((uint8_t*)=
qiov->iov[i].iov_base)[j];
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++count;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 qemu_log("--- iobuf offset %"PRIx64" len %x sum: %"PRIx64"\n", acb->=
rwco.offset, count, sum);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>
>>>>>> I tried to get rid of aio task by patching qcow2_co_preadv_part:
>>>>>> ret =3D qcow2_co_preadv_task(bs, ret, cluster_offset, offset, cur_by=
tes, qiov, qiov_offset);
>>>>>>
>>>>>> That change fixed a bug, but I have no idea what to debug next to fi=
gure out the exact reason of the failure.
>>>>>>
>>>>>> Do you have any ideas or hints?
>>>>>>
>>>>>
>>>>> Hi!
>>>>>
>>>>> Hmm, do mean that read from the disk may return wrong data? It would
>>>>> be very bad of course :(
>>>>> Could you provide a reproducer, so that I can look at it and debug?
>>>>
>>>> It is just a winxp-32 image. I record the execution and replay it with=
 the following command lines:
>>>>
>>>> qemu-system-i386 -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin -m =
512M -drive file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive d=
river=3Dblkreplay,if=3Dnone,image=3Ddevice-34-file,id=3Ddevice-34-driver -d=
evice ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -net none
>>>>
>>>> qemu-system-i386 -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -m =
512M -drive file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive d=
river=3Dblkreplay,if=3Dnone,image=3Ddevice-34-file,id=3Ddevice-34-driver -d=
evice ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -net none
>>>>
>>>> Replay stalls at some moment due to the non-determinism of the executi=
on (probably caused by the wrong data read).
>>>
>>> Hmm.. I tried it=C2=A0 (with x86_64 qemu and centos image). I waited fo=
r some time for a first command, than Ctrl+C it. After it replay.bin was 4M=
. Than started the second command. It works, not failing, not finishing. Is=
 it bad? What is expected behavior and what is wrong?
>>>
>>>>
>>>>> What is exactly the case? May be you have other parallel aio
>>>>> operations to the same region?
>>>>
>>>> As far as I understand, all aio operations, initiated by IDE controlle=
r, are performed one-by-one.
>>>> I don't see anything else in the logs.
>>>>
>>>>> Ideas to experiment:
>>>>>
>>>>> 1. change QCOW2_MAX_WORKERS to 1 or to 2, will it help?
>>>>
>>>> 1 or 2 are ok, and 4 or 8 lead to the failures.
>>>>
>>>>> 2. understand what is the case in code: is it read from one or severa=
l
>>>>> clusters, is it aligned,
>>>>> what is the type of clusters, is encryption in use, compression?
>>>>
>>>> There is no encryption and I thinks compression is not enabled too.
>>>> Clusters are read from the temporary overlay:
>>>>
>>>> blk_aio_prwv
>>>> blk_aio_read_entry
>>>> bdrv_co_preadv_part complete offset: 26300000 qiov_offset: 1c200 len: =
1e00
>>>> bdrv_co_preadv_part complete offset: 24723e00 qiov_offset: 0 len: 1c20=
0
>>>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e00=
0
>>>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e00=
0
>>>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e00=
0
>>>>
>>>>
>>>>> 3. understand what kind of data corruption. What we read instead of
>>>>> correct data? Just garbage, or may be zeroes, or what..
>>>>
>>>> Most bytes are the same, but some are different:
>>>>
>>>> < 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
>>>> < 46 49 4c 45 30 00 03 00 18 d1 33 02 00 00 00 00
>>>> < 01 00 01 00 38 00 01 00 68 01 00 00 00 04 00 00
>>>> < 00 00 00 00 00 00 00 00 04 00 00 00 9d 0e 00 00
>>>> < 02 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
>>>> ---
>>>>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00
>>>>> 46 49 4c 45 30 00 03 00 86 78 35 03 00 00 00 00
>>>>> 01 00 01 00 38 00 01 00 60 01 00 00 00 04 00 00
>>>>> 00 00 00 00 00 00 00 00 04 00 00 00 a1 0e 00 00
>>>>> 04 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
>>>>
>>>> That is strange. I could think, that it was caused by the bugs in
>>>> deterministic CPU execution, but the first difference in logs
>>>> occur in READ operation (I dump read/write buffers in blk_aio_complete=
).
>>>>
>>>
>>> Aha, yes, looks strange.
>>>
>>> Then next steps:
>>>
>>> 1. Does problem hit into the same offset every time?
>>> 2. Do we write to this region before this strange read?
>>>
>>> 2.1. If yes, we need to check that we read what we write.. You say you =
dump buffers
>>> in blk_aio_complete... I think it would be more reliable to dump at sta=
rt of
>>> bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may modify it=
s buffers
>>> during operation which would be strange but possible.
>>>
>>> 2.2 If not, hmm...
>>>
>>>
>>
>> Another idea to check: use blkverify
>=20
> I added logging of file descriptor and discovered that different results =
are obtained
> when reading from the backing file.
> And even more - replay runs of the same recording produce different resul=
ts.
> Logs show that there is a preadv race, but I can't figure out the source =
of the failure.
>=20
> Log1:
> preadv c 30467e00
> preadv c 30960000
> --- sum =3D a2e1e
> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 8200
> --- sum =3D 10cdee
> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len: ee00
>=20
> Log2:
> preadv c 30467e00
> --- sum =3D a2e1e
> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 8200
> preadv c 30960000
> --- sum =3D f094f
> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len: ee00
>=20
>=20
> Checksum calculation was added to preadv in file-posix.c
>=20

So, preadv in file-posix.c returns different results for the same offset, f=
or file which is always opened in RO mode? Sounds impossible :)


--=20
Best regards,
Vladimir

