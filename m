Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D9C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB59A222C2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J0FqSJot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB59A222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ko4-00017t-UQ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kly-0005qp-IE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Klw-0002q2-FR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Klw-0002oH-5s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqdVt017760;
 Mon, 24 Feb 2020 20:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=7UjjuP2FmuYTT4iXis61TQAn6g0dDfgnNX5xcejwkxw=;
 b=J0FqSJotdsGB0iM67K3lHah4+V2MdIrj7pjxiqQ3SLe6OEz+BZAKa9ghbSFVu2kfgBCY
 jYCYz2n/Ely+XaBLiMWX/cQYjOo2Uf66cnmAq1afGYqrDOjfLd6TUXoDFPHeEA5sMcb+
 PhjmoXXE/EoICDd2QUwz7FG44lKBl9gebHvljvIuwRGCN5i4oigt/8PwQcjYvtBMj0S6
 9Ew2hKwuvKt6bh2pBvmqAs7yH/WA498Pm5zPrGCHS7wq4xigPqJqyS5XNbrXiGCoJNJd
 EZZFxbZuafsVJtJciQNVOKQmglTw4wMQ+pK3ujj2kKDBLfMLKa5nklpAAKqFnzD3Hlu/ Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yavxrhycs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqWXO016815;
 Mon, 24 Feb 2020 20:55:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2ybduv6ccj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:55:59 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKttcl028200;
 Mon, 24 Feb 2020 20:55:55 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:55:54 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/50] Initial support for multi-process qemu
Date: Mon, 24 Feb 2020 15:54:51 -0500
Message-Id: <cover.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello
  
Started with the presentation in October 2017 made by Marc-Andre (Red Hat)
and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum 2018,
the multi-process project is now available and presented in this patchset.
This first series enables the emulation of lsi53c895a in a separate process.

We posted the Proof Of Concept patches [2] before the BoF session in 2018.
Subsequently, we posted RFC v1 [3], RFC v2 [4], RFC v3 [5] and RFC v4 [6].

John & Elena presented the status of this project in KVM Forum 2019. We
appreciate the in-person and email feedback we received to improve this
patchset. We also received valuable feedback and direction on future
improvements from the bi-weekly KVM community conference. We have
incorporated all the feedback in the current version of the series, v5.

Following people contributed to this patchset:

John G Johnson <john.g.johnson@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Kanth Ghatraju <kanth.ghatraju@oracle.com>
Konrad Wilk <konrad.wilk@oracle.com>

For full concept writeup about QEMU disaggregation, refer to
docs/devel/qemu-multiprocess.rst. Please refer to
docs/qemu-multiprocess.txt for usage information.

We are planning on making the following improvements in the future to the experimental
Qemu multi-process:
 - Asynchronous communication channel;
 - Performance improvements;
 - Libvirt support;
 - Enforcement of security policies and privileges control;

We welcome all your ideas, concerns, and questions for this patchset.

Thank you!


