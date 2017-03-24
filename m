Received: from eggs.gnu.org ([2001:4830:134:3::10]:43626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crTb4-00027H-4r
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crTaz-0001Ol-58
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:05:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crTay-0001OT-TE
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE21A624B3
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 18:05:52 +0000 (UTC)
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
	<1490377482-13337-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c3cb3590-0fe5-1c0f-0b55-6114d86a31a5@redhat.com>
Date: Fri, 24 Mar 2017 13:05:38 -0500
MIME-Version: 1.0
In-Reply-To: <1490377482-13337-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gnsTvC4B8W59mC2FDEr3tMPXho82w3cFq"
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/9] rbd: Reject -blockdev
 server.*.{numeric, to, ipv4, ipv6}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gnsTvC4B8W59mC2FDEr3tMPXho82w3cFq
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <c3cb3590-0fe5-1c0f-0b55-6114d86a31a5@redhat.com>
Subject: Re: [PATCH RFC v2 1/9] rbd: Reject -blockdev
 server.*.{numeric,to,ipv4,ipv6}
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
 <1490377482-13337-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 12:44 PM, Markus Armbruster wrote:
> We use InetSocketAddress in the QAPI schema.  However, the code
> doesn't use inet_connect_saddr(), but formats "host" and "port" into a
> configuration string for rados_conf_set().  Thus, members "numeric",
> "to", "ipv4" and "ipv6" are silently ignored.  Not nice.  Example:
>=20
>     -blockdev rbd,node-name=3Dnn,pool=3Dp,image=3Di,server.0.host=3Dh0,=
server.0.port=3D12345,server.0.ipv4=3Doff
>=20
> Factor a suitable InetSocketAddressBase out of InetSocketAddress, and
> use that.  "numeric", "to", "ipv4" and "ipv6" are now rejected.

Are now rejected when using -blockdev-add or QMP, but are still
(silently) ignored when using -drive [fixed later in series].

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi-schema.json     | 21 ++++++++++++++-------
>  qapi/block-core.json |  2 +-
>  2 files changed, 15 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gnsTvC4B8W59mC2FDEr3tMPXho82w3cFq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1V/yAAoJEKeha0olJ0NqJ80H/RWNk8PweYgLG97f4rFZ8BRp
q95lW1ZpsxvhQC03amwAKpeTXcZabmr5OgOhl7CpFDlJnVB+lOXsts2b+of+qv66
32DoxY2+wbET2eJyXvFyD48CdaqzW5zDrPcrqx7iv6NF8AiErsWVJU4MnJSFc2zY
F0IEgSY2/ulCJ3tsfggKI5+RGamSAkQ7Vtmuymbyo/iJibhfapguFgQlNU/RH8J+
Z7457AI2ZYrrwrh5wok9fwZAS1xi+xARl1GfeqYDwvichmwan+uW4gN6PKbtgwJu
bO6/cw8XfIjfEBHkiyOdAvKq8s0t7Pv5frznWatgpw6FIZgSl/3o1Gca5htUF20=
=1cq8
-----END PGP SIGNATURE-----

--gnsTvC4B8W59mC2FDEr3tMPXho82w3cFq--
