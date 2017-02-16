Received: from eggs.gnu.org ([2001:4830:134:3::10]:47445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceOal-0004Qw-Fn
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceOah-0003zA-FB
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:07:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ceOah-0003yx-6i
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:07:31 -0500
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
	<1487255507-106654-22-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5712fbf2-1a9e-42c9-a22f-554a6e8bc14d@redhat.com>
Date: Thu, 16 Feb 2017 10:07:28 -0600
MIME-Version: 1.0
In-Reply-To: <1487255507-106654-22-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6X0P6Weo6rgmTddLL6nTf52V7vlx45ipj"
Subject: Re: [Qemu-devel] [PULL 21/23] report guest crash information in
 GUEST_PANICKED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6X0P6Weo6rgmTddLL6nTf52V7vlx45ipj
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <5712fbf2-1a9e-42c9-a22f-554a6e8bc14d@redhat.com>
Subject: Re: [Qemu-devel] [PULL 21/23] report guest crash information in
 GUEST_PANICKED event
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
 <1487255507-106654-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-22-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/16/2017 08:31 AM, Paolo Bonzini wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> it's not very convenient to use the crash-information property interfac=
e,
> so provide a CPU class callback to get the guest crash information, and=
 pass
> that information in the event
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Message-Id: <1487053524-18674-3-git-send-email-den@openvz.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

> +++ b/qapi/event.json
> @@ -488,7 +488,9 @@
>  #
>  # @action: action that has been taken, currently always "pause"
>  #
> -# Since: 1.5
> +# @info: optional information about a panic
> +#
> +# Since: 1.5 (@info since 2.9)

I had a (late) comment on this being unusual formatting, but it can be
fixed in a followup patch if there is no other reason to respin the pull
request.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6X0P6Weo6rgmTddLL6nTf52V7vlx45ipj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpc5AAAoJEKeha0olJ0NqHkoIAIq+yFnR6LV4ltObg3r+Q5el
7l22fILtJp75zpvaTSoqyj8zTaDU8BwpPwV6+eht7Jf9OmmcJE+kw3ZivtzjSzYm
BWLNVdajoYfKYSwKmhlDgsh1lNvH6nUALpvESgLSt853hwKW2syz6/VqngnMQjWF
hqs8jPD4AfKvii8Cp01ZPdV0oQz6tm1j8+amdgquPGLl/jifCuwcg1uJ//VuRmwR
IdIG1atKmt54JeBMIpZxAOYtDogdZNl3kuk+c73gbt1BQBkIP059Gwv3oT9UjaZG
20t05VWCax/03rXRk7/+rxbxH8HoLhY15skXA0WAgIClo8so/VENIMpJFT5Swlg=
=TC2g
-----END PGP SIGNATURE-----

--6X0P6Weo6rgmTddLL6nTf52V7vlx45ipj--
