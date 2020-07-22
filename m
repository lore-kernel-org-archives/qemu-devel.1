Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D138C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47567205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtQV/63V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47567205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyEDs-0003GN-IL
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jferlan@redhat.com>)
 id 1jyEDC-0002jy-1J
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:51:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43325
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jferlan@redhat.com>)
 id 1jyED9-0004JW-DN
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595422261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7W7GOOjRPsszcekTc2xW5YKz8bPPe8R40Rmc0xdcOoA=;
 b=XtQV/63V3iIEnh/HillNadYlprzKzcfCj/WPGt+4Q86JIEw9Lo8+RQXsitaUvsCffymSum
 sTx0HJ+nMAbna9kaMP6MjarkKbx3tcbaKkuNmnHjo4ryQj7qNwALAP3/md79KTj8TiVddd
 RCYhi94P5kpdf2/T7shIWczvT4rUBkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-BKip9j7KMJCZTUr_qGvOCQ-1; Wed, 22 Jul 2020 08:49:33 -0400
X-MC-Unique: BKip9j7KMJCZTUr_qGvOCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DEFD8015F3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 12:49:32 +0000 (UTC)
Received: from unknown0050b6a41c42.attlocal.net (ovpn-113-12.phx2.redhat.com
 [10.3.113.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08DEB5C1BB
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 12:49:31 +0000 (UTC)
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: John Ferlan <jferlan@redhat.com>
Subject: Virt Storage/Block meeting minutes - 01-Jul-2020
Message-ID: <b9949b69-5ae8-c54a-5083-7ac1f43a4f5f@redhat.com>
Date: Wed, 22 Jul 2020 08:49:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jferlan@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


<forgot to send these after the last meeting>

Meeting date/time: Jul 01, 13:00 UTC

Previous meetings: http://etherpad.corp.redhat.com/PlatformVirtStorageMeetings
Prior meeting: http://etherpad.corp.redhat.com/PlatformVirtStorageMeetings-2020-Jun-10

Join the meeting:
Bluejeans: https://redhat.bluejeans.com/1471327918/
(phone numbers are available in the website above)
*4 to mute/unmute
IRC: #block-call

Attendees: jferlan, philmd, pkrempa, mreitz, stefanha, eblake

Updates and announcements:
 * FYI - QEMU 5.1 Upstream
   * softfreeze 2020-07-07
   * hardfreeze  2020-07-14
   * release 2020-08-11 or 2020-08-18 
 * FYI - RHEL schedules:
   * 8.x-AV - https://pp.engineering.redhat.com/pp/product/rhel_av/schedule
     * http://batcave.lab.eng.brq.redhat.com/reports/full-rhel8/short_report.html
     * 8.2.1 - Changes require exception+/blocker+
       * GA: Tue 2020-07-28
     * 8.3.0 - Will get rebase of qemu-5.1 and libvirt-6.7
       * Feature Freeze: Tue 2020-09-01
       * Bug Freeze: Mon 2020-09-14
       * Final Freeze: Tue 2020-10-06 
   * 8.3.0
     * Backport from RHEL AV 8.2.1:
       * https://bugzilla.redhat.com/show_bug.cgi?id=1844296
     * Unless High/Urgent, avoid clone from RHEL AV 8.3.0+
   * 7.9 - changes require blocker+
     * GA: Tue 2020-08-11
     * All future changes occur via zstream processing

 * FYI - Layered Products
   * RHV 4.4 will use on RHEL-AV-8.2.x.
     * GA Planned: 2020-08-04
   * OSP
     * OSP 15 and 16.0 are using RHEL-AV-8.1.1
     * OSP 16.1 compose (as of 11-Mar-2020) is using RHEL-AV-8.2
       * GA Planned: June 2020
   * CNV will use RHEL-AV-8.2.x and stay up to date with RHEL-AV in future versions
     * 2.3 GA: 2020-05-04
     * 2.4 GA Planned: 2020-06-24

 * FYI - General QEMU/libvirt Release Rebase schedule: https://docs.google.com/spreadsheets/d/1izPBg1YSeEHDcuy8gtfcbVgHdx_xkRYubHnbe6BkV8c

----------------------------------------------------------------------------------------------------------------------------

Projects:

 * Incremental Backup
   * 8.2.1: https://projects.engineering.redhat.com/browse/RHELPLAN-39267
     * Completed:
       * bz1779904 - RFE: ability to estimate bitmap space utilization for qcow2
       * bz1779893 - RFE: Copy bitmaps with qemu-img convert
       * bz1778593 - Qemu coredump when backup to a existing small size image
       * bz1804593 - RFE: Allow incremental backups with externally-created snapshots
         * Peter generated kbase/docs on usage

     * Moved to 8.3.0
       * bz1780409 - RFE: Add block-dirty-bitmap-generate block job to facilitate bitmap chain recovery
         * Hope to get this completed before qemu-5.1 soft freeze
         * plan for qemu is to get x-block-dirty-bitmap-populate into 5.1 with x- prefix, to allow us the ability to change interface as we experiment with it, since libvirt is not depending on it yet

     * Questions/Discussion over current implementation
       * 

     * RHV progress [nsoffer, eshenitz]
       * not present


   * 8.3.0: https://projects.engineering.redhat.com/browse/RHELPLAN-38611
     * libvirt: [pkrempa]
       * Need bz for libvirt work to utilize qemu block-dirty-bitmap-generate bz1780409 
         * 

       * bz1829829 - backups after disk hotplug
         * refactored some internals which will make fixing this simpler
         * Patches are done but need to be tested prior to sending

       * bz1799011 - bitmaps + live migration
         * 

       * bz1799010 - bitmaps + virDomainBlockPull
         * [jferlan] Previous meeting minutes indicate this is not needed by RHV, so should we close the bz and remove from Epic then?
         * patches are done but need to be tested prior to sending

       * bz1799015 - Enable Incremental Backup by default
         * Update depends on?
         * all of the above :)

     * qemu [eblake, kwolf, mreitz]
       * bz1780409 - RFE: Add block-dirty-bitmap-generate block job to facilitate bitmap chain recovery (eblake)
         * Hope to get this completed before qemu-5.1 soft freeze
         * v3 sent upstream, review had some command suggestions, and need to investigate those options more
           * Considering using the x- prefix before softfreeze to allow for changes

       * bz1790492 - bitmaps + live migration (mreitz)
         * First non-RFC posted: https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg01669.html
         * goal to get this in before 5.1 softfreeze

       * bz1801625 - block-stream job without dirtying bitmaps (kwolf)
         * [jferlan] Previous meeting minutes indicate this may not be necessary, so should we close the bz and remove from Epic then?
         * Will require mreitz series "Deal with filters" to expose the corner case

       * bz1780416 - RFE: qemu-img check --repair should optionally remove any corrupted bitmaps (virt-maint)
         * [Need owner]

   * QEMU Backlog - Need to determine need, owner, and possible release
     * bz1814664 - backup in push mode will actually write ZEROes to target image [eblake]
       * 

     * bz1816692 - when scratch file has no space during pull-mode backup, the backup job will still run, this will produce a inconsistent backup file [virt-maint]
       * 

     * bz1802401 - The actual size of backup image bigger than base image after dd data file in guest [virt-maint]
       * 

     * bz1784266 - Error prompt info when do incremental backup with an invalid "bitmap-mode" [virt-maint]
       * 

----------------------------------------------------------------------------------------------------------------------------

 * Project Cheetah: [stefanha]
   * Cheetah - performance improvements for fast storage in KVM: https://docs.engineering.redhat.com/display/RHELPLAN/Cheetah+-+performance+improvements+for+fast+storage+in+KVM

     * bz1827722 - QEMU multi-queue virtio-blk/scsi by default and associated scalability optimizations that eliminate interprocessor interrupts.
       * Benchmarked guest driver NUMA-awareness but there was no measurable improvement, leaving it for now
       * Found that automatic irq affinity of virtqueue interrupts does not honor NUMA, so completion interrupts may be handled on a CPU in another NUMA node. This is a problem for devices with few interrupts. Not a problem for true multiqueue devices because we want an irq on each CPU anyway.
       * Userspace cannot override irq affinity when the guest driver uses automatic irq affinity, e.g. virtio_blk.ko

     * bz1827756 - virtio-blk io_uring passthrough to provide guests direct access to host storage APIs [sgarzare]
       * Stefano on PTO

     * QEMU nvme [philmd]
       * series posted: "cleanups required to use multiple queues"
         * https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg10136.html
     * Preliminary step required for BZ#1827750
     * Add support for sharing PCI devices between nvme:// block driver instances"

     * qemu-storage-daemon [kwolf]
       * Updates on Coiby Xu's vhost-user-blk server patches
         * Review is moving along, getting closer to merge

       * Upstream: [PATCH v6 00/12] monitor: Optionally run handlers in coroutines
         * https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg08018.html

       * bz1827724 - qemu-storage-daemon SPDK-like polling mode I/O [stefanha]
         * No change/update

     * virtio_blk.ko completion polling [stefanha]
       * Update on extend cpuidle-haltpoll to peek at virtqueues w/ mtosatti
         * No change/update

     * bz1519010 - QEMU multi-queue block layer support [bonzini]
       * Eliminate CPU bottlenecks by spreading I/O across CPUs on the host 
       * No change/update

     * bz1806887 - High IOPS storage performance optimizations [stefanha]
       * Generic BZ tracking upstream changes targeting RHEL-AV-8.3.0 due to a rebase
       * No change/update

----------------------------------------------------------------------------------------------------------------------------

 * virtio-fs [mreitz, slp]
   * Rust virtiofsd implementation - packaging progress/concerns
     * Update to packaging conundrum?
       * Upstream cloud-hypervisor community is moving virtio-fs daemon to separate git repo \o/
       * Contact w/ Don Bayly (Intel Partner Manager)

   * Upstream code to enable on s390x (Marc Hartmayer <mhartmay@linux.ibm.com>)
     * 

   * kubevirt/CNV
     * Initial PR from Vladik: https://github.com/kubevirt/kubevirt/pull/3493

   * kvm.ko async pf for virtio-fs DAX [future work]
     * Making progress but Vivek is concerned that there is no mechanism yet that is suitable for raising faults to the guest

----------------------------------------------------------------------------------------------------------------------------

 * LUKS encryption slot management [mlevitsk, mreitz]
   * Issues with build/test on PULL, Max has reposted upstream with iotest adjustments
   * Going to try to make soft freeze

----------------------------------------------------------------------------------------------------------------------------

 * Project Capybara [areis, jsnow, stefanha]
   * Capybara weekly meeting details: https://docs.google.com/document/d/12N_Ml0_ZFEKgS609sDu7EaaU9ePYBM1QXV52sXVQy8o
   * OpenShift Virtualization Storage presentation (pre-meeting):  https://docs.google.com/presentation/d/1iRBx15NMtWqeLE5QTQAY2W77GDBOnd4jRwDXyzif-hs/edit
   * Various discussion with extended details on capybara-list
     * See Kubernetes CSI (https://github.com/kubernetes-csi) qemu-storage-daemon plugin​
       * If qemu-storage-daemon is a storage provider, can we provide backups, NVMe userspace driver, storage migration, I/O throttling, etc? The answer to many of these is "yes" although we need to fit it into the CSI API.
       * 

----------------------------------------------------------------------------------------------------------------------------

 * virtio-blk vDPA [stefanha]
   * Mellanox looking at VFIO, might not use vDPA

----------------------------------------------------------------------------------------------------------------------------

 * virtio-blk 2.0 [stefanha] - from <virt-devel>
   * Please see discussion on mailing list if you are interested in details

----------------------------------------------------------------------------------------------------------------------------

 * NVMe emulation device maintenance problem
   * Only "include/block/nvme.h" is important for Red Hat
   * Keith - current maintainer - is not very active
   * recent high activity from Samsung and WDC
   * Kevin suggests Klaus from Samsung step in to help

 * -----------------------------------------------------------------------------------------------------------------------

Next meeting will be 22-Jul.  The 08-Jul meeting was canceled

 * <feel free to add more>


