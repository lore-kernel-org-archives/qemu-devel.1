Received: from eggs.gnu.org ([2001:4830:134:3::10]:58556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dT1qw-0006SW-SV
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dT1qr-0000Kt-Ph
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:09:34 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:59510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dT1qr-0000Ka-IM
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:09:29 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1588F8369E
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 10:09:28 +0200 (CEST)
Date: Thu, 6 Jul 2017 10:09:19 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170706100919.36be6596@bahia.lan>
In-Reply-To: <1499306921-5391-1-git-send-email-peterx@redhat.com>
References: <1499242883-2184-4-git-send-email-peterx@redhat.com>
	<1499306921-5391-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/8Qy16GaGUZXoTLAuGGh9NPW";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2.1 3/4] doc: add item for "-M
 enforce-config-section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, lvivier@redhat.com, ehabkost@redhat.com, quintela@redhat.com, dgilbert@redhat.com

--Sig_/8Qy16GaGUZXoTLAuGGh9NPW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  6 Jul 2017 10:08:41 +0800
Peter Xu <peterx@redhat.com> wrote:

> It's never documented, and now we have one more parameter for it (which
> obsoletes this one). Document it properly.
>=20
> Although now when enforce-config-section is set, it'll override the
> other "-global" parameter, that is not necessarily a rule. Forbid that
> usage in the document.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2.1:
> - remove the "undefined behavior" sentence [Markus]
>=20
>  qemu-options.hx | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 297bd8a..1ce7a37 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -85,6 +85,14 @@ Enables or disables NVDIMM support. The default is off.
>  @item s390-squash-mcss=3Don|off
>  Enables or disables squashing subchannels into the default css.
>  The default is off.
> +@item enforce-config-section=3Don|off
> +If @option{enforce-config-section} is set to @var{on}, force migration
> +code to send configuration section even if the machine-type sets the
> +@option{migration.send-configuration} property to @var{off}.
> +NOTE: this parameter is deprecated. Please use @option{-global}
> +@option{migration.send-configuration}=3D@var{on|off} instead.
> +@option{enforce-config-section} cannot be used together with
> +@option{-global} @option{migration.send-configuration}.

Is this last sentence correct ?

My understanding is that "enforce-config-section" overrides
"migration.send-configuration"...

>  @end table
>  ETEXI
> =20


--Sig_/8Qy16GaGUZXoTLAuGGh9NPW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlld8C8ACgkQAvw66wEB28LvOgCfcGwG6qk+4DiLa33AsHy6slrp
+BsAn2kgSWM4q9XxZHxzA38oUlHX9rMi
=N6my
-----END PGP SIGNATURE-----

--Sig_/8Qy16GaGUZXoTLAuGGh9NPW--
