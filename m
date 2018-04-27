Received: from eggs.gnu.org ([2001:4830:134:3::10]:38687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC7tn-0002cC-5n
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fC7ti-0000cj-Ey
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:15:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fC7ti-0000cN-8v
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 14:15:06 -0400
References: <20180427173416.19233-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd81d081-e7ca-95af-7922-ae5f149e6edf@redhat.com>
Date: Fri, 27 Apr 2018 13:14:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180427173416.19233-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OAgoze6oo59jTLtiEWVgxeo9CMbnjOxSn"
Subject: Re: [Qemu-devel] [PATCH v2] migration: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, bala24@linux.vnet.ibm.com, peterx@redhat.com, quintela@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OAgoze6oo59jTLtiEWVgxeo9CMbnjOxSn
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, bala24@linux.vnet.ibm.com, peterx@redhat.com,
 quintela@redhat.com
Message-ID: <bd81d081-e7ca-95af-7922-ae5f149e6edf@redhat.com>
Subject: Re: [PATCH v2] migration: update docs
References: <20180427173416.19233-1-dgilbert@redhat.com>
In-Reply-To: <20180427173416.19233-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2018 12:34 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Update the migration docs:
>=20
> Among other changes:
>   * Added a general list of advice for device authors
>   * Reordered the section on conditional state (subsections etc)
>     into the order we prefer.
>   * Add a note about firmware
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  docs/devel/migration.rst | 531 +++++++++++++++++++++++++++------------=

>  1 file changed, 375 insertions(+), 156 deletions(-)

> +
> +General advice for device developers
> +------------------------------------
> +
> +- The migration state saved should reflect the device being modelled r=
ather
> +  than the way your implementation works.   That way if you change the=
 implementation

Three spaces between sentences is unusual.


> +
> +- The migration might happen at an inconvenient point,
> +  e.g. right in the middle of the guest reprogramming the device, duri=
ng
> +  guest reboot or shutdown or while the device is waiting for external=
 IO.
> +  It's strongly preferred that migrations do not fail in this situatio=
n,
> +  since in the cloud environment migrations might happen automatically=
 to
> +  VMs that the administrator doesn't directly control.

Not for this patch, but is there any mechanism for a device to request
that migration be delayed just long enough for the device to have a
chance to get out of that inconsistent state, rather than having to
migrate the inconvenient state?

> +When we migrate a device, we save/load the state as a series
> +of fields.  Some times, due to bugs or new functionality, we need to

Sometimes


> @@ -328,9 +329,12 @@ Sometimes members of the VMState are no longer nee=
ded:
> =20
>    - removing them will break migration compatibility
> =20
> -  - making them version dependent and bumping the version will break b=
ackwards migration compatibility.
> +  - making them version dependent and bumping the version will break b=
ackward migration compatibility.

Is it worth worrying about long lines?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OAgoze6oo59jTLtiEWVgxeo9CMbnjOxSn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrjaJ0ACgkQp6FrSiUn
Q2qHMQf/VJob3MzT1Gm7HgKrkLOv2TMSssu0sHgweIgmCZt0Z364eM6eYqI2T8Nj
PvRlYJJ9c0P8XWVtrCU9K1n2dIrHKQwuFjNoaE102BM91j83c8bJYy7FREFJdcXN
uhg3glMsjCPYsU/SLUZXNnHdD6z8yBxtpSBeAYE0LG5DBYr9skmT0Rit9c8oltu1
OzveMDga+l8r93flvVwD1QKOqiYWb3vDlksxbyCDIbe3r55yPPw8UjN8toWxyB+x
a9uky2IyMyKNZVxkntWLhoHOYssxnShDudPiVbvJ/wIvBgzRsmBhyN4kYi5uPrFX
QxgpoWN9luH9d2i+cEjfvIK2XTlPHQ==
=dyWg
-----END PGP SIGNATURE-----

--OAgoze6oo59jTLtiEWVgxeo9CMbnjOxSn--
