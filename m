Received: from eggs.gnu.org ([2001:4830:134:3::10]:53240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw8Y9-0005H4-Or
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw8Y7-0007lc-6A
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:38:13 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cw8Y6-0007lO-Vj
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:38:11 -0400
Received: by mail-wr0-x242.google.com with SMTP id t20so12007899wra.2
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 07:38:10 -0700 (PDT)
Date: Thu, 6 Apr 2017 15:38:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406143807.GN21895@stefanha-x1.localdomain>
References: <4712D8F4B26E034E80552F30A67BE0B1A4E5F6@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p1Od3smaOkJqivj4"
Content-Disposition: inline
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A4E5F6@ORSMSX112.amr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] Put all trace.o into libqemuutil.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, 'Daniel Berrange' <berrange@redhat.com>, 'Paolo Bonzini' <pbonzini@redhat.com>


--p1Od3smaOkJqivj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2017 at 09:39:39PM +0000, Xu, Anthony wrote:

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

I fixed up the patch when applying it.  Comments below:

> Put all trace.o into libqemuutil.a

Please use the "trace: " prefix for tracing patches.

All components of QEMU have commonly used prefixes that make it easy to
identify which area a patch affects.  People reading the mailing list or
grepping through git logs rely on this.

>=20
> Currently all trace.o are linked into qemu-system, qemu-img,=20
> qemu-nbd, qemu-io etc., even the corresponding components=20
> are not included.
> Put all trace.o into libqemuutil.a that the linker would only pull in .o=
=20
> files containing symbols that are actually referenced by the=20
> program.
>=20
>=20
> Signed-off -by: Anthony Xu <anthony.xu@intel.com>

Please use git-format-patch(1) to send correctly formatted patches in
the future.  git-am(1) was unable to apply your email and I had to do it
manually.

Stefan

--p1Od3smaOkJqivj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5lLPAAoJEJykq7OBq3PIkPkIAMKCu7jwoRQdV3ArhqEvrdYy
2G5veNfrvdJxnO7CIWfy8gZ+OMA+m0KFBUR5jjKVFrZ8GAs4Zq6CXVAnKTDLjuai
8vtBbDKuEYDPcpzRQs2avbox4gtquDO3dyRQvaVL4PpJSGyuQBjD+9GwdgzJswsw
TBerie0KvUgof4RCrDd8saoIyus7HLILRlBqf26fs/uwXKjC45YK8hXXX6D7MgS4
fvZtjaS95b4o0Hyp+xTw0UD3ehR2dM5ditZBLM78eEC/VqqXEokJ3YNro8e1QDlR
/yChpWX5E/FrZHpDvXlW8Cmkg8KXvPGTBIY9wej+ul15K0lYzSKoFEdKdue7a14=
=kVJP
-----END PGP SIGNATURE-----

--p1Od3smaOkJqivj4--
