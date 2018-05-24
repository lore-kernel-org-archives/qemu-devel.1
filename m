Received: from eggs.gnu.org ([2001:4830:134:3::10]:54132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kash@tripleback.net>) id 1fLsWj-0005qp-F9
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kash@tripleback.net>) id 1fLsWd-0006HL-Rj
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:51:41 -0400
Received: from mail.tripleback.net ([198.50.226.104]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kash@tripleback.net>) id 1fLsWd-0006Ev-L1
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:51:35 -0400
References: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
From: Kash Pande <kash@tripleback.net>
Message-ID: <4e7811da-f900-bbf4-ea88-cf8983a6675f@tripleback.net>
Date: Thu, 24 May 2018 11:51:29 -0400
MIME-Version: 1.0
In-Reply-To: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qWUBCsyHYs17HFs51jn2CvcfayoWLwiWp"
Subject: Re: [Qemu-devel] [PATCH v11 0/5] i386: Enable TOPOEXT to support
 hyperthreading on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qWUBCsyHYs17HFs51jn2CvcfayoWLwiWp
From: Kash Pande <kash@tripleback.net>
To: Babu Moger <babu.moger@amd.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com
Message-ID: <4e7811da-f900-bbf4-ea88-cf8983a6675f@tripleback.net>
Subject: Re: [PATCH v11 0/5] i386: Enable TOPOEXT to support hyperthreading on
 AMD CPU
References: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
In-Reply-To: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tested-by: Kash Pande <kash@tripleback.net>


Hopefully we can get this merged because it's taken a ridiculously long
time with many back-and-forths for small issues that could have been put
off til later.

Kash

On 2018-05-24 11:43 AM, Babu Moger wrote:
> This series enables the TOPOEXT feature for AMD CPUs. This is required =
to
> support hyperthreading on kvm guests.
>
> This addresses the issues reported in these bugs:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1481253
> https://bugs.launchpad.net/qemu/+bug/1703506=20
>
> v11:
>  Patches are based off of Eduardo's git://github.com/ehabkost/qemu.git =
x86-next.
>  Summary of changes.
>  1.Added more comments explaining different constants and variables.
>  2.Removed NUM_SHARING_CACHE macro and made the code simpler.
>  3.Changed the function name num_sharing_l3_cache to cores_in_core_comp=
lex.
>    This function is actually finding the number of cores in a core comp=
lex.
>    Purpose here is to re-use the code in couple more places.
>  4.Added new function nodes_in_socket to find number of nodes in the co=
nfig.
>    Purpose here is to re-use the code.
>  5.Used DIV_ROUND_UP wherever applicable.
>  6.Renamed few constants and functions to generic names.
>  7.Few more text corrections.
> =20



--qWUBCsyHYs17HFs51jn2CvcfayoWLwiWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlsG34QACgkQLHWyk7ic
JXg0Ogf/Uz/WKkeSCalDDFLb2apOnotGUJF2YBOTkz+wtARojTLebmIPB2YLGtnC
7rthYEYuNdI1PykHvEluZetWf3exW1VnyG9iceXN/BjjitJkSCvgNirjW1l2HgQB
fHx08sdX7wf0fxV4o6l0I7vJsiUf6/T8dSLBpuWce/knZQ9B4efH8ltakI3eu6xv
H0oqW0GpFfAbNbg9957dx8/gS7qQAGBKVAMi3qMXGdpzIv8xPPkQHNAmtUND810z
L914g9/uQIZ6rN9JUZGzBtyy+wCNHs+Tf4jFCsX3WG8Ho5rpmgvbPJuAMlQ0tmYI
sAjTVOT4VEtlCPyc/r79K6Vsqwdzvw==
=8tal
-----END PGP SIGNATURE-----

--qWUBCsyHYs17HFs51jn2CvcfayoWLwiWp--
