Received: from eggs.gnu.org ([209.51.188.92]:41512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpWGa-0001VL-Dc
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpWGZ-00035n-Cp
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:41:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpWGZ-00032k-67
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:41:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so5634973wmi.4
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 02:41:40 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <734fb3f7-479c-2382-3728-4a1553fddc80@redhat.com>
Date: Fri, 1 Feb 2019 11:41:38 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v5 00/52] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

Hi,

On 1/25/19 11:06 AM, Paolo Bonzini wrote:
> (I'm only momentarily at the helm and will give control back to Yang after
> this iteration.)
> 
> This is still RFC mostly because of the lack of documentation, and because
> only x86 is fully converted, but it's converging.  Other targets still
> enable embedded devices in default-configs/ instead of using "select"
> directives.  For many targets, the conversion will be trivial because
> they only support one board.  The complex ones are ARM, MIPS and PPC
> of course.  s390 as usual is just different in some respects, but all
> of its issues are sorted out already in this series and so it's just
> yet another single-board target.
> 
> It supports defconfig (default-configs file chooses boards only)
> and allnoconfig (default-configs file chooses devices too) and builds
> all targets.  I haven't yet checked that the configuration is the same
> before and after the conversion, but at least device-introspection-test
> and other qtests all pass, which did catch some errors.
> 
> As mentioned in the previous versions, this is only a replacement
> for default-configs, in order to simplify configuration and remove
> the need to track dependencies between configuration symbols.  In
> fact, even with the current incomplete conversion the diffstat
> for default-configs is already
> 
>  31 files changed, 108 insertions(+), 241 deletions(-)
> 
> Devices can be disabled by adding for example
> 
>    CONFIG_HPET=n
> 
> to default-configs/i386-softmmu.mak.  If you prefer they can be
> listed manually and "make allnoconfig" can be executed before
> building.  This probably should become a configure option
> "--without-default-devices" instead.
> 
> For the previous discussions on the Kconfig design, see
> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02827.html
> 
> Patches 1-27 should probably be committed now, so please review!  Yang,
> once they are reviewed you can extract them and post them to the
> mailing list as non-RFC!
> 
> As to the rest, you're welcome to try them, post conversions for the
> simple targets, suggest usability improvements, and whatever.  Thanks to
> everyone for the work on the previous iterations.  It's great to see
> the work on this GSoC project come back to life after five years!

How to express "depends of (TARGET_LONG_BITS > 32)"?
