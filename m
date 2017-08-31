Received: from eggs.gnu.org ([2001:4830:134:3::10]:56516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnLrT-0007wR-5A
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnLrQ-0006yz-0t
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:34:07 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dnLrP-0006yh-Pi
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:34:03 -0400
Received: by mail-wr0-x235.google.com with SMTP id y15so401642wrc.2
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 02:34:03 -0700 (PDT)
Date: Thu, 31 Aug 2017 10:34:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170831093400.GH13619@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/13] add support for
 Hypervisor.framework in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 03:26:49AM -0500, Sergio Andres Gomez Del Real wrote:
> ================
> Changes in v2:
>  (1) Removed legacy option "-enable-hvf" in favor of "-M accel=hvf"
>  (2) Added missing copyright headers; replace fprintfs for error_report;
>      improved commit description.
>  (3) Moved patch that adds compilation rules in Makefile.objs right after
>      the patch that adds the new files from Google's repo.
>  (4) Removed conditional macros from cpus.c and cpu.c
>  (5) Moved patch that fixes coding style to patch # 3
>  (6) Fix commit message in apic patch
>  (7) Squash some commits to avoid code churn
> ================
> 
> The following patchset adds to QEMU the supporting for macOS's native
> hypervisor, Hypervisor.framework (hvf). The code base is taken from
> Google's Android emulator at
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev.
> 
> Apart from general code refactoring, some additional features were implemented:
> retrieve the set of features supported by host cpu and hvf (cpuid);
> dirty page tracking for VGA memory area; reimplementation of the event
> injection mechanism to allow injection of exceptions during vmexits, which is
> exemplified by the injection of a GP fault when the guest vmexits due to
> execution of the vmcall instruction; changing the emulator's use of CPUState
> structure in favor of CPUX86State, so as to in the future remove data structures
> that are uselessly specific to hvf and unified some of the state between kvm/tcg
> and hvf.
> Some features initially planned to implement that didn't make it include:
> page fault handling in the emulator and implementing the dummy_signal to handle
> the SIG_IPI signal without race conditions. Hopefully these can be implemented
> in the near future.

I have done a brief review (mainly style issues) of the whole series.

A test case is required.  Maybe the easiest option is to extend
tests/boot-serial-test.c to try hvf (if available).  That way an
automated test will verify that the BIOS executes inside the guest.

Stefan
