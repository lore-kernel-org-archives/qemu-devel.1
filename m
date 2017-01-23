Received: from eggs.gnu.org ([2001:4830:134:3::10]:48469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVc56-0003N7-68
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVc52-0001L7-7d
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:42:36 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:33667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cVc52-0001L2-0b
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:42:32 -0500
Received: by mail-wm0-x235.google.com with SMTP id d140so32648299wmd.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 02:42:31 -0800 (PST)
Date: Mon, 23 Jan 2017 10:42:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170123104228.GG29186@stefanha-x1.localdomain>
References: <CAAKRE72RN=DvVqxYMba5KdnWQ+jrAXTpxQc7Qdgiymu6oByosg@mail.gmail.com>
	<20170118102942.GA5284@stefanha-x1.localdomain>
	<CAAKRE70s=Cdk9xedS3xavOj9_TMRa4ZNvZqVw8jqVxVMDCM7Vg@mail.gmail.com>
	<CAJSP0QUU3CgJdX6p-vAQAyAeQio3Br7grUFBRrT-N0s2F6X58g@mail.gmail.com>
	<CAAKRE72fjOwKs6V8MMOB-9WWv1vYidKYt3QSTZAoxEboXq2f5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Content-Disposition: inline
In-Reply-To: <CAAKRE72fjOwKs6V8MMOB-9WWv1vYidKYt3QSTZAoxEboXq2f5g@mail.gmail.com>
Subject: Re: [Qemu-devel] VM Hung issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Umar Draz <unix.co@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 19, 2017 at 10:22:57PM +0500, Umar Draz wrote:
> Yes the display is blank, and network also not responding, it means vm
> somewhere hung.

Try "gstack $PID_OF_QEMU" when the VM is hung.  This will output a
backtrace for all threads in QEMU.  You might need to install the gdb
package to get gstack.

Please post the backtrace.  Maybe we'll be able to identify a deadlock
or other bug.

Stefan

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYhd4UAAoJEJykq7OBq3PIMDUIALZmQTl1T+F8KQyAVBjMdyP8
QLAH9msd9uK35uSkw3f46VVJ+QlFtusZQZBS7PFjIxglwWdjmrU/KGcKcU2k03tj
L+psSN4TvwqDETIG7Qz9UqO1MQDHMB/mltyZ9wMb8tMP+X3K0xawMVgmte9sQf2g
kglAkYvajE7+mwXF9JLd2hHTIcNduSXmC5NgyWwUxueiBTDMUpVRYSd+yx5R/cCR
i5HeQ6j3xlUC5mkKHIk3m5xD8gsos6XU/soygU0S+Q4lrM/MMtQedab/Z9Krdcbq
HJ1fUA+zZhCDbiE17WXydZIGmgUiWQMJ621e7RzbfiN8shPfovXvCH5vT+e1g+A=
=I2VA
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--
