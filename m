Received: from eggs.gnu.org ([2001:4830:134:3::10]:46541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQcnV-0004NI-SH
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQcnS-0008Ss-Nt
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:00:05 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:54058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQcnS-0008RY-HH
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:00:02 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 820F210E9A4
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 18:59:59 +0200 (CEST)
Date: Thu, 29 Jun 2017 18:59:56 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170629185956.4907c616@bahia.lan>
In-Reply-To: <CAFEAcA_nEPOV25nimO1w2K51G7ooaRUseSwwy=Vc-gvFv2AkTA@mail.gmail.com>
References: <1498743831-28676-1-git-send-email-groug@kaod.org>
	<CAFEAcA_nEPOV25nimO1w2K51G7ooaRUseSwwy=Vc-gvFv2AkTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/kWQjCqQLSLqo4o4m1QIxt5w";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 0/8] 9pfs patches for 2.10 20170629
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

--Sig_/kWQjCqQLSLqo4o4m1QIxt5w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Jun 2017 17:00:51 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 29 June 2017 at 14:43, Greg Kurz <groug@kaod.org> wrote:
> > The following changes since commit 464588675455afda2899e20a0b120e4075de=
50c7:
> >
> >   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170627-t=
ag' into staging (2017-06-29 11:45:01 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/gkurz/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 06a37db7b12e4d42a6699c2fef820158f470ec4f:
> >
> >   9pfs: handle transport errors in pdu_complete() (2017-06-29 15:11:51 =
+0200)
> >
> > ----------------------------------------------------------------
> > - fixes a minor bug that could possibly prevent old guests to remove
> >   directories
> > - makes default permissions for new files configurable from the cmdline
> >   when using mapped security modes
> > - handle transport errors
> > - g_malloc()+memcpy() converted to g_memdup()
> >
> > ----------------------------------------------------------------
> > Bruce Rogers (1):
> >       9pfs: local: remove: use correct path component
> >
> > Greg Kurz (4):
> >       virtio-9p: record element after sanity checks
> >       virtio-9p: message header is 7-byte long
> >       virtio-9p: break device if buffers are misconfigured
> >       9pfs: handle transport errors in pdu_complete()
> >
> > Marc-Andr=C3=A9 Lureau (1):
> >       9pfs: replace g_malloc()+memcpy() with g_memdup()
> >
> > Stefano Stabellini (1):
> >       xen-9pfs: disconnect if buffers are misconfigured
> >
> > Tobias Schramm (1):
> >       9pfs: local: Add support for custom fmode/dmode in 9ps mapped sec=
urity modes
> > =20
>=20
> Applied, thanks.
>=20

Thanks but I just realize I forgot to add my Signed-off-by to patch 3/8... =
:-\

Sorry.

--
Greg

> -- PMM


--Sig_/kWQjCqQLSLqo4o4m1QIxt5w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllVMgwACgkQAvw66wEB28JsZQCfSRweAQztmPBxSOCaFmgtWh1g
mJQAn3eGMqs5G0ebPTgpPLpAIwBxwj1Q
=RPh8
-----END PGP SIGNATURE-----

--Sig_/kWQjCqQLSLqo4o4m1QIxt5w--
