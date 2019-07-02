Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2280C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FAE2089C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FAE2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEXs-0005ct-Po
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57758)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hiEVD-0003zr-Ho
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hiEVC-0007gN-2Y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:51:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:27257)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hiEVB-0007A5-Nq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:51:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jul 2019 01:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,442,1557212400"; d="scan'208";a="184453392"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga001.fm.intel.com with ESMTP; 02 Jul 2019 01:49:56 -0700
Date: Tue, 2 Jul 2019 16:49:34 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190702084934.GA25987@richard>
References: <20190619094907.10131-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619094907.10131-1-pagupta@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Qemu virtio pmem device
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: kwolf@redhat.com, aarcange@redhat.com, nilal@redhat.com,
 xiaoguangrong.eric@gmail.com, mst@redhat.com, rth@twiddle.net,
 cohuck@redhat.com, david@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com,
 riel@surriel.com, lcapitulino@redhat.com, dan.j.williams@intel.com,
 dgilbert@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 03:19:00PM +0530, Pankaj Gupta wrote:
> This patch series has implementation for "virtio pmem"
> device. "virtio pmem" is persistent memory(nvdimm) device in 
> guest which allows to bypass the guest page cache. This
> also implements a VIRTIO based asynchronous flush mechanism.  
> Details of project idea for 'virtio pmem' flushing interface
> is shared [2] & [3].
>
> Sharing Qemu device emulation in this patchset. Tested with 
> guest kernel driver [1]. This series is based on David's 
> memory device refactoring [5] work with modified version of
> my initial virtio pmem [4] series.
>
> Usage: 
> ./qemu -name test -machine pc -m 8G,slots=240,maxmem=20G 
> -object memory-backend-file,id=mem1,share,mem-path=test.img,
>  size=4G,share
> -device virtio-pmem-pci,memdev=mem1,id=nv1
>

Hi, Pankaj

I tried this series with v14 kernel driver, while getting some error on using
this. Not sure this is my error configuration.

The qemu command line is:

    -object memory-backend-file,id=mem1,share=on,mem-path=/dev/dax0.0,size=1G,align=2M 
    -device virtio-pmem-pci,memdev=mem1,id=nv1

The guest boots up and I can see /dev/pmem0 device. But when I want to
partition this device, I got the error:

    # parted /dev/pmem0 mklabel gpt
    Warning: Error fsyncing/closing /dev/pmem0: Input/output error

Also I see an error when running "ndctl list":

    libndctl: __sysfs_device_parse: ndctl0: add_dev() failed

Would you mind letting me know which part I am wrong?

> (qemu) info memory-devices
>  Memory device [virtio-pmem]: "nv1"
>  memaddr: 0x240000000
>  size: 4294967296
>  memdev: /objects/mem1
>
> Implementation is divided into two parts:
> New virtio pmem guest driver and qemu code changes for new 
> virtio pmem paravirtualized device. In this series we are
> sharing Qemu device emulation.
>
>1. Guest virtio-pmem kernel driver
>---------------------------------
>   - Reads persistent memory range from paravirt device and 
>     registers with 'nvdimm_bus'.  
>   - 'nvdimm/pmem' driver uses this information to allocate 
>     persistent memory region and setup filesystem operations 
>     to the allocated memory. 
>   - virtio pmem driver implements asynchronous flushing 
>     interface to flush from guest to host.
>
>2. Qemu virtio-pmem device
>---------------------------------
>   - Creates virtio pmem device and exposes a memory range to 
>     KVM guest. 
>   - At host side this is file backed memory which acts as 
>     persistent memory. 
>   - Qemu side flush uses aio thread pool API's and virtio 
>     for asynchronous guest multi request handling. 
>
> Virtio-pmem security implications and suggested countermeasures:
> ---------------------------------------------------------------
>
> In previous posting of kernel driver, there was discussion [7]
> on possible implications of page cache side channel attacks with 
> virtio pmem. After thorough analysis of details of known side 
> channel attacks, below are the suggestions:
>
> - Depends entirely on how host backing image file is mapped 
>   into guest address space. 
>
> - virtio-pmem device emulation, by default shared mapping is used
>   to map host backing file. It is recommended to use separate
>   backing file at host side for every guest. This will prevent
>   any possibility of executing common code from multiple guests
>   and any chance of inferring guest local data based based on 
>   execution time.
>
> - If backing file is required to be shared among multiple guests 
>   it is recommended to don't support host page cache eviction 
>   commands from the guest driver. This will avoid any possibility
>   of inferring guest local data or host data from another guest. 
>
> - Proposed device specification [6] for virtio-pmem device with 
>   details of possible security implications and suggested 
>   countermeasures for device emulation.
>
>Changes from PATCH v1:
> - Change proposed version from qemu 4.0 to 4.1 - Eric
> - Remove virtio queue_add from unrealize function - Cornelia  
>
>[1] https://lkml.org/lkml/2019/6/12/624
>[2] https://www.spinics.net/lists/kvm/msg149761.html
>[3] https://www.spinics.net/lists/kvm/msg153095.html  
>[4] https://marc.info/?l=linux-kernel&m=153572228719237&w=2 
>[5] https://marc.info/?l=qemu-devel&m=153555721901824&w=2
>[6] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
>[7] https://lkml.org/lkml/2019/1/9/1191
>
> Pankaj Gupta (3):
>  virtio-pmem: add virtio device
>  virtio-pmem: sync linux headers
>  virtio-pci: proxy for virtio-pmem
>
> David Hildenbrand (4):
>  virtio-pci: Allow to specify additional interfaces for the base type
>  hmp: Handle virtio-pmem when printing memory device infos
>  numa: Handle virtio-pmem in NUMA stats
>  pc: Support for virtio-pmem-pci
>
> hmp.c                                        |   27 ++-
> hw/i386/Kconfig                              |    1 
> hw/i386/pc.c                                 |   72 ++++++++++
> hw/virtio/Kconfig                            |   10 +
> hw/virtio/Makefile.objs                      |    2 
> hw/virtio/virtio-pci.c                       |    1 
> hw/virtio/virtio-pci.h                       |    1 
> hw/virtio/virtio-pmem-pci.c                  |  131 ++++++++++++++++++
> hw/virtio/virtio-pmem-pci.h                  |   34 ++++
> hw/virtio/virtio-pmem.c                      |  189 +++++++++++++++++++++++++++
> include/hw/pci/pci.h                         |    1 
> include/hw/virtio/virtio-pmem.h              |   49 +++++++
> include/standard-headers/linux/virtio_ids.h  |    1 
> include/standard-headers/linux/virtio_pmem.h |   35 +++++
> numa.c                                       |   24 +--
> qapi/misc.json                               |   28 +++-
> 16 files changed, 580 insertions(+), 26 deletions(-)
>----

-- 
Wei Yang
Help you, Help me

