Received: from eggs.gnu.org ([2001:4830:134:3::10]:33443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGFB-0001aW-QN
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGFA-00030e-KT
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:49:09 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chGFA-00030P-DX
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:49:08 -0500
Received: by mail-wr0-x22c.google.com with SMTP id o22so7897156wro.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 05:49:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170222183919.11928-1-ehabkost@redhat.com>
References: <20170222183919.11928-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 13:48:46 +0000
Message-ID: <CAFEAcA8_SsbdXWFbAt+qKXF-XGBjAt=ZbDgzSaeXYFzYPL1KTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 0/3] i386: Add "max" CPU model to TCG
 and KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 22 February 2017 at 18:39, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Changes v1 -> v2:
> * Fix build without CONFIG_KVM at lmce_supported()
> * Rebased on top of my x86-next branch:
>   https://github.com/ehabkost/qemu x86-next
>
> Git branch for testing:
>   https://github.com/ehabkost/qemu-hacks work/x86-cpu-max-tcg
>
> libvirt code to use the new feature already exist, and were
> submitted to libvir-list, at:
>   https://www.mail-archive.com/libvir-list@redhat.com/msg142168.html
>
> ---
>
> This is a replacement for the previous series that enabled the
> "host" CPU model on TCG. Now a new "max" CPU is being added,
> while keeping "host" KVM-specific.
>
> In addition to simply adding "max" as a copy of the existing
> "host" CPU model, additional patches change it to not use any
> host CPUID information when in TCG mode.


I had a look at implementing this for ARM, and ran into problems
because of how we've done '-cpu host'. For us the "host" CPU
type is registered dynamically when kvm_init() is called,
because (a) it only exists if -enable-kvm and (b) it probes
the kernel to find out what's available. So I could easily
add 'max' in the same place; but then where should I add the
type definition of 'max' for the non-KVM case?

Any suggestions?

thanks
-- PMM
