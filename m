Received: from eggs.gnu.org ([209.51.188.92]:39485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyJiM-0002BS-3Z
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyJiL-00029x-0u
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:06:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gyJiK-00028M-Nz
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:06:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB1E9308FF29
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 17:06:47 +0000 (UTC)
Date: Mon, 25 Feb 2019 17:06:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190225170646.GH379@stefanha-x1.localdomain>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline
In-Reply-To: <87imx8uu99.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Krempa <pkrempa@redhat.com>


--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 09:50:26AM +0100, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > QMP clients can usually detect the presence of features via schema
> > introspection.  There are rare features that do not involve schema
> > changes and are therefore impossible to detect with schema
> > introspection.
> >
> > This patch adds the query-qemu-capabilities command.  It returns a list
> > of capabilities that this QEMU supports.
>=20
> The name "capabilities" could be confusing, because we already have QMP
> capabilities, complete with command qmp_capabilities.  Would "features"
> work?

Sure, will fix.

> > The decision to make this a command rather than something statically
> > defined in the schema is intentional.  It allows QEMU to decide which
> > capabilities are available at runtime, if necessary.
> >
> > This new interface is necessary so that QMP clients can discover that
> > migrating disk image files is safe with cache.direct=3Doff on Linux.
> > There is no other way to detect whether or not QEMU supports this.
>=20
> I think what's unsaid here is that we don't want to make a completely
> arbitrary schema change just to carry this bit of information.  We
> could, but we don't want to.  Correct?

Yes, exactly.

> > +{ 'struct': 'QemuCapabilities',
> > +  'data': { 'capabilities': ['QemuCapability'] } }
> > +
> > +##
> > +# @query-qemu-capabilities:
> > +#
> > +# Return the capabilities supported by this QEMU.  Most features can be
> > +# detected via schema introspection but some are not observable from t=
he
> > +# schema.  This command offers a way to check for the presence of such
> > +# features.
> > +#
> > +# Since: 4.0
> > +##
> > +{ 'command': 'query-qemu-capabilities',
> > +  'returns': 'QemuCapabilities' }
>=20
> Capabilities are flags: either present or absent, thus effectively
> boolean.  I don't have a specific reason to doubt limiting capabilities
> to boolean.  However, doing QemuCapabilities like
>=20
>    { 'struct': 'QemuCapabilities',
>      'data': { 'migrate-with-cache-direct-off-on-linux': 'bool' } }
>=20
> could grow to support other values more easily.  What do you think?

Oops, I didn't think of the obvious solution!  Thank you, will fix.

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdCCmAAoJEJykq7OBq3PIoKIH/136yt+wHAWdMtsXxxvXjp7n
2h5KoUiwIgLy94aSCXX7222iXFrhVK6NUyzNJpWIuZCARGB/68YD9YVcwB9G9HWp
SLnbBXyv8BVifSZO1TW+zjm2eIyVmc5iOzdv1e+qiuX+rSGy7XNN7y/grTbOptae
3KFgOLHWCt6or7MJwj8Q1BkR4G/2gRAvjXqzm6a6dd4ccBb5m+LlCOzgjb+gn8fJ
/ERTzv40BbwWpUtlhowaAJf3PBwRhu/bycfS+Cw8QdxFIPKX7Ri1Yx6dRSr8obFU
UAUSDJ0u8XZQGGGSk6CI7EnxGEI/WyXb22Aj0OEN9Z9ehiKDpyJv4R45nzcJ6nA=
=nltX
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--
