Received: from eggs.gnu.org ([2001:4830:134:3::10]:52250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpEyV-0006KN-VG
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpEyR-00036P-Ba
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:37:11 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:47086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpEyR-00034e-4U
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:37:07 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id CFCBBA96CE
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 16:37:04 +0200 (CEST)
Date: Tue, 5 Sep 2017 16:36:56 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170905163656.73d98e23@bahia>
In-Reply-To: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
References: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/NUr1VY6uRxecSU3O5pE22QN";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] ppc: fix migration with KVM
 PR (nested)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>

--Sig_/NUr1VY6uRxecSU3O5pE22QN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I wanted to Cc Sam also but it was late and I forgot :)

On Mon, 04 Sep 2017 23:46:44 +0200
Greg Kurz <groug@kaod.org> wrote:

> A guest running with KVM PR ends up irresponsive after migration most of =
the
> time. This happens because the HPT allocated by QEMU is likely to have a
> different address on the destination than it had on the source, but we pu=
sh
> the source address to KVM.
>=20
> This series does a little cleanup and fixes the issue. I could successful=
ly
> test it with a nested setup (KVM PR running in KVM HV).
>=20
> However, this isn't enough to fix migration when using KVM PR on baremeta=
l...
> CPUs seem to end up looping on H_CEDE in the guest. I can't figure out wh=
at's
> happening... Any suggestion would be appreciated.
>=20
> Cheers,
>=20
> --
> Greg
>=20
> ---
>=20
> Greg Kurz (4):
>       spapr: only update SDR1 once per-cpu during CAS
>       spapr: introduce a helper to compute the address of the HPT
>       ppc: kvm: introduce a helper to update SDR1 for a single CPU
>       ppc: kvm: update HPT pointer in KVM PR after migration
>=20
>=20
>  hw/ppc/spapr.c          |   15 +++++++++++++++
>  hw/ppc/spapr_cpu_core.c |    8 +++-----
>  hw/ppc/spapr_hcall.c    |   20 +++++++++-----------
>  include/hw/ppc/spapr.h  |    1 +
>  target/ppc/cpu.h        |    1 +
>  target/ppc/kvm.c        |   12 ++++++++----
>  target/ppc/kvm_ppc.h    |    3 ++-
>  target/ppc/machine.c    |    7 +++++++
>  8 files changed, 46 insertions(+), 21 deletions(-)
>=20
>=20


--Sig_/NUr1VY6uRxecSU3O5pE22QN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWa62iAAKCRAC/DrrAQHb
whjLAJ4ocKsyqa/bWfd46woH2Y+EImQTOACgnzdUlVlE3Za8sB2dVEtuN1Wf8Mk=
=BeAZ
-----END PGP SIGNATURE-----

--Sig_/NUr1VY6uRxecSU3O5pE22QN--
