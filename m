Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E88CC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F162320879
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XCPH9KhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F162320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU3ms-0001Hf-Pt
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 02:34:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hU3m3-0000yR-UO
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hU3m2-00015W-Ie
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:33:51 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54819)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hU3m1-000137-4w; Fri, 24 May 2019 02:33:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 459Gm35kNVz9sB8; Fri, 24 May 2019 16:33:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558679619;
	bh=2tK3Gnl7KWc4CZMXXRxxhd5TrJFQVVp+pZix153h3fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCPH9KhP4CkXjPhj1+FRbcmkAiRAGzQxJjGYsztsX0kY0NEX6bhmTHyaPMLWu94sw
	lkSivyrle19DQF/ADa+vNMh2VeyM345SQ41rmXtxrbM/Wbdoj3VpUZDUEc5OHeTPAT
	FLZwYY0Lav7Xq6MCJAxXZNx/KOFw56yX0pLNpYSk=
Date: Fri, 24 May 2019 16:30:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190524063049.GD1967@umbus.fritz.box>
References: <20190522044600.16534-1-david@gibson.dropbear.id.au>
	<CAFEAcA_-O7AS-qBmj_Ba6N69WW5DBenPmxUATs3vQcdBW5Hj5w@mail.gmail.com>
	<20190524004616.GB1967@umbus.fritz.box>
	<20190524021725.GC1967@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <20190524021725.GC1967@umbus.fritz.box>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PULL 00/38] ppc-for-4.1 queue 20190522
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
	Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 12:17:25PM +1000, David Gibson wrote:
> On Fri, May 24, 2019 at 10:46:16AM +1000, David Gibson wrote:
> > On Thu, May 23, 2019 at 10:29:57AM +0100, Peter Maydell wrote:
> > > On Wed, 22 May 2019 at 05:46, David Gibson <david@gibson.dropbear.id.=
au> wrote:
> > > >
> > > > The following changes since commit a4f667b6714916683408b983cfe0a615=
a725775f:
> > > >
> > > >   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-=
3' into staging (2019-05-21 16:30:13 +0100)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190522
> > > >
> > > > for you to fetch changes up to 885659103ad9e1b0460e89c548e9fb823b00=
7b7e:
> > > >
> > > >   docs: provide documentation on the POWER9 XIVE interrupt controll=
er (2019-05-22 10:38:22 +1000)
> > > >
> > > > ----------------------------------------------------------------
> > > > ppc patch queue 2019-05-22
> > > >
> > > > Next pull request against qemu-4.1.  Highlights:
> > > >   * KVM accelerated support for the XIVE interrupt controller in PA=
PR
> > > >     guests
> > > >   * A number of TCG vector fixes
> > > >   * Fixes for the PReP / 40p machine
> > > >
> > > > Other than that it's just a bunch of assorted fixes, cleanups and
> > > > minor improvements.
> > > >
> > > > This supersedes the pull request dated 2019-05-21.  I've dropped the
> > > > headers update, since it had a mistake, but is now made redundant b=
y a
> > > > similar update in Cornelia's applied PR.  I've also added a patch w=
ith
> > > > extra documentation for the XIVE interrupt controller, and fixed a
> > > > couple of minor style errors in the previous PR.
> > > >
> > > > ----------------------------------------------------------------
> > >=20
> > > Hi -- this failed 'make check-tcg' for the linux-static build
> > > (x86-64 host):
> > >=20
> > >   TEST    linux-test on ppc64abi32
> > > qemu-ppc64abi32:
> > > /home/petmay01/linaro/qemu-for-merges/accel/tcg/cpu-exec.c:700:
> > > cpu_exec: Assertion `!have_mmap_lock()' failed.
> > > qemu-ppc64abi32:
> > > /home/petmay01/linaro/qemu-for-merges/accel/tcg/cpu-exec.c:700:
> > > cpu_exec: Assertion `!have_mmap_lock()' failed.
> > > /home/petmay01/linaro/qemu-for-merges/tests/tcg/Makefile:122: recipe
> > > for target 'run-linux-test' failed
> >=20
> > Bother.  I did run a make check-tcg on an x86_64 host, and didn't see
> > this.  Investigating...
>=20
>   BUILD   TCG tests for ppc64abi32-linux-user
>   BUILD   ppc64abi32 guest-tests SKIPPED
>   RUN     TCG tests for ppc64abi32-linux-user
>   RUN     tests for ppc64abi32 SKIPPED
>=20
> Well, that explains why I didn't see it.  I'm using the docker setup
> for check-tcg, but it's not clear to me what bits I need to run the
> ppc64abi32 tests.

What I can find seems to imply that it should use a a 32-bit ppc
target compiler, but if I do that the test SEGVs on master, not just
on my branch.

I'm having a lot of trouble even figuring out what the ppc64abi32
target is supposed to be about.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlznj5cACgkQbDjKyiDZ
s5KKQhAAkBxsUGs1VmNW1aWdWhL+++siuEJxzbEhJgG6j434f1lo5ugHTvXXt0rk
vwGdU0Qc1zyjAYWtvK5EuxN9R2K/jeRRSb/yK2qzqtMA5KvCPqjoaq68WzlomwlT
b04eEuyCYNaqagHoDT4AN3Cw4/Gmg92ybKOHFFKt3KZUqPVQw1olOx/wlzwrNpgZ
OaL6uNmykhhQrc0iLF/k2/beCPjUxxeBaOt2IgeJoJLKVoll+8EGKTHCm8Fweh7I
8Ck6QNUUak60P5t9OdNdQ3d6zlNLLOXk59qz1XusD5WFuRXz1vDdEDl9dX7kNdA1
Trh56+wCwujBh+O0yAwzkIZK8qda8aogPGoxYOw5LaRRdjJ5EVx4lT15V8lTPjmq
rsKQpGnKYl8u+3iWfP4ZkP83sGXzQ6dSAxbsji1QJTdsHuxaMDJ0dLaB9YovFHno
7Rpr8IxZ2jVZwiKowIIW7hreeY45M7os5Jna/QwParg50nEEKk6YzG5ZTlrXP6bz
qTVsgmyKQxtT3C9AQ/iCRG5M5QocApeudADNDiH0HkAHbRpjxSC5vNzbaGcTTNXV
O+3Jvcry4F26OWumIdA6JT41sXeYzIjQqmL7Bz9bxYUk+GzhNs+W2YmZ2DrwlINm
mOT8Q13QJETyV/9w3pYo6r9MCosvcpnFed6awnlWvATRwDAXDyw=
=wBtj
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

