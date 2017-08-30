Received: from eggs.gnu.org ([2001:4830:134:3::10]:57712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6HD-0003sk-Rp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6H9-0005vL-PK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6H9-0005ud-JB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:35 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:42 +0200
Message-Id: <20170830165252.13421-35-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 34/44] target/s390x: move s390_do_cpu_reset() to
 diag.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Only used in that file. Also drop the comment, not really needed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-13-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h  | 7 -------
 target/s390x/diag.c | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8300cb219d..9cdce6c6bd 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -490,13 +490,6 @@ static inline hwaddr decode_basedisp_s(CPUS390XState=
 *env, uint32_t ipb,
 /* Base/displacement are at the same locations. */
 #define decode_basedisp_rs decode_basedisp_s
=20
-/* helper functions for run_on_cpu() */
-static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
-
-    scc->cpu_reset(cs);
-}
 static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data =
arg)
 {
     cpu_reset(cs);
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 10ac845bcd..1847cdb0ca 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -39,6 +39,13 @@ static int modified_clear_reset(S390CPU *cpu)
     return 0;
 }
=20
+static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
+
+    scc->cpu_reset(cs);
+}
+
 static int load_normal_reset(S390CPU *cpu)
 {
     S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
--=20
2.13.5
