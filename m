Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893CFC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E22421556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E22421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WUk-0002ck-3C
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1j6WU8-0002BA-8Y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j6WU6-0000CM-NX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:26:36 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57594)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1j6WU6-0000BR-BK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:26:34 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 9EC87C010D;
 Tue, 25 Feb 2020 12:26:31 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: <kwolf@redhat.com>
References: <2fb9fb4840d5aa92a716487f83ceb36c@ispras.ru>
 <0afe41fc-cc09-5682-a667-574c44fd6da3@virtuozzo.com>
 <5891b48a131321be62a4a311253da44c@ispras.ru>
 <af246719-910b-1394-2f18-b88e3daa9c81@virtuozzo.com>
 <0cbd2c7a-44e1-272f-9995-1ff7e2fb9e36@virtuozzo.com>
 <b3405d429e42bdf03177db1b8f7531ee@ispras.ru>
 <b5811027-388a-98db-fe73-93230b5e29ae@virtuozzo.com>
 <5fe1747e6e7b818d93fd9a7fd0434bed@ispras.ru>
 <99ed3129-9460-dbad-0441-95bad08d5636@virtuozzo.com>
 <796f18ec7246b8d07ac5d6bb59dca71f@ispras.ru>
 <b408733f-a0d7-62ab-8862-8d70d7148e5f@virtuozzo.com>
 <ac41c395f09a4101b7403e4116beba6a@ispras.ru>
 <e11be78b-9461-6068-969a-2f242ef5ada0@virtuozzo.com>
In-Reply-To: <e11be78b-9461-6068-969a-2f242ef5ada0@virtuozzo.com>
Subject: RE: Race condition in overlayed qcow2?
Date: Tue, 25 Feb 2020 12:26:32 +0300
Message-ID: <004a01d5ebbd$ab3dad70$01b90850$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: ru
Thread-Index: AdXrvKYTDoJE5CcfR9OYxlMvrY2RZwAAEq2Q
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
Cc: 'Vladimir Sementsov-Ogievskiy' <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin, what do you think about it?

What guest is intended to receive, when it requests multiple reads to =
the same buffer in a single DMA transaction?

Should it be the first SG part? The last one?
Or just a random set of bytes? (Then why it is reading this data in that =
case?)

Pavel Dovgalyuk

> -----Original Message-----
> From: Vladimir Sementsov-Ogievskiy [mailto:vsementsov@virtuozzo.com]
> Sent: Tuesday, February 25, 2020 12:19 PM
> To: dovgaluk
> Cc: qemu-devel@nongnu.org; mreitz@redhat.com; kwolf@redhat.com
> Subject: Re: Race condition in overlayed qcow2?
>=20
> 25.02.2020 10:56, dovgaluk wrote:
> > Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =
2020-02-25 10:27:
> >> 25.02.2020 8:58, dovgaluk wrote:
> >>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =
2020-02-21 16:23:
> >>>> 21.02.2020 15:35, dovgaluk wrote:
> >>>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =
2020-02-21 13:09:
> >>>>>> 21.02.2020 12:49, dovgaluk wrote:
> >>>>>>> Vladimir Sementsov-Ogievskiy =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =
2020-02-20 12:36:
> >>>>>>
> >>>>>> So, preadv in file-posix.c returns different results for the =
same
> >>>>>> offset, for file which is always opened in RO mode? Sounds =
impossible
> >>>>>> :)
> >>>>>
> >>>>> True.
> >>>>> Maybe my logging is wrong?
> >>>>>
> >>>>> static ssize_t
> >>>>> qemu_preadv(int fd, const struct iovec *iov, int nr_iov, off_t =
offset)
> >>>>> {
> >>>>>      ssize_t res =3D preadv(fd, iov, nr_iov, offset);
> >>>>>      qemu_log("preadv %x %"PRIx64"\n", fd, (uint64_t)offset);
> >>>>>      int i;
> >>>>>      uint32_t sum =3D 0;
> >>>>>      int cnt =3D 0;
> >>>>>      for (i =3D 0 ; i < nr_iov ; ++i) {
> >>>>>          int j;
> >>>>>          for (j =3D 0 ; j < (int)iov[i].iov_len ; ++j)
> >>>>>          {
> >>>>>              sum +=3D ((uint8_t*)iov[i].iov_base)[j];
> >>>>>              ++cnt;
> >>>>>          }
> >>>>>      }
> >>>>>      qemu_log("size: %x sum: %x\n", cnt, sum);
> >>>>>      assert(cnt =3D=3D res);
> >>>>>      return res;
> >>>>> }
> >>>>>
> >>>>
> >>>> Hmm, I don't see any issues here..
> >>>>
> >>>> Are you absolutely sure, that all these reads are from backing =
file,
> >>>> which is read-only and never changed (may be by other processes)?
> >>>
> >>> Yes, I made a copy and compared the files with binwalk.
> >>>
> >>>> 2. guest modifies buffers during operation (you can catch it if
> >>>> allocate personal buffer for preadv, than calculate checksum, =
then
> >>>> memcpy to guest buffer)
> >>>
> >>> I added the following to the qemu_preadv:
> >>>
> >>>      // do it again
> >>>      unsigned char *buf =3D g_malloc(cnt);
> >>>      struct iovec v =3D {buf, cnt};
> >>>      res =3D preadv(fd, &v, 1, offset);
> >>>      assert(cnt =3D=3D res);
> >>>      uint32_t sum2 =3D 0;
> >>>      for (i =3D 0 ; i < cnt ; ++i)
> >>>          sum2 +=3D buf[i];
> >>>      g_free(buf);
> >>>      qemu_log("--- sum2 =3D %x\n", sum2);
> >>>      assert(sum2 =3D=3D sum);
> >>>
> >>> These two reads give different results.
> >>> But who can modify the buffer while qcow2 workers filling it with =
data from the disk?
> >>>
> >>
> >> As far as I know, it's guest's buffer, and guest may modify it =
during
> >> the operation. So, it may be winxp :)
> >
> > True, but normally the guest won't do it.
> >
> > But I noticed that DMA operation which causes the problems has the =
following set of the
> buffers:
> > dma read sg size 20000 offset: c000fe00
> > --- sg: base: 2eb1000 len: 1000
> > --- sg: base: 3000000 len: 1000
> > --- sg: base: 2eb2000 len: 3000
> > --- sg: base: 3000000 len: 1000
> > --- sg: base: 2eb5000 len: b000
> > --- sg: base: 3040000 len: 1000
> > --- sg: base: 2f41000 len: 3000
> > --- sg: base: 3000000 len: 1000
> > --- sg: base: 2f44000 len: 4000
> > --- sg: base: 3000000 len: 1000
> > --- sg: base: 2f48000 len: 2000
> > --- sg: base: 3000000 len: 1000
> > --- sg: base: 3000000 len: 1000
> > --- sg: base: 3000000 len: 1000
> >
> >
> > It means that one DMA transaction performs multiple reads into the =
same address.
> > And no races is possible, when there is only one qcow2 worker.
> > When there are many of them - they can fill this buffer =
simultaneously.
> >
>=20
> Hmm, actually if guest start parallel reads into same buffer from =
different offsets, races are
> possible anyway, as different requests run in parallel even with one =
worker, because
> MAX_WORKERS is per-request value, not total... But several workers may =
increase probability of
> races or introduce new ones.
>=20
> So, actually, several workers of one request can write to the same =
buffer only if guest
> provides broken iovec, which references the same buffer several times =
(if it is possible at
> all).
>=20
>=20
>=20
> --
> Best regards,
> Vladimir


