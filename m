Received: from eggs.gnu.org ([209.51.188.92]:46286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6S7-0008PR-Jv
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6S6-0007KU-IA
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:11 -0400
Received: from smtp4.iitb.ac.in ([103.21.127.18]:35308 helo=smtp1.iitb.ac.in)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
	id 1hD6S6-0007JR-63
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:10 -0400
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 47CA71027500
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 17:29:06 +0530 (IST)
Received: from jeeves.cse.iitb.ac.in (miller.cse.iitb.ac.in [10.129.3.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id AB38A360033
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 17:29:03 +0530 (IST)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Sun,  7 Apr 2019 17:28:38 +0530
Message-Id: <20190407115839.25054-2-skrtbhtngr@gmail.com>
In-Reply-To: <20190407115839.25054-1-skrtbhtngr@gmail.com>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RESEND v2 1/2] hvf: declare hvf_handle_io if
 NEED_CPU_H is defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Paolo Bonzini <pbonzini@redhat.com>

hvf_handle_io needs the poisoned type CPUArchState as its argument.
Declaring it if NEED_CPU_H is defined enables include/sysemu/hvf.h
to be included for common object compilation as well.

Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
---
 include/sysemu/hvf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index aaa51d2c51..7eca3ec7be 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -63,8 +63,12 @@ typedef struct HVFState {
 extern HVFState *hvf_state;
=20
 void hvf_set_phys_mem(MemoryRegionSection *, bool);
+
+#ifdef NEED_CPU_H
 void hvf_handle_io(CPUArchState *, uint16_t, void *,
                   int, int, int);
+#endif
+
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
=20
 /* Disable HVF if |disable| is 1, otherwise, enable it iff it is support=
ed by
--=20
2.20.1
