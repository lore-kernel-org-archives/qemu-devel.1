Received: from eggs.gnu.org ([2001:4830:134:3::10]:49911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGJu-00013C-R1
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGJq-00066v-6q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:22:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47499
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIGJq-00065G-04
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:22:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56FJ785136119
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 11:22:52 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awv1tkax9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 11:22:52 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 6 Jun 2017 16:22:50 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 06 Jun 2017 17:22:48 +0200
In-Reply-To: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149676256806.31274.17021734547869850899.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 1/3] target/ppc: pass const pointer to
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/kvm.c     |    4 ++--
 target/ppc/kvm_ppc.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 51249ce79e55..88817620766c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -478,7 +478,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     }
 }
 
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 {
     Object *mem_obj = object_resolve_path(obj_path, NULL);
     char *mempath = object_property_get_str(mem_obj, "mem-path", NULL);
@@ -499,7 +499,7 @@ static inline void kvm_fixup_page_sizes(PowerPCCPU *cpu)
 {
 }
 
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 {
     return true;
 }
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f48243d13ffc..fd72d6b05a98 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -64,7 +64,7 @@ int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
 
-bool kvmppc_is_mem_backend_page_size_ok(char *obj_path);
+bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
 
 #else
 
