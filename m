Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C6EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F3A21726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F3A21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CKV-0004Ah-CZ
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i1CJR-0003UC-QY
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i1CJQ-0000to-AJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:21:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i1CJM-0000oe-Ri; Fri, 23 Aug 2019 12:21:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3C25A2FC4E;
 Fri, 23 Aug 2019 16:21:11 +0000 (UTC)
Received: from localhost (ovpn-117-66.ams2.redhat.com [10.36.117.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 955A9600C1;
 Fri, 23 Aug 2019 16:21:08 +0000 (UTC)
Date: Fri, 23 Aug 2019 17:21:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190823162107.GC27586@stefanha-x1.localdomain>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
 <20190822155046.GA20462@stefanha-x1.localdomain>
 <9c1212a8-e9a2-662a-95ca-eab33ea7e367@virtuozzo.com>
 <0f0c8882-ab41-8fcf-85ca-ecff901f4ce8@virtuozzo.com>
 <870d2422-b37a-2ce2-72d6-6cded1598b22@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <870d2422-b37a-2ce2-72d6-6cded1598b22@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 23 Aug 2019 16:21:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for
 io
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 05:59:43PM +0000, Vladimir Sementsov-Ogievskiy wrot=
e:
> 22.08.2019 20:39, Vladimir Sementsov-Ogievskiy wrote:
> > 22.08.2019 20:24, Vladimir Sementsov-Ogievskiy wrote:
> >> 22.08.2019 18:50, Stefan Hajnoczi wrote:
> >>> On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> >>>> Hi all!
> >>>>
> >>>> Here is new parameter qiov_offset for io path, to avoid
> >>>> a lot of places with same pattern of creating local_qiov or hd_qiov
> >>>> variables.
> >>>>
> >>>> These series also includes my
> >>>> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
> >>>> with some changes [described in 01 and 03 emails]
> >>>>
> >>>> Vladimir Sementsov-Ogievskiy (12):
> >>>> =A0=A0 util/iov: introduce qemu_iovec_init_extended
> >>>> =A0=A0 util/iov: improve qemu_iovec_is_zero
> >>>> =A0=A0 block/io: refactor padding
> >>>> =A0=A0 block: define .*_part io handlers in BlockDriver
> >>>> =A0=A0 block/io: bdrv_co_do_copy_on_readv: use and support qiov_offs=
et
> >>>> =A0=A0 block/io: bdrv_co_do_copy_on_readv: lazy allocation
> >>>> =A0=A0 block/io: bdrv_aligned_preadv: use and support qiov_offset
> >>>> =A0=A0 block/io: bdrv_aligned_pwritev: use and support qiov_offset
> >>>> =A0=A0 block/io: introduce bdrv_co_p{read,write}v_part
> >>>> =A0=A0 block/qcow2: refactor qcow2_co_preadv to use buffer-based io
> >>>> =A0=A0 block/qcow2: implement .bdrv_co_preadv_part
> >>>> =A0=A0 block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
> >>>>
> >>>> =A0 block/qcow2.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
> >>>> =A0 include/block/block_int.h |=A0 21 ++
> >>>> =A0 include/qemu/iov.h=A0=A0=A0=A0=A0=A0=A0 |=A0 10 +-
> >>>> =A0 block/backup.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
> >>>> =A0 block/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 532 ++=
++++++++++++++++++++----------------
> >>>> =A0 block/qcow2-cluster.c=A0=A0=A0=A0 |=A0 14 +-
> >>>> =A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 131 +++++---=
--
> >>>> =A0 qemu-img.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =
4 +-
> >>>> =A0 util/iov.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 153 ++=
+++++++--
> >>>> =A0 9 files changed, 559 insertions(+), 309 deletions(-)
> >>>
> >>> qemu-iotests 077 fails after I apply this series (including your
> >>> uninitialized variable fix).=A0 I'm afraid I can't include it in the =
block
> >>> pull request, sorry!
> >>>
> >>> Stefan
> >>>
> >>
> >> Hmm, 77 don't work on master for me:
> >> 077=A0=A0=A0=A0=A0 fail=A0=A0=A0=A0=A0=A0 [20:23:57] [20:23:59]=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 output mismatch (see 07=
7.out.bad)
> >> --- /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out=A0=
=A0=A0=A0 2019-04-22 15:06:56.162045432 +0300
> >> +++ /work/src/qemu/up-block-drop-hd-qiov/tests/qemu-iotests/077.out.ba=
d 2019-08-22 20:23:59.124122307 +0300
> >> @@ -1,7 +1,15 @@
> >> =A0=A0QA output created by 077
> >> +=3D=3D117186=3D=3DWARNING: ASan doesn't fully support makecontext/swa=
pcontext functions and may produce false positives in some cases!
> >> +=3D=3D117186=3D=3DWARNING: ASan is ignoring requested __asan_handle_n=
o_return: stack top: 0x7ffefc071000; bottom 0x7fad7277b000; size: 0x0051898=
f6000 (350200225792)
> >> +False positive error reports may follow
> >> +For details see http://code.google.com/p/address-sanitizer/issues/det=
ail?id=3D189
> >> =A0=A0Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
> >>
> >> =A0=A0=3D=3D Some concurrent requests involving RMW =3D=3D
> >> +=3D=3D117197=3D=3DWARNING: ASan doesn't fully support makecontext/swa=
pcontext functions and may produce false positives in some cases!
> >> +=3D=3D117197=3D=3DWARNING: ASan is ignoring requested __asan_handle_n=
o_return: stack top: 0x7fffa4fcc000; bottom 0x7fa93a2c1000; size: 0x00566ad=
0b000 (371159248896)
> >> +False positive error reports may follow
> >> +For details see http://code.google.com/p/address-sanitizer/issues/det=
ail?id=3D189
> >> =A0=A0wrote XXX/XXX bytes at offset XXX
> >> =A0=A0XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> =A0=A0wrote XXX/XXX bytes at offset XXX
> >> @@ -66,6 +74,10 @@
> >> =A0=A0XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >>
> >> =A0=A0=3D=3D Verify image content =3D=3D
> >> +=3D=3D117219=3D=3DWARNING: ASan doesn't fully support makecontext/swa=
pcontext functions and may produce false positives in some cases!
> >> +=3D=3D117219=3D=3DWARNING: ASan is ignoring requested __asan_handle_n=
o_return: stack top: 0x7ffc722de000; bottom 0x7f0848232000; size: 0x00f42a0=
ac000 (1048677367808)
> >> +False positive error reports may follow
> >> +For details see http://code.google.com/p/address-sanitizer/issues/det=
ail?id=3D189
> >> =A0=A0read 512/512 bytes at offset 0
> >> =A0=A0512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> =A0=A0read 512/512 bytes at offset 512
> >> @@ -156,5 +168,9 @@
> >> =A0=A01 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> =A0=A0read 2048/2048 bytes at offset 71680
> >> =A0=A02 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> +=3D=3D117229=3D=3DWARNING: ASan doesn't fully support makecontext/swa=
pcontext functions and may produce false positives in some cases!
> >> +=3D=3D117229=3D=3DWARNING: ASan is ignoring requested __asan_handle_n=
o_return: stack top: 0x7fffa3342000; bottom 0x7fd85a275000; size: 0x0027490=
cd000 (168729300992)
> >> +False positive error reports may follow
> >> +For details see http://code.google.com/p/address-sanitizer/issues/det=
ail?id=3D189
> >> =A0=A0No errors were found on the image.
> >> =A0=A0*** done
> >> Failures: 077
> >> Failed 1 of 1 tests
> >>
> >>
> >>
> >=20
> > But after "block/io: refactor padding" it hangs instead of this fail.. =
This is not good
> >=20
> >=20
>=20
> Aha seems it's because 77 has "break pwritev_rmw_after_tail" which may no=
t fire if we have merge_reads =3D true.
>=20
> So, for me the following fix for 03 helps (77 fails, but not hangs, so sa=
me behavior as on master):
>=20
> diff --git a/block/io.c b/block/io.c
> index 6448f1c503..04e69400d8 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1493,13 +1493,23 @@ static int bdrv_padding_rmw_read(BdrvChild *child,
>=20
>           qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
>=20
> -        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
> +        if (pad->head) {
> +            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
> +        }
> +        if (pad->merge_reads && pad->tail) {
> +            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
> +        }
>           ret =3D bdrv_aligned_preadv(child, req, req->overlap_offset, by=
tes,
>                                     align, &local_qiov, 0);
>           if (ret < 0) {
>               return ret;
>           }
> -        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
> +        if (pad->head) {
> +            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
> +        }
> +        if (pad->merge_reads && pad->tail) {
> +            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
> +        }
>=20
>=20
> Does it work for you?

Yes, it works as expected now, thanks.  I've squashed in your fix and
will send these patches in the next block pull request.

Stefan

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1gEnMACgkQnKSrs4Gr
c8hfNQf/ZHLqFsvcYDVnhLwFQqrlMaSzvKZHYgCaZvjFt4j1ExX5CUpgKdZGVWvB
i5zlj7bCp7nOHrWUF972YApckoMPP7jr0Q3kjX8hDXU151NsrU80U6ATVRbDpYjI
4mnWIxp02YACwoNWw2CYuiKXNPZTHsufWATUOAFa25N9Ep51KCwUwS9JZHgxdp6V
DMaodpCYcOz1xCUkI+lk8jm7XIbyeAfSuHuMiG1PuD9G0E7jPZLAYlygH2aPYoy0
56QYoFQ0REXuNPqH7OK8U/EEQTdLh2bppWQz+7U2elDzZWtMeAereYG8dR9qKmuS
lWNzKLgM4URl0kU+ghYLDXO18OsOEQ==
=oXDm
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--

