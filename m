Received: from eggs.gnu.org ([2001:4830:134:3::10]:34362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cWm-0005db-44
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cWh-0000Np-Tu
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:11:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1cWh-0000NL-KR
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:11:39 -0400
References: <20171009170607.4155-1-mdroth@linux.vnet.ibm.com>
	<20171009170607.4155-2-mdroth@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a31e42ae-f9d2-0bfc-04f9-6e6c2e35c9f8@redhat.com>
Date: Mon, 9 Oct 2017 13:11:28 -0500
MIME-Version: 1.0
In-Reply-To: <20171009170607.4155-2-mdroth@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mp8tu1cmCPGNTDEk1P6q8kVdUXGCxkfnO"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qdev: store DeviceState's canonical
 path to use when unparenting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mp8tu1cmCPGNTDEk1P6q8kVdUXGCxkfnO
From: Eric Blake <eblake@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>, groug@kaod.org, armbru@redhat.com,
 alex.williamson@redhat.com, imammedo@redhat.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Message-ID: <a31e42ae-f9d2-0bfc-04f9-6e6c2e35c9f8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qdev: store DeviceState's canonical
 path to use when unparenting
References: <20171009170607.4155-1-mdroth@linux.vnet.ibm.com>
 <20171009170607.4155-2-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20171009170607.4155-2-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2017 12:06 PM, Michael Roth wrote:
> device_unparent(dev, ...) is called when a device is unparented,
> either directly, or as a result of a parent device being
> finalized, and handles some final cleanup for the device. Part
> of this includes emiting a DEVICE_DELETED QMP event to notify
> management, which includes the device's path in the composition
> tree as provided by object_get_canonical_path().
>=20

> +++ b/hw/core/qdev.c
> @@ -928,6 +928,13 @@ static void device_set_realized(Object *obj, bool =
value, Error **errp)
>              goto post_realize_fail;
>          }
> =20
> +        /*
> +         * always free/re-initialize here since the value cannot be cl=
eaned up
> +         * in device_unrealize due to it's usage later on in the unplu=
g path

s/it's/its/ (remember, "it's" is only appropriate if "it is" or "it has"
can be substituted in its place; otherwise you meant the possessive "its"=
)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mp8tu1cmCPGNTDEk1P6q8kVdUXGCxkfnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnbu9AACgkQp6FrSiUn
Q2oOXwf9GT5tFA/5h/FbWm2hmgzdPC8BVGgWUM+6KIOtZvB9FC4ADB0Q69nouA92
tFDDh5zqudTVgmveQW9tm0HzX5ryFQ0eVVpzy6IEhWtHy8VIsg2JYHomgYN9X7zj
7mcYf0CIYKCVooCupdnq54rZwgTNd0/mdzmIlAVqc+v6rweEkbuy9xBt4LbBH7uB
Np+cluG256eQA7hRWWCK3+Sfn9gIi95aK063Pwj7REtNSQloWNrUkk9D1R6jr+vO
/axxYat5N6ebIJAi2uM1BrvAH55Lb/1gp10SB2x46FJ+4GJk9N1bzcay4IGrgAmL
qGqvOb1WExa4DSb/fk2vnkC5qcIOEw==
=IvAz
-----END PGP SIGNATURE-----

--mp8tu1cmCPGNTDEk1P6q8kVdUXGCxkfnO--
