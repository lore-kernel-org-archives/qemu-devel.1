Received: from eggs.gnu.org ([2001:4830:134:3::10]:37522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3559f609a=Peter.Chubb@data61.csiro.au>)
	id 1dTeDr-0003Q1-Ej
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 21:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3559f609a=Peter.Chubb@data61.csiro.au>)
	id 1dTeDo-0007SI-9Q
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 21:07:47 -0400
Received: from vic-mtaout1.csiro.au ([2405:b000:b00:220::64:37]:6888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=3559f609a=Peter.Chubb@data61.csiro.au>)
	id 1dTeDn-00075g-7v
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 21:07:44 -0400
From: <Peter.Chubb@data61.csiro.au>
Date: Fri, 7 Jul 2017 23:35:00 +0000
Message-ID: <84tw2nbz31.wl-Peter.Chubb@data61.csiro.au>
References: <cover.1499453787.git.alistair.francis@xilinx.com>
	<125868e788f5705e31c0326bed02bc75f9fb173e.1499453788.git.alistair.francis@xilinx.com>
In-Reply-To: <125868e788f5705e31c0326bed02bc75f9fb173e.1499453788.git.alistair.francis@xilinx.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB5DF0EDD28946499FB55FA9B0990574@csiro.au>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/8] Convert error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair.francis@xilinx.com
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@kamp.de, jdurgin@redhat.com, rjones@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org, robh@kernel.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au, ehabkost@redhat.com, marcel@redhat.com, mst@redhat.com, imammedo@redhat.com, david@gibson.dropbear.id.au, agraf@suse.de, kraxel@redhat.com, jasowang@redhat.com, mtosatti@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, stefanha@redhat.com

>>>>> "Alistair" =3D=3D Alistair Francis <alistair.francis@xilinx.com> writ=
es:

Alistair> Convert all uses of error_report("[Ww]arning:"... to use
Alistair> warn_report() instead. This helps standardise on a single
Alistair> method of printing warnings to the user.

Alistair> All of the warnings were changed using this command: find
Alistair> ./* -type f -exec sed -i \ 's|error_report.*[Ww]arning:
Alistair> |warn_report("|g' {} +

Alistair> Then the white space changes where manually fixed
Alistair> afterwards.

s/where/were/

Otherwise,
	Reviewed by: Peter Chubb <peter.chubb@data61.csiro.au>
(for KZM and i.mx25 parts; I did look at the other bits but didn't see
	anything obviously crazy.)

--=20
Dr Peter Chubb         Tel: +61 2 9490 5852      http://ts.data61.csiro.au/
Trustworthy Systems Group                           Data61 (formerly NICTA)=
