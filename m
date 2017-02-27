Received: from eggs.gnu.org ([2001:4830:134:3::10]:49685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRBK-00042s-SD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ciRBG-0003db-V2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:42:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42791
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ciRBG-0003dG-Nu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:41:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RJdGhI137589
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:56 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vs23kru6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:55 -0500
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 27 Feb 2017 16:41:54 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.18.232.42])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 3A9F61DC0054
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 14:41:52 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v1RJfop536372608
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:50 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v1RJfod8006512
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:41:50 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 16:41:32 -0300
In-Reply-To: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1488224492-20316-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1488224492-20316-6-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 5/5] risugen_ppc64: Remove unused code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com

Because we don't support custom fpsrc value yet it's better to remove
that code.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 risugen_ppc64.pm | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index 46ab7b1..4f7c709 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -404,10 +404,6 @@ sub write_test_code($)
     print "Generating code using patterns: @keys...\n";
     progress_start(78, $numinsns);
 
-    #if ($fp_enabled) {
-    #    write_set_fpscr($fpscr);
-    #}
-
     if (grep { defined($insn_details{$_}->{blocks}->{"memory"}) } @keys) {
         write_memblock_setup();
     }
-- 
2.7.4
