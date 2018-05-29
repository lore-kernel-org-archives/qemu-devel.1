Received: from eggs.gnu.org ([2001:4830:134:3::10]:33717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fNaBB-0001f9-Jn
	for qemu-devel@nongnu.org; Tue, 29 May 2018 04:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fNaB8-0004Uo-HW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 04:40:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fNaB8-0004Tb-A9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 04:40:26 -0400
Date: Tue, 29 May 2018 10:40:21 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180529084021.GC31560@dnr>
References: <20180529073140.7392-1-zyimin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20180529073140.7392-1-zyimin@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>
Cc: qemu-devel@nongnu.org, otubo@redhat.com, fiuczy@linux.ibm.com, borntraeger@de.ibm.com, jferlan@redhat.com, pbonzini@redhat.com


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 03:31:40PM +0800, Yi Min Zhao wrote:
>If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remains
>compiled. This would make libvirt set the corresponding capability and
>then trigger failure during guest startup. This patch moves the code
>regarding seccomp command line options to qemu-seccomp.c file and
>wraps qemu_opts_foreach finding sandbox option with CONFIG_SECCOMP.
>Because parse_sandbox() is moved into qemu-seccomp.c file, change
>seccomp_start() to static function.
>
>Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
>---
>1. Problem Description
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>If QEMU is built without seccomp support, 'elevateprivileges' remains comp=
iled.
>This option of sandbox is treated as an indication for seccomp blacklist s=
upport
>in libvirt. This behavior is introduced by the libvirt commits 31ca6a5 and
>3527f9d. It would make libvirt build wrong QEMU cmdline, and then the guest
>startup would fail.
>
>2. Libvirt Log
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>qemu-system-s390x: -sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,sp=
awn=3Ddeny,\
>resourcecontrol=3Ddeny: seccomp support is disabled
>
>3. Fixup
>=3D=3D=3D=3D=3D=3D=3D=3D
>Move the code related ot sandbox to qemu-seccomp.c file and wrap them with
>CONFIG_SECCOMP. So compile the code related to sandbox only when
>CONFIG_SECCOMP is defined.
>---
> include/sysemu/seccomp.h |   3 +-
> qemu-seccomp.c           | 121 ++++++++++++++++++++++++++++++++++++++++++=
++++-
> vl.c                     | 118 +-----------------------------------------=
---
> 3 files changed, 124 insertions(+), 118 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>
Tested-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlsNEekACgkQyvpdPXT/
AmmaYRAA7X5Zp4DwArA9jm6pL3ebFtTXbZ/9EEG0S+b9Vjwq4FIOUMFQjZ0BMuLl
+pQK/pwpxPR2WYrFaSBefEGh8VObaViOAGulj745LlCsuN7IBMDfjUXSQLoXt7k1
GkZ5rty4H9saQeKkwX+SkZD4+m/cqFsy1mo1u1Mv6/aFOp6ghFbTpxmgUIJa87+Y
gSftjNqlc7h4gwmrFOtWLfVPH4fPCjG/BexSEaVbnuVQ49lbwZZG30uLFHDYtsxb
Hx87KL0THzNZbeLFsj22nS2r2Bw2xsBmzhcWI3jcBeKgk8zo3OghAHN09v082smr
dkiHCT9FibrwvDyybBDW6qVgoVp8ZUvresFNqEAhazq3/6E924fxbtgB2LnY2QOB
Cly4NtvL29ZiqpCb2gKAG3xozITxVCk9CEDupEZUmF23zMswnigQWAPQd4AxqGvU
/84QP9hyBIAcyCujNrdyAdp3q6oEnbs1H4CTIClSfZGKpX3SDxEM1URb91Czvzmp
bdXf+N1SC5jEfON9spWjkFxJOxyHmu+lJAuIIRQBhe+z9PR7IvnmR6ElVxo/eH+f
ZG5t8hKM0bBefNZjUVBSRPlrMizBup9Lq6kFSG88ti7OsX1r+F8GHzfZmXRR2zvv
nMmCAWuNf4mUwWxMRtMJTMlq90Z0XaoUKFbu0g79FdVDSqXrZnM=
=2vCd
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
