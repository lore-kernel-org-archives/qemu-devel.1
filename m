Received: from eggs.gnu.org ([2001:4830:134:3::10]:54596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2O-0008Hn-7n
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2N-0006oe-2U
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:12 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:32 +0100
Message-Id: <20171214171004.25058-15-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 14/46] s390x/tcg: io instructions don't need
 potential_page_fault()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

As we handle the retaddr in all cases properly now, we can drop it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171130162744.25442-10-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 85d0a6c3af..d0859c4bc7 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4008,7 +4008,6 @@ static ExitStatus op_spx(DisasContext *s, DisasOps *o)
 static ExitStatus op_xsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_xsch(cpu_env, regs[1]);
     set_cc_static(s);
     return NO_EXIT;
@@ -4017,7 +4016,6 @@ static ExitStatus op_xsch(DisasContext *s, DisasOps *o)
 static ExitStatus op_csch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_csch(cpu_env, regs[1]);
     set_cc_static(s);
     return NO_EXIT;
@@ -4026,7 +4024,6 @@ static ExitStatus op_csch(DisasContext *s, DisasOps *o)
 static ExitStatus op_hsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_hsch(cpu_env, regs[1]);
     set_cc_static(s);
     return NO_EXIT;
@@ -4035,7 +4032,6 @@ static ExitStatus op_hsch(DisasContext *s, DisasOps *o)
 static ExitStatus op_msch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_msch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return NO_EXIT;
@@ -4044,7 +4040,6 @@ static ExitStatus op_msch(DisasContext *s, DisasOps *o)
 static ExitStatus op_rchp(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_rchp(cpu_env, regs[1]);
     set_cc_static(s);
     return NO_EXIT;
@@ -4053,7 +4048,6 @@ static ExitStatus op_rchp(DisasContext *s, DisasOps *o)
 static ExitStatus op_rsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_rsch(cpu_env, regs[1]);
     set_cc_static(s);
     return NO_EXIT;
@@ -4062,7 +4056,6 @@ static ExitStatus op_rsch(DisasContext *s, DisasOps *o)
 static ExitStatus op_ssch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_ssch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return NO_EXIT;
@@ -4071,7 +4064,6 @@ static ExitStatus op_ssch(DisasContext *s, DisasOps *o)
 static ExitStatus op_stsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_stsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return NO_EXIT;
@@ -4080,7 +4072,6 @@ static ExitStatus op_stsch(DisasContext *s, DisasOps *o)
 static ExitStatus op_tsch(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_tsch(cpu_env, regs[1], o->in2);
     set_cc_static(s);
     return NO_EXIT;
@@ -4089,7 +4080,6 @@ static ExitStatus op_tsch(DisasContext *s, DisasOps *o)
 static ExitStatus op_chsc(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_chsc(cpu_env, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.13.6
