Received: from eggs.gnu.org ([2001:4830:134:3::10]:41948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMpt-00033f-OE
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMpq-0006ZG-MX
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:36:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 12:34:27 +0200
Message-Id: <20170831103432.6007-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170831103432.6007-1-marcandre.lureau@redhat.com>
References: <20170831103432.6007-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/29] kvm: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 linux-headers/asm-x86/kvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index c2824d02ba..1930b95bcb 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -153,7 +153,7 @@ struct kvm_sregs {
 	__u64 cr0, cr2, cr3, cr4, cr8;
 	__u64 efer;
 	__u64 apic_base;
-	__u64 interrupt_bitmap[(KVM_NR_INTERRUPTS + 63) / 64];
+	__u64 interrupt_bitmap[DIV_ROUND_UP(KVM_NR_INTERRUPTS, 64)];
 };
=20
 /* for KVM_GET_FPU and KVM_SET_FPU */
--=20
2.14.1.146.gd35faa819
