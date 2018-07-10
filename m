Received: from eggs.gnu.org ([2001:4830:134:3::10]:54747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fcmWt-0003mW-IH
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fcmWq-0007eR-H0
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:53:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fcmWq-0007dh-6x
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:53:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6A6naEh006762
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 02:53:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k4jpkw4b3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 02:53:38 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 10 Jul 2018 07:53:35 +0100
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-6-git-send-email-jjherne@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 10 Jul 2018 08:53:31 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-6-git-send-email-jjherne@linux.ibm.com>
Content-Language: en-US
Message-Id: <2c9a3595-6afa-1a03-413d-1632cad979cc@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 05/15] s390-bios: Factor finding boot device
 out of virtio code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com


On 07/05/2018 07:25 PM, Jason J. Herne wrote:
[...]
> -    IPL_assert(found, "No virtio device found");
Can you also change the boot-serial testcase:

this seems to work:


diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 952a2e7ead..b03b55d182 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -96,7 +96,7 @@ static testdef_t tests[] = {
     { "sparc", "SS-4", "", "MB86904" },
     { "sparc", "SS-600MP", "", "TMS390Z55" },
     { "sparc64", "sun4u", "", "UltraSPARC" },
-    { "s390x", "s390-ccw-virtio", "", "virtio device" },
+    { "s390x", "s390-ccw-virtio", "", "device" },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
     { "microblaze", "petalogix-s3adsp1800", "", "TT",
       sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
