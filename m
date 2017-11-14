Received: from eggs.gnu.org ([2001:4830:134:3::10]:48234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eEZ5Z-0006HW-9n
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eEZ5V-0004cx-AQ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:09:09 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1eEZ5V-0004Zw-3T
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 06:09:05 -0500
Received: by mail-wm0-f66.google.com with SMTP id t139so21153047wmt.1
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 03:09:04 -0800 (PST)
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <81495d39-0026-dba2-10b9-86d7df5babd3@tuxfamily.org>
Date: Tue, 14 Nov 2017 12:09:00 +0100
MIME-Version: 1.0
In-Reply-To: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] HAXM is now open source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Ning <yu.ning@linux.intel.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Vincent Palatin <vpalatin@chromium.org>

On 14.11.2017 09:54, Yu Ning wrote:
> Hello,
> 
> As some of you may have noticed, since QEMU 2.9.0, an accelerator known
> as “hax” has been available for Windows and macOS builds of QEMU, thanks
> to the hard work of Vincent Palatin and help from this community (Paolo
> Bonzini, Stefan Weil, et al.).
> 
> The accelerator requires a host kernel module (driver) known as Intel
> Hardware Accelerated Execution Manager (HAXM), i.e. intelhaxm.sys on
> Windows or intelhaxm.kext on macOS, similar to how the KVM accelerator
> depends on kvm.ko on Linux.
> 
> Today, we released the source code of the HAXM kernel module under the
> BSD 3-clause license:
> 
> https://github.com/intel/haxm
> 
> We look forward to working with the community to improve HAXM (both the
> kernel module and the accelerator). The code is accompanied by some
> basic documentation (README.md and API.md), which is incomplete, but
> hopefully helps people get started. If you have any questions or
> suggestions, please create an issue or post a comment on GitHub.

That's great news! I hope this all will help to promote QEMU on Windows
and macOS quite a bit!

However, during the past months, I noticed a couple of times that users
ask on IRC or the qemu-discuss mailing list how they could accelerate
their QEMU on Windows - and they are running only in TCG mode when you
ask how they start QEMU. So it seems like there is not much knowledge
about "--accel hax" in the public yet. Maybe you could write a nice blog
post for the QEMU blog or something similar that explains how to use
HAXM with QEMU on Windows for the normal users? Or maybe make it more
prominent in the QEMU wiki? (e.g. the main page only mentions KVM and
Xen, but not HAXM)

 Thomas
