Received: from eggs.gnu.org ([209.51.188.92]:49015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guLzu-0007vC-Tf
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guLzo-0005pT-2i
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:44:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guLzm-0005fu-6M
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:44:27 -0500
References: <20190202144531.5772-1-n54@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3dc285c-496f-c2ad-126a-91b2e4690a5f@redhat.com>
Date: Thu, 14 Feb 2019 19:44:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190202144531.5772-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: Enhance the stub for
 kvm_arch_get_supported_cpuid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 02/02/19 15:45, Kamil Rytarowski wrote:
> 
> Clang/LLVM on NetBSD with enabled optimization cannot link
> correct qemu program because of a missing symbol of
> kvm_arch_get_supported_cpuid() in kvm-stubs.o used by executables.

Can you please include the full error message?  Usually these things are
a sign of a bug elsewhere.

Paolo
