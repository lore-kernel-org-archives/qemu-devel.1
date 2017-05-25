Received: from eggs.gnu.org ([2001:4830:134:3::10]:55068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leo@gaspard.io>) id 1dDgo9-0005Vl-QL
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leo@gaspard.io>) id 1dDgo6-0003p3-Ka
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:39:17 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:18816
	helo=smtp.smtpout.orange.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leo@gaspard.io>) id 1dDgo6-0003Xi-4I
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:39:14 -0400
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<c3f72497-76d9-7400-d701-0a6446463600@gaspard.io>
	<20170524105432.264f2e43@bahia.ttt.fr.ibm.com>
From: Leo Gaspard <leo@gaspard.io>
Message-ID: <a832603e-ffc4-f277-c894-527fc8ccabd8@gaspard.io>
Date: Thu, 25 May 2017 02:38:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170524105432.264f2e43@bahia.ttt.fr.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eFhVCAnfE9jiNn6a0Tuq527c567cuTLaJ"
Subject: Re: [Qemu-devel] [PATCH v2 0/4] 9pfs: local: fix metadata of
 mapped-file security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eFhVCAnfE9jiNn6a0Tuq527c567cuTLaJ
From: Leo Gaspard <leo@gaspard.io>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Message-ID: <a832603e-ffc4-f277-c894-527fc8ccabd8@gaspard.io>
Subject: Re: [PATCH v2 0/4] 9pfs: local: fix metadata of mapped-file security
 mode
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <c3f72497-76d9-7400-d701-0a6446463600@gaspard.io>
 <20170524105432.264f2e43@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170524105432.264f2e43@bahia.ttt.fr.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 10:54 AM, Greg Kurz wrote:
> On Wed, 24 May 2017 00:59:29 +0200
> Leo Gaspard <leo@gaspard.io> wrote:
>=20
>> On 05/23/2017 04:32 PM, Greg Kurz wrote:
>>> v2: - posted patch for CVE-2017-7493 separately
>>>     - other changes available in each patch changelog
>>>
>>> Leo,
>>>
>>> If you find time to test this series, I'll gladly add your Tested-by:=
 to
>>> it before merging. =20
>>
>> Just tested with a base of 2.9.0 with patches [1] [2] (from my
>> distribution), [3] (required to apply cleanly) and this patchset.
>>
>> Things appear to work as expected, and .virtfs_metadata{,_root} appear=

>> to be neither readable nor writable by any user.
>>
>=20
> Shall I add your Tested-by: to the patch then ?

Hmm, I can't find the definition of Tested-by: on [1], but if it means
"tested it by hand without maybe trying all possible edge cases" then I
guess you can add it :)

>> That said, one thing still bothering me with the fix in [3] is that it=

>> still "leaks" the host's uid/gid to the guest when a corresponding fil=
e
>> in .virtfs_metadata is not present (while I'd have expected it to appe=
ar
>> as root:root in the guest), but that's a separate issue, and I guess
>> retro-compatibility prevents any fixing it.
>>
>=20
> Heh, I had a tentative patch to create root:root credentials and 0700 m=
ode
> bits by default... but this could indeed break some setups, so I decide=
d
> not to post it.

Hmm, maybe adding an option to the security_model=3Dmapped-* that allows
to run default to root:root 0700 would allow to keep retrocompat, and in
a few versions swap the default value of the parameter? As the
'dscript=3Dno' of -netdev type=3Dtap appears to have disappeared -- and
broke my scripts -- in the switch to 1.9.0, I guess such a change would
be allowed by the retrocompatibility policy of qemu?

Anyway, it's fun to see you had thought of that too!

Cheers,
Leo


[1] http://wiki.qemu.org/Contribute/SubmitAPatch


--eFhVCAnfE9jiNn6a0Tuq527c567cuTLaJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEplquSIS+CbvsrRWvilWEi2CQ+c8FAlkmJ48ACgkQilWEi2CQ
+c+nYgv/dK5v8vJfEHq+C3sTwEdzd8pZ3N4geaGdJMGlbahE1JxVfBV6rMt1Ydo1
mhVi0CObhP2eNKFczV4MoZ0sZJ/t5P5GTC+XYxZo+zhxM3cWpyj5DVvQdlwtMC6U
OdRfOl7WAJh61AGOCKEzMxbJyBzdrY05s+WEng01PFsuWMuudLg2nXgTN8maTlU9
15CEVYx2OHMDkS+wlOBRB4HZNSLyU27OYA3CMiUF55apqCKr//hIpGpqwZ+NYicU
ytDOhpckpAp80X9aXniL+Z38KxPQZQdPheLcLNrGjl21eMb/A76ZGaJfmZhKmnuJ
ec0q+D/pG0HA5EoObezTzGeYImroqBPCAK6ReqYivmUEQVpBENhzzC0e2mSGMsgu
r44Bapmfp8WzXKegU4wZYfvu49VD3fAyU4+k4/v6ay7QsmJJIpdJijsf/njugjE0
nOJMAlOwzbIdnSCUzH4Do3YmeviZZlzLZlnfrZumRzrlwrj43a8HpeMHD9Iu37m+
qe4LBS3A
=blLh
-----END PGP SIGNATURE-----

--eFhVCAnfE9jiNn6a0Tuq527c567cuTLaJ--
