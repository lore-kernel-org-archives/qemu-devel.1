Received: from eggs.gnu.org ([2001:4830:134:3::10]:34733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evRgy-0005q2-Os
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evRgu-00029o-TB
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:57:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evRgu-00029W-Mk
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:56:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68E74C057F9F
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:56:51 +0000 (UTC)
Date: Mon, 12 Mar 2018 14:56:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180312175649.GB28578@localhost.localdomain>
References: <1518000027-274608-1-git-send-email-imammedo@redhat.com>
	<1518000027-274608-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518000027-274608-4-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] fixup! cpu: add CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Feb 07, 2018 at 11:40:25AM +0100, Igor Mammedov wrote:
> it will be used for providing to cpu name resolving class for
> parsing cpu model for system and user emulation code.
> 
> Along with change add target to null-machine tests, so
> that when switch to CPU_RESOLVING_TYPE happens,
> it would ensure that null-machine usecase still works.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu> (m68k)
> Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc)
> Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de> (tricore)

Squashing this before sending a new pull request.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/riscv/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index cff02a2857..41e06ac0f9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -46,6 +46,7 @@
 
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
 #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
 
 #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
 #define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
-- 
2.14.3
