Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02ACC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6AA2467A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q1XpBOZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6AA2467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58iH-00087w-Ux
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j58Hd-00080U-Iv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j58Hb-0005ot-Gv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:23:56 -0500
Received: from mail-am6eur05on2139.outbound.protection.outlook.com
 ([40.107.22.139]:64225 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j58Ha-0005nT-Dc
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:23:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/ci8cTx6VodrboQkR84qtkuKSc6JU4jubSdzQ1OC/LdkdWvCcaVqxKWKux6s0378Y18QOk5ITxnDYXeZlVHz8wtYhg5xARjL/1J7MtZJgsdpVSqRFKjwLyo5cyRq8/p/1jbGZSrjU70G772f9JD2fSFBV+S35/pVkkTDk02ss5piBtQCd9eJ/Lu6bBdD16+Jj06SYV9nZM/fzD+pP7x/7P/Y9dAARqtfkBjzBpVeFXSlVg/dZo9efFeJFubedg7CPf6nIIxYQ2rwdSEL8sp7bcJ0SFaHPxVGxf/TcGmxsNQ25bEfz6M8bUHvYwW1qGChNBwpH/qF0K8M3n1FNB8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph0aBIl97+GzmO6+GX6OuIR/bDehsW12h2WAlTCt0Q4=;
 b=IXUn2Eb5E2rFfbLXD31cmG0UOYtVEot864YvLmq4wu1GX4fqK0xKkFlGCzhTK2Qi/RgVdyKqSrWXOTBc5rmJN+nTTy6CJ2MPkw/H/oYYKAi+PRBUmoaO0DEz1qs1QBjmkvtHIo/CdYRfotlNutv5pojwnhANEsFggD5KmT31xURw9Ruiischhj0c6p9NV2UsdeFfFIGaLPT9lEwxOw9uX75rrt9eeSUXn9mEAkKRRvwj3hDSqkPjLgQjFAPnel8zkeKlEH7Mjh5gRgFS+tJnwWEcVqULG6OWVU6akg5FlzRQNVbTU/qt2vMxM/zd70fCP61hQ9jUNXAnlRziVpFALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph0aBIl97+GzmO6+GX6OuIR/bDehsW12h2WAlTCt0Q4=;
 b=q1XpBOZKLvo7i+jrXznsW6ZK7BLyJZaD5v/ubJBukIFvbBXm4EUfT54ZRJL0cl5az4UZ7PWVdjB6KQX4hzC/NKF6pczX8qnJI3TaURbrJxc4BK9uPFwQovmPhxu+rjPGkthRBVHtj4/lTcUCOXkZWFX+TQ4/3756rDN1i89R+Ao=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3768.eurprd08.prod.outlook.com (20.178.91.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 21 Feb 2020 13:23:50 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Fri, 21 Feb 2020
 13:23:50 +0000
Subject: Re: Race condition in overlayed qcow2?
To: dovgaluk <dovgaluk@ispras.ru>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
 <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
 <b3405d429e42bdf03177db1b8f7531ee@ispras.ru>
 <b5811027-388a-98db-fe73-93230b5e29ae@virtuozzo.com>
 <5fe1747e6e7b818d93fd9a7fd0434bed@ispras.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200221162348264
Message-ID: <99ed3129-9460-dbad-0441-95bad08d5636@virtuozzo.com>
Date: Fri, 21 Feb 2020 16:23:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <5fe1747e6e7b818d93fd9a7fd0434bed@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0701CA0048.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::16) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0048.eurprd07.prod.outlook.com (2603:10a6:3:9e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9 via Frontend Transport; Fri, 21 Feb 2020 13:23:49 +0000
X-Tagtoolbar-Keys: D20200221162348264
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36cabc2d-6b88-4111-f695-08d7b6d149c2
X-MS-TrafficTypeDiagnostic: AM6PR08MB3768:
X-Microsoft-Antispam-PRVS: <AM6PR08MB37682B16F5E066900C013CF0C1120@AM6PR08MB3768.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(4326008)(8676002)(52116002)(478600001)(16576012)(66946007)(81166006)(66476007)(81156014)(2906002)(8936002)(36756003)(5660300002)(2616005)(186003)(16526019)(6486002)(26005)(6916009)(316002)(31696002)(66556008)(956004)(86362001)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3768;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RITH6LjPdPpGYV/EjwHHIDb7WOd04MVYvJFIbAz+xGgXA4AOC2Qv/LwRlkDNMQMyCNRTMiCxxtUEKrfV2V1LWXR24VQZTl+QBBOB0rPZPMOvSDl/VUsq+lsDzQtJLVF3yyo2jrnTotRHUQQcTRYY+DVoeQ2mUAuHJ2lvJcWFho8NbHrxxQ/J/356ezqzo8Qx9mKeMBs486tfKdA7qdJfPXbRp4RaRuMMm5HBWfkrRnYedld24MjjtRFP5TgOxynQFXFLqedrYVVd7P+4HvePDo+ybuBQSX4Kwxe/1hJwcZ1Vkz8XgphELa0D6Jge+ej7OiaAgp9KTFMv4Abqm1FdCqWygf4TK37jIYKCSJZn4vDmvt/hQLHdGKpGvQknmZVVxjwq4qgWBEVAjFUWG1x39SjjBtrrrYMcLnOy4oxIF7ZZTYmwj4IwWTRG/hzFXnef
X-MS-Exchange-AntiSpam-MessageData: 0JDydEmV6N1tNI+m0pqqpUOth3nPj2dB866yajTrwlqEhSLbYUdUrExhX7ZmBCA4RvGUhCEOTEBmnfUrC7oN4PgtZ1adB3fWpSSrIWuF3ozFwFprmsIFl9D9p2+CEp5NtWyCaiNmZCQp4i5Kqjjlqw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cabc2d-6b88-4111-f695-08d7b6d149c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 13:23:49.9567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4u97Hq4pv/TS7jcPtr8Jx1NtvP+nij20n6X1MFAop49Q83IS/ZvAv4mcQgPf8pAgGiK9ZMV5e86dcmH3+LE9TY1yiLhVtJJoyl8UIwzySA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3768
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.139
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

21.02.2020 15:35, dovgaluk wrote:
> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-21 13=
:09:
>> 21.02.2020 12:49, dovgaluk wrote:
>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-20 =
12:36:
>>>>>> 1 or 2 are ok, and 4 or 8 lead to the failures.
>>>>>>
>>>>>>
>>>>>> That is strange. I could think, that it was caused by the bugs in
>>>>>> deterministic CPU execution, but the first difference in logs
>>>>>> occur in READ operation (I dump read/write buffers in blk_aio_comple=
te).
>>>>>>
>>>>>
>>>>> Aha, yes, looks strange.
>>>>>
>>>>> Then next steps:
>>>>>
>>>>> 1. Does problem hit into the same offset every time?
>>>>> 2. Do we write to this region before this strange read?
>>>>>
>>>>> 2.1. If yes, we need to check that we read what we write.. You say yo=
u dump buffers
>>>>> in blk_aio_complete... I think it would be more reliable to dump at s=
tart of
>>>>> bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may modify =
its buffers
>>>>> during operation which would be strange but possible.
>>>>>
>>>>> 2.2 If not, hmm...
>>>>>
>>>>>
>>>>
>>>> Another idea to check: use blkverify
>>>
>>> I added logging of file descriptor and discovered that different result=
s are obtained
>>> when reading from the backing file.
>>> And even more - replay runs of the same recording produce different res=
ults.
>>> Logs show that there is a preadv race, but I can't figure out the sourc=
e of the failure.
>>>
>>> Log1:
>>> preadv c 30467e00
>>> preadv c 30960000
>>> --- sum =3D a2e1e
>>> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 8200
>>> --- sum =3D 10cdee
>>> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len: ee=
00
>>>
>>> Log2:
>>> preadv c 30467e00
>>> --- sum =3D a2e1e
>>> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len: 8200
>>> preadv c 30960000
>>> --- sum =3D f094f
>>> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len: ee=
00
>>>
>>>
>>> Checksum calculation was added to preadv in file-posix.c
>>>
>>
>> So, preadv in file-posix.c returns different results for the same
>> offset, for file which is always opened in RO mode? Sounds impossible
>> :)
>=20
> True.
> Maybe my logging is wrong?
>=20
> static ssize_t
> qemu_preadv(int fd, const struct iovec *iov, int nr_iov, off_t offset)
> {
>  =C2=A0=C2=A0=C2=A0 ssize_t res =3D preadv(fd, iov, nr_iov, offset);
>  =C2=A0=C2=A0=C2=A0 qemu_log("preadv %x %"PRIx64"\n", fd, (uint64_t)offse=
t);
>  =C2=A0=C2=A0=C2=A0 int i;
>  =C2=A0=C2=A0=C2=A0 uint32_t sum =3D 0;
>  =C2=A0=C2=A0=C2=A0 int cnt =3D 0;
>  =C2=A0=C2=A0=C2=A0 for (i =3D 0 ; i < nr_iov ; ++i) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int j;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 0 ; j < (int)iov[i=
].iov_len ; ++j)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sum +=
=3D ((uint8_t*)iov[i].iov_base)[j];
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++cnt=
;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0 qemu_log("size: %x sum: %x\n", cnt, sum);
>  =C2=A0=C2=A0=C2=A0 assert(cnt =3D=3D res);
>  =C2=A0=C2=A0=C2=A0 return res;
> }
>=20
> This code prints preadv checksum.
> But when I calculate the same with the standalone program, then it gives =
me another values of the checksums for the same offsets:
>=20
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/uio.h>
>=20
> unsigned char buf[0x100000];
>=20
> int main(int argc, char **argv)
> {
>  =C2=A0 if (argc < 4) return 1;
>  =C2=A0 int f =3D open(argv[1], O_RDONLY);
>  =C2=A0 unsigned int cnt;
>  =C2=A0 unsigned int offs;
>  =C2=A0 sscanf(argv[2], "%x", &offs);
>  =C2=A0 sscanf(argv[3], "%x", &cnt);
>  =C2=A0 printf("file: %s offset: %x size: %x\n", argv[1], offs, cnt);
>  =C2=A0 struct iovec iov =3D {buf, (size_t)cnt};
>  =C2=A0 size_t sz =3D preadv(f, &iov, 1, offs);
>  =C2=A0 printf("read %x\n", (int)sz);
>  =C2=A0 int i;
>  =C2=A0 unsigned int sum =3D 0;
>  =C2=A0 for (i =3D 0 ; i < cnt ; ++i)
>  =C2=A0=C2=A0=C2=A0 sum +=3D buf[i];
>  =C2=A0 printf("sum =3D %x\n", sum);
> }
>=20


Hmm, I don't see any issues here..

Are you absolutely sure, that all these reads are from backing file, which =
is read-only and never changed (may be by other processes)?
Hmm, may be it worth making backing file to be read-only on file-system lev=
el?
If yes, I can imagine only two things:
1. bug in file-system (as all that we are doing is preadv syscall from the =
same place of never-modified file)
2. guest modifies buffers during operation (you can catch it if allocate pe=
rsonal buffer for preadv, than calculate checksum, then memcpy to guest buf=
fer)


--=20
Best regards,
Vladimir

