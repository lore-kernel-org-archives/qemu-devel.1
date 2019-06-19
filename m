Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71F3C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FD720B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FD720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36432 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXPU-0001vt-Iq
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43423)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hdXDz-0006LL-6b
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hdXDx-0000o8-A0
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hdXDw-0000f2-QI
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:49:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 908AD88319;
 Wed, 19 Jun 2019 09:49:32 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-148.sin2.redhat.com
 [10.67.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FA1E1001DCB;
 Wed, 19 Jun 2019 09:49:11 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 15:19:00 +0530
Message-Id: <20190619094907.10131-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 19 Jun 2019 09:49:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/7] Qemu virtio pmem device
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
Cc: kwolf@redhat.com, aarcange@redhat.com, cohuck@redhat.com,
 xiaoguangrong.eric@gmail.com, mst@redhat.com, pagupta@redhat.com,
 riel@surriel.com, david@redhat.com, armbru@redhat.com, ehabkost@redhat.com,
 lcapitulino@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, dan.j.williams@intel.com, nilal@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 This patch series has implementation for "virtio pmem"
 device. "virtio pmem" is persistent memory(nvdimm) device in 
 guest which allows to bypass the guest page cache. This
 also implements a VIRTIO based asynchronous flush mechanism.  
 Details of project idea for 'virtio pmem' flushing interface
 is shared [2] & [3].

 Sharing Qemu device emulation in this patchset. Tested with 
 guest kernel driver [1]. This series is based on David's 
 memory device refactoring [5] work with modified version of
 my initial virtio pmem [4] series.

 Usage: 
 ./qemu -name test -machine pc -m 8G,slots=240,maxmem=20G 
 -object memory-backend-file,id=mem1,share,mem-path=test.img,
  size=4G,share
 -device virtio-pmem-pci,memdev=mem1,id=nv1

 (qemu) info memory-devices
  Memory device [virtio-pmem]: "nv1"
  memaddr: 0x240000000
  size: 4294967296
  memdev: /objects/mem1

 Implementation is divided into two parts:
 New virtio pmem guest driver and qemu code changes for new 
 virtio pmem paravirtualized device. In this series we are
 sharing Qemu device emulation.

1. Guest virtio-pmem kernel driver
---------------------------------
   - Reads persistent memory range from paravirt device and 
     registers with 'nvdimm_bus'.  
   - 'nvdimm/pmem' driver uses this information to allocate 
     persistent memory region and setup filesystem operations 
     to the allocated memory. 
   - virtio pmem driver implements asynchronous flushing 
     interface to flush from guest to host.

2. Qemu virtio-pmem device
---------------------------------
   - Creates virtio pmem device and exposes a memory range to 
     KVM guest. 
   - At host side this is file backed memory which acts as 
     persistent memory. 
   - Qemu side flush uses aio thread pool API's and virtio 
     for asynchronous guest multi request handling. 

 Virtio-pmem security implications and suggested countermeasures:
 ---------------------------------------------------------------

 In previous posting of kernel driver, there was discussion [7]
 on possible implications of page cache side channel attacks with 
 virtio pmem. After thorough analysis of details of known side 
 channel attacks, below are the suggestions:

 - Depends entirely on how host backing image file is mapped 
   into guest address space. 

 - virtio-pmem device emulation, by default shared mapping is used
   to map host backing file. It is recommended to use separate
   backing file at host side for every guest. This will prevent
   any possibility of executing common code from multiple guests
   and any chance of inferring guest local data based based on 
   execution time.

 - If backing file is required to be shared among multiple guests 
   it is recommended to don't support host page cache eviction 
   commands from the guest driver. This will avoid any possibility
   of inferring guest local data or host data from another guest. 

 - Proposed device specification [6] for virtio-pmem device with 
   details of possible security implications and suggested 
   countermeasures for device emulation.

Changes from PATCH v1:
 - Change proposed version from qemu 4.0 to 4.1 - Eric
 - Remove virtio queue_add from unrealize function - Cornelia  

[1] https://lkml.org/lkml/2019/6/12/624
[2] https://www.spinics.net/lists/kvm/msg149761.html
[3] https://www.spinics.net/lists/kvm/msg153095.html  
[4] https://marc.info/?l=linux-kernel&m=153572228719237&w=2 
[5] https://marc.info/?l=qemu-devel&m=153555721901824&w=2
[6] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
[7] https://lkml.org/lkml/2019/1/9/1191

 Pankaj Gupta (3):
  virtio-pmem: add virtio device
  virtio-pmem: sync linux headers
  virtio-pci: proxy for virtio-pmem

 David Hildenbrand (4):
  virtio-pci: Allow to specify additional interfaces for the base type
  hmp: Handle virtio-pmem when printing memory device infos
  numa: Handle virtio-pmem in NUMA stats
  pc: Support for virtio-pmem-pci

 hmp.c                                        |   27 ++-
 hw/i386/Kconfig                              |    1 
 hw/i386/pc.c                                 |   72 ++++++++++
 hw/virtio/Kconfig                            |   10 +
 hw/virtio/Makefile.objs                      |    2 
 hw/virtio/virtio-pci.c                       |    1 
 hw/virtio/virtio-pci.h                       |    1 
 hw/virtio/virtio-pmem-pci.c                  |  131 ++++++++++++++++++
 hw/virtio/virtio-pmem-pci.h                  |   34 ++++
 hw/virtio/virtio-pmem.c                      |  189 +++++++++++++++++++++++++++
 include/hw/pci/pci.h                         |    1 
 include/hw/virtio/virtio-pmem.h              |   49 +++++++
 include/standard-headers/linux/virtio_ids.h  |    1 
 include/standard-headers/linux/virtio_pmem.h |   35 +++++
 numa.c                                       |   24 +--
 qapi/misc.json                               |   28 +++-
 16 files changed, 580 insertions(+), 26 deletions(-)
----

