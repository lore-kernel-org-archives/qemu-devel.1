Received: from eggs.gnu.org ([2001:4830:134:3::10]:54244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvQ-0001gb-Rs
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvP-00034d-SC
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvP-000347-Ho
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:14 -0300
Message-Id: <20180625222524.382-3-ehabkost@redhat.com>
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/12] i386: improve alignment of CPU model
 listing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Since the addition of the -IBRS CPU model variants, the descriptions
shown by '-cpu help' are not well aligned, as several model names
overflow the space allowed. Right aligning the CPU model names is also
not attractive, because it obscures the common name prefixes of many
models. The CPU model name field needs to be 4 characters larger, and
be left aligned instead.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180606165527.17365-2-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 86fb1a4fb8..e1d7157d8c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3380,7 +3380,7 @@ static void x86_cpu_list_entry(gpointer data, gpoin=
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
2.18.0.rc1.1.g3f1ff2140
