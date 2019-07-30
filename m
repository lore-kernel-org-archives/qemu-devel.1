Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F040FC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C517D20665
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C517D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsOFj-0005g7-3f
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 05:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hang.yuan@linux.intel.com>) id 1hsOEw-0004qQ-BT
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hang.yuan@linux.intel.com>) id 1hsOEu-0006Gw-0i
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:16:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:7912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hang.yuan@linux.intel.com>)
 id 1hsOEt-0006Ec-Mo
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:16:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jul 2019 02:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,326,1559545200"; d="scan'208";a="370890713"
Received: from henry-optiplex-7050.bj.intel.com (HELO [10.238.157.79])
 ([10.238.157.79])
 by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2019 02:16:03 -0700
From: Hang Yuan <hang.yuan@linux.intel.com>
To: qemu-devel@nongnu.org
Message-ID: <0c127d4a-ea95-8566-5392-a0f17c871cec@linux.intel.com>
Date: Tue, 30 Jul 2019 17:05:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] x86 VMCS guest interruptibility state save/load
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
Cc: "yi.y.sun@intel.com;colin.xu"@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello all,

When I read QEMU and KVM codes on saving/loading snapshot, I don't find 
the interruptibility state in x86 VMCS structure is saved and loaded in 
QEMU though KVM supports getting/setting this field from/into VMCS. (No 
"env.interrupt.shadow" in QEMU vmstate_x86_cpu.fields.) I understand it 
may cause guest-state error if this field is not restored but other 
registers or VMCS fields are restored. Do you think it's a valid issue?

Thanks,
Henry

