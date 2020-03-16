Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CD1C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5755420658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5755420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtyb-0004qB-Fg
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jDtFz-00054R-Tg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jDtFy-0005dn-0K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:10:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:50526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jDtFx-0005JZ-Mb; Mon, 16 Mar 2020 13:10:25 -0400
IronPort-SDR: hp3m2bFfjv92uWZF4q6prC3UUaGe2lv/Kp4YFv7tF8wAxdNKrEYJitI2UA4e09ijMIRqRcJkJk
 TKhk1/LyhgFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2020 10:10:18 -0700
IronPort-SDR: IzrfkbEgizgpCDO9UBbXRz7KNaYtNqhPX3Vo+bwzpNan0QSqz4eSAw2QVvpS1Z+1miiJDVTJmu
 N25jqJQx7KdQ==
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; d="scan'208";a="417222311"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.251.138.8])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2020 10:10:17 -0700
Subject: Re: [PATCH RESEND v2] block/nvme: introduce PMR support from NVMe 1.4
 spec
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Klaus Birkelund Jensen <its@irrelevant.dk>
References: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
 <20200310095147.GC140737@stefanha-x1.localdomain>
 <15b8a77d-50de-2228-a0e6-a461b82f1873@linux.intel.com>
 <CAJSP0QXatOWgicLo5sGt9KA2QupC2qXD2LCdHWKgHFdzgt9pEg@mail.gmail.com>
 <12576914-0ef4-efd2-355a-cff3f4eeae69@linux.intel.com>
 <20200312060827.gjddwgmevyptsmpl@apples.localdomain>
 <20200316113216.GB449975@stefanha-x1.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <cf3833cc-fbd1-9930-fee1-ed9b26647f1c@linux.intel.com>
Date: Mon, 16 Mar 2020 10:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316113216.GB449975@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.126
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

On 3/16/20 4:32 AM, Stefan Hajnoczi wrote:
> On Wed, Mar 11, 2020 at 11:08:27PM -0700, Klaus Birkelund Jensen wrote:
>> On Mar 11 15:54, Andrzej Jakowski wrote:
>>> On 3/11/20 2:20 AM, Stefan Hajnoczi wrote:
>>>> Please try:
>>>>
>>>>   $ git grep pmem
>>>>
>>>> backends/hostmem-file.c is the backend that can be used and the
>>>> pmem_persist() API can be used to flush writes.
>>> I've reworked this patch into hostmem-file type of backend.
>>> From simple tests in virtual machine: writing to PMR region
>>> and then reading from it after VM power cycle I have observed that
>>> there is no persistency.
> Sounds like an integration bug.  QEMU's NVDIMM emulation uses
> HostMemoryBackend and file contents survive guest reboot.
> 
> If you would like help debugging this, please post a link to the code
> and the command-line that you are using.
> 

Code is posted here
https://github.com/AndrzejJakowski/qemu/commit/3a7762a1d13ff1543d1da430748eb24e38faab6f

QEMU command line:

# below are just relevant pieces of configuration, other stuff omitted
# tried different setting (e.g. pmem=on and pmem=off)

./x86_64-softmmu/qemu-system-x86_64 ... \
-object memory-backend-file,id=mem1,share=off,pmem=on,mem-path=../nvme_pmr.bin,size=$((1*1024*1024)) \
-drive file=../nvme.bin,format=raw,if=none,id=nvme_emulated \
-device nvme,drive=nvme_emulated,serial="test serial",pmrdev=mem1 

In VM:
My persisent memory region is exposed PCI BAR
Region 2: Memory at fe000000 (64-bit, prefetchable) [size=1M]

So I perform reads/writes from/to following adress 0xfe000000 (decimal 4261412864)

dd if=test.bin of=/dev/mem bs=1 count=30 seek=4261412864
dd if=/dev/mem of=test1.bin bs=1 count=30 skip=4261412864

On VMM I didn't observe that backing file has been updated and after power cycling VM 
I see old junk when reading PMR region.

Also from include/qemu/pmem.h it looks like pmem_persist() will cause qemu to exit 
if libpmem is not installed:

#ifndef QEMU_PMEM_H
#define QEMU_PMEM_H

#ifdef CONFIG_LIBPMEM
#include <libpmem.h>
#else  /* !CONFIG_LIBPMEM */

static inline void *
pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
{
    /* If 'pmem' option is 'on', we should always have libpmem support,
       or qemu will report a error and exit, never come here. */
    g_assert_not_reached();
    return NULL;
}

static inline void
pmem_persist(const void *addr, size_t len)
{
    g_assert_not_reached();
}

#endif /* CONFIG_LIBPMEM */

#endif /* QEMU_PMEM_H */ 

