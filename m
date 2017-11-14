Received: from eggs.gnu.org ([2001:4830:134:3::10]:34206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eEWz6-0005m2-2z
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eEWz2-0003NF-4b
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:54:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:34367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eEWz1-0003LO-SS
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:54:16 -0500
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
Date: Tue, 14 Nov 2017 16:54:09 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] HAXM is now open source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Vincent Palatin <vpalatin@chromium.org>

Hello,

As some of you may have noticed, since QEMU 2.9.0, an accelerator known 
as “hax” has been available for Windows and macOS builds of QEMU, thanks 
to the hard work of Vincent Palatin and help from this community (Paolo 
Bonzini, Stefan Weil, et al.).

The accelerator requires a host kernel module (driver) known as Intel 
Hardware Accelerated Execution Manager (HAXM), i.e. intelhaxm.sys on 
Windows or intelhaxm.kext on macOS, similar to how the KVM accelerator 
depends on kvm.ko on Linux.

Today, we released the source code of the HAXM kernel module under the 
BSD 3-clause license:

https://github.com/intel/haxm

We look forward to working with the community to improve HAXM (both the 
kernel module and the accelerator). The code is accompanied by some 
basic documentation (README.md and API.md), which is incomplete, but 
hopefully helps people get started. If you have any questions or 
suggestions, please create an issue or post a comment on GitHub.

Thanks,
Yu
