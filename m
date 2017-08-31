Received: from eggs.gnu.org ([2001:4830:134:3::10]:36811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKIh-00044n-Jn
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dnKIe-00024t-HD
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:54:07 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dnKIe-00024d-9Z
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:54:04 -0400
Received: by mail-wm0-x233.google.com with SMTP id u26so23814874wma.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 00:54:04 -0700 (PDT)
Date: Thu, 31 Aug 2017 08:54:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170831075401.GB13619@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/13] hvf: add code base from Google's
 QEMU repository
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

On Wed, Aug 30, 2017 at 03:26:51AM -0500, Sergio Andres Gomez Del Real wrote:
> This file begins tracking the files that will be the code base for HVF
> support in QEMU. This code base is part of Google's QEMU version of
> their Android emulator, and can be found at
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev
> 
> This code is based on Veertu Inc's vdhh (Veertu Desktop Hosted
> Hypervisor), found at https://github.com/veertuinc/vdhh. Everything is
> appropriately licensed under GPL v2.
> 
> This code base already implements a very great deal of functionality,
> although Google's version removed from Vertuu's the support for APIC
> page and hyperv-related stuff. According to the Android Emulator Release
> Notes, Revision 26.1.3 (August 2017), "Hypervisor.framework is now
> enabled by default on macOS for 32-bit x86 images to improve performance
> and macOS compatibility", although we better use with caution for, as the
> same Revision warns us, "If you experience issues with it specifically,
> please file a bug report...". The code hasn't seen much update in the
> last 5 months, so I think that we can further develop the code with
> occasional visiting Google's repository to see if there has been any
> update.
> 
> The code's style isn't aligned to QEMU's standards; this will be fixed
> in a subsequent patch in this series.
> On top of this code base we are implementing the following features: fix
> the code that passes the cpuid features to the guest; implementing dirty
> page tracking for vga memory region; reimplementing the event injection
> mechanism for exception injection and many other minor
> fixes/refactoring that are documented in their respective patches.
> 
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---

This looks like a reasonable approach to getting Hypervisor.framework
support.  I haven't reviewed the details but it contains all the pieces
one would expect.

Which guest OSes have you booted successfully?

Stefan
