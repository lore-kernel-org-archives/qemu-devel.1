Received: from eggs.gnu.org ([2001:4830:134:3::10]:59784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsFvN-0001oB-Ed
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsFvM-0007EB-CX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:14:25 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<83c3006b-d62e-441b-57f1-dea64b141c11@redhat.com>
	<20170913075914.GA3929@lemon>
	<3c085442-744b-e08c-279c-fc0c74559551@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d6dca783-ad4e-eaab-99b5-5a3e76e16756@redhat.com>
Date: Wed, 13 Sep 2017 17:14:12 -0500
MIME-Version: 1.0
In-Reply-To: <3c085442-744b-e08c-279c-fc0c74559551@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mETuNXGCrVeqUerWoUHX9h80qkgJKx3iT"
Subject: Re: [Qemu-devel] [PATCH v2 00/10] cleanup qemu-iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mETuNXGCrVeqUerWoUHX9h80qkgJKx3iT
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <d6dca783-ad4e-eaab-99b5-5a3e76e16756@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/10] cleanup qemu-iotests
References: <20170912144459.11359-1-pbonzini@redhat.com>
 <83c3006b-d62e-441b-57f1-dea64b141c11@redhat.com>
 <20170913075914.GA3929@lemon>
 <3c085442-744b-e08c-279c-fc0c74559551@redhat.com>
In-Reply-To: <3c085442-744b-e08c-279c-fc0c74559551@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 05:06 PM, Paolo Bonzini wrote:
> On 13/09/2017 09:59, Fam Zheng wrote:
>> On Wed, 09/13 08:47, Thomas Huth wrote:
>>> Meta comment: Could we maybe also rename "tests/qemu-iotests" to
>>> "tests/iotests" ? The "qemu" prefix sounds always very superfluous to=
 me
>>> here...
>>
>> Sounds good, and saves typing for when this path is manually entered. =
But maybe
>> keep tests/qemu-iotests as a symlink to keep old scripts happy?
>=20
> The simplest way to keep old scripts happy would be too keep the prefix=

> :) even though it does sound unnecessary.

Can't someone manually add the symlink to keep their own scripts working
both before and after the change, even if we don't commit the symlink
into git?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mETuNXGCrVeqUerWoUHX9h80qkgJKx3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm5rbQACgkQp6FrSiUn
Q2q0Jgf9HrIWbjkjQSWDo0Rg1U3tza9V2eoR7ohSZOS7cAT2t3XucCHf0DQFrF/S
cPC/Ic/HVDlpqbptBoXJl42E85nALRlPbONdB3DUvliMQMoCYhRGgTiyaygP2Uju
hJUjd1RVS4fi5YD7kmZao0V9j8bu7CN7fC5gS6lcOsKo54ifoIPWIrHIoTp+WYWy
f/sPSyNId1I6AZm9Y61YTeMmaK6f/dsA9MkoTayW99ryJ/4sqyLzHrR4JSloEsPw
ImN25Z26EUi+nWDYiGFknbGBCDgCZSNKLox1J6F+3pqDWi0xSjXov8722JoRe2Dg
yuXkupUFoqML6/7ToX7ogxpLK+ZNjw==
=UXzb
-----END PGP SIGNATURE-----

--mETuNXGCrVeqUerWoUHX9h80qkgJKx3iT--
