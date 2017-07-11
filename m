Received: from eggs.gnu.org ([2001:4830:134:3::10]:45721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dUv96-0005Gm-D6
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dUv95-0006Ne-6Z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:24:08 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dUv94-0006MM-Vo
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:24:07 -0400
Received: by mail-lf0-x244.google.com with SMTP id g21so14492944lfk.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 06:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20170711103011.32631-1-marcandre.lureau@redhat.com>
	<149977714973.27.4735882964481215123@5d477a5b5989>
In-Reply-To: <149977714973.27.4735882964481215123@5d477a5b5989>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 11 Jul 2017 13:23:54 +0000
Message-ID: <CAJ+F1C+56=YZdasG6Z2sVj12RG4QrJ863=BSx1jN5hOcFCvQ-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/7] KASLR kernel dump support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com, lersek@redhat.com

Hi

On Tue, Jul 11, 2017 at 2:47 PM <no-reply@patchew.org> wrote:

> Hi,
>
> This series failed build test on s390x host. Please find the details belo=
w.
>
>
 I'll resend the series after I get a few more replies/acked/reviewed-by.

The fix should be:

Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Tue Jul 11 15:14:13 2017 +0200

    stubs: add vmcoreinfo_get() stub

    Common dump code may call vmcoreinfo_get() which is not available on
    all targets.

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

diff --git a/stubs/vmcoreinfo.c b/stubs/vmcoreinfo.c
new file mode 100644
index 0000000000..a994153832
--- /dev/null
+++ b/stubs/vmcoreinfo.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+
+#include "hw/acpi/vmcoreinfo.h"
+
+bool vmcoreinfo_get(VMCoreInfoState *vis, uint64_t *paddr, uint32_t *size,
+                    Error **errp)
+{
+    return false;
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f5b47bfd74..3bedc73252 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -36,6 +36,7 @@ stub-obj-y +=3D qmp_pc_dimm_device_list.o
 stub-obj-y +=3D target-monitor-defs.o
 stub-obj-y +=3D target-get-monitor-def.o
 stub-obj-y +=3D pc_madt_cpu_entry.o
+stub-obj-y +=3D vmcoreinfo.o


--=20
Marc-Andr=C3=A9 Lureau
