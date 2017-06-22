Received: from eggs.gnu.org ([2001:4830:134:3::10]:45909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TG-0007pK-16
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TC-0006vz-2y
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1TB-0006vi-Si
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC1C4C00B8CC
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:44:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:58 +0200
Message-Id: <20170622124204.19407-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 25/31] kvm: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.13.1.395.gf7b71de06
