Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC55C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFAF2465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OPXit+17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFAF2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4iGx-0005RG-LR
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4iGA-0004vd-H3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4iG4-0006xa-7H
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:36:42 -0500
Received: from mail-eopbgr30114.outbound.protection.outlook.com
 ([40.107.3.114]:29942 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4iG3-0006x0-CB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:36:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx5oYb+BSD3KVjqameRTGnuPFWqg+SslGUGpWqT/lzcUhc9Y41roHJv+J8joVQMkhfPyLz5H7uCJ9FMX6Yhv/yR+27mZAB3KMsIRVCrdOSNDEYbiSGnavjiGjiosJhGpCvNoBoMm2eCS9Dxb1snfDSaf4ASa/kmwkT0x2owXntXqjP2IQPPfeBd0df8googActt1fb/A2tMIxQpmycLVX92m9uMFllx79buqnY5MInJ/HRhlYi+lQDMEVZ3FVQpbZCoILQ37FDuttSpMkhyVHrZ+ZJjbqDKS3eqVRS9quMVZGlYVh85tVOMKnzxuWfDzrmzOeYiTszpt4EQX/UAbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioKYXN4WDpfyjIZR4hrt7QQwtiJ7ECCwPjO7Zyansv0=;
 b=Dzz2x0sDzaW11f/3RwavoO5L3w5Zv7ePpsqnMukC8qamJNS8Ag5aflHhYb7/cRhDU1Lue6uOspuG6uPlVI48A1Qu2mk91OTzQEIJ3AFfkTDl6sf9Pu06B4u7Wvp8PXCpB3X30FwNdwXeFKjNzs3J/3o30nCD20GkAp/qucJBKL4cgbSAWcS2CKbY7hXdN1YOEGTmE/enTozqL/b90NUnmPpdXo8OoF524nfJA3Qxbs97BviPN2Y3fuPFl8QzcG1Mhh/h35SQdbWZt1BzRZesjCXD99N62aaQ/gumVp3H7c53ao2iD7ZrE+8J8h9rwf4PUms4OAo9igzWkcMVf0sfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioKYXN4WDpfyjIZR4hrt7QQwtiJ7ECCwPjO7Zyansv0=;
 b=OPXit+17ZzamAIqyYIazA24l1bZyyXfOfAIw1nln05qhP75IUcQU44dbEL/yEw44B0N8Tmh2Ze4V91ixsquO1q4aRibTk/g0IQIwuLW5+1ga2/mQyhytRSFA5/VJgqEjbE9qtMQCNTVQrZ8REHYC9cQ/pGHZS7ACtx/kPLyTOsE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4950.eurprd08.prod.outlook.com (10.255.122.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Thu, 20 Feb 2020 09:36:32 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 09:36:32 +0000
Subject: Re: Race condition in overlayed qcow2?
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: dovgaluk <dovgaluk@ispras.ru>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
X-Tagtoolbar-Keys: D20200220123630479
Message-ID: <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
Date: Thu, 20 Feb 2020 12:36:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0257.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::33) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0257.eurprd05.prod.outlook.com (2603:10a6:3:fb::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 09:36:31 +0000
X-Tagtoolbar-Keys: D20200220123630479
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1cedd78-30dc-4a09-21e3-08d7b5e85ea8
X-MS-TrafficTypeDiagnostic: AM6PR08MB4950:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4950E1BAC0876E973B636680C1130@AM6PR08MB4950.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39840400004)(189003)(199004)(31696002)(36756003)(186003)(16526019)(16576012)(316002)(2906002)(2616005)(8676002)(956004)(5660300002)(31686004)(52116002)(26005)(66476007)(66946007)(66556008)(86362001)(6916009)(81166006)(478600001)(8936002)(81156014)(4326008)(6486002)(505234006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4950;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1EfkcT1jd5Lqk0wsnOXcd5ysqFvMnSBf/VcrWky9tz6uH8oXJf9of+D0IcjQdrm3b4RvrqdNg0kZhVfsWcVvRevq5j3pSP6vWuzZvNA35cjZHLo4G5C/mbUVofaK1x1Kqtq4h2ocRsK0Zh0zt0u5B78xw1YTr2sJkXf6t/Qlmhbdhy+3C+ylyaubC2RnGRUGIOEBSL7fZLzPY8hGNlIywfn2mN3JJSZ/efXWcd7YCdtmBC6Z/Z0/LliuAUFTwBkaejL/WWUd+GMe11lRVCDl7GXZ9quIwPO0qcyHUgHOo6cEWpQ8D/252zQmSW072n57J1Y8vensu2trmZUrH54Q+pq0SW79TPYLLplGodZj+Hofc6g7WRf18kTMDCsPw7bChxqJRzrdKYI51SG5+MEA4qDFpjTQcUdCUwosYKHVNUxVWlQdFdGlPGnQJ8EZvkOIegGOUe8f9VQzKdhXZYrfzX0hYct13KiIYC5zU+F5DVjJwkl19auT+R6Sn+HDDrpn
X-MS-Exchange-AntiSpam-MessageData: U0ha+0pLKFqzRfZOA6O5rTUS15G3CPxJThiamTzob4Cjs0hipWQK7hm86N6dQ6uWnoECTcmFdSREOQ3ajShjcvdr/wBQ6O8I0C4Om0WFopHcrxEWitKl3wwwXi4uoG+XHt3u/pkedYWD/5xWgwASvA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cedd78-30dc-4a09-21e3-08d7b5e85ea8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 09:36:32.3150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2Oavy/cnUzz1pOtC4lJyMMLezJ3f26/XGL2WfLCRE+M2Ac2IvuO5wGQJVu5f88BgmzMJbU1XNvcxteJ/RM6ZYD4UA+5yJ4dGK2Lu5IBKgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4950
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.114
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

20.02.2020 12:05, Vladimir Sementsov-Ogievskiy wrote:
> 20.02.2020 11:31, dovgaluk wrote:
>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-19 1=
9:07:
>>> 19.02.2020 17:32, dovgaluk wrote:
>>>> I encountered a problem with record/replay of QEMU execution and figur=
ed out the following, when
>>>> QEMU is started with one virtual disk connected to the qcow2 image wit=
h applied 'snapshot' option.
>>>>
>>>> The patch d710cf575ad5fb3ab329204620de45bfe50caa53 "block/qcow2: intro=
duce parallel subrequest handling in read and write"
>>>> introduces some kind of race condition, which causes difference in the=
 data read from the disk.
>>>>
>>>> I detected this by adding the following code, which logs IO operation =
checksum. And this checksum may be different in different runs of the same =
recorded execution.
>>>>
>>>> logging in blk_aio_complete function:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log("%"PRId64": =
blk_aio_complete\n", replay_get_current_icount());
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov =
=3D acb->rwco.iobuf;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qiov && qiov->iov=
) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size_t i, j;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t sum =3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int count =3D 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 for (i =3D 0 ; i < qiov->niov ; ++i) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 0 ; j < qiov->iov[i].iov_len ; ++j) =
{
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sum +=3D ((uint8_t*)qio=
v->iov[i].iov_base)[j];
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++count;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 qemu_log("--- iobuf offset %"PRIx64" len %x sum: %"PRIx64"\n", acb->rwc=
o.offset, count, sum);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> I tried to get rid of aio task by patching qcow2_co_preadv_part:
>>>> ret =3D qcow2_co_preadv_task(bs, ret, cluster_offset, offset, cur_byte=
s, qiov, qiov_offset);
>>>>
>>>> That change fixed a bug, but I have no idea what to debug next to figu=
re out the exact reason of the failure.
>>>>
>>>> Do you have any ideas or hints?
>>>>
>>>
>>> Hi!
>>>
>>> Hmm, do mean that read from the disk may return wrong data? It would
>>> be very bad of course :(
>>> Could you provide a reproducer, so that I can look at it and debug?
>>
>> It is just a winxp-32 image. I record the execution and replay it with t=
he following command lines:
>>
>> qemu-system-i386 -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin -m 51=
2M -drive file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive dri=
ver=3Dblkreplay,if=3Dnone,image=3Ddevice-34-file,id=3Ddevice-34-driver -dev=
ice ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -net none
>>
>> qemu-system-i386 -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -m 51=
2M -drive file=3Dxp.qcow2,if=3Dnone,id=3Ddevice-34-file,snapshot -drive dri=
ver=3Dblkreplay,if=3Dnone,image=3Ddevice-34-file,id=3Ddevice-34-driver -dev=
ice ide-hd,drive=3Ddevice-34-driver,bus=3Dide.0,id=3Ddevice-34 -net none
>>
>> Replay stalls at some moment due to the non-determinism of the execution=
 (probably caused by the wrong data read).
>=20
> Hmm.. I tried it=C2=A0 (with x86_64 qemu and centos image). I waited for =
some time for a first command, than Ctrl+C it. After it replay.bin was 4M. =
Than started the second command. It works, not failing, not finishing. Is i=
t bad? What is expected behavior and what is wrong?
>=20
>>
>>> What is exactly the case? May be you have other parallel aio
>>> operations to the same region?
>>
>> As far as I understand, all aio operations, initiated by IDE controller,=
 are performed one-by-one.
>> I don't see anything else in the logs.
>>
>>> Ideas to experiment:
>>>
>>> 1. change QCOW2_MAX_WORKERS to 1 or to 2, will it help?
>>
>> 1 or 2 are ok, and 4 or 8 lead to the failures.
>>
>>> 2. understand what is the case in code: is it read from one or several
>>> clusters, is it aligned,
>>> what is the type of clusters, is encryption in use, compression?
>>
>> There is no encryption and I thinks compression is not enabled too.
>> Clusters are read from the temporary overlay:
>>
>> blk_aio_prwv
>> blk_aio_read_entry
>> bdrv_co_preadv_part complete offset: 26300000 qiov_offset: 1c200 len: 1e=
00
>> bdrv_co_preadv_part complete offset: 24723e00 qiov_offset: 0 len: 1c200
>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e000
>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e000
>> bdrv_co_preadv_part complete offset: c0393e00 qiov_offset: 0 len: 1e000
>>
>>
>>> 3. understand what kind of data corruption. What we read instead of
>>> correct data? Just garbage, or may be zeroes, or what..
>>
>> Most bytes are the same, but some are different:
>>
>> < 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00
>> < 46 49 4c 45 30 00 03 00 18 d1 33 02 00 00 00 00
>> < 01 00 01 00 38 00 01 00 68 01 00 00 00 04 00 00
>> < 00 00 00 00 00 00 00 00 04 00 00 00 9d 0e 00 00
>> < 02 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
>> ---
>>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00
>>> 46 49 4c 45 30 00 03 00 86 78 35 03 00 00 00 00
>>> 01 00 01 00 38 00 01 00 60 01 00 00 00 04 00 00
>>> 00 00 00 00 00 00 00 00 04 00 00 00 a1 0e 00 00
>>> 04 00 00 00 00 00 00 00 10 00 00 00 60 00 00 00
>>
>> That is strange. I could think, that it was caused by the bugs in
>> deterministic CPU execution, but the first difference in logs
>> occur in READ operation (I dump read/write buffers in blk_aio_complete).
>>
>=20
> Aha, yes, looks strange.
>=20
> Then next steps:
>=20
> 1. Does problem hit into the same offset every time?
> 2. Do we write to this region before this strange read?
>=20
> 2.1. If yes, we need to check that we read what we write.. You say you du=
mp buffers
> in blk_aio_complete... I think it would be more reliable to dump at start=
 of
> bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may modify its =
buffers
> during operation which would be strange but possible.
>=20
> 2.2 If not, hmm...
>=20
>=20

Another idea to check: use blkverify

blkverify is filter driver, which on write writes to two separate files and=
 on read
check that it reads the same from these two files (and print error and exit=
s if differs)

So, I imagine creating two overlays by hand, like
qemu-img create -f qcow2 -b /path/to/xp.qcow2 a.qcow2
qemu-img create -f qcow2 -b /path/to/xp.qcow2 b.qcow2

and then stating vm with something like this:

-drive driver=3Dblkverify,raw.filename=3D/work/a.qcow2,test.file.filename=
=3D/work/b.qcow2



--=20
Best regards,
Vladimir

