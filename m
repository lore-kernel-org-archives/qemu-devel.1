Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E146FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63222182B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63222182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huZjX-0001fI-Sq
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 05:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1huZj8-0001CZ-GE
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1huZj7-0003RR-AY
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:56:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1huZj4-0003QF-Pl; Mon, 05 Aug 2019 05:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCC7D7FDFF;
 Mon,  5 Aug 2019 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-77.ams2.redhat.com
 [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54EAC60C47;
 Mon,  5 Aug 2019 09:56:12 +0000 (UTC)
Date: Mon, 5 Aug 2019 11:56:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190805095610.GA6889@localhost.localdomain>
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 05 Aug 2019 09:56:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] util/hbitmap: fix unaligned reset
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
Cc: fam@euphon.net, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 02.08.2019 um 23:19 hat Max Reitz geschrieben:
> On 02.08.19 20:58, Vladimir Sementsov-Ogievskiy wrote:
> > hbitmap_reset is broken: it rounds up the requested region. It leads to
> > the following bug, which is shown by fixed test:
> >=20
> > assume granularity =3D 2
> > set(0, 3) # count becomes 4
> > reset(0, 1) # count becomes 2
> >=20
> > But user of the interface assume that virtual bit 1 should be still
> > dirty, so hbitmap should report count to be 4!
> >=20
> > In other words, because of granularity, when we set one "virtual" bit,
> > yes, we make all "virtual" bits in same chunk to be dirty. But this
> > should not be so for reset.
> >=20
> > Fix this, aligning bound correctly.
> >=20
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >=20
> > Hi all!
> >=20
> > Hmm, is it a bug or feature? :)
> > I don't have a test for mirror yet, but I think that sync mirror may be=
 broken
> > because of this, as do_sync_target_write() seems to be using unaligned =
reset.
>=20
> Crap.
>=20
>=20
> Yes, you=E2=80=99re right.  This would fix it, and it wouldn=E2=80=99t fi=
x it in the
> worst way.
>=20
> But I don=E2=80=99t know whether this patch is the best way forward still=
=2E  I
> think call hbitmap_reset() with unaligned boundaries generally calls for
> trouble, as John has laid out.  If mirror=E2=80=99s do_sync_target_write(=
) is
> the only offender right now, I=E2=80=99d prefer for hbitmap_reset() to as=
sert
> that the boundaries are aligned (for 4.2), and for
> do_sync_target_write() to be fixed (for 4.1? :-/).
>=20
> (A practical problem with this patch is that do_sync_target_write() will
> still do the write, but it won=E2=80=99t change anything in the bitmap, s=
o the
> copy operation was effectively useless.)
>=20
> I don=E2=80=99t know how to fix mirror exactly, though.  I have four idea=
s:
>=20
> (A) Quick fix 1: do_sync_target_write() should shrink [offset, offset +
> bytes) such that it is aligned.  This would make it skip writes that
> don=E2=80=99t fill one whole chunk.
>=20
> +: Simple fix.  Could go into 4.1.
> -: Makes copy-mode=3Dwrite-blocking equal to copy-mode=3Dbackground unless
>    you set the granularity to like 512. (Still beats just being
>    completely broken.)

write-blocking promises that the guest receives request completion only
when the request has also been written to the target. If you completely
skip the write, this promise is broken.

So I think you'd have to keep the write and only align the range for the
purpose of clearing bits in the dirty bitmap. This would result in some
duplicated I/O, which is an efficiency problem, but at least it
shouldn't come with a correctness problem.

Kevin

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdR/06AAoJEH8JsnLIjy/WGY8QAMOEn7Zi0NjF84fHBo1MJsV/
iSJW6vX+KfitFLoWffrT0GXGVWldaFFJq1UBHurfppCSeuOGzvXWa2ptJI+Rj+q4
u50M3t9sZA2Yq1bftqtF90p/j6JF++NTDq1WtpyUv4eujei9gNxK9T67i1ph/EdI
dIHI+jzqP1WKlFm6sxoOSb7u8KZbQfiuLOeYWPt2YzhqP7UYONj36DAR2Foy7qHa
Rn/NFBOgMZVbbzmMV1zOL76dxKuEKYD7cANiH5Swwu61eyu03IkpokxroxjbD+mL
6YcL/gLEoje9VjRNUsuoGSy2PT54ogWwwzkJmNm+t1haIO9DSIN07GRjkYl0Q3Wm
uOSqx8ZDfFL47fxSGlpWWOiC+hgpNADZkhJavtaVqZNeeTLL3mxtZYM5ykCdQXy0
S6F3PHEU7zLmtGAtIvHkbnFpGEOhaf1aWxz8ouUwni71/2JAdgAZbLzi6dcp/6Xp
E15Vasr2S1UEm3ae870JQ9SwMSiwBTLK2qDtGu416LCGX0ZhDByYYZyFE2Ef4W6S
9mhoici5TgRPeZlrIjfP5FWX+xL2GE4P6jCUMDnUzQUgIdpmv7Me4HTNw3MI7vaH
9Wz8qjDDiEBH+5DiHNsy1+Pg5P9jtAE+LlkYyxrEI2ov0kD08tyrPctdJNRQ+nn8
ib71R9doEPLvTunMEStF
=Frdd
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

