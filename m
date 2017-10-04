Received: from eggs.gnu.org ([2001:4830:134:3::10]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzjyD-0004KG-AC
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzjy9-0005Iq-2F
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzjy8-0005Hp-S8
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:44:12 -0400
References: <150711240619.28742.14769362567837002713.malonedeb@gac.canonical.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <115da2b1-2dbf-62c5-5f5e-5dcb126ae891@redhat.com>
Date: Wed, 4 Oct 2017 15:44:06 +0200
MIME-Version: 1.0
In-Reply-To: <150711240619.28742.14769362567837002713.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1721224] [NEW] qemu crashes with Assertion
 `!bus->dma[0] && !bus->dma[1]' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1721224 <1721224@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: "R.Nageswara Sastry" <nasastry@in.ibm.com>, Eduardo Otubo <otubo@redhat.com>

On 04.10.2017 12:20, R.Nageswara Sastry wrote:
> Public bug reported:
> 
> Re-production steps:
> git clone today's qemu git tree (4th Oct 2017)
> ./configure --target-list=ppc64-softmmu && make -j 8
> 
> Run the device-crash-test from scripts folder, seeing the following
> error
> 
> INFO: running test case: machine=prep binary=ppc64-softmmu/qemu-system-ppc64 device=i82374 accel=tcg
> WARNING: qemu received signal -6: ppc64-softmmu/qemu-system-ppc64 -chardev socket,id=mon,path=/var/tmp/qemu-30972-monitor.sock -mon chardev=mon,mode=control -display none -vga none -S -machine prep,accel=tcg -device i82374
> CRITICAL: failed: machine=prep binary=ppc64-softmmu/qemu-system-ppc64 device=i82374 accel=tcg
> CRITICAL: cmdline: ppc64-softmmu/qemu-system-ppc64 -S -machine prep,accel=tcg -device i82374
> CRITICAL: log: qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.
> CRITICAL: exit code: -6

Eduardo is working on a patch for this, see:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg08007.html
("dma/i82374: avoid double creation of i82374 device")

 Thomas
