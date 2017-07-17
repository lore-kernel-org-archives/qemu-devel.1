Received: from eggs.gnu.org ([2001:4830:134:3::10]:54755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXECL-0005Uh-AS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXECK-0005Ba-EF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 18:09:01 -0400
References: <20170717192635.17880-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d81b08ad-8115-dd97-9577-e8a9cf35b322@redhat.com>
Date: Mon, 17 Jul 2017 17:08:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170717192635.17880-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="86CcHVinoRE5NBEGVw8xQGD9s61s2L4k9"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] NBD fixes before softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--86CcHVinoRE5NBEGVw8xQGD9s61s2L4k9
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-block@nongnu.org
Message-ID: <d81b08ad-8115-dd97-9577-e8a9cf35b322@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] NBD fixes before softfreeze
References: <20170717192635.17880-1-eblake@redhat.com>
In-Reply-To: <20170717192635.17880-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 02:26 PM, Eric Blake wrote:
> Paolo's inclusion of my NBD series in his miscellaneous tree
> ended up with a couple of bugs that were pointed out in the
> thread after the pull request was first created; these are the
> fixes.  They are small enough that I don't mind using maintainer
> status to bundle them up as a PULL request for NBD sometime on
> Monday (in order to make soft freeze), whether or not they've
> been reviewed by then; but of course, review is appreciated.
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01983.html
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01981.html
>=20
> since v1:
> - more defines and comments to make patch 2 more legible [John]
>=20
> 001/2:[----] [--] 'nbd: Trace client command being sent'
> 002/2:[0026] [FC] 'nbd: Fix server reply to NBD_OPT_EXPORT_NAME of olde=
r clients'
>=20
> Eric Blake (2):
>   nbd: Trace client command being sent
>   nbd: Fix server reply to NBD_OPT_EXPORT_NAME of older clients

Thanks; queued on my NBD branch:
git://repo.or.cz/qemu/ericb.git nbd

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--86CcHVinoRE5NBEGVw8xQGD9s61s2L4k9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlltNXAACgkQp6FrSiUn
Q2rJLAf+P6OiafUp861RxpfsR0UG41suYwVqIoPjlyQWsZyjMAxaCrUMbPwXCsnx
GJMyK0kDV6FhSL4NKb7GNNKzPucMJzf1AIRowr/dP+DlScKHhopXaeyoFuAp/S+q
7YzVv6XLKnsPccETiJ6YTIeBToGI5BFMqkH9vJDn4JekcjGwo8hg1BTpeY6gSiOw
6778F+ryMP89EMIhuLqVa5LmO7WArCk4a++nFQi0kQji5IM+ORMvFXbPmlHUycag
9tQMw4kR0OAUWZjVVPKvKIpXXzDm5LAhRsvzbatlGUyzxwtjTXx0kY8YE0EP28zb
0O8iOG6fpVhpzEGVcqhulJylb6MNqg==
=HaBE
-----END PGP SIGNATURE-----

--86CcHVinoRE5NBEGVw8xQGD9s61s2L4k9--
