Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43FC742A2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 01:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4B5214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 01:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4B5214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlkbN-000799-Kx
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 21:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60970)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hlkb6-0006Jw-4Q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 21:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hlkb4-0003Fa-U4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 21:43:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hlkb4-0003Ep-JU
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 21:43:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6C1gDrJ140247
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 21:43:37 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tpdxt4y0r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 21:43:37 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Fri, 12 Jul 2019 02:21:02 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 12 Jul 2019 02:20:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6C1K1Bm36962596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2019 01:20:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EE8DB206B;
 Fri, 12 Jul 2019 01:20:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C20BB2066;
 Fri, 12 Jul 2019 01:20:01 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jul 2019 01:20:01 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 20:19:33 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19071201-0064-0000-0000-000003FA8FFF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011412; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230877; UDB=6.00648363; IPR=6.01012152; 
 MB=3.00027683; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-12 01:21:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071201-0065-0000-0000-00003E3A2A2E
Message-Id: <20190712011934.29863-2-mdroth@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-11_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120020
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 1/2] docs/specs: initial spec summary for
 Ultravisor-related hcalls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now this only covers hcalls relating to TPM communication since
it's the only one particularly important from a QEMU perspective atm,
but others can be added here where it makes sense.

The full specification for all hcalls/ucalls will eventually be made
available in the public/OpenPower version of the PAPR specification.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 docs/specs/ppc-spapr-uv-hcalls.txt | 74 ++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 docs/specs/ppc-spapr-uv-hcalls.txt

diff --git a/docs/specs/ppc-spapr-uv-hcalls.txt b/docs/specs/ppc-spapr-uv-hcalls.txt
new file mode 100644
index 0000000000..0278f89190
--- /dev/null
+++ b/docs/specs/ppc-spapr-uv-hcalls.txt
@@ -0,0 +1,74 @@
+On PPC64 systems supporting Protected Execution Facility (PEF), system
+memory can be placed in a secured region where only an "ultravisor"
+running in firmware can provide to access it. pseries guests on such
+systems can communicate with the ultravisor (via ultracalls) to switch to a
+secure VM mode (SVM) where the guest's memory is relocated to this secured
+region, making its memory inaccessible to normal processes/guests running on
+the host.
+
+The various ultracalls/hypercalls relating to SVM mode are currently
+only documented internally, but are planned for direct inclusion into the
+public OpenPOWER version of the PAPR specification (LoPAPR/LoPAR). An internal
+ACR has been filed to reserve a hypercall number range specific to this
+use-case to avoid any future conflicts with the internally-maintained PAPR
+specification. This document summarizes some of these details as they relate
+to QEMU.
+
+== hypercalls needed by the ultravisor ==
+
+Switching to SVM mode involves a number of hcalls issued by the ultravisor
+to the hypervisor to orchestrate the movement of guest memory to secure
+memory and various other aspects SVM mode. The below documents the hcalls
+relevant to QEMU.
+
+- H_TPM_COMM (0xef10)
+
+  For TPM_COMM_OP_EXECUTE operation:
+    Send a request to a TPM and receive a response, opening a new TPM session
+    if one has not already been opened.
+
+  For TPM_COMM_OP_CLOSE_SESSION operation:
+    Close the existing TPM session, if any.
+
+  Arguments:
+
+    r3 : H_TPM_COMM (0xef10)
+    r4 : TPM operation, one of:
+         TPM_COMM_OP_EXECUTE (0x1)
+         TPM_COMM_OP_CLOSE_SESSION (0x2)
+    r5 : in_buffer, guest physical address of buffer containing the request
+         - Caller may use the same address for both request and response
+    r6 : in_size, size of the in buffer, must
+         - Must be less than or equal to 4KB
+    r7 : out_buffer, guest physical address of buffer to store the response
+         - Caller may use the same address for both request and response
+    r8 : out_size, size of the out buffer
+         - Must be at least 4KB, as this is the maximum request/response size
+           supported by most TPM implementations, including the TPM Resource
+           Manager in the linux kernel.
+
+  Return values:
+
+    r3 : H_Success    request processed successfully
+         H_PARAMETER  invalid TPM operation
+         H_P2         in_buffer is invalid
+         H_P3         in_size is invalid
+         H_P4         out_buffer is invalid
+         H_P5         out_size is invalid
+         H_RESOURCE   TPM is unavailable
+    r4 : For TPM_COMM_OP_EXECUTE, the size of the response will be stored here
+         upon success.
+
+  Use-case/notes:
+
+    SVM filesystems are encrypted using a symmetric key. This key is then
+    wrapped/encrypted using the public key of a trusted system which has the
+    private key stored in the system's TPM. An Ultravisor will use this
+    hcall to unwrap/unseal the symmetric key using the system's TPM device
+    or a TPM Resource Manager associated with the device.
+
+    The Ultravisor sets up a separate session key with the TPM in advance
+    during host system boot. All sensitive in and out values will be
+    encrypted using the session key. Though the hypervisor will see the 'in'
+    and 'out' buffers in raw form, any sensitive contents will generally be
+    encrypted using this session key.
-- 
2.17.1


