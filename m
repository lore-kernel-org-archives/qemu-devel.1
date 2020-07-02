Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE711C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A304D207E8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A304D207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqs7d-0001BC-UC
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 01:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jqs6t-0000Dg-78
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:50:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jqs6q-0005UR-Uh
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:50:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0625XTk7002032
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2020 01:50:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3212at1hku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 01:50:05 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0625mHb6078746
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2020 01:50:05 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3212at1hke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2020 01:50:05 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0625iwoK018589;
 Thu, 2 Jul 2020 05:50:04 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02wdc.us.ibm.com with ESMTP id 31wwr95y0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2020 05:50:04 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0625o35u45941058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2020 05:50:03 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 391DB6A058;
 Thu,  2 Jul 2020 05:50:03 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B20386A057;
 Thu,  2 Jul 2020 05:50:02 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.160.82.151])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2020 05:50:02 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Add support for Control-Flow Integrity
Date: Thu,  2 Jul 2020 01:49:46 -0400
Message-Id: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-02_02:2020-07-01,
 2020-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007020041
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 01:50:06
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

LLVM/Clang, starting from v3.9, supports runtime checks for forward-edge
Control-Flow Integrity (CFI).

CFI on indirect function calls can have a huge impact in enhancing QEMU
security, by significantly limiting one of the most used attack vectors
for VM Escape. Attacks demonstrated in [1],[2] and [3] will, at some
point, change a function pointer in a QEMU data structure.

At high level, LLVM's implementation relies on compile-time information
to create a range of consecutive trampolines for "compatible functions".
At runtime, if the pointer is not in the valid range, it is assumed that
the control flow was hijacked, and the process is terminated with an
"Illegal Instruction" exception.

CAVEATS:

1) For this CFI check to work, the code must always respect the function
signature when using function pointer. While this is generally true
in QEMU, there are a few instances where pointers are handled as
generic void* from the caller. Since this is a common approach, Clang
offer a flag to relax pointer checks and consider all pointer types
to be compatible.

2) Since CFI relies on compile-time information, it requires using
link-time optimization (LTO) to support CFI across compilation units.
This adds a requirement for the gold linker, and LLVM's versions of
static libraries tools (ar, ranlib, nm).

3) CFI checks cannot be performed on shared libraries (given that functions
are not known at compile time). This means that indirect function calls
will fail if the function pointer belong to a shared library.
This does not seem to be a big issue for a standard QEMU deployment today,
but QEMU modules won't be able to work when CFI is enabled.
There is a way to allow shared library pointers, but it is experimental
in LLVM, requires some work and reduces performance and security. For
these reasons, I think it's best to start with this version, and discuss
an extension for modules later.

4) CFI cannot be fully applied to TCG. The purpose of TCG is to transform
code on-the-fly from one ISA to another. In doing so, binary blobs of
executable code are created and called with function pointers.
Since the code did not exist at compile time, runtime CFI checks find such
functions illegal. To allow the code to keep running, CFI checks are not
performed in the core function of TCG/TCI, and in the code that
implements TCG plugins.
This does not affect QEMU when executed with KVM, and all the device
emulation code is always protected, even when using TCG.

5) Most of the logic to enable CFI goes in the configure, since it's
just a matter of checking for dependencies and incompatible options.
However, I had to disable CFI checks for a few TCG functions.
This can only be done through a blacklist file. I added a file in the
root of QEMU, called cfi-blacklist.txt for such purpose. I am open to
suggestions on where the file should go, and I am willing to become the
maintainer of it, if deemed necessary.

PERFORMANCE:

Enabling CFI creates a larger binary, which may be an issue in some use
cases. However, the increase is not exceptionally large. On my Ubuntu
system, with default options, I see an increase of stripped size from
14MiB to 15.3MiB when enabling CFI with Clang v9.

There is also a possible performance issue, since for every indirect
function call, and additional address check is performed, followed by
an additional indirect call to the trampoline function.
However, especially in the case of KVM-based virtualization, the impact
should be minimal, since indirect function pointers should be used mostly
for device emulation.

I used Kata Container's metrics tests since that is a simple,
reproducible set of tests to stress storage and network between VMs,
and run a Lifecycle test to measure VM startup times under a specific
workload. A full report is available here [4].

The difference between LLVM with and without CFI is generally low.
Sometimes CFI is actually offering better performance, which may be
explained by having a different binary layout because of LTO.
Lifecycle and network do not seem to be affected much. With storage,
the situation is a bit more variable, but the oscillations seem to be
more related to the benchmark variability than the CFI overhead.

I also run a quick check-acceptance on full system VMs with and without CFI,
the results are at [4] and show comparable results, with CFI slightly
outperforming the default binary produced by LLVM.

----

[1] Mehdi Talbi and Paul Fariello. VM escape - QEMU Case Study
[2] Nelson Elhage. Virtunoid: Breaking out of KVM
[3] Marco Grassi and Kira. Vulnerability Discovery and Exploitation
of Virtualization Solutions for Cloud Computing and Desktops
[4] https://github.com/dbuono/QEMU-CFI-Performance

Daniele Buono (2):
  check-block: enable iotests with cfi-icall
  configure: add support for Control-Flow Integrity

 cfi-blacklist.txt    |  27 +++++++
 configure            | 177 +++++++++++++++++++++++++++++++++++++++++++
 tests/check-block.sh |  18 +++--
 3 files changed, 215 insertions(+), 7 deletions(-)
 create mode 100644 cfi-blacklist.txt

-- 
2.26.2


