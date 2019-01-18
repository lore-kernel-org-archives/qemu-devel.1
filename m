Received: from eggs.gnu.org ([209.51.188.92]:55184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gkRdV-0004KS-Er
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gkRdL-0001rx-Pt
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:44:24 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gkRdL-0001rO-IW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:44:19 -0500
Received: by mail-wr1-x442.google.com with SMTP id u4so14456789wrp.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 02:44:19 -0800 (PST)
Date: Fri, 18 Jan 2019 10:44:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190118104416.GF21579@stefanha-x1.localdomain>
References: <20190117145207.31212-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
In-Reply-To: <20190117145207.31212-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: add ability to do simple printf
 logging via systemtap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 02:52:07PM +0000, Daniel P. Berrang=E9 wrote:

Dequeued.  I encountered two issues during testing:

1. s/binary/file/ in qemu-trace-stap's which() function:

diff --git a/scripts/qemu-trace-stap b/scripts/qemu-trace-stap
index b2eb41fbb0..3b4ec5e9b9 100755
--- a/scripts/qemu-trace-stap
+++ b/scripts/qemu-trace-stap
@@ -37,7 +37,7 @@ def which(file):
         if os.path.exists(os.path.join(path, file)):
                 return os.path.join(path, file)
=20
-    print("Unable to find '%s' in $PATH" % binary)
+    print("Unable to find '%s' in $PATH" % file)
     sys.exit(1)
=20
=20

2. The tpm_crb_mmio_read trace event's TARGET_FMT_plx format specifier
   macro isn't handled.  stap sees a literal "TARGET_FMT_plx" string and
   reports that the number of format string arguments is incorrect:

   semantic error: Wrong number of args to formatted print operator: identi=
fier 'printf' at :9189:5
   source:     printf("%d@%d tpm_crb_mmio_read CRB read 0x TARGET_FMT_plx  =
len:%u val: 0x%x\n", pid(), gettimeofday_ns(), addr, size, val)

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQa4AAAoJEJykq7OBq3PIbGYH/1j7o9VfX0yzfik7qYdSdHJY
U00Z+COf57cc4aUEc7fswwqJN1v9xbp/xS57uhMFUWSgXQyyS+yLEqn79WkYPOXP
KCvhVYZXjjYLYd3ihkofKuMWS1AqFDoCrHdtyKO5qm/DxqDakYcfIoiYrojDOdxD
blPVvsy5P7PmUzwlL6CQN83RgNVWKrp0JZ4Q2jKMZvRFtMA2eUzlkXDcwJD6oiLb
DMEsUZYTecRdcy6WVdFoDSr9GnGFR/0UHkGtrXgX2CFDU7c6GyCGfRfC2Z0l/rtn
dX6A2hEJ+/7DFxthh94A+UFc77E+TTkeR1iq0+dHKlw3xB5h/64MD0EfM7vgPIU=
=9cip
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
