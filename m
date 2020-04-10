Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB6C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 06:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6685B2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 06:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6685B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMnGl-0000eG-Iu
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 02:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenyi.qiang@intel.com>) id 1jMnFb-0007HN-1j
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 02:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenyi.qiang@intel.com>) id 1jMnFZ-0007CN-Ec
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 02:34:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:42751)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chenyi.qiang@intel.com>)
 id 1jMnFZ-00079l-6s
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 02:34:49 -0400
IronPort-SDR: Vpmc5vvRkyttxEGS6muNL7hnyjmuRexyVJFVeKyRIJ4vNYAOZ8tKrSQPP+lsMFzqo3mri5ucMG
 S6fIWBlRCwuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 23:34:39 -0700
IronPort-SDR: Ldt3E0A4b8sPN0It9l5AtCJrQbNhOF+OPSKWC+fUxWZuIPsnb5U6/qXVAUkCoZ33Nz4w4jNWfH
 F9SZq9W5rHqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; d="scan'208";a="425800255"
Received: from chenyi-pc.sh.intel.com ([10.239.159.72])
 by orsmga005.jf.intel.com with ESMTP; 09 Apr 2020 23:34:37 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v3 0/4] modify CPU model info
Date: Fri, 10 Apr 2020 14:35:51 +0800
Message-Id: <20200410063555.2309-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the missing VMX features in Skylake-Server, Cascadelake-Server and
Icelake-Server CPU models. In Icelake-Server CPU model, it lacks sha_ni,
avx512ifma, rdpid and fsrm. The model number of Icelake-Server also needs
to be fixed.

The modification on Icelake-Client CPU model will be gathered and sent in
anothor patch set.

Changes in v3:
	- remove the modification on Icelake-Client model number
	- change the missing features of Icelake-Server from v3 to v4

Changes in v2:
	- add missing features as a new version of CPU model
	- add the support of FSRM
	- add New CPUID of FSRM and RDPID in Icelake-Server CPU model

Chenyi Qiang (4):
  target/i386: add missing vmx features for several CPU models
  target/i386: add fast short REP MOV support
  target/i386: add the missing features for Icelake-Server CPU model
  target/i386: modify Icelake-Server CPU model number

 target/i386/cpu.c | 20 +++++++++++++++++---
 target/i386/cpu.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.17.1


