Received: from eggs.gnu.org ([2001:4830:134:3::10]:57200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dMoCm-0003ZF-5X
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dMoCl-0000hl-B3
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:22:24 -0400
Date: Mon, 19 Jun 2017 00:22:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170619042216.GC10709@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727927074.28532.17986481795216498698.stgit@frigg.lan>
	<20170616001842.GA25056@flamenco> <87mv95cq9t.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mv95cq9t.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 6/6] target: [tcg,
 arm] Port to generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Sun, Jun 18, 2017 at 17:41:02 +0300, Lluís Vilanova wrote:
> Is there any ready-made kernel or disk image I can test with?

I test ARM with:

$ qemu-system-arm -machine type=virt -nographic -smp 1 -m 4096 \
	-netdev user,id=unet,hostfwd=tcp::2222-:22 \
	-device virtio-net-device,netdev=unet \
	-drive file=jessie-arm32-die-on-boot.qcow2,id=myblock,index=0,if=none \
	-device virtio-blk-device,drive=myblock \
	-kernel aarch32-current-linux-kernel-only.img \
	-append 'console=ttyAMA0 root=/dev/vda1' \
	-name arm,debug-threads=on -smp 1

Grab the image & kernel from:
  http://www.cs.columbia.edu/~cota/qemu/
NB. The image shuts down without even asking for a username; it's convenient
for testing/benchmarking.

		E.
