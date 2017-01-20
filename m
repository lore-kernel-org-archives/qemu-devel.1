Received: from eggs.gnu.org ([2001:4830:134:3::10]:45416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUWFZ-0005gw-1t
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUWFY-0003ZI-0A
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:16:53 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:33881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUWFX-0003YY-SC
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:16:51 -0500
Received: by mail-vk0-x22a.google.com with SMTP id r136so48596923vke.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 02:16:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170119210449.11991-1-ehabkost@redhat.com>
References: <20170119210449.11991-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 10:16:30 +0000
Message-ID: <CAFEAcA_3WVpgBpCahWa716KF44Frxg98HosLYZrHC9tkqU-Pow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/6] i386: Add "max" CPU model to TCG and
 KVM
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

On 19 January 2017 at 21:04, Eduardo Habkost <ehabkost@redhat.com> wrote:
> This is v2 of the previous series that enabled the "host" CPU
> model on TCG. Now a new "max" CPU is being added, while keeping
> "host" KVM-specific.
>
> In addition to simply adding "max" as a copy of the existing
> "host" CPU model, additional patches change it to not use any
> host CPUID information when in TCG mode.
>
> ---
> Cc: "Richard W.M. Jones" <rjones@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Jiri Denemark <jdenemar@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
>
> Eduardo Habkost (6):
>   i386: Unset cannot_destroy_with_object_finalize_yet on "host" model
>   i386: Add ordering field to CPUClass
>   i386: Rename X86CPU::host_features to X86CPU::max_features
>   i386: Create "max" CPU model
>   i386: Make "max" model not use any host CPUID info on TCG
>   i386: Don't set CPUClass::cpu_def on "max" model
>
>  target/i386/cpu-qom.h |   6 ++-
>  target/i386/cpu.h     |   2 +-
>  target/i386/cpu.c     | 110 +++++++++++++++++++++++++++++---------------------
>  3 files changed, 71 insertions(+), 47 deletions(-)

Should we be documenting this new -cpu max somewhere?

(If this series is OK I can send patches to add support to
ARM, and also to add "-machine gic-version=max" to allow
picking the best available interrupt controller type, by
analogy.)

thanks
-- PMM
