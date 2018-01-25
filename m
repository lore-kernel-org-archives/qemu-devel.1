Received: from eggs.gnu.org ([2001:4830:134:3::10]:41479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eenHN-0001zX-U1
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 14:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eenHJ-0002H4-CI
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 14:33:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eenHJ-0002FS-1d
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 14:33:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D640A34D8
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 19:33:39 +0000 (UTC)
References: <20180125170930.20009-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b70578b-6062-e7c8-8542-e3afc0d570ba@redhat.com>
Date: Thu, 25 Jan 2018 13:33:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180125170930.20009-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Rxi8G3Qo34UccUhzHTG4fxUv57gCLgUDc"
Subject: Re: [Qemu-devel] [PATCH v2] docs: update information for TLS
 certificate management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rxi8G3Qo34UccUhzHTG4fxUv57gCLgUDc
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9b70578b-6062-e7c8-8542-e3afc0d570ba@redhat.com>
Subject: Re: [PATCH v2] docs: update information for TLS certificate
 management
References: <20180125170930.20009-1-berrange@redhat.com>
In-Reply-To: <20180125170930.20009-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2018 11:09 AM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> The current docs for TLS assume only VNC is using TLS. Some of the info=
rmation
> is also outdated (ie lacking subject alt name info for certs). Rewrite =
it to
> more accurately reflect the current situation.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> Changed in v2:
>=20
>  - Much content editting  / fixes (Eric)

Does it count if I find "editing" typos in the part that doesn't land in
git? :)

> +@subsection Configuring SASL mechanisms
> +
> +The following documentation assumes use of the Cyrus SASL implementati=
on on a
> +Linux host, but the principals should apply to any other SASL implemen=
tation
> +or host. When SASL is enabled, the mechanism configuration will be loa=
ded from
> +system default SASL service config /etc/sasl2/qemu.conf. If running QE=
MU as an
> +unprivileged user, an environment variable SASL_CONF_PATH can be used =
to make
> +behaviour suddenly changedit search alternate locations for the servic=
e config.

s/suddenly changedit/change to/?  Not sure if that's what you meant
there, or if you omitted words in addition to the space

> +The saslpasswd2 program can be used to populate the passwd.db file wit=
h
> +accounts.
> +
> +Other SASL configurations will be left as an exercise for the reader. =
Note that
> +all mechanisms except GSSAPI, should be combined with use of TLS to en=
sure a

either "mechanisms, except GSSAPI," or "mechanisms except GSSAPI" (using
just one comma is wrong; the choice between the other two forms depend
on whether you want a pause for emphasis)

> +
> +Almost all network services in QEMU have the ability to use TLS for
> +session data encryption, along with x509 certificates for simple
> +client authentication. What follows is a description of how to
> +generate certificates suitable for usage with QEMU, and applies to
> +the VNC server, character devices with the TCP backend, NBD server
> +and client, and migration sever and client.

s/sever/server/


> +@node tls_creds_setup
> +@subsection TLS x509 credential configuration
> =20
> -@node vnc_setup_sasl
> +QEMU has a standard mechanism for loading x509 credentials that will b=
e
> +used for network services and clients. It requires specifying the
> +@code{tls-creds-x509} class name to the @code{-object} command line

Note that qemu accepts both -object and --object,...

> +argument for the system emulators. This also works for the helper tool=
s
> +like @code{qemu-nbd} and @code{qemu-img}, but is named @code{--object}=
=2E

=2E..while you are correct that other tools do not accept -object.  I
argue, as one of our bite-sized tasks, that we should just use
@code{--object} everywhere and not bother documenting the single-dash
crutch that qemu has.

https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documenta=
tion

Getting closer, and when it comes to documentation, anything is better
than nothing, so I trust that you'll fix my comments and can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Rxi8G3Qo34UccUhzHTG4fxUv57gCLgUDc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpqMRAACgkQp6FrSiUn
Q2o/0ggAhKEfeCchIPeXFryLuc/uLtRVwnMfFkE7BEvEEhcv1oKnuavd2nODh9RS
HFzxLVmTv4ZO4OReLKy2UfPJE87jU6mMu28m3dRptJpEwrhaQvY2hYhnCOedovmJ
zXrQn+RjJ6gOF612FuMg1/JjXhZ3ZAeK1JzDmkYEg6kulFNYpD1Y2iVMjOSfATNT
5p6UBNDotzvzms1YlZxlQLCZ3e7SkPzXchh0+NwxgU6fS0oP3CZRvUXSKO7fDbeP
LNv2PFLCTdVqttTXoGJ+v/7i5EcUkzet/znwX9QrH3x/aGrbZ0ZGnpMxQYzyXd+L
+LWaztFP3JSEFIpBmMlkAQ3JD4tlhQ==
=Q82a
-----END PGP SIGNATURE-----

--Rxi8G3Qo34UccUhzHTG4fxUv57gCLgUDc--
