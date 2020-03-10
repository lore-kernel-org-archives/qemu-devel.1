Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6162C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A726215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 20:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A726215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBlCS-0005I2-Ni
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 16:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jBlBl-0004nl-GR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jBlBk-0003rW-B3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 16:09:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:27966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jBlBk-0003mF-2c; Tue, 10 Mar 2020 16:09:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Mar 2020 13:09:13 -0700
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; d="scan'208";a="245808240"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.78.27.169])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 10 Mar 2020 13:09:12 -0700
Subject: Re: [PATCH RESEND v2] block/nvme: introduce PMR support from NVMe 1.4
 spec
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
 <20200310095147.GC140737@stefanha-x1.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <15b8a77d-50de-2228-a0e6-a461b82f1873@linux.intel.com>
Date: Tue, 10 Mar 2020 13:09:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310095147.GC140737@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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

On 3/10/20 2:51 AM, Stefan Hajnoczi wrote:
> On Fri, Mar 06, 2020 at 03:38:53PM -0700, Andrzej Jakowski wrote:
>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>> index d28335cbf3..ff7e74d765 100644
>> --- a/hw/block/nvme.c
>> +++ b/hw/block/nvme.c
>> @@ -19,10 +19,14 @@
>>   *      -drive file=<file>,if=none,id=<drive_id>
>>   *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
>>   *              cmb_size_mb=<cmb_size_mb[optional]>, \
>> + *              [pmr_file=<pmr_file_path>,] \
>>   *              num_queues=<N[optional]>
>>   *
>>   * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
>>   * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
>> + *
>> + * Either cmb or pmr - due to limitation in avaialbe BAR indexes.
> 
> s/avaialbe/available/
> 
>> + * pmr_file file needs to be preallocated and power of two in size.
> 
> Why does it need to be preallocated?

PMR file is mmaped into address space. If memory accesses are made outside of 
file then SIGBUS signal is raised. Preallocation requirement was introduced
to prevent this situation.

> 
>>   */
>>  
>>  #include "qemu/osdep.h"
>> @@ -1141,6 +1145,28 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
>>          NVME_GUEST_ERR(nvme_ub_mmiowr_cmbsz_readonly,
>>                         "invalid write to read only CMBSZ, ignored");
>>          return;
>> +#ifndef _WIN32
> 
> This ifdef is a hint that the layering is not right.  QEMU device models
> usually only implement the "frontend" device registers, interrupts, and
> request processing logic.  The platform-specific host "backend"
> (mmapping files, sending network packets, audio/graphics APIs, etc) is
> implemented separately.

Agree. I couldn't find QEMU backend ensuring persistence - thus decided to
go with mmap.

> 
> In the previous version I asked NVDIMM folks to review this patch and
> suggest how to use the same HostMemoryBackend (see
> include/sysemu/hostmem.h) that is already used for NVDIMM emulation.
> 
> That seems cleaner than baking platform-specific memory mapped file I/O
> into hw/block/nvme.c, and it will also add a few features that this
> patch does not have.
> 
> If NVDIMM folks don't respond to this email, would you be able to
> research backends/hostmem*.c and try to integrate it?  If you feel lost
> I can help but it will require me to spend time investigating how that
> stuff works again :).
> 

Yes I can research this topic. Does HostMemoryBacked provide persistence?


