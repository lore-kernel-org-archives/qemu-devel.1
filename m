Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED28AC2BAEE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A772074E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A772074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAKK-0004U1-1h
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jCAGM-0003bW-6B
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jCAGK-0000qw-PE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:55:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:61869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jCAGK-0007DF-GO; Wed, 11 Mar 2020 18:55:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 15:54:33 -0700
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; d="scan'208";a="236616706"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.78.27.169])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Mar 2020 15:54:32 -0700
Subject: Re: [PATCH RESEND v2] block/nvme: introduce PMR support from NVMe 1.4
 spec
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
 <20200310095147.GC140737@stefanha-x1.localdomain>
 <15b8a77d-50de-2228-a0e6-a461b82f1873@linux.intel.com>
 <CAJSP0QXatOWgicLo5sGt9KA2QupC2qXD2LCdHWKgHFdzgt9pEg@mail.gmail.com>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <12576914-0ef4-efd2-355a-cff3f4eeae69@linux.intel.com>
Date: Wed, 11 Mar 2020 15:54:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXatOWgicLo5sGt9KA2QupC2qXD2LCdHWKgHFdzgt9pEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Zhang Yi <yi.z.zhang@linux.intel.com>, "He,
 Junyan" <junyan.he@intel.com>, kbusch@kernel.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/11/20 2:20 AM, Stefan Hajnoczi wrote:
> Please try:
> 
>   $ git grep pmem
> 
> backends/hostmem-file.c is the backend that can be used and the
> pmem_persist() API can be used to flush writes.

I've reworked this patch into hostmem-file type of backend.
From simple tests in virtual machine: writing to PMR region
and then reading from it after VM power cycle I have observed that
there is no persistency.

I guess that persistent behavior can be achieved if memory backend file
resides on actual persistent memory in VMM. I haven't found mechanism to
persist memory backend file when it resides in the file system on block
storage. My original mmap + msync based solution worked well there.
I believe that main problem with mmap was with "ifdef _WIN32" that made it 
platform specific and w/o it patchew CI complained. 
Is there a way that I could rework mmap + msync solution so it would fit
into qemu design?


