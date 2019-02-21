Received: from eggs.gnu.org ([209.51.188.92]:41323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gwmc0-0008Mt-EI
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@outlook.com>) id 1gwmby-0006N7-92
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:33:55 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
Date: Thu, 21 Feb 2019 11:33:45 +0000
Message-ID: <VI1PR0602MB3245E37D4FDC665371678A0FA47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190204060636.GF29758@stefanha-x1.localdomain>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlook.com>
	<AM5PR0602MB32368CB5ADDEC05F42D8BC8FA46D0@AM5PR0602MB3236.eurprd06.prod.outlo>
	<VI1PR0602MB3245FD0A939EC3E28CA0F740A46F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190211031725.GB18083@stefanha-x1.localdomain>
	<VI1PR0602MB3245424120D151F29884A7E2A4630@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190220165839.GJ30403@stefanha-x1.localdomain>
	<f168e72e-89fe-cf9b-89ff-3eb820f8a5cf@redhat.com>
	<VI1PR0602MB32456F471A198636E7C7C0B1A47D0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<20190221111147.GB3282@stefanha-x1.localdomain>
In-Reply-To: <20190221111147.GB3282@stefanha-x1.localdomain>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Hi Stefan,

I can confirm that the symbols are included in the binary using gdb.

I will send you and Paolo an email with the link and credentials (if needed=
) so you can download everything.

Thanks!

On jue, feb 21, 2019 at 12:11 PM, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
On Wed, Feb 20, 2019 at 06:56:04PM +0000, Fernando Casas Sch=F6ssow wrote:
Regarding the dumps I have three of them including guest memory, 2 for virt=
io-scsi, 1 for virtio-blk, in case a comparison may help to confirm which i=
s the proble.) I can upload them to a server you indicate me or I can also =
put them on a server so you can download them as you see fit. Each dump, co=
mpressed, is around 500MB.
Hi Fernando, It would be great if you could make a compressed coredump and =
the corresponding QEMU executable (hopefully with debug symbols) available =
on a server so Paolo and/or I can download them. If you're wondering about =
the debug symbols, since you built QEMU from source the binary in x86_64-so=
ftmmu/qemu-system-x86_64 should have the debug symbols. "gdb path/to/qemu-s=
ystem-x86_64" will print "Reading symbols from qemu-system-x86_64...done." =
if symbols are available. Otherwise it will say "Reading symbols from qemu-=
system-x86_64...(no debugging symbols found)...done.". Thanks, Stefan