[1]: http://events17.linuxfoundation.org/sites/events/files/slides/KVM%20FORUM%20multi-process.pdf
[1]: https://www.youtube.com/watch?v=Kq1-coHh7lg
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
[3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg602285.html
[4]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg624877.html
[5]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg642000.html
[6]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg655118.html

Elena Ufimtseva (23):
  multi-process: add a command line option for debug file
  multi-process: introduce proxy object
  mutli-process: build remote command line args
  multi-process: configure remote side devices
  multi-process: add qdev_proxy_add to create proxy devices
  multi-process: remote: add setup_devices msg processing
  multi-process: remote: use fd for socket from parent process
  multi-process: remote: add create_done condition
  multi-process: add processing of remote device command line
  multi-process: refractor vl.c code
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
  multi-process: Validate incoming commands from Proxy
  multi-process: add configure and usage information

Jagannathan Raman (26):
  multi-process: memory: alloc RAM from file at offset
  multi-process: Refactor machine_init and exit notifiers
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
  multi-process: Synchronize remote memory
  multi-process: create IOHUB object to handle irq
  multi-process: Retrieve PCI info from remote process
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

 Makefile                         |    2 +
 Makefile.objs                    |   45 ++
 Makefile.target                  |  105 +++-
 accel/Makefile.objs              |    2 +
 accel/stubs/kvm-stub.c           |    5 +
 accel/stubs/tcg-stub.c           |  107 ++++
 backends/Makefile.objs           |    2 +
 block/Makefile.objs              |    2 +
 chardev/char.c                   |   14 +
 configure                        |   15 +
 docs/devel/index.rst             |    1 +
 docs/devel/qemu-multiprocess.rst | 1102 ++++++++++++++++++++++++++++++++++++++
 docs/qemu-multiprocess.txt       |   86 +++
 exec.c                           |   31 +-
 hmp-commands-info.hx             |   10 +
 hmp-commands.hx                  |   25 +-
 hw/Makefile.objs                 |    7 +
 hw/block/Makefile.objs           |    2 +
 hw/core/Makefile.objs            |   19 +
 hw/nvram/Makefile.objs           |    2 +
 hw/pci/Makefile.objs             |    4 +
 hw/proxy/memory-sync.c           |  212 ++++++++
 hw/proxy/qemu-proxy.c            |  906 +++++++++++++++++++++++++++++++
 hw/scsi/Makefile.objs            |    2 +
 include/chardev/char.h           |    1 +
 include/exec/address-spaces.h    |    2 +
 include/exec/ram_addr.h          |    4 +-
 include/hw/pci/pci_ids.h         |    3 +
 include/hw/proxy/memory-sync.h   |   37 ++
 include/hw/proxy/qemu-proxy.h    |  107 ++++
 include/hw/qdev-core.h           |    2 +
 include/io/mpqemu-link.h         |  218 ++++++++
 include/monitor/monitor.h        |    2 +
 include/monitor/qdev.h           |   26 +
 include/qemu-common.h            |    8 +
 include/qemu/log.h               |    1 +
 include/qemu/mmap-alloc.h        |    3 +-
 include/remote/iohub.h           |   50 ++
 include/remote/machine.h         |   32 ++
 include/remote/memory.h          |   20 +
 include/remote/pcihost.h         |   45 ++
 include/sysemu/runstate.h        |    3 +
 include/sysemu/sysemu.h          |    2 +
 io/Makefile.objs                 |    2 +
 io/mpqemu-link.c                 |  410 ++++++++++++++
 memory.c                         |    2 +-
 migration/Makefile.objs          |   13 +
 migration/savevm.c               |   63 +++
 migration/savevm.h               |    3 +
 monitor/Makefile.objs            |    4 +
 monitor/misc.c                   |   84 +--
 monitor/monitor-internal.h       |   38 ++
 monitor/monitor.c                |   40 +-
 net/Makefile.objs                |    2 +
 qapi/Makefile.objs               |    2 +
 qdev-monitor.c                   |  259 ++++++++-
 qemu-options.hx                  |   21 +
 qom/Makefile.objs                |    4 +
 remote/Makefile.objs             |    6 +
 remote/iohub.c                   |  148 +++++
 remote/machine.c                 |   99 ++++
 remote/memory.c                  |   63 +++
 remote/pcihost.c                 |   64 +++
 remote/remote-main.c             |  625 +++++++++++++++++++++
 remote/remote-opts.c             |  115 ++++
 remote/remote-opts.h             |   15 +
 rules.mak                        |    2 +-
 runstate.c                       |   41 ++
 scripts/hxtool                   |   44 +-
 softmmu/vl.c                     |  299 ++++-------
 stubs/audio.c                    |   12 +
 stubs/gdbstub.c                  |   23 +
 stubs/machine-init-done.c        |    4 +
 stubs/migration.c                |  211 ++++++++
 stubs/monitor.c                  |   72 +++
 stubs/net-stub.c                 |  121 +++++
 stubs/qapi-misc.c                |   43 ++
 stubs/qapi-target.c              |   55 ++
 stubs/replay.c                   |   26 +
 stubs/runstate-check.c           |    3 +
 stubs/ui-stub.c                  |  130 +++++
 stubs/vl-stub.c                  |  195 +++++++
 stubs/vmstate.c                  |   19 +
 stubs/xen-mapcache.c             |   22 +
 ui/Makefile.objs                 |    2 +
 util/Makefile.objs               |    2 +
 util/log.c                       |    2 +
 util/mmap-alloc.c                |    7 +-
 util/notify.c                    |   43 ++
 util/oslib-posix.c               |    2 +-
 vl-parse.c                       |  164 ++++++
 vl.h                             |   43 ++
 92 files changed, 6698 insertions(+), 245 deletions(-)
 create mode 100644 docs/devel/qemu-multiprocess.rst
 create mode 100644 docs/qemu-multiprocess.txt
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/memory-sync.h
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


