Received: from eggs.gnu.org ([2001:4830:134:3::10]:44565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXSfS-0001nj-HR
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXSfP-0006RO-9k
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:08:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eXSfP-0006QC-27
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:08:15 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 Jan 2018 15:08:11 +0100
Message-Id: <20180105140811.5303-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] improved phrasing regarding Meltdown
 and live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, simon.leinen@switch.ch

---
 _posts/2018-01-04-spectre.md | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/_posts/2018-01-04-spectre.md b/_posts/2018-01-04-spectre.md
index 5bbc7ed..ca11324 100644
--- a/_posts/2018-01-04-spectre.md
+++ b/_posts/2018-01-04-spectre.md
@@ -13,11 +13,13 @@ named _Meltdown_ and _Spectre_, affect in one way or another almost
 all processors that perform out-of-order execution, including x86 (from
 Intel and AMD), POWER, s390 and ARM processors.
 
-No microcode updates are required to block the _Meltdown_ attack; it is
-enough to update the guest operating system to a version that separates
-the user and kernel address spaces (known as _page table isolation_ for
-the Linux kernel).  Therefore, this post will focus on _Spectre_, and
-especially on [CVE-2017-5715](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-5715).
+No microcode updates are required to block the _Meltdown_ attack.  In
+addition, the _Meltdown_ flaw does not allow a malicious guest to read the
+contents of hypervisor memory.  Fixing it only requires that the operating
+system separates the user and kernel address spaces (known as _page table
+isolation_ for the Linux kernel), which can be done separately on the host
+and the guests.  Therefore, this post will focus on _Spectre_, and especially
+on [CVE-2017-5715](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-5715).
 
 Fixing or mitigating _Spectre_ in general, and CVE-2017-5715 in particular,
 requires cooperation between the processor and the operating system kernel or
@@ -52,9 +54,10 @@ host from malicious guests__.  Nevertheless, updates will be posted to the
 qemu-devel mailing list in the next few days, and a 2.11.1 patch release
 will be released with the fix.
 
-Once updates are provided, __live migration will not be enough to protect
-guest kernel from guest userspace__.  Because the virtual CPU has to be
-changed to one with the new CPUID bits, the guest will have to be restarted.
+Once updates are provided, __live migration to an updated version of
+QEMU will not be enough to protect guest kernel from guest userspace__.
+Because the virtual CPU has to be changed to one with the new CPUID bits,
+the guest will have to be restarted.
 
 As of today, the QEMU project is not aware of whether similar changes will
 be required for non-x86 processors.  If so, they will also posted to the
@@ -67,4 +70,5 @@ Zero](https://googleprojectzero.blogspot.it/2018/01/reading-privileged-memory-wi
 posts on the topic, as well as the [Spectre and Meltdown FAQ](https://meltdownattack.com/#faq).
 
 __5 Jan 2018__: clarified the level of protection provided by the host kernel
-update; added a note on live migration.
+update; added a note on live migration; clarified the impact of Meltdown on
+virtualization hosts
-- 
2.14.3
