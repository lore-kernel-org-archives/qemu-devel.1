Received: from eggs.gnu.org ([209.51.188.92]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZmM-0006MA-4f
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZmL-0003Za-6r
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:50 -0400
Date: Thu, 25 Apr 2019 09:30:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190425083045.GC30231@stefanha-x1.localdomain>
References: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
	<20190423094217.GC6022@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20190423094217.GC6022@redhat.com>
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BQemu-block=5D__question=EF=BC=9A_Does_?=
 =?utf-8?q?qemu-pr-helper_have_its_own_log_files=EF=BC=9F?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Jie Wang <wangjie88@huawei.com>, "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Fangyi (C)" <eric.fangyi@huawei.com>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 10:42:17AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 23, 2019 at 11:12:40AM +0800, Jie Wang wrote:
> > =C2=A0Does qemu-pr-helper have its own log files=EF=BC=9F
>=20
> When QEMU launches it, i think it just inherits stdout/err from
> QEMU itself, so errors appear mixed into QEMU's stdout output.

I thought QEMU does not launch qemu-pr-helper.  Have I missed something?

QEMU ships systemd .service and .socket files for managing
qemu-pr-helper externally.

> When libvirt launches it, there stdout is connected to /dev/null
> and stderr is connected to a pipe which libvirt closes almost
> immediately. This means any errors are lost as any attempt to
> write to stderr will get EPIPE :-(

For anyone looking at the code:
src/qemu/qemu_process.c:qemuProcessStartManagedPRDaemon()

Stefan

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwXA1AAoJEJykq7OBq3PI/QoH/3PwwjgmRYq6fAoTt4Xu6FBU
siKILMWL7wMWjzvxUIs+JY2ZeOXbvci6mT0zOvGqhNAiQANKVNhUunze576ZtFlD
Ug2ePB4AuU3ccwAElR0zpJoneoJMU1T6ksIxLh4V/NwBDtQL1dNYFN7VSulLKxbo
YMI0BZQ8ky7eZXCx7nSmHgF9BtdjxLqsvPMDtmSkOb6SXpnneTq+6FQRYTImSYEt
o5Gp/bcc5NTgc67/tGfSPCEl1qqDdEQ6YN/S/mSk8tZkcbqoDpX0J/tpp4oDThI3
g1o5yFTOHxeExtsk+Vff7bDXg3QRC+0gyn+IFA8XX8opWlOglN89SlR8qZceUL8=
=0xgx
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
