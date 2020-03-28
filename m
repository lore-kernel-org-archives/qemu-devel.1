Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F0FC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B635C206F1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 03:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B635C206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI1ne-0003uI-Sw
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 23:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenyi.qiang@intel.com>) id 1jI1ml-0002hl-CE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenyi.qiang@intel.com>) id 1jI1mj-0003eP-JN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:05:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:6615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chenyi.qiang@intel.com>)
 id 1jI1mj-0003En-AA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 23:05:21 -0400
IronPort-SDR: pujxCqThIwKQaE3ME0jOzNQ3gvKn88qk+/6LGe70bXnXyFm6mbC0WVimlndY1Yd0Y92GEfSPlX
 JKf2uwEfAhZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 20:05:17 -0700
IronPort-SDR: wrZSxUg3lfJ7ygvtpM+NVm6vODj9S0XnNL/o/4NlasmXO/mxerDvd/1n5f2dWSXpJEApwPQv72
 zYpX6QyantCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; d="scan'208";a="421319409"
Received: from chenyi-pc.sh.intel.com ([10.239.159.72])
 by orsmga005.jf.intel.com with ESMTP; 27 Mar 2020 20:05:15 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v2 0/4] modify CPU model info
Date: Sat, 28 Mar 2020 11:06:21 +0800
Message-Id: <20200328030625.16428-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.136
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
Icelake-Server CPU models. In Icelake-Server CPU model, it also lacks
sha_ni, avx512ifma, rdpid and fsrm. The model numbers of Icelake-Client
and Icelake-Server need to be fixed.

Changes in v2:
	- add missing features as a new version of CPU model
	- add the support of FSRM

Chenyi Qiang (4):
  target/i386: add missing vmx features for several CPU models
  target/i386: add fast short REP MOV support
  target/i386: add the missing features for Icelake-Server CPU model
  target/i386: modify Icelake-Client and Icelake-Server CPU model number

 target/i386/cpu.c | 22 ++++++++++++++++++----
 target/i386/cpu.h |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.17.1


