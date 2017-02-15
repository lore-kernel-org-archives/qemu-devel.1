Received: from eggs.gnu.org ([2001:4830:134:3::10]:39393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce5Sn-0001Ut-V9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ce5Sj-0006ND-Qb
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:42:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ce5Sj-0006M4-I1
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:42:01 -0500
References: <1487053524-18674-1-git-send-email-den@openvz.org>
	<1487053524-18674-2-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f805c30f-47d1-6f79-c01b-ac1155d6859a@redhat.com>
Date: Wed, 15 Feb 2017 13:41:57 -0600
MIME-Version: 1.0
In-Reply-To: <1487053524-18674-2-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gmTIRhRT0TTEcLbKW32SRlT5Gq8WJqVMd"
Subject: Re: [Qemu-devel] [PATCH v4 1/3] i386/cpu: add crash-information QOM
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gmTIRhRT0TTEcLbKW32SRlT5Gq8WJqVMd
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <f805c30f-47d1-6f79-c01b-ac1155d6859a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/3] i386/cpu: add crash-information QOM
 property
References: <1487053524-18674-1-git-send-email-den@openvz.org>
 <1487053524-18674-2-git-send-email-den@openvz.org>
In-Reply-To: <1487053524-18674-2-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 12:25 AM, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> Windows reports BSOD parameters through Hyper-V crash MSRs. This
> information is very useful for initial crash analysis and thus
> it would be nice to have a way to fetch it.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---

> +++ b/qapi-schema.json
> @@ -5846,6 +5846,30 @@
>    'data': [ 'pause', 'poweroff' ] }
> =20
>  ##
> +# @GuestPanicInformation:
> +#
> +# Information about a guest panic
> +#
> +# Since: 2.9
> +##
> +{'union': 'GuestPanicInformation',
> + 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
> +

Markus has been trying to eliminate the addition of new "simple unions"
- while they are syntactically shorter in the .json file, they are
bulkier over the wire with extra {} nesting, and more verbose in the C
code, when compared to using a flat union instead.  I won't necessarily
hold up this patch as-is, but if we are going to avoid new simple
unions, we have to change this before 2.9 bakes in the {} nesting (we
can convert a simple union to a flat union without breaking QMP
back-compat, but it's messier than if we avoid the nesting to begin with)=
=2E

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gmTIRhRT0TTEcLbKW32SRlT5Gq8WJqVMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpK8FAAoJEKeha0olJ0NqWX0H/3zTGmXJpmnMhcMW0NctjRFu
BRxEdTCbavzDwzWjuVTPBm0W5CjsP6STREge7GxIhBrrjVakm710ZsuiTuQjBvyA
fjf9K8SK5n2YAnYzOCyZGQUCgz6eOOQo8aFGK4nzmlfRtQlqctM3yMXw2yczM0cX
C45csCxMULbIEgzMpHpef3dDAfHu5U9Nt02Hk32+lLBsRb3xgUGDMDZuNGR3+mE5
JOKt/AoC2P7GkiLfyDtPXe3mKJqAgG3KV224EEAkExcBJMmWpxdPOvFKCoH8QQ7F
PAwKVIIoBysS32VM/oM0E1Wec39hd7/cy6yGQKTnUD0+DAUbGDJ4fIFJdnFvyX8=
=uFL7
-----END PGP SIGNATURE-----

--gmTIRhRT0TTEcLbKW32SRlT5Gq8WJqVMd--
