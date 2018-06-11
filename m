Received: from eggs.gnu.org ([2001:4830:134:3::10]:56001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQYG-0006uH-WD
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQYD-0000Zk-Mt
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:24:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQYD-0000Zc-Gr
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:24:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:23:55 -0300
Message-Id: <20180611172355.12067-4-ehabkost@redhat.com>
In-Reply-To: <20180611172355.12067-1-ehabkost@redhat.com>
References: <20180611172355.12067-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] pc: Remove PC_COMPAT_2_12 from 3.0
 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Juan Quintela <quintela@redhat.com>

commit f548222c added PC_COMPAT_2_12 to the 3.0 PC machine-types.
I believe this happened during manual conflict resolution when
applying the patch.

Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
Cc: Juan Quintela <quintela@redhat.com>
Fixes: f548222c24342ca74689de7794f9006b43f86a54
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180608192940.19548-1-ehabkost@redhat.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_piix.c | 1 -
 hw/i386/pc_q35.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3d81136065..b4c5b03274 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -430,7 +430,6 @@ static void pc_i440fx_3_0_machine_options(MachineClass *m)
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
 DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b60cbb9266..83d6d75efa 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -312,7 +312,6 @@ static void pc_q35_3_0_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
 DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
-- 
2.18.0.rc1.1.g3f1ff2140
