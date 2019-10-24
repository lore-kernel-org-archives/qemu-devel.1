Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119C6C47E49
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C205520856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ia2MZiia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C205520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZ9x-0007zf-Ho
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ83-0004kS-FY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ81-0003gY-HH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:09:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ81-0003eg-7a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:09:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94Nwj116354;
 Thu, 24 Oct 2019 09:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=gfz5AkVe0kXHxioqlFteHzt4z+dmV3WQW/Xu3Icr4XQ=;
 b=Ia2MZiiaESDZew25B6xgcFRx6VLtPgJyrhzEZ431Ss7ULCDJU4lf72cnt6V5qDxjUlGi
 fd6VESgCBD6ZDO5yNvM4hte4S6G+z7iP6NnFb6oW5zqeezOJqXjaGuz/biTw05r7ukvz
 0hpucbM5NbFGq4pij3t23yhjD9L3pPG9QF1Qv2coyRIH+c/H0vlP9kEG4xSNdSwT9zCj
 TmH/VH1LnLTyscnKO19VKvFL1Ps6Sg6RRA8HYLyTYEzYSikawXWiYkQ/t3/gIdSDj47w
 95j0yIOxInHhusH7g7Mcmui0NsBHXEDh+PDZ5XOd+y+7IkZ1CQkaUhcmO5uJgeKSvnDP fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2vqswttdv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:09:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98l6n076083;
 Thu, 24 Oct 2019 09:09:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2vtjkj2ve6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:09:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O99fZi001589;
 Thu, 24 Oct 2019 09:09:41 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:09:40 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 00/49] Initial support of multi-process qemu
Date: Thu, 24 Oct 2019 05:08:41 -0400
Message-Id: <cover.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Started with the presentation in October 2017 made by Marc-Andre (Red Hat)
and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum 2018,
the multi-process project is now a prototype and presented in this patchset.
John & Elena will present the status of this project in KVM Forum 2019.

This first series enables the emulation of lsi53c895a in a separate process.

We posted the Proof Of Concept patches [2] before the BoF session in 2018.
Subsequently, we posted RFC v1 [3], RFC v2 [4] and RFC v3 [5] of this series. 

We want to present version 4 of this series, which incorporates the feedback
we received for v3 & adds support for live migrating the remote process.

Following people contributed to this patchset:

John G Johnson <john.g.johnson@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Kanth Ghatraju <kanth.ghatraju@oracle.com>

For full concept writeup about QEMU disaggregation refer to
docs/devel/qemu-multiprocess.rst. Please refer to 
docs/qemu-multiprocess.txt for usage information.

We are planning on making the following improvements in the future:
 - Performance improvements
 - Libvirt support
 - Enforcement of security policies
 - blockdev support

We welcome all your ideas, concerns, and questions for this patchset.

Thank you!

