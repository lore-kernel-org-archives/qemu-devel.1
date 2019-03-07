Received: from eggs.gnu.org ([209.51.188.92]:45693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1tyP-0002Hs-1e
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1tyO-0005m5-Ag
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:26:13 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1h1tyO-0005lH-1z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:26:12 -0500
Received: by mail-wm1-x341.google.com with SMTP id j125so9476595wmj.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:26:11 -0800 (PST)
Date: Thu, 7 Mar 2019 14:26:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190307142609.GF2843@stefanha-x1.localdomain>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elena.ufimtseva@oracle.com
Cc: qemu-devel@nongnu.org, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2019 at 11:22:53PM -0800, elena.ufimtseva@oracle.com wrote:
> diff --git a/docs/devel/qemu-multiprocess.txt b/docs/devel/qemu-multiprocess.txt
> new file mode 100644
> index 0000000..e29c6c8
> --- /dev/null
> +++ b/docs/devel/qemu-multiprocess.txt

Thanks for this document and the interesting work that you are doing.
I'd like to discuss the security advantages gained by disaggregating
QEMU in more detail.

The security model for VMs managed by libvirt (most production x86, ppc,
s390 guests) is that the QEMU process is untrusted and only has access
to resources belonging to the guest.  SELinux is used to restrict the
process from accessing other files, processes, etc on the host.

QEMU does not hold privileged resources that must be kept away from the
guest.  An escaped guest can access its image file, tap file descriptor,
etc but they are the same resources it could already access via device
emulation.

Can you give specific examples of how disaggregation improves security?

Stefan

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgSoBAAoJEJykq7OBq3PIdGAIAKKqZwaoR2SUQ/U/6gv94J5H
q+OhD0Jl8u8aa3FgOrwVTZNBw/8vlJb3Lp9qcrtBcLaCfk7PgnFL5WfXenb6k8CP
A6Rx0BNO8VJvu3Z7fRlIG3b9MmjVbEFeiUjV9r6J0292DqPAz5/Ynampw0378x3g
jN3Xu3+ftAH3GqiTYxnqYegjVxttdKd1ohbn+oV7QovWQv2Rt78AC+RgFbRQ5Czn
4vqroZitoXTYnnHqOKSdFXV7of3ZCJDaUwood1HX9stCk438unAQsxA0eoFFk13x
HJmOLhh7IZlhav0+6vfk49yEL5/6U1+aabE47c1YHfuYoxrHBbtoXWlTR/208CA=
=Pju8
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
