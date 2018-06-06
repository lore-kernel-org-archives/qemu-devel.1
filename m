Received: from eggs.gnu.org ([2001:4830:134:3::10]:39182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQbig-0004bv-9y
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQbic-0003we-Tu
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:55:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQbic-0003wO-N9
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:55:30 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  6 Jun 2018 17:55:25 +0100
Message-Id: <20180606165527.17365-2-berrange@redhat.com>
In-Reply-To: <20180606165527.17365-1-berrange@redhat.com>
References: <20180606165527.17365-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] i386: improve alignment of CPU model
 listing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Since the addition of the -IBRS CPU model variants, the descriptions
shown by '-cpu help' are not well aligned, as several model names
overflow the space allowed. Right aligning the CPU model names is also
not attractive, because it obscures the common name prefixes of many
models. The CPU model name field needs to be 4 characters larger, and
be left aligned instead.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 94260412e2..aa4d9949b4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3206,7 +3206,7 @@ static void x86_cpu_list_entry(gpointer data, gpoin=
ter user_data)
         desc =3D cc->cpu_def->model_id;
     }
=20
-    (*s->cpu_fprintf)(s->file, "x86 %16s  %-48s\n",
+    (*s->cpu_fprintf)(s->file, "x86 %-20s  %-48s\n",
                       name, desc);
     g_free(name);
 }
--=20
2.17.0
