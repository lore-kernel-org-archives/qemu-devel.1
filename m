Received: from eggs.gnu.org ([2001:4830:134:3::10]:57214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2mT-0000r2-Ki
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2mQ-0006PG-DM
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:54:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZ2mQ-0006OL-3p
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:54:02 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-5-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb8239ca-8960-8bd5-5160-a65b20904d3c@redhat.com>
Date: Tue, 9 Jan 2018 16:53:40 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-5-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fAz9fI5uTAvNMOfCbcOK5YXEudFy7XDqa"
Subject: Re: [Qemu-devel] [RFC v6 04/27] qobject: let
 object_property_get_str() use new API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fAz9fI5uTAvNMOfCbcOK5YXEudFy7XDqa
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <bb8239ca-8960-8bd5-5160-a65b20904d3c@redhat.com>
Subject: Re: [RFC v6 04/27] qobject: let object_property_get_str() use new API
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-5-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-5-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:
> We can simplify object_property_get_str() using the new
> qobject_get_try_str().
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qom/object.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I'm not opposed to your patch split (particularly since it makes
backports easier if it just needs the new function and then your later
uses of the new function, without touching existing uses); but I might
have merged this with the previous patch so that the new API has a
client right away, proving why the new API is worthwhile as part of its
introduction.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fAz9fI5uTAvNMOfCbcOK5YXEudFy7XDqa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVR/QACgkQp6FrSiUn
Q2pkFwgAnZ7pVbt9C7SFEfirNLUkrHswxTikVkxsgh/f1KMwrv59E04wKoHAJrie
B9Yow+fZ00J5EQTYqw59PcnhmRXRfExrj7Zx+MyPx3vPOHzlMH53BxaLe7f34/62
cJw9Zi75kK42Y3JZtnT59N7KBJNmwyzACrEWYck+ZhDhHf9Nb53MHdl4iu7KS3yV
pYEVETjoRAzyYCSGHLTI/fKLFuGXWEoQNyfC+V94rqXuRw9DQVM20ZNPEmmIgKun
Mn52Gf/lu3zFSFELSVIye8XSQ8uoTU+herSC6oxfvDFa3lZsIfU532sirhqhBYQV
EFsWU0rXWl1m/YLF5TNSh3s07QKZkg==
=+Gwl
-----END PGP SIGNATURE-----

--fAz9fI5uTAvNMOfCbcOK5YXEudFy7XDqa--
