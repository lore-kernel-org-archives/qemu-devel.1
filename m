Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51D9C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EED206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EED206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieDFQ-0003QX-3o
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 02:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ieDEH-0002Fz-GN
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ieDEG-0002jS-3X
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:13:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:5946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ieDEF-0002aC-SM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:13:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Dec 2019 23:13:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; d="scan'208";a="202738801"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga007.jf.intel.com with ESMTP; 08 Dec 2019 23:13:06 -0800
From: Tao Xu <tao3.xu@intel.com>
To: ehabkost@redhat.com,
	pbonzini@redhat.com,
	rth@twiddle.net
Subject: [PATCH v2 0/4] Add extra information to versioned CPU models
Date: Mon,  9 Dec 2019 15:12:59 +0800
Message-Id: <20191209071303.24303-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series of patches will remove MPX from Denverton, remove Remove
monitor from some CPU models. Add additional information for -cpu help
to indicate the changes in this version of CPU model.

The output is as follows:
./x86_64-softmmu/qemu-system-x86_64 -cpu help | grep "\["
x86 Broadwell-v2          Intel Core Processor (Broadwell) [no TSX]                 
x86 Broadwell-v3          Intel Core Processor (Broadwell) [IBRS]                   
x86 Broadwell-v4          Intel Core Processor (Broadwell) [no TSX, IBRS]           
x86 Cascadelake-Server-v2  Intel Xeon Processor (Cascadelake) [ARCH_CAPABILITIES]    
x86 Cascadelake-Server-v3  Intel Xeon Processor (Cascadelake) [ARCH_CAPABILITIES, no TSX]
x86 Denverton-v2          Intel Atom Processor (Denverton) [no MPX, no MONITOR]     
x86 Dhyana-v2             Hygon Dhyana Processor [no MONITOR]                       
x86 EPYC-v2               AMD EPYC Processor [IBPB]                                 
x86 EPYC-v3               AMD EPYC Processor [IBPB, no MONITOR]                     
x86 Haswell-v2            Intel Core Processor (Haswell) [no TSX]                   
x86 Haswell-v3            Intel Core Processor (Haswell) [IBRS]                     
x86 Haswell-v4            Intel Core Processor (Haswell) [no TSX, IBRS]             
x86 Icelake-Client-v2     Intel Core Processor (Icelake) [no TSX]                   
x86 Icelake-Server-v2     Intel Xeon Processor (Icelake) [no TSX]                   
x86 IvyBridge-v2          Intel Xeon E3-12xx v2 (Ivy Bridge) [IBRS]                 
x86 Nehalem-v2            Intel Core i7 9xx (Nehalem Class Core i7) [IBRS]          
x86 Opteron_G3-v2         AMD Opteron 23xx (Gen 3 Class Opteron) [no MONITOR]       
x86 SandyBridge-v2        Intel Xeon E312xx (Sandy Bridge) [IBRS]                   
x86 Skylake-Client-v2     Intel Core Processor (Skylake) [IBRS]                     
x86 Skylake-Client-v3     Intel Core Processor (Skylake) [no TSX, IBRS]             
x86 Skylake-Server-v2     Intel Xeon Processor (Skylake) [IBRS]                     
x86 Skylake-Server-v3     Intel Xeon Processor (Skylake) [no TSX, IBRS]             
x86 Snowridge-v2          Intel Atom Processor (SnowRidge) [no MPX]                 
x86 Snowridge-v3          Intel Atom Processor (SnowRidge) [no MPX, no MONITOR]     
x86 Westmere-v2           Westmere E56xx/L56xx/X56xx (Nehalem-C) [IBRS]

Changes in v2:
    - correct the note of Cascadelake v3 (Xiaoyao)

Tao Xu (4):
  target/i386: Add Denverton-v2 (no MPX) CPU model
  target/i386: Remove monitor from some CPU models
  target/i386: Add new property note to versioned CPU models
  target/i386: Add notes for versioned CPU models

 target/i386/cpu.c | 112 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 27 deletions(-)

-- 
2.20.1


