Received: from eggs.gnu.org ([2001:4830:134:3::10]:58875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWTsB-0002t3-8P
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:13:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWTs7-0004F2-6G
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:13:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eWTs6-0004Df-TV
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:13:19 -0500
References: <20180102170936.6150-1-danielhb@linux.vnet.ibm.com>
	<20180102170936.6150-2-danielhb@linux.vnet.ibm.com>
	<d83ea302-8e38-26bf-7e1f-18b6373e158b@redhat.com>
	<2e316196-0b13-1394-018f-c5324b0ade71@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab1e4789-6815-ac63-d34f-1acf7d5bee1b@redhat.com>
Date: Tue, 2 Jan 2018 15:13:15 -0600
MIME-Version: 1.0
In-Reply-To: <2e316196-0b13-1394-018f-c5324b0ade71@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OG5PWdpAjnm5YHwc2wweq8Xe8dVwBKakk"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qmp: adding
 'wakeup-suspend-support' in query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OG5PWdpAjnm5YHwc2wweq8Xe8dVwBKakk
From: Eric Blake <eblake@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com
Message-ID: <ab1e4789-6815-ac63-d34f-1acf7d5bee1b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qmp: adding 'wakeup-suspend-support'
 in query-target
References: <20180102170936.6150-1-danielhb@linux.vnet.ibm.com>
 <20180102170936.6150-2-danielhb@linux.vnet.ibm.com>
 <d83ea302-8e38-26bf-7e1f-18b6373e158b@redhat.com>
 <2e316196-0b13-1394-018f-c5324b0ade71@linux.vnet.ibm.com>
In-Reply-To: <2e316196-0b13-1394-018f-c5324b0ade71@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2018 02:28 PM, Daniel Henrique Barboza wrote:

>>> With this extra tool, management can avoid situations where a guest
>>> that does not have proper suspend/wake capabilities ends up in
>>> inconsistent state (e.g.
>>> https://github.com/open-power-host-os/qemu/issues/31).
>>>
>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>>> ---
>> Only an interface review:
>>

>>> @@ -2388,11 +2388,12 @@
>>> =C2=A0 # Information describing the QEMU target.
>>> =C2=A0 #
>>> =C2=A0 # @arch: the target architecture (eg "x86_64", "i386", etc)
>>> +# @wakeup-suspend-support: true if the target supports wake up from
>>> suspend
>> Missing a '(since 2.12)' notation.
>=20
> TargetInfo is marked as "Since 1.2.0".=C2=A0 Should I add the 2.12.0 no=
tation
> to the
> new parameter or change the 1.2.0 notation of TargetInfo?

Just on the new field, as in:

##
# @TargetInfo:
#
# Information describing the QEMU target.
#
# @arch: the target architecture (eg "x86_64", "i386", etc)
# @wakeup-suspend-support: true if the target supports wake up from
#                          suspend (since 2.12)
#
# Since: 1.2.0
##

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OG5PWdpAjnm5YHwc2wweq8Xe8dVwBKakk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpL9esACgkQp6FrSiUn
Q2q8hwgAosXqmCeS3N86txI6qKtMI2pfg8CiOXx9JegFCCwSIVzXacn9K7o6NqNn
1Gx4D34FcUx/ndyLEX0QQVITKbpVMM9PtKyW+ZZpc/WYcXxQHnThYgIK8i6s/Yth
egYLaqm3u+mzF601BNbmhwTg+Az1rPSMM5+tlGPsUSOqB3tl7kZzBwPOB+mJkhU8
/dVb+fGvTMe7N5hAvY8AbfvW3CAYYR90EPj+kQ5EsKPIPgHkFJcXAmaaYMrxeYFK
onLXM/EhgZHzMTLftJ3SB+HicSyuh8ARJaG2KgS7bcP1Hl5wivdD3DNqZWyxYNJq
7mRhqkvhcMvQQjSMpHZg+7wvze5mBA==
=gbj+
-----END PGP SIGNATURE-----

--OG5PWdpAjnm5YHwc2wweq8Xe8dVwBKakk--
