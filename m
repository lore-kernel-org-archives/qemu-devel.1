Received: from eggs.gnu.org ([2001:4830:134:3::10]:37637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYXc-0003ht-7T
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 00:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYXX-00026S-9J
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 00:05:48 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:38425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diYXW-00025r-W8
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 00:05:43 -0400
Received: by mail-pg0-x22d.google.com with SMTP id t80so28315557pgb.5
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 21:05:42 -0700 (PDT)
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fa2d048b-574f-0e0b-ebb4-4a3fc4febc96@linaro.org>
Date: Thu, 17 Aug 2017 21:05:39 -0700
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 09/10] s390x/kvm: move KVM
 declarations and stubs to separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 08/17/2017 02:22 AM, David Hildenbrand wrote:
> Let's do it just like the other architectures. Introduce kvm-stub.c
> for stubs and kvm_s390x.h for the declarations.
> 
> Add a fake declaration of struct kvm_s390_irq so we don't need other
> ugly CONFIG_KVM checks.
> 
> Change license to GPL2+ and keep copyright notice.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/Makefile.objs |   1 +
>  target/s390x/cpu.h         | 121 +--------------------------------------------
>  target/s390x/kvm-stub.c    | 111 +++++++++++++++++++++++++++++++++++++++++
>  target/s390x/kvm_s390x.h   |  51 +++++++++++++++++++
>  4 files changed, 164 insertions(+), 120 deletions(-)
>  create mode 100644 target/s390x/kvm-stub.c
>  create mode 100644 target/s390x/kvm_s390x.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
