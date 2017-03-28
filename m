Received: from eggs.gnu.org ([2001:4830:134:3::10]:34811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csw3t-0006ja-Pe
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csw3q-0005Z9-O8
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:41:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csw3q-0005Yz-Fb
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:41:42 -0400
References: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
	<20170328210014-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb207ad9-0659-19c6-19cc-15fb8abd43c2@redhat.com>
Date: Tue, 28 Mar 2017 13:41:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170328210014-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l3hg9XcmeiCsHBqA03vr0iHCo5Pow1kWb"
Subject: Re: [Qemu-devel] qemu-devel mailing list vs DMARC and
 microsoft.com's p=reject policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l3hg9XcmeiCsHBqA03vr0iHCo5Pow1kWb
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Message-ID: <fb207ad9-0659-19c6-19cc-15fb8abd43c2@redhat.com>
Subject: Re: [Qemu-devel] qemu-devel mailing list vs DMARC and microsoft.com's
 p=reject policy
References: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
 <20170328210014-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170328210014-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2017 01:28 PM, Michael S. Tsirkin wrote:
>>  (2) I could reconfigure mailman to try to not rewrite anything that
>>      we think is likely to be signed (in particular not the body or th=
e
>>      subject)
>>    * this means dropping the [qemu-devel] tag from the subject, which =
I'm
>>      a bit reluctant to do (it seems likely at least some readers are
>>      filtering on it, and personally I quite like it)
>>    * if anybody DKIM-signs the Sender: header we're stuck anyway
>=20
> For the record I'd strongly prefer this option - I tag all list mail
> and so "qemu-devel" appears twice: in subject and as a tag.
> Also, if mail is copied to another list, qemu-devel will
> still appear as gmail de-duplicates email by msg id.
> I can remove tags I don't care about but can't remove
> subject prefixes.

I'm ambivalent - I like the prefixes, but don't mind if they are not
present (it's easy enough to filter on List-Sender: when the prefix is
not reliable).  It's especially nice that the prefix lets me tell the
difference between mail sent to qemu-devel and qemu-block while still
dumping both lists into the same folder.

> Is there a way not to munge the name? It's currently rewritten to
> add "via qemu-devel" which confuses the clients which think
> it's part of the name, and can't be easily stripped away.

Not that I know of, but at least the munging only occurs for senders
with restrictive DMARC and not for ALL senders.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--l3hg9XcmeiCsHBqA03vr0iHCo5Pow1kWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2q5gAAoJEKeha0olJ0NqUwMH/2PYEAlpuqVxu1mbnA8KupUv
ks/KTJLDZjYUr0AptxlPaLaP9eIfiTJtGpfYDaUROx+EkspAYt/FznwZCwDsLbJP
12V8W9LEOr11px54IeHlW4LXTTXCYfriJmYEpHoX0CNqJFtklPRTvIJU/BhpTF2z
zcMHp68RKQVjxZowfyIuv+4+hQFx3NH75MGRm/stpB2RYtsB8xmsxDLj273SvHNt
Fmx8gYffTvu6EKWWnUEgZeDYBejZQoZpqwyqLbUSE505cOVDx65Y9nmCq85dhNDW
xKlqr25qcoGo9Cw28cv14gjyG1n5xBn1coce56GNuwKCwP+Q2v9KyKuoOkDdSGc=
=RMT3
-----END PGP SIGNATURE-----

--l3hg9XcmeiCsHBqA03vr0iHCo5Pow1kWb--
