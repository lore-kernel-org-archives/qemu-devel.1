Received: from eggs.gnu.org ([2001:4830:134:3::10]:36980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2LOl-0005Xd-6H
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2LOi-0008GH-1z
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 13:34:11 -0400
References: <1485377117-18105-1-git-send-email-thuth@redhat.com>
	<f524e29d-6e8c-19b0-e170-2a6876cbfe69@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <c00a72ff-a3a0-76d1-1b0e-4477bddeff2f@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 20:34:05 +0300
MIME-Version: 1.0
In-Reply-To: <f524e29d-6e8c-19b0-e170-2a6876cbfe69@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix crash when
 running without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

27.02.2017 22:36, Thomas Huth wrote:
> On 25.01.2017 21:45, Thomas Huth wrote:
>> When running QEMU with "-M none -device loader,file=kernel.elf", it
>> currently crashes with a segmentation fault, because the "none"-machine
>> does not have any CPU by default and the generic loader code tries
>> to dereference s->cpu. Fix it by adding an appropriate check for a
>> NULL pointer.

Applied to -trivial, thanks!

/mjt
