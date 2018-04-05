Received: from eggs.gnu.org ([2001:4830:134:3::10]:37228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47BF-0007F3-Jk
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47BE-0003iU-PQ
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:52:05 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f47BE-0003iK-EV
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:52:04 -0400
Received: by mail-wr0-x241.google.com with SMTP id p53so29229555wrc.10
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 08:52:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180330170209.20627-1-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84d1f39e-856b-5f5c-0352-37554b825f55@redhat.com>
Date: Thu, 5 Apr 2018 17:52:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180330170209.20627-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 0/2] i386/hyperv: fully control
 Hyper-V features in CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

On 30/03/2018 19:02, Roman Kagan wrote:
> In order to guarantee compatibility on migration, QEMU should have
> complete control over the features it announces to the guest via CPUID.
> 
> However, a number of Hyper-V-related features happen to depend on the
> support in the underlying KVM, with no regard to QEMU configuration.
> 
> Make QEMU regain control over what Hyper-V features it announces to the
> guest.
> 
> Note #1: the patches are also being proposed[*] for stable-2.11, even
> though one of them introduces a new cpu property.  This is done to
> minimize the number of published QEMU releases where the behavior of the
> features is unpredictable, with potentially fatal consequences for the
> guest.
> 
> Note #2: there are other problems in the surrounding code, like ugly
> error reporting or inconsistent population of MSRs.  I think this can be
> put off to post-2.12.
> 
> [*] for the stable branch the second patch will have error returns
> replaced with warnings; I'll post a separate series.
> 
> v2 -> v3:
>  - include the fix for 'hv-time' missed previously
> 
> v1 -> v2:
>  - indicate what flag requested the feature that can't be enabled in the
>    error message
>  - fix a typo in the error message for VP_RUNTIME

Queued, thanks.

Paolo

> 
> Roman Kagan (2):
>   i386/hyperv: add hv-frequencies cpu property
>   i386/hyperv: error out if features requested but unsupported
> 
>  target/i386/cpu.h |  1 +
>  target/i386/cpu.c |  1 +
>  target/i386/kvm.c | 56 ++++++++++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 45 insertions(+), 13 deletions(-)
> 
