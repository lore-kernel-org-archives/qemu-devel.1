Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FADC35DF2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 05:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8876221556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 05:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8876221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6TEw-0002oQ-M5
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 00:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1j6TEN-0002Ot-Jg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j6TEL-0007s3-Ve
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:58:07 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57634)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j6TEL-0007pi-JE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 00:58:05 -0500
Received: from mail.ispras.ru (localhost [127.0.0.1])
 by mail.ispras.ru (Postfix) with ESMTPSA id C8DA3C0101;
 Tue, 25 Feb 2020 08:58:00 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 25 Feb 2020 08:58:00 +0300
From: dovgaluk <dovgaluk@ispras.ru>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Race condition in overlayed qcow2?
In-Reply-To: <99ed3129-9460-dbad-0441-95bad08d5636@virtuozzo.com>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
 <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
 <b3405d429e42bdf03177db1b8f7531ee@ispras.ru>
 <b5811027-388a-98db-fe73-93230b5e29ae@virtuozzo.com>
 <5fe1747e6e7b818d93fd9a7fd0434bed@ispras.ru>
 <99ed3129-9460-dbad-0441-95bad08d5636@virtuozzo.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <796f18ec7246b8d07ac5d6bb59dca71f@ispras.ru>
X-Sender: dovgaluk@ispras.ru
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 83.149.199.45
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

Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-21 16=
:23:
> 21.02.2020 15:35, dovgaluk wrote:
>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-21=
 13:09:
>>> 21.02.2020 12:49, dovgaluk wrote:
>>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2020-02-=
20 12:36:
>>>>>>> 1 or 2 are ok, and 4 or 8 lead to the failures.
>>>>>>>=20
>>>>>>>=20
>>>>>>> That is strange. I could think, that it was caused by the bugs in
>>>>>>> deterministic CPU execution, but the first difference in logs
>>>>>>> occur in READ operation (I dump read/write buffers in=20
>>>>>>> blk_aio_complete).
>>>>>>>=20
>>>>>>=20
>>>>>> Aha, yes, looks strange.
>>>>>>=20
>>>>>> Then next steps:
>>>>>>=20
>>>>>> 1. Does problem hit into the same offset every time?
>>>>>> 2. Do we write to this region before this strange read?
>>>>>>=20
>>>>>> 2.1. If yes, we need to check that we read what we write.. You say=
=20
>>>>>> you dump buffers
>>>>>> in blk_aio_complete... I think it would be more reliable to dump=20
>>>>>> at start of
>>>>>> bdrv_co_pwritev and at end of bdrv_co_preadv. Also, guest may=20
>>>>>> modify its buffers
>>>>>> during operation which would be strange but possible.
>>>>>>=20
>>>>>> 2.2 If not, hmm...
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> Another idea to check: use blkverify
>>>>=20
>>>> I added logging of file descriptor and discovered that different=20
>>>> results are obtained
>>>> when reading from the backing file.
>>>> And even more - replay runs of the same recording produce different=20
>>>> results.
>>>> Logs show that there is a preadv race, but I can't figure out the=20
>>>> source of the failure.
>>>>=20
>>>> Log1:
>>>> preadv c 30467e00
>>>> preadv c 30960000
>>>> --- sum =3D a2e1e
>>>> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len:=20
>>>> 8200
>>>> --- sum =3D 10cdee
>>>> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len:=
=20
>>>> ee00
>>>>=20
>>>> Log2:
>>>> preadv c 30467e00
>>>> --- sum =3D a2e1e
>>>> bdrv_co_preadv_part complete offset: 30467e00 qiov_offset: 0 len:=20
>>>> 8200
>>>> preadv c 30960000
>>>> --- sum =3D f094f
>>>> bdrv_co_preadv_part complete offset: 30960000 qiov_offset: 8200 len:=
=20
>>>> ee00
>>>>=20
>>>>=20
>>>> Checksum calculation was added to preadv in file-posix.c
>>>>=20
>>>=20
>>> So, preadv in file-posix.c returns different results for the same
>>> offset, for file which is always opened in RO mode? Sounds impossible
>>> :)
>>=20
>> True.
>> Maybe my logging is wrong?
>>=20
>> static ssize_t
>> qemu_preadv(int fd, const struct iovec *iov, int nr_iov, off_t offset)
>> {
>>  =C2=A0=C2=A0=C2=A0 ssize_t res =3D preadv(fd, iov, nr_iov, offset);
>>  =C2=A0=C2=A0=C2=A0 qemu_log("preadv %x %"PRIx64"\n", fd, (uint64_t)of=
fset);
>>  =C2=A0=C2=A0=C2=A0 int i;
>>  =C2=A0=C2=A0=C2=A0 uint32_t sum =3D 0;
>>  =C2=A0=C2=A0=C2=A0 int cnt =3D 0;
>>  =C2=A0=C2=A0=C2=A0 for (i =3D 0 ; i < nr_iov ; ++i) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int j;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =3D 0 ; j < (int)io=
v[i].iov_len ; ++j)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 su=
m +=3D ((uint8_t*)iov[i].iov_base)[j];
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++=
cnt;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0 qemu_log("size: %x sum: %x\n", cnt, sum);
>>  =C2=A0=C2=A0=C2=A0 assert(cnt =3D=3D res);
>>  =C2=A0=C2=A0=C2=A0 return res;
>> }
>>=20
>=20
> Hmm, I don't see any issues here..
>=20
> Are you absolutely sure, that all these reads are from backing file,
> which is read-only and never changed (may be by other processes)?

Yes, I made a copy and compared the files with binwalk.

> 2. guest modifies buffers during operation (you can catch it if
> allocate personal buffer for preadv, than calculate checksum, then
> memcpy to guest buffer)

I added the following to the qemu_preadv:

     // do it again
     unsigned char *buf =3D g_malloc(cnt);
     struct iovec v =3D {buf, cnt};
     res =3D preadv(fd, &v, 1, offset);
     assert(cnt =3D=3D res);
     uint32_t sum2 =3D 0;
     for (i =3D 0 ; i < cnt ; ++i)
         sum2 +=3D buf[i];
     g_free(buf);
     qemu_log("--- sum2 =3D %x\n", sum2);
     assert(sum2 =3D=3D sum);

These two reads give different results.
But who can modify the buffer while qcow2 workers filling it with data=20
from the disk?



Pavel Dovgalyuk

