Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C959C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2728F2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nv7VW0FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2728F2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jzu-00008H-8j
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4jyr-0007W9-DR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4jyp-0007lz-Hm
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:26:56 -0500
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]:24159
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4jyo-0007jX-3s
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:26:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APlgmOgtp9UEbsD3z0gUmYxRVN7tbRPGjUCGqDZYQCKJxf/3hMe+I03y6DRCOa3mCEgTiHI8zmMUEzRoHNLleQ/r8qBqiXA3/1dKkOVpHVGrnJhFhDWbxqBmiqT4vI374lv+5yGzyq1AEuczpOGFYsqicpBE1Fd6nTCKxctsVouBKjutFP+DwL/cd5pBNI9gZkJa0R7i2nmrcaL1WVUt3B1MO69pwOpLO+U2SMnjHNmU9iDAp3kLrJkmNPA0oOo/7x0MdOxuplfc0jiCXPbx3mDbmy4qKSkc5F2OUyxDKL2VG86kuwDFcECynjGMPYctIS8SCDBbHMtpnrVwXDEe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1gZqw3txgN6qCbWZbDgK3c+ZCK8jp+y6DS3CSqtCXA=;
 b=cqTGlSxz7oFvTETG68f1mmglEtRxDtPIQkI2QlURGQ4ZyruRjGlrBJ63+vGlF5ykLlU/HE24tKobuSIcQ0zzKJal09QMpU7hqWg1rlFsqQM3c3/PWICEfXhV6mL4al27XoOpN5ChP5mN75pRGa2K7DP8DQjozAMTlbZerTeCAOdA8wbj4VaF0a6UkjdVcVC7IvSxYRDPvjWnWpts11OFszhu35vCrvO2Tg55+LzuCrOJhoGPn0XkR1EzaVs9gybsGdUJM/PJL3QK+/ITxXPp+OOWXCZTnnkJrSZCRY2BJwoqFrAdSKiJ7S9wNrqKrOG8IX2MxubZmjXVHmSQQFRSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1gZqw3txgN6qCbWZbDgK3c+ZCK8jp+y6DS3CSqtCXA=;
 b=nv7VW0FZ3Fgf8GbRTPF86XtpaMFN3Gfgkt6YQIrUsmfyoSxGj4vR6FgY6aVQp/aAaYYCZdWYn+OnbSrBU6ZVC5QJfe5duS+K22kiZ6eTVpXURfvOwSOLOaCvAo2mHzRV8xiMHCUlVHHRSnZ8cqy67AjvUokO45Y+bTOPa6CeNfQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB2998.eurprd08.prod.outlook.com (52.135.168.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 11:26:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 11:26:49 +0000
Subject: Re: Race condition in overlayed qcow2?
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
 <003701d5e7d4$90bcc130$b2364390$@ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200220142647686
Message-ID: <ea13d572-4840-3e88-bc7f-d7c4351cc345@virtuozzo.com>
Date: Thu, 20 Feb 2020 14:26:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <003701d5e7d4$90bcc130$b2364390$@ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0102CA0012.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend
 Transport; Thu, 20 Feb 2020 11:26:49 +0000
X-Tagtoolbar-Keys: D20200220142647686
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7307da9e-e341-4f8f-61b6-08d7b5f7c6f2
X-MS-TrafficTypeDiagnostic: AM6PR08MB2998:
X-Microsoft-Antispam-PRVS: <AM6PR08MB29987F11C595D280DC448A44C1130@AM6PR08MB2998.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(396003)(366004)(376002)(136003)(199004)(189003)(52116002)(8676002)(81166006)(66556008)(86362001)(66476007)(316002)(26005)(66946007)(16576012)(36756003)(31696002)(6916009)(186003)(16526019)(81156014)(8936002)(5660300002)(6486002)(956004)(31686004)(2616005)(4326008)(2906002)(478600001)(505234006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB2998;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTkNLnUEFds6VemtQiZ9xfJ5Na7BgFNLsDoL4bUvLY4kePZiOyxLjBJqbZqLVj8hZMXwFk/izkLfY0HBE3fmruDUgzvjy83W8AnQ42vh1jtaqmOMj8AuQaMc0+uYHvcRAhx3hv0CiNRy4QV5+ksx+Mmv45V0gDeakOMPaiXdvhavVeJBdmd+oS7CYFGtsbVFFR9mi6qq76voA4RHw1aFk5Jz7U9vXH+9uFNtxFCLqNZz/SmAaNSbd14uy7C0gAzTU7wDqvUseh9Ma7iF5tidc3FOj89H4P+XKmLNLKg/SYM8UXZHkHripIlj+OcqmGqiR6jL++SD4RWJZWwJ34YEtmSiEdNJLyqTvVnqBOMwPKyTVjGn1Q7wHU+6ao4pLmK+Nh/xtwOLBoJLv6NwhYyJdapnxRBVkwkQiNGRC2VV5V9453pbDRm+4f6DTvZmSM+hRq72AmjFmSOEMXkKJ54EeFU1fxTBW1CXG+FW9yRxLLC6qDnbQfQg+LaF5hvbZV0J
X-MS-Exchange-AntiSpam-MessageData: r6U3tCO489nIjhRtb2tIZzBjLvDXDUpVjIlPCZmQgMGhIJiOsZjeLIQnVqS8AOXy8hKx/LuswKlG4wtJ7s238VLzGyIRXF44vzVOAwxPWoldupXQZrthlffVrr0ltxNY5dDQgXQYAJPngf4BpUuLEA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7307da9e-e341-4f8f-61b6-08d7b5f7c6f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 11:26:49.6576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReYgRcF2EqKGIAEVjyvxSElWhop/F43E7yrWqsnD6ymEhuDZafav3kdDABtodKGDTo0R8Bjmmk/a5mozjUFCY6hFIZyY0Z6mHY11k1qaJJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2998
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::703
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

20.02.2020 13:00, Pavel Dovgalyuk wrote:
>> From: Vladimir Sementsov-Ogievskiy [mailto:vsementsov@virtuozzo.com]
>> 20.02.2020 11:31, dovgaluk wrote:
>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-19 =
19:07:
>>>> 19.02.2020 17:32, dovgaluk wrote:
>>>>> I encountered a problem with record/replay of QEMU execution and figu=
red out the
>> following, when
>>>>> QEMU is started with one virtual disk connected to the qcow2 image wi=
th applied 'snapshot'
>> option.
>>>>>
>>>>> The patch d710cf575ad5fb3ab329204620de45bfe50caa53 "block/qcow2: intr=
oduce parallel
>> subrequest handling in read and write"
>>>>> introduces some kind of race condition, which causes difference in th=
e data read from the
>> disk.
>>>>>
>>>>> I detected this by adding the following code, which logs IO operation=
 checksum. And this
>> checksum may be different in different runs of the same recorded executi=
on.
>>>>>
>>>>> logging in blk_aio_complete function:
>>>>>           qemu_log("%"PRId64": blk_aio_complete\n", replay_get_curren=
t_icount());
>>>>>           QEMUIOVector *qiov =3D acb->rwco.iobuf;
>>>>>           if (qiov && qiov->iov) {
>>>>>               size_t i, j;
>>>>>               uint64_t sum =3D 0;
>>>>>               int count =3D 0;
>>>>>               for (i =3D 0 ; i < qiov->niov ; ++i) {
>>>>>                   for (j =3D 0 ; j < qiov->iov[i].iov_len ; ++j) {
>>>>>                       sum +=3D ((uint8_t*)qiov->iov[i].iov_base)[j];
>>>>>                       ++count;
>>>>>                   }
>>>>>               }
>>>>>               qemu_log("--- iobuf offset %"PRIx64" len %x sum: %"PRIx=
64"\n", acb-
>>> rwco.offset, count, sum);
>>>>>           }
>>>>>
>>>>> I tried to get rid of aio task by patching qcow2_co_preadv_part:
>>>>> ret =3D qcow2_co_preadv_task(bs, ret, cluster_offset, offset, cur_byt=
es, qiov, qiov_offset);
>>>>>
>>>>> That change fixed a bug, but I have no idea what to debug next to fig=
ure out the exact
>> reason of the failure.
>>>>>
>>>>> Do you have any ideas or hints?
>>>>>
>>>>
>>>> Hi!
>>>>
>>>> Hmm, do mean that read from the disk may return wrong data? It would
>>>> be very bad of course :(
>>>> Could you provide a reproducer, so that I can look at it and debug?
>>>
>>> It is just a winxp-32 image. I record the execution and replay it with =
the following command
>> lines:
>>>
>>> qemu-system-i386 -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin -m 5=
12M -drive
>> file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive driver=3Db=
lkreplay,if=3Dnone,image=3Ddevice-
>> 34-file,id=3Ddevice-34-driver -device ide-hd,drive=3Ddevice-34-driver,bu=
s=3Dide.0,id=3Ddevice-34 -net
>> none
>>>
>>> qemu-system-i386 -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -m 5=
12M -drive
>> file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive driver=3Db=
lkreplay,if=3Dnone,image=3Ddevice-
>> 34-file,id=3Ddevice-34-driver -device ide-hd,drive=3Ddevice-34-driver,bu=
s=3Dide.0,id=3Ddevice-34 -net
>> none
>>>
>>> Replay stalls at some moment due to the non-determinism of the executio=
n (probably caused by
>> the wrong data read).
>>
>> Hmm.. I tried it  (with x86_64 qemu and centos image). I waited for some=
 time for a first
>> command, than Ctrl+C it. After it replay.bin was 4M. Than started the se=
cond command. It
>> works, not failing, not finishing. Is it bad? What is expected behavior =
and what is wrong?
>=20
> The second command should finish. There is no replay introspection yet (i=
n master), but you can
> stop qemu with gdb and inspect replay_state.current_icount field. It shou=
ld increase with every
> virtual CPU instruction execution. If that counter has stopped, it means =
that replay hangs.

It hangs for me even with QCOW2_MAX_WORKERS =3D 1..

>=20
>>>> What is exactly the case? May be you have other parallel aio
>>>> operations to the same region?
>>>
>>> As far as I understand, all aio operations, initiated by IDE controller=
, are performed one-
>> by-one.
>>> I don't see anything else in the logs.
>>>
>>>> Ideas to experiment:
>>>>
>>>> 1. change QCOW2_MAX_WORKERS to 1 or to 2, will it help?
>>>
>>> 1 or 2 are ok, and 4 or 8 lead to the failures.
>>>
>>>> 2. understand what is the case in code: is it read from one or several
>>>> clusters, is it aligned,
>>>> what is the type of clusters, is encryption in use, compression?
>>>
>>> There is no encryption and I thinks compression is not enabled too.
>>> Clusters are read from the temporary overlay:
>>>
>>> blk_aio_prwv
>>> blk_aio_read_entry
>>> bdrv_co_preadv_part complete offset: 26300000 qiov_offset: 1c200 len: 1=
e00
>>> bdrv_co_preadv_part complete offset: 24723e00 qiov_offset: 0 len: 1c200
>>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e000
>>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e000
>>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e000
>>>
>>>
>>>> 3. understand what kind of data corruption. What we read instead of
>>>> correct data? Just garbage, or may be zeroes, or what..
>>>
>>> Most bytes are the same, but some are different:
>>>
>>> < 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
>>> < 46 49 4c 45 30 00 03 00 18 d1 33 02 00 00 00 00
>>> < 01 00 01 00 38 00 01 00 68 01 00 00 00 04 00 00
>>> < 00 00 00 00 00 00 00 00 04 00 00 00 9d 0e 00 00
>>> < 02 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
>>> ---
>>>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00
>>>> 46 49 4c 45 30 00 03 00 86 78 35 03 00 00 00 00
>>>> 01 00 01 00 38 00 01 00 60 01 00 00 00 04 00 00
>>>> 00 00 00 00 00 00 00 00 04 00 00 00 a1 0e 00 00
>>>> 04 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
>>>
>>> That is strange. I could think, that it was caused by the bugs in
>>> deterministic CPU execution, but the first difference in logs
>>> occur in READ operation (I dump read/write buffers in blk_aio_complete)=
.
>>>
>>
>> Aha, yes, looks strange.
>>
>> Then next steps:
>>
>> 1. Does problem hit into the same offset every time?
>=20
> Yes, almost the same offset, almost the same phase of the execution.
>=20
>> 2. Do we write to this region before this strange read?
>=20
> No.
>=20
>> 2.1. If yes, we need to check that we read what we write.. You say you d=
ump buffers
>> in blk_aio_complete... I think it would be more reliable to dump at star=
t of
>> bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may modify its=
 buffers
>> during operation which would be strange but possible.
>=20
> I dumped every write in file-posix.c handle_aiocb_rw_linear and qemu_pwri=
tev
> and found no difference in executions.
>=20
>> 2.2 If not, hmm...
>=20
> Exactly.
>=20
> Pavel Dovgalyuk
>=20


--=20
Best regards,
Vladimir

