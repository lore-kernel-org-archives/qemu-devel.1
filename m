Received: from eggs.gnu.org ([2001:4830:134:3::10]:59117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3iCB-0004yj-Ha
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3iC7-0006Ge-0S
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:11:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3iC6-0006GS-QD
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:11:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94023EB71B
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 13:11:15 +0000 (UTC)
References: <20180404065346.3252-1-peterx@redhat.com>
	<20180404070054.GD12052@lemon.usersys.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <428bd264-d0f6-a379-e653-9b869c89c005@redhat.com>
Date: Wed, 4 Apr 2018 08:11:05 -0500
MIME-Version: 1.0
In-Reply-To: <20180404070054.GD12052@lemon.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dvc3lJQ1BDQJTJkudNzU8tuSGk6w5fmQh"
Subject: Re: [Qemu-devel] [PATCH for-2.12] iothread: workaround glib bug
 which hangs qmp-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dvc3lJQ1BDQJTJkudNzU8tuSGk6w5fmQh
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <428bd264-d0f6-a379-e653-9b869c89c005@redhat.com>
Subject: Re: [PATCH for-2.12] iothread: workaround glib bug which hangs
 qmp-test
References: <20180404065346.3252-1-peterx@redhat.com>
 <20180404070054.GD12052@lemon.usersys.redhat.com>
In-Reply-To: <20180404070054.GD12052@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/04/2018 02:00 AM, Fam Zheng wrote:
> On Wed, 04/04 14:53, Peter Xu wrote:
>> Free the AIO context earlier than the GMainContext (if we have) to
>> workaround a possible Glib bug.  No functional change at all.
>>

>>
>> With glib version 2.28.8-9 (current default version on centos6) we mig=
ht
>> encounter above with the old code. It is verified that glib version
>> 2.50.3-3 won't trigger that bug again, but since we are still supporti=
ng
>> glib 2.28.8-9, we may want this workaround.
>>

>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>

Thanks; will queue through my qapi tree for 2.12 (might be -rc3, since I
already sent a pull request for -rc2)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dvc3lJQ1BDQJTJkudNzU8tuSGk6w5fmQh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrEzukACgkQp6FrSiUn
Q2of1gf+MKyZ/3ZKzy2GitZHam9eHTRJjkckJ9dBcfojcKDOPgST064GmI/pWNKF
2rGzQGyoOwBoxfuBWPIs236ACmAhfBBncuM2z6ThB4tBUNaJoOF5FjvVByOQIUFO
qJobguJZRTB0BDrhO53pw3SQ9/AmdSALOh/K07YxE3DLTKC49Dv01OxBQUKG8Zhf
SeMWk4N4fKBZBYsrcojzZW9nJPXITZ+e44LdSsymrkWDt6Qse+vHUFcXWXCcz41I
Ymowwx/PxK3MTifSeBAB555vqbbIf/bn6WoqxOoaFBnUQxUehuVc203/7++0filj
kLF26VToP8GhZfVue3wS9oN0zrB0/A==
=wqhm
-----END PGP SIGNATURE-----

--dvc3lJQ1BDQJTJkudNzU8tuSGk6w5fmQh--
