Received: from eggs.gnu.org ([2001:4830:134:3::10]:59172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepJ3-00035r-2E
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cepJ0-0004ag-Do
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:39:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cepJ0-0004Zw-7V
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:39:02 -0500
References: <1487362554-5688-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5407a810-b21d-8551-c8b8-01a6582e3c0e@redhat.com>
Date: Fri, 17 Feb 2017 14:39:00 -0600
MIME-Version: 1.0
In-Reply-To: <1487362554-5688-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LrpqxtoiLxesCqpt0sbJEXC1QotN02evu"
Subject: Re: [Qemu-devel] [PATCH] tests: Use error_free_or_abort() where
 appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrpqxtoiLxesCqpt0sbJEXC1QotN02evu
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com
Message-ID: <5407a810-b21d-8551-c8b8-01a6582e3c0e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Use error_free_or_abort() where
 appropriate
References: <1487362554-5688-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1487362554-5688-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:15 PM, Markus Armbruster wrote:
> Done with this Coccinelle semantic patch:
>=20
>     @@
>     expression E;
>     @@
>     -    g_assert(E);
>     -    error_free(E);
>     +    error_free_or_abort(&E);
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qemu-opts.c              | 3 +--
>  tests/test-qobject-output-visitor.c | 6 ++----
>  2 files changed, 3 insertions(+), 6 deletions(-)

Nice that it doesn't find many uses (it means we've already swept the
tests for this pattern manually).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LrpqxtoiLxesCqpt0sbJEXC1QotN02evu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp19kAAoJEKeha0olJ0NqhO8H/iboyy6VAZv5k0oGZnATDSNS
prpNA7LCm+OyHgZBzMPntwVH8L/7H4YF37oe1L/zzlUsY9KkOwFhMD4mV7uJggkg
mhkecL2WyttwPPkwnp0q4NjEsgP2r48RzYbd08UiSVHwU6zNLLmKtphSZYNFd77l
/YuiySm9vSCAZiSx2+9d92jGLMFsc5ucxbRXEZ84SQ8r9tysBerayeuvaoBi2zHG
8ZvbIpB39FMLzDuEz7GuZRfnxgcZ2m5LZ3rCCvsYLqC5jn6Zy4qYMrXDbIaikdmr
aBdpEz28/YObqh9V46e4y97z0xrXGCMOB2j3Voo81Jf+MVwdIcAdXOtjtWmGB/w=
=ruSa
-----END PGP SIGNATURE-----

--LrpqxtoiLxesCqpt0sbJEXC1QotN02evu--
