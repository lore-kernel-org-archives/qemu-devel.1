Received: from eggs.gnu.org ([2001:4830:134:3::10]:46521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e6yUQ-0006fb-GQ
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e6yUN-0005vL-Dq
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:39:26 -0400
Date: Tue, 24 Oct 2017 13:39:13 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171024123913.GB2787@redhat.com>
References: <20171024122045.30072-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171024122045.30072-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] tpm: add stubs to fix compiling
 with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On Tue, Oct 24, 2017 at 09:20:41AM -0300, Philippe Mathieu-Daud=E9 wrote:
> This fixes building with --disable-tpm as reported by Zoltan:
>   http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg05369.html
>=20
> Cc'ing Peter in case this enters as a build fix instead of via trivial.
>=20
> v2:
> - added Richard W.M. Jones Tested-by tag
> - remove #ifdef CONFIG_TPM in tpm.c (Stefan Berger)

Can confirm v2 works as well.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
