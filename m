Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A6C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 02:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736E0222BD
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 02:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736E0222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDJGP-0001ce-GU
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 22:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iDJFM-0000QD-9d
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 22:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iDJFJ-000868-F8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 22:11:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:8123)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iDJFJ-0007zX-7n
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 22:11:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 19:10:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,549,1559545200"; d="scan'208";a="340608093"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga004.jf.intel.com with ESMTP; 25 Sep 2019 19:10:57 -0700
From: Tao Xu <tao3.xu@intel.com>
To: ehabkost@redhat.com, sgarzare@redhat.com, philmd@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Subject: [PATCH v5 0/2] target/i386: cpu.h macros clean up
Date: Thu, 26 Sep 2019 10:10:53 +0800
Message-Id: <20190926021055.6970-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some comments, clean up comments over 80 chars per line. There
is an extra line in comment of CPUID_8000_0008_EBX_WBNOINVD, remove
the extra enter and spaces.

Drop the duplicated definition of cpuid AVX512_VBMI macro and rename it
as CPUID_7_0_ECX_AVX512_VBMI. Rename CPUID_7_0_ECX_VBMI2
as CPUID_7_0_ECX_AVX512_VBMI2.

Changelog:
v5:
    - correct commit messages. (Suggested by Stefano Garzarella)
v4:
    - rename CPUID_7_0_ECX_VBMI2 as CPUID_7_0_ECX_AVX512_VBMI2.
      (Suggested by Stefano Garzarella)
v3:
    - split the patch into 2 patches. (Suggested by Stefano Garzarella
      and Eduardo Habkost)
v2:
    - correct the comments over 80 chars per line. (Suggested by
      Philippe Mathieu-Daudé)

Tao Xu (2):
  target/i386: clean up comments over 80 chars per line
  target/i386: drop the duplicated definition of cpuid AVX512_VBMI macro

 target/i386/cpu.c           |   8 +-
 target/i386/cpu.h           | 163 +++++++++++++++++++++++-------------
 target/i386/hvf/x86_cpuid.c |   2 +-
 3 files changed, 111 insertions(+), 62 deletions(-)

-- 
2.20.1


