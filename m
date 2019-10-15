Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD63C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDEB42089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEB42089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKIZH-0004qG-VT
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 04:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iKIXl-0002n9-DP
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iKIXk-0003NH-4X
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iKIXh-0003MH-Td; Tue, 15 Oct 2019 04:50:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1258630832E9;
 Tue, 15 Oct 2019 08:50:57 +0000 (UTC)
Received: from localhost (ovpn-116-252.ams2.redhat.com [10.36.116.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB2786012E;
 Tue, 15 Oct 2019 08:50:51 +0000 (UTC)
Date: Tue, 15 Oct 2019 09:50:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 1/1] test-bdrv-drain: fix iothread_join() hang
Message-ID: <20191015085050.GB16745@stefanha-x1.localdomain>
References: <20191014085211.25800-1-stefanha@redhat.com>
 <20191014085211.25800-2-stefanha@redhat.com>
 <8fd9e071-c62d-f90f-a7d7-b5b320cbde9b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <8fd9e071-c62d-f90f-a7d7-b5b320cbde9b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 15 Oct 2019 08:50:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 01:11:41PM +0200, Paolo Bonzini wrote:
> On 14/10/19 10:52, Stefan Hajnoczi wrote:
> > tests/test-bdrv-drain can hang in tests/iothread.c:iothread_run():
> >=20
> >   while (!atomic_read(&iothread->stopping)) {
> >       aio_poll(iothread->ctx, true);
> >   }
> >=20
> > The iothread_join() function works as follows:
> >=20
> >   void iothread_join(IOThread *iothread)
> >   {
> >       iothread->stopping =3D true;
> >       aio_notify(iothread->ctx);
> >       qemu_thread_join(&iothread->thread);
> >=20
> > If iothread_run() checks iothread->stopping before the iothread_join()
> > thread sets stopping to true, then aio_notify() may be optimized away
> > and iothread_run() hangs forever in aio_poll().
> >=20
> > The correct way to change iothread->stopping is from a BH that executes
> > within iothread_run().  This ensures that iothread->stopping is checked
> > after we set it to true.
> >=20
> > This was already fixed for ./iothread.c (note this is a different source
> > file!) by commit 2362a28ea11c145e1a13ae79342d76dc118a72a6 ("iothread:
> > fix iothread_stop() race condition"), but not for tests/iothread.c.
>=20
> Aha, I did have some kind of dejavu when sending the patch I have just
> sent; let's see if this also fixes the test-aio-multithread assertion
> failure.
>=20
> Note that with this change the atomic read of iothread->stopping can go
> away; I can send a separate patch later.

Yes, I thought about the atomic_read() later as well.

Stefan

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2liGoACgkQnKSrs4Gr
c8jEHAf/aHCx+sxAGErHk10SnSoPBz9IsBgEytnJ0b8Xy0gE2jM5VSfxPYmzT+Ld
lBnCT235H4eCsCedj+ZOdsRKHvgJAzxo9qjfSWbzIMHw/JMlJdsDDvTUw0cSEmxl
n5sc0xqbHznBNKby5KC/GTAePElXC86b7UFKTgFIF2XqMiHkYYKAJUi/sOpvQxkL
Re5Jnk0qJMw5gf3iJINHfYPMYNCKAX6DlbSnu865oatCfp7j41SFHo65JaxaEkyT
+zl9lpBWWETwAjldzwQGim/puKQ8TPSwJLvdtUeenYqje3uEL9NCQLynxU7ynXfe
czMrOgZqebQtpfidAyHwbxd+kCEQmg==
=qcQe
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--

