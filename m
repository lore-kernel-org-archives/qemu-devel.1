Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3009DC34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F4042208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 20:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4042208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Vvm-0007jO-6T
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 15:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1j4Vuy-0007D7-AW
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1j4Vux-0002qA-8v
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 15:26:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:13124)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1j4Vux-0002oa-0a; Wed, 19 Feb 2020 15:25:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2020 12:25:56 -0800
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; d="scan'208";a="224618330"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.78.27.169])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 19 Feb 2020 12:25:55 -0800
Subject: Re: [PATCH v1] block/nvme: introduce PMR support from NVMe 1.4 spec
To: qemu-devel@nongnu.org
References: <158207442698.20350.5846437537237258589@a1bbccc8075a>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <e5672095-a9ce-5098-bcfc-e71107b9f1d7@linux.intel.com>
Date: Wed, 19 Feb 2020 13:25:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <158207442698.20350.5846437537237258589@a1bbccc8075a>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: keith.busch@intel.com, kwolf@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 6:07 PM, no-reply@patchew.org wrote:
> === TEST SCRIPT BEGIN ===
> #! /bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-mingw@fedora J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>   CC      hw/display/sii9022.o
>   CC      hw/display/ssd0303.o
> /tmp/qemu-test/src/hw/block/nvme.c: In function 'nvme_pmr_read':
> /tmp/qemu-test/src/hw/block/nvme.c:1342:15: error: implicit declaration of function 'msync'; did you mean 'fsync'? [-Werror=implicit-function-declaration]
>          ret = msync(n->pmrbuf, n->f_pmr_size, MS_SYNC);
>                ^~~~~
>                fsync
> /tmp/qemu-test/src/hw/block/nvme.c:1342:15: error: nested extern declaration of 'msync' [-Werror=nested-externs]
> /tmp/qemu-test/src/hw/block/nvme.c:1342:47: error: 'MS_SYNC' undeclared (first use in this function)
>          ret = msync(n->pmrbuf, n->f_pmr_size, MS_SYNC);
>                                                ^~~~~~~
> /tmp/qemu-test/src/hw/block/nvme.c:1342:47: note: each undeclared identifier is reported only once for each function it appears in
> /tmp/qemu-test/src/hw/block/nvme.c: In function 'nvme_realize':
> /tmp/qemu-test/src/hw/block/nvme.c:1413:21: error: implicit declaration of function 'mmap'; did you mean 'max'? [-Werror=implicit-function-declaration]
>          n->pmrbuf = mmap(NULL, n->f_pmr_size,
>                      ^~~~

This patch seems to fail on cross-compilation for Windows env.
I plan to submit second version of this patch which will conditionally
support PMR for Linux environment only. It should take care of this problem.

Do you see any better fix for that?

