Received: from eggs.gnu.org ([209.51.188.92]:44160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCJsT-0001C2-Lp
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCJsS-0002Br-K7
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:07:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45570
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hCJsS-0002Aa-CM
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:07:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3586dEw031738
	for <qemu-devel@nongnu.org>; Fri, 5 Apr 2019 04:07:07 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rp2yygnvh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 04:06:46 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 5 Apr 2019 09:05:24 +0100
From: Greg Kurz <groug@kaod.org>
Date: Fri, 05 Apr 2019 10:05:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 1/2] target/ppc/trace-events: Fix trivial typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/trace-events |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index 3858f97dff54..ed4d57c6d9c1 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -1,5 +1,5 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # kvm.c
-kvm_failed_spr_set(int str, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
-kvm_failed_spr_get(int str, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
+kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
+kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
