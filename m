Received: from eggs.gnu.org ([2001:4830:134:3::10]:43358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csZaK-00079g-SE
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csZaH-00033F-N1
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:41:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csZaH-00031m-Di
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:41:41 -0400
References: <20170327182137.7006-1-laurent@vivier.eu>
	<20170327182137.7006-2-laurent@vivier.eu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <237b2650-da58-c844-d594-390f41e23e65@redhat.com>
Date: Mon, 27 Mar 2017 13:41:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170327182137.7006-2-laurent@vivier.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0WUKN1SfB0Xe1WnnaJE9mFKG1apNLw5ae"
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0WUKN1SfB0Xe1WnnaJE9mFKG1apNLw5ae
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <237b2650-da58-c844-d594-390f41e23e65@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] slirp: add SOCKS5 support
References: <20170327182137.7006-1-laurent@vivier.eu>
 <20170327182137.7006-2-laurent@vivier.eu>
In-Reply-To: <20170327182137.7006-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 01:21 PM, Laurent Vivier wrote:
> When the VM is used behind a firewall, This allows
> to use a SOCKS5 proxy server to connect the VM IP stack

"allows to $verb" is not idiomatic English; the correct forms are
generally "allows $subject to $verb" or "allows ${verb}ing".  In this
case, I'd lean towards "this allows the use of a SOCKS5 proxy server"

> directly to the Internet.
>=20
> This implementation doesn't manage UDP packets, so they
> are simply dropped (as with restrict=3Don), except for
> the localhost as we need it for DNS.
>=20
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

> +++ b/qapi-schema.json
> @@ -3680,6 +3680,9 @@
>      '*ipv6-dns':         'str',
>      '*smb':       'str',
>      '*smbserver': 'str',
> +    '*proxy-server': 'str',
> +    '*proxy-user':   'str',
> +    '*proxy-passwd': 'str',

Why can't we spell this out as password, instead of abbreviating?
Should this hook into the "secrets object" framework so that someone
does not have to pass the password in plaintext?

>      '*hostfwd':   ['String'],
>      '*guestfwd':  ['String'] } }

Missing documentation.

Do we want all three proxy elements to be in a substruct? The difference
is between:

{ ... "smb": "foo", "proxy-server": "bar", "proxy-user": "noone",
"proxy-passwd": "hello" }

and a substruct:

{ ... "smb": "foo", "proxy": { "server": "bar", "user", "noone",
"passwd": "hello" } }


> =20
> +@item proxy-server=3D@var{addr}:@var{port}[,proxy-user=3D@var{user},pr=
oxy-passwd=3D@var{passwd}]]

Yes, you DEFINITELY need to hook into the "secrets object" framework to
avoid having to pass a password in plaintext on the command line.  Dan
Berrange may have more advice on doing that.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0WUKN1SfB0Xe1WnnaJE9mFKG1apNLw5ae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2VzgAAoJEKeha0olJ0NqHrUH/398n2bOxDZ0lDDyxjB4Ghmd
r0kL9wLdfAXkYF2cy9ZO568g6Fti/ui+N8H9FTRSiwczGA5EDM+rEtjZLGaqLcKk
RL/xEODdXvsF3LZd0T10mCma3CTsbjmd58JtCgxIhpsrRYvMxza/hFe6L8zwMENs
RzCmpvj5YOwszVbPwYmO84AoiT+a8t8e4QgGkYu4kHbz53WryGom+LWjkyme4/vQ
4FRJQYdYCXOmypQmHVLnJy0mFVHvOi4CIbTLuTDpfqyuWghY58r0Wupwnase243e
cMLlA8HKRCaRY6cIFksaV8Q0kpBviqGTBEP4HdTiSBLO3SLLi8MnMFuhzYSrgf0=
=z2m6
-----END PGP SIGNATURE-----

--0WUKN1SfB0Xe1WnnaJE9mFKG1apNLw5ae--