[1]: http://events17.linuxfoundation.org/sites/events/files/slides/KVM%20FORUM%20multi-process.pdf
[1]: https://www.youtube.com/watch?v=Kq1-coHh7lg
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
[3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg602285.html
[4]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg624877.html
[5]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg642000.html

Elena Ufimtseva (22):
  multi-process: add a command line option for debug file
  multi-process: introduce proxy object
  mutli-process: build remote command line args
  multi-process: configure remote side devices
  multi-process: add qdev_proxy_add to create proxy devices
  multi-process: remote: add setup_devices and setup_drive msg
    processing
  multi-process: remote: use fd for socket from parent process
  multi-process: remote: add create_done condition
  multi-process: add processing of remote drive and device command line
  multi-process: refractor vl.c code to re-use in remote
  multi-process: add remote option
  multi-process: add remote options parser
  multi-process: add parse_cmdline in remote process
  multi-process: send heartbeat messages to remote
  multi-process: handle heartbeat messages in remote process
  multi-process/mon: choose HMP commands based on target
  multi-process/mig: Load VMSD in the proxy object
  multi-process/mig: refactor runstate_check into common file
  multi-process/mig: Synchronize runstate of remote process
  multi-process/mig: Restore the VMSD in remote process
  multi-process: Enable support for multiple devices in remote
  multi-process: add configure and usage information

Jagannathan Raman (26):
  multi-process: memory: alloc RAM from file at offset
  multi-process: util: Add qemu_thread_cancel() to cancel running thread
  multi-process: Add stub functions to facilate build of multi-process
  multi-process: Add config option for multi-process QEMU
  multi-process: build system for remote device process
  multi-process: define mpqemu-link object
  multi-process: add functions to synchronize proxy and remote endpoints
  multi-process: setup PCI host bridge for remote device
  multi-process: setup a machine object for remote device process
  multi-process: setup memory manager for remote device
  multi-process: remote process initialization
  multi-process: PCI BAR read/write handling for proxy & remote
    endpoints
  multi-process: Add LSI device proxy object
  multi-process: Synchronize remote memory
  multi-process: create IOHUB object to handle irq
  multi-process: Introduce build flags to separate remote process code
  multi-process: Use separate MMIO communication channel
  multi-process: perform device reset in the remote process
  multi-process/mon: stub functions to enable QMP module for remote
    process
  multi-process/mon: enable QMP module support in the remote process
  multi-process/mon: Refactor monitor/chardev functions out of vl.c
  multi-process/mon: Initialize QMP module for remote processes
  multi-process: prevent duplicate memory initialization in remote
  multi-process/mig: build migration module in the remote process
  multi-process/mig: Enable VMSD save in the Proxy object
  multi-process/mig: Send VMSD of remote to the Proxy object

John G Johnson (1):
  multi-process: add the concept description to
    docs/devel/qemu-multiprocess

 Makefile                            |    2 +
 Makefile.objs                       |   39 ++
 Makefile.target                     |   94 ++-
 accel/stubs/kvm-stub.c              |    5 +
 accel/stubs/tcg-stub.c              |  106 ++++
 backends/Makefile.objs              |    2 +
 block/Makefile.objs                 |    2 +
 chardev/char.c                      |   14 +
 configure                           |   15 +
 docs/devel/index.rst                |    1 +
 docs/devel/qemu-multiprocess.rst    | 1102 +++++++++++++++++++++++++++++++++++
 docs/qemu-multiprocess.txt          |   86 +++
 exec.c                              |   14 +-
 hmp-commands-info.hx                |   10 +
 hmp-commands.hx                     |   25 +-
 hw/Makefile.objs                    |    9 +
 hw/block/Makefile.objs              |    2 +
 hw/core/Makefile.objs               |   17 +
 hw/nvram/Makefile.objs              |    2 +
 hw/pci/Makefile.objs                |    4 +
 hw/proxy/Makefile.objs              |    1 +
 hw/proxy/memory-sync.c              |  226 +++++++
 hw/proxy/proxy-lsi53c895a.c         |   97 +++
 hw/proxy/qemu-proxy.c               |  807 +++++++++++++++++++++++++
 hw/scsi/Makefile.objs               |    2 +
 include/chardev/char.h              |    1 +
 include/exec/address-spaces.h       |    2 +
 include/exec/ram_addr.h             |    2 +-
 include/hw/pci/pci_ids.h            |    3 +
 include/hw/proxy/memory-sync.h      |   51 ++
 include/hw/proxy/proxy-lsi53c895a.h |   42 ++
 include/hw/proxy/qemu-proxy.h       |  125 ++++
 include/hw/qdev-core.h              |    2 +
 include/io/mpqemu-link.h            |  214 +++++++
 include/monitor/monitor.h           |    2 +
 include/monitor/qdev.h              |   25 +
 include/qemu-common.h               |    8 +
 include/qemu/log.h                  |    1 +
 include/qemu/mmap-alloc.h           |    3 +-
 include/qemu/thread.h               |    1 +
 include/remote/iohub.h              |   63 ++
 include/remote/machine.h            |   48 ++
 include/remote/memory.h             |   34 ++
 include/remote/pcihost.h            |   59 ++
 include/sysemu/runstate.h           |    3 +
 io/Makefile.objs                    |    2 +
 io/mpqemu-link.c                    |  351 +++++++++++
 memory.c                            |    2 +-
 migration/Makefile.objs             |   12 +
 migration/savevm.c                  |   63 ++
 migration/savevm.h                  |    3 +
 monitor/Makefile.objs               |    3 +
 monitor/misc.c                      |   84 +--
 monitor/monitor-internal.h          |   38 ++
 monitor/monitor.c                   |   83 ++-
 net/Makefile.objs                   |    2 +
 qapi/Makefile.objs                  |    2 +
 qdev-monitor.c                      |  270 ++++++++-
 qemu-options.hx                     |   21 +
 qom/Makefile.objs                   |    4 +
 remote/Makefile.objs                |    6 +
 remote/iohub.c                      |  159 +++++
 remote/machine.c                    |  133 +++++
 remote/memory.c                     |   99 ++++
 remote/pcihost.c                    |   85 +++
 remote/remote-main.c                |  633 ++++++++++++++++++++
 remote/remote-opts.c                |  131 +++++
 remote/remote-opts.h                |   31 +
 replay/Makefile.objs                |    2 +-
 rules.mak                           |    2 +-
 runstate.c                          |   41 ++
 scripts/hxtool                      |   44 +-
 stubs/audio.c                       |   12 +
 stubs/gdbstub.c                     |   21 +
 stubs/machine-init-done.c           |    4 +
 stubs/migration.c                   |  211 +++++++
 stubs/monitor.c                     |   72 +++
 stubs/net-stub.c                    |  121 ++++
 stubs/qapi-misc.c                   |   43 ++
 stubs/qapi-target.c                 |   49 ++
 stubs/replay.c                      |   26 +
 stubs/runstate-check.c              |    3 +
 stubs/ui-stub.c                     |  130 +++++
 stubs/vl-stub.c                     |  193 ++++++
 stubs/vmstate.c                     |   20 +
 stubs/xen-mapcache.c                |   22 +
 ui/Makefile.objs                    |    2 +
 util/log.c                          |    2 +
 util/mmap-alloc.c                   |    7 +-
 util/oslib-posix.c                  |    2 +-
 util/qemu-thread-posix.c            |   10 +
 vl-parse.c                          |  161 +++++
 vl.c                                |  310 ++++------
 vl.h                                |   54 ++
 94 files changed, 6908 insertions(+), 246 deletions(-)
 create mode 100644 docs/devel/qemu-multiprocess.rst
 create mode 100644 docs/qemu-multiprocess.txt
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 hw/proxy/proxy-lsi53c895a.c
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/memory-sync.h
 create mode 100644 include/hw/proxy/proxy-lsi53c895a.h
 create mode 100644 include/hw/proxy/qemu-proxy.h
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 include/remote/iohub.h
 create mode 100644 include/remote/machine.h
 create mode 100644 include/remote/memory.h
 create mode 100644 include/remote/pcihost.h
 create mode 100644 io/mpqemu-link.c
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/iohub.c
 create mode 100644 remote/machine.c
 create mode 100644 remote/memory.c
 create mode 100644 remote/pcihost.c
 create mode 100644 remote/remote-main.c
 create mode 100644 remote/remote-opts.c
 create mode 100644 remote/remote-opts.h
 create mode 100644 runstate.c
 mode change 100644 => 100755 scripts/hxtool
 create mode 100644 stubs/audio.c
 create mode 100644 stubs/migration.c
 create mode 100644 stubs/net-stub.c
 create mode 100644 stubs/qapi-misc.c
 create mode 100644 stubs/qapi-target.c
 create mode 100644 stubs/ui-stub.c
 create mode 100644 stubs/vl-stub.c
 create mode 100644 stubs/xen-mapcache.c
 create mode 100644 vl-parse.c
 create mode 100644 vl.h

-- 
1.8.3.1


