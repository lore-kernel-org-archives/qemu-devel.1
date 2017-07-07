Received: from eggs.gnu.org ([2001:4830:134:3::10]:55175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=35458a3c6=Peter.Chubb@data61.csiro.au>)
	id 1dTHPz-0001Vu-Pi
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=35458a3c6=Peter.Chubb@data61.csiro.au>)
	id 1dTHPy-0004s0-8K
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:46:47 -0400
Received: from act-mtaout4.csiro.au ([2405:b000:e00:257::7:41]:47810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=35458a3c6=Peter.Chubb@data61.csiro.au>)
	id 1dTHPx-0004n3-6A
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:46:46 -0400
From: <Peter.Chubb@data61.csiro.au>
Date: Fri, 7 Jul 2017 00:14:02 +0000
Message-ID: <84wp7layt8.wl-Peter.Chubb@data61.csiro.au>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
In-Reply-To: <0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B320BA6E6A558844985E34747A78DA7E@csiro.au>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 3/6] Convert error_report() to
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

In a number of cases the initial double quote has been removed as
well.  This will have to be fixed.
e.g.,=20
-        error_report("Warning: 'filename' option specified. "
+        warn_report('filename' option specified. "

I'm surprised the result compiled cleanly.

Peter C


--
Dr Peter Chubb         Tel: +61 2 9490 5852      http://ts.data61.csiro.au/
Trustworthy Systems Group                           Data61 (formerly NICTA)=
