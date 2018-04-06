Received: from eggs.gnu.org ([2001:4830:134:3::10]:54248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4SxW-0005dP-Nx
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4SxR-0003Ye-J4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:07:20 -0400
References: <20180326184147.1565719-1-eblake@redhat.com>
	<cceeaa0f-946d-5c26-2fad-55cebbb73027@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2fc46ce7-e0d3-8aab-feb1-025d4829046f@redhat.com>
Date: Fri, 6 Apr 2018 10:07:15 -0500
MIME-Version: 1.0
In-Reply-To: <cceeaa0f-946d-5c26-2fad-55cebbb73027@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7HojYKKlJlONUHnqNKaRmcM1PEdW3zAmZ"
Subject: Re: [Qemu-devel] [PATCH for-2.12] maint: Add .mailmap entries for
 patches claiming list authorship
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7HojYKKlJlONUHnqNKaRmcM1PEdW3zAmZ
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2fc46ce7-e0d3-8aab-feb1-025d4829046f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] maint: Add .mailmap entries for
 patches claiming list authorship
References: <20180326184147.1565719-1-eblake@redhat.com>
 <cceeaa0f-946d-5c26-2fad-55cebbb73027@redhat.com>
In-Reply-To: <cceeaa0f-946d-5c26-2fad-55cebbb73027@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2018 01:45 PM, Eric Blake wrote:
> On 03/26/2018 01:41 PM, Eric Blake wrote:
>> The list did not author any patches, but it does rewrite the
>> 'From:' header of messages sent from any domain with restrictive
>> SPF policies that would otherwise prevent the message from reaching
>> all list recipients.  If a maintainer is not careful to undo the
>> list header rewrite, and the author did not include a manual
>> 'From:' line in the body to fix the munged header, then 'git am'
>> happily attributes the patch to the list.  Add some mailmap
>> entries to correct the few that have escaped our attention; while
>> we also work on improving the tooling to catch the problem in
>> the future before a merge is even made.
>>
>> Also improve the comments occurring in the file, including line
>> length improvements.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> Probably worth inclusion in 2.12-rc1, since it makes statistics
>> about the release easier to follow.
>=20
> I'll include this in my qapi+misc pull for 2.12-rc2

That pull request was abandoned; Paolo, do you want to pick this up in
your misc tree?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7HojYKKlJlONUHnqNKaRmcM1PEdW3zAmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrHjSQACgkQp6FrSiUn
Q2ovWAgAplfOZMPl+VnJQGBuwqnDd2DmHEzRkJBNNwuj0Lw4S0gcuiZTSkxhlCzR
PROBSauu6DyftxLQRtL+Ayccl2XRJGu11nkSibYOaLbG00Hsb0LfUuMNoRDVJh1i
xIYkyO7mrzm4Dk2FL9g+DfcuT6EDiP3N4GZ1qeBSmTjfndRK9kGUR+oRaAozKSLy
LX4MjLiIAXhxFjNT/u7yS/1KM/+LJqcPwu5qO/mLWWl7EP/t8hzngnxAX8yTZgrE
FmURrASpZNs+tpkJGqiNxp8ZEt589uGGz9VOHlICzneL/0GyfnpU4WqnMOEZ+QO2
NTCmiML3ttJz2w+fAJJlw+O3GibPGg==
=oCaK
-----END PGP SIGNATURE-----

--7HojYKKlJlONUHnqNKaRmcM1PEdW3zAmZ--
