Received: from eggs.gnu.org ([2001:4830:134:3::10]:51409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG7A-0008UM-6M
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG79-0005KX-3p
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:16 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:51448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG78-0005KK-Vs
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:15 -0500
Received: by mail-qk0-x242.google.com with SMTP id n66so1605155qki.8
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 18:29:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  7 Nov 2017 23:28:27 -0300
Message-Id: <20171108022828.7242-6-f4bug@amsat.org>
In-Reply-To: <20171108022828.7242-1-f4bug@amsat.org>
References: <20171108022828.7242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 5/6] hw/i386: deprecate the pc-0.10 and
 pc-0.11 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Both are deprecated since 2.9.0

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/pc_piix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f79d5cb694..c462b702ff 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -941,6 +941,7 @@ static void pc_i440fx_0_11_machine_options(MachineClass *m)
     pc_i440fx_0_12_machine_options(m);
     m->hw_version = "0.11";
     SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
+    m->deprecated_reason = "Too old";
 }
 
 DEFINE_I440FX_MACHINE(v0_11, "pc-0.11", pc_compat_0_13,
@@ -976,6 +977,7 @@ static void pc_i440fx_0_10_machine_options(MachineClass *m)
     pc_i440fx_0_11_machine_options(m);
     m->hw_version = "0.10";
     SET_MACHINE_COMPAT(m, PC_COMPAT_0_10);
+    m->deprecated_reason = "Too old";
 }
 
 DEFINE_I440FX_MACHINE(v0_10, "pc-0.10", pc_compat_0_13,
-- 
2.15.0
