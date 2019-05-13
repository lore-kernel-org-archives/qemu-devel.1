Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF6C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF0EC2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0EC2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53961 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7EV-0005tZ-4R
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:26:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1hQ7Dg-0005KD-1D
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1hQ7De-0004ik-C1
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:26:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50544
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hQ7De-0004i4-6d
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:26:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4D9HMwU066487
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 05:26:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sf55rt153-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 05:26:00 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
	Mon, 13 May 2019 10:25:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 13 May 2019 10:25:54 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
	[9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4D9PrXa62324818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 13 May 2019 09:25:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 455734C046;
	Mon, 13 May 2019 09:25:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46C4B4C044;
	Mon, 13 May 2019 09:25:52 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 13 May 2019 09:25:52 +0000 (GMT)
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, david@gibson.dropbear.id.au,
	xiaoguangrong.eric@gmail.com, mst@redhat.com
Date: Mon, 13 May 2019 04:25:51 -0500
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051309-0008-0000-0000-000002E60A45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051309-0009-0000-0000-000022529DD2
Message-Id: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-13_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905130067
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [RFC v2 PATCH 0/3] ppc: spapr: virtual NVDIMM support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sbhat@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patchset attempts to implement the virtual NVDIMM for pseries.

PAPR semantics is such that each NVDIMM device is comprising of multiple
SCM(Storage Class Memory) blocks. The hypervisor is expected to prepare the
FDT for the NVDIMM device and send guest a hotplug interrupt with new type 
RTAS_LOG_V6_HP_TYPE_PMEM currently handled by the upstream kernel. In response
to that interrupt, the guest requests the hypervisor to bind each of the SCM
blocks of the NVDIMM device using hcalls. There can be SCM block unbind
requests in case of driver errors or unplug(not supported now) use cases. The
NVDIMM label read/writes are done through hcalls.

There are also new futuristic hcalls added(currently unused in the kernel), for
querying the informations such as binding, logical addresses of the SCM blocks.
The current patchset leaves them unimplemented.

Since each virtual NVDIMM device is divided into multiple SCM blocks, the bind,
unbind, and queries using hcalls on those blocks can come independently. This
doesnt fit well into the qemu device semantics, where the map/unmap are done at
the (whole)device/object level granularity. The patchset uses the existing
NVDIMM class structures for the implementation. The bind/unbind is left to
happen at the object_add/del phase itself instead of at hcalls on-demand.

The guest kernel makes bind/unbind requests for the virtual NVDIMM device at the
region level granularity. Without interleaving, each virtual NVDIMM device is
presented as separate region. There is no way to configure the virtual NVDIMM
interleaving for the guests today. So, there is no way a partial bind/unbind
request can come for the vNVDIMM in a hcall for a subset of SCM blocks of a
virtual NVDIMM. Hence it is safe to do bind/unbind everything during the
object_add/del.

The free device-memory region which is used for memory hotplug are done using
multiple LMBs of size(256MiB) and are expected to be aligned to 256 MiB. As the
SCM blocks are mapped to the same region, the SCM blocks also need to be
aligned to this size for the subsequent memory hotplug to work. The minimum SCM
block size is set to this size for that reason and can be made user configurable
in future if required.

The first patch moves around the existing static function to common area
for using it in the subsequent patches. Second patch adds the FDT entries and
basic device support, the third patch adds the hcalls implementation.

The patches are also available at https://github.com/ShivaprasadGBhat/qemu.git -
pseries-nvdimm branch and can be used with the upstream kernel. ndctl can be
used for configuring the nvdimms inside the guest.

This is how it can be used ..
Add nvdimm=on to the qemu machine argument,
Ex : -machine pseries,nvdimm=on
For coldplug, the device to be added in qemu command line as shown below
-object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
-device nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

For hotplug, the device to be added from monitor as below
object_add memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
device_add nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0

---
v1 : http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg01545.html
Changes from v1:
     - Rebased to upstream, this required required dt_populate implementation
       for nvdimm hotplug support
     - Added uuid option to nvdimm device
     - Removed the memory region sizing down code as suggested by Igor,
       now erroring out if NVDIMM size excluding the label area is not
       aligned to 256MB, so patch 2 from previous series no longer needed.
     - Removed un-implemented hcalls
     - Changed the hcalls to different kinds of checks and return
       different values.
     - Addressed comments for v1

Shivaprasad G Bhat (3):
      mem: make nvdimm_device_list global
      spapr: Add NVDIMM device support
      spapr: Add Hcalls to support PAPR NVDIMM device


 default-configs/ppc64-softmmu.mak |    1 
 hw/acpi/nvdimm.c                  |   27 -----
 hw/mem/Kconfig                    |    2 
 hw/mem/nvdimm.c                   |   70 +++++++++++++
 hw/ppc/spapr.c                    |  202 +++++++++++++++++++++++++++++++++++--
 hw/ppc/spapr_drc.c                |   18 +++
 hw/ppc/spapr_events.c             |    4 +
 hw/ppc/spapr_hcall.c              |  202 +++++++++++++++++++++++++++++++++++++
 include/hw/mem/nvdimm.h           |    8 +
 include/hw/ppc/spapr.h            |   19 +++
 include/hw/ppc/spapr_drc.h        |    9 ++
 11 files changed, 523 insertions(+), 39 deletions(-)

--
Signature


