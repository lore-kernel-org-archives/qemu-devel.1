Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72892C4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5062B20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5062B20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLvY-0002KR-HJ
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jFLuA-0000vQ-D9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jFLu9-0006wd-5r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:57:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:38241)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jFLu8-0003L6-Tc; Fri, 20 Mar 2020 13:57:57 -0400
IronPort-SDR: lkXXAsQfU8hKbQKIILurs2x/MAdkEDEas7ALw+I1tv4jJnPaPKkZTqz23dYsEXhHCM4QRzN+rX
 v9Y0AquErJMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 10:48:12 -0700
IronPort-SDR: b0iti4Ld/cYvOtRlvl0xw1ATAMnmSQfo1yhYBynSRHh121acHxShUObXxMuqYKvps20eIfLDGR
 CYbH4n/b/1Ww==
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="237287137"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.255.231.83])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 10:48:11 -0700
Subject: Re: [PATCH v3] block/nvme: introduce PMR support from NVMe 1.4 spec
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200318200303.11322-1-andrzej.jakowski@linux.intel.com>
 <20200320154505.GD138042@stefanha-x1.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <74c9c6e8-9407-a0fb-0070-b8758b7a46eb@linux.intel.com>
Date: Fri, 20 Mar 2020 10:48:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320154505.GD138042@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.115
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
Cc: kwolf@redhat.com, haozhong.zhang@intel.com, qemu-block@nongnu.org,
 dgilbert@redhat.com, qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com,
 junyan.he@intel.com, kbusch@kernel.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 8:45 AM, Stefan Hajnoczi wrote:
> Please use qemu_ram_writeback() so that pmem_persist() and qemu_msync()
> are used as appropriate.

Thx!
qemu_ram_writeback() doesn't return any status. How can I know that actual msync succeds?

Also qemu_ram_writeback() requires me to include #include "exec/ram_addr.h". 
After including it when I compile code I'm getting following error:

In file included from hw/block/nvme.c:49:
/root/sources/pmr/qemu/include/exec/ram_addr.h:23:10: fatal error: cpu.h: No such file or directory
   23 | #include "cpu.h"
      |          ^~~~~~~
compilation terminated.
make: *** [/root/sources/pmr/qemu/rules.mak:69: hw/block/nvme.o] Error 1

Why this is happening and what should be changed.

