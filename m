Received: from eggs.gnu.org ([2001:4830:134:3::10]:52889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Tti-0000gb-IB
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 11:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4Ttf-0005kI-Ei
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 11:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d4Ttf-0005kE-62
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 11:02:55 -0400
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170428065754eucas1p1f51713373ce8c2d19945a4f91c52bd5c@eucas1p1.samsung.com>
	<1493362658-8179-5-git-send-email-a.perevalov@samsung.com>
	<20170428093825.GA22801@pxdev.xzpeter.org>
	<3a95fb33-f496-7e9d-50cb-6286d23dbdf6@samsung.com>
	<20170428100700.GC22801@pxdev.xzpeter.org>
	<20170428162205.GE3276@work-vm>
	<20170429091634.GA6721@aperevalov-ubuntu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <634a3b43-34f7-8fb7-5291-6b0985f1d205@redhat.com>
Date: Sat, 29 Apr 2017 10:02:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170429091634.GA6721@aperevalov-ubuntu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0G1VprxqWSFL6Ce4eX6eduQGe1nU1sFWn"
Subject: Re: [Qemu-devel] [PATCH RESEND V3 4/6] migration: add postcopy
 downtime into MigrationIncommingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey <a.perevalov@samsung.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: i.maximets@samsung.com, f4bug@amsat.org, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0G1VprxqWSFL6Ce4eX6eduQGe1nU1sFWn
From: Eric Blake <eblake@redhat.com>
To: Alexey <a.perevalov@samsung.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: i.maximets@samsung.com, f4bug@amsat.org, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <634a3b43-34f7-8fb7-5291-6b0985f1d205@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 4/6] migration: add postcopy
 downtime into MigrationIncommingState
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
 <CGME20170428065754eucas1p1f51713373ce8c2d19945a4f91c52bd5c@eucas1p1.samsung.com>
 <1493362658-8179-5-git-send-email-a.perevalov@samsung.com>
 <20170428093825.GA22801@pxdev.xzpeter.org>
 <3a95fb33-f496-7e9d-50cb-6286d23dbdf6@samsung.com>
 <20170428100700.GC22801@pxdev.xzpeter.org> <20170428162205.GE3276@work-vm>
 <20170429091634.GA6721@aperevalov-ubuntu>
In-Reply-To: <20170429091634.GA6721@aperevalov-ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/29/2017 04:16 AM, Alexey wrote:

>>>>
>>>>> There seem to be two parts to this:
>>>>>  a) Adding the mis parameter to ufd_version_check
>>>>>  b) Asking for the feature
>>>>
>>>>> Please split it into two patches.

Also, fix the typo in the subject line: s/Incomming/Incoming/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0G1VprxqWSFL6Ce4eX6eduQGe1nU1sFWn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZBKsYAAoJEKeha0olJ0NqUbIH/0SzWe1nmMJa9MWL1xYka7O0
bI5y7gZnhVB8VsG5A0VIpEmvqWBMA420dZsaz9w1R/tk0COkAupBvpdOSqtNZ5VS
VIUftSA0QfYzpxSdCfp+jhdebhsNZ8QypEYDBqUGbZNbImEMU9svqxqAJzGJ/BRV
GnHOVPYsW9WCLkQbA22n0OJry8zjA/bi6pLG/eqC0e5UX3aD0NPdkzwfXVnXADo6
olIFsanX1kRpBJ0XCk6PVjorT5BgrVetkaYFNkynB6zgia8QLCT0ODay4FyuxH7C
LT3L4ytifuxPH4GafM0sBfv/CbMKZrcBUbhtV4VazXDY2FH+XOTATVhojMou/k4=
=iOyq
-----END PGP SIGNATURE-----

--0G1VprxqWSFL6Ce4eX6eduQGe1nU1sFWn--
