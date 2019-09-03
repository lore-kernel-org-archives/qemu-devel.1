Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB7AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A1A2168B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pC6WmLdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A1A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fg0-0004NA-77
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZb-00072d-1i
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZY-0008Qo-Uo
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZX-0008KZ-SS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXjOX062374;
 Tue, 3 Sep 2019 20:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=WT86UpWiCBUg412j4ot7crvrvixk5j2YDRy0DXpJduc=;
 b=pC6WmLdGIPax2tMyLnYAYUP94pPf9BDR0XO7LsB6gq4wPBQPC3pEua4yXGAK0Ah7aN8Y
 Ob/gbvl9sJSc8HjVdjKARTV/StP2ObL4klMkwYdCDW2aM73XiMwXXc4fc1wrxyjORk35
 9oThRqYfEGdwltT+jFEO5gQo86oJO+8dKmOQXhrwVxBaN2l80eDzf9JLU5DY1j7ynkTl
 yvMQRccS1DYTKnqDWNs4+D4AjKpaOEga33jlZYR+ezb4F9wMt6wjuBSh+R+1U593Os3w
 EhgKM+BV5FrDaxJW+Yvn+mo/XjuEciyes3YV5A1YIBo7HSPc4qJtoB4AR+XU3ojpt5eH KQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2usy66r2bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcKNu188138;
 Tue, 3 Sep 2019 20:38:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2usu5117e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:26 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83KcNs3022743;
 Tue, 3 Sep 2019 20:38:23 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:23 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:26 -0400
Message-Id: <cover.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 x83KXjOX062374
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 00/45] Initial support of multi-process
 qemu
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

Started with the presentation in October 2017 made by Marc-Andre (Red Hat=
)
and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum 201=
8,
the multi-process project is now a prototype and presented in this patchs=
et.

This first series enables the emulation of lsi53c895a in a separate proce=
ss.

We posted the Proof Of Concept patches [2] before the BoF session in 2018.
Subsequently, we posted RFC v1 [3] & RFC v2 [4] of this series.=20

Thanks to the v1 & v2 review, we were able to incorporate the feedback in=
to
our goals.

In the summer of 2019, we participated in a conference with folks at RedH=
at,
who provided us with feedback to improve the design of this project.=20

We want to present version 3 of this series which incorporates the feedba=
ck
we received for v2 & the enhancements suggested in the conference. Follow=
ing
are the improvements made in this series:
  - The command-line arguments are Orchestrator friendly. A new option
    named "-remote" carries the command-line of the emulation process.
    Added "rid" suboption to the "-device" option and moved "-drive"
    option to the emulation process's command-line.
  - Redesigned Monitor interface allows direct access to the remote proce=
ss,
    thereby making it more scalable, maintainable & Orchestrator friendly.
    We also enabled more monitor commands for the remote process.
  - Enabled the remote process to run multiple LSI controllers
  - Redesigned the communication link to support multiple channels. MMIO
    transactions are carried out in a separate channel.
  - Fixed the bugs discovered during testing. Individual patches provide
    the details of these fixes.

Following people contributed to this patchset:

John G Johnson <john.g.johnson@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Kanth Ghatraju <kanth.ghatraju@oracle.com>

For full concept writeup about QEMU disaggregation refer to
docs/devel/qemu-multiprocess.txt. Please refer to=20
docs/qemu-multiprocess.txt for usage information.

We are planning on making the following improvements in the future:
  - Live migration
  - Performance improvements
  - Libvirt support
  - Enforcement of security policies
  - blockdev support

We welcome all=C2=A0your=C2=A0ideas, concerns, and questions=C2=A0for thi=
s patchset.

Thank you!

[1]: http://events17.linuxfoundation.org/sites/events/files/slides/KVM%20=
FORUM%20multi-process.pdf
[1]: https://www.youtube.com/watch?v=3DKq1-coHh7lg
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
[3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg602285.html
[4]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg624877.html

Elena Ufimtseva (20):
  multi-process: add a command line option for debug file
  multi-process: introduce proxy object
  mutli-process: build remote command line args
  multi-process: add support of device id to communication channel
  multi-process: modify BARs read/write to support dev_id
  multi-process: support dev id in config read/write
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
  multi-process: add support for multiple devices
  multi-process: add heartbeat timer and signal handler
  multi-process: handle heartbeat messages in remote process
  multi-process: add configure and usage information

Jagannathan Raman (24):
  multi-process: memory: alloc RAM from file at offset
  multi-process: util: Add qemu_thread_cancel() to cancel running thread
  multi-process: Add stub functions to facilate build of multi-process
  multi-process: Add config option for multi-process QEMU
  multi-process: build system for remote device process
  multi-process: define proxy-link object
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
  multi-process/mon: build system for QMP module in remote process
  multi-process/mon: Refactor monitor/chardev functions out of vl.c
  multi-process/mon: trim HMP command set for remote storage processes
  multi-process/mon: Initialize QMP module for remote processes
  multi-process: prevent duplicate memory initialization in remote

John G Johnson (1):
  multi-process: add the concept description to
    docs/devel/qemu-multiprocess

 Makefile                            |   2 +
 Makefile.objs                       |  33 ++
 Makefile.target                     |  91 +++++-
 accel/stubs/kvm-stub.c              |   5 +
 accel/stubs/tcg-stub.c              |  95 ++++++
 backends/Makefile.objs              |   2 +
 block/Makefile.objs                 |   2 +
 configure                           |  15 +
 docs/devel/qemu-multiprocess.txt    | 627 ++++++++++++++++++++++++++++++=
++++++
 docs/qemu-multiprocess.txt          |  86 +++++
 exec.c                              |  14 +-
 hmp-scsi-commands-info.hx           | 167 ++++++++++
 hmp-scsi-commands.hx                | 384 ++++++++++++++++++++++
 hw/Makefile.objs                    |   9 +
 hw/block/Makefile.objs              |   2 +
 hw/core/Makefile.objs               |  16 +
 hw/nvram/Makefile.objs              |   2 +
 hw/pci/Makefile.objs                |   4 +
 hw/proxy/Makefile.objs              |   1 +
 hw/proxy/memory-sync.c              | 226 +++++++++++++
 hw/proxy/proxy-lsi53c895a.c         | 168 ++++++++++
 hw/proxy/qemu-proxy.c               | 615 ++++++++++++++++++++++++++++++=
+++++
 hw/scsi/Makefile.objs               |   2 +
 include/exec/address-spaces.h       |   2 +
 include/exec/ram_addr.h             |   2 +-
 include/glib-compat.h               |   4 +
 include/hw/pci/pci_ids.h            |   3 +
 include/hw/proxy/memory-sync.h      |  51 +++
 include/hw/proxy/proxy-lsi53c895a.h |  42 +++
 include/hw/proxy/qemu-proxy.h       | 106 ++++++
 include/hw/qdev-core.h              |   2 +
 include/io/proxy-link.h             | 202 ++++++++++++
 include/monitor/qdev.h              |  24 ++
 include/qemu-common.h               |   8 +
 include/qemu/log.h                  |   1 +
 include/qemu/mmap-alloc.h           |   3 +-
 include/qemu/thread.h               |   1 +
 include/remote/iohub.h              |  63 ++++
 include/remote/machine.h            |  48 +++
 include/remote/memory.h             |  34 ++
 include/remote/pcihost.h            |  59 ++++
 io/Makefile.objs                    |   2 +
 io/proxy-link.c                     | 363 +++++++++++++++++++++
 memory.c                            |   2 +-
 migration/Makefile.objs             |   2 +
 monitor/Makefile.objs               |   3 +
 monitor/misc.c                      |  84 ++---
 monitor/monitor-internal.h          |  38 +++
 qapi/Makefile.objs                  |   2 +
 qdev-monitor.c                      | 257 ++++++++++++++-
 qemu-options.hx                     |  21 ++
 qom/Makefile.objs                   |   5 +
 remote/Makefile.objs                |   6 +
 remote/iohub.c                      | 159 +++++++++
 remote/machine.c                    | 133 ++++++++
 remote/memory.c                     |  99 ++++++
 remote/pcihost.c                    |  84 +++++
 remote/remote-main.c                | 626 ++++++++++++++++++++++++++++++=
+++++
 remote/remote-opts.c                | 123 +++++++
 remote/remote-opts.h                |  31 ++
 rules.mak                           |   2 +-
 stubs/gdbstub.c                     |  21 ++
 stubs/machine-init-done.c           |   4 +
 stubs/migration.c                   | 162 ++++++++++
 stubs/monitor.c                     |  65 ++++
 stubs/net-stub.c                    | 100 ++++++
 stubs/qapi-misc.c                   |  41 +++
 stubs/qapi-target.c                 |  49 +++
 stubs/replay.c                      |  18 ++
 stubs/ui-stub.c                     | 130 ++++++++
 stubs/vl-stub.c                     | 169 ++++++++++
 stubs/vmstate.c                     |  20 ++
 stubs/xen-mapcache.c                |  22 ++
 ui/Makefile.objs                    |   2 +
 util/log.c                          |   2 +
 util/mmap-alloc.c                   |   7 +-
 util/oslib-posix.c                  |   2 +-
 util/qemu-thread-posix.c            |  10 +
 vl-parse.c                          | 249 ++++++++++++++
 vl.c                                | 298 ++++++++---------
 vl.h                                |  58 ++++
 81 files changed, 6466 insertions(+), 228 deletions(-)
 create mode 100644 docs/devel/qemu-multiprocess.txt
 create mode 100644 docs/qemu-multiprocess.txt
 create mode 100644 hmp-scsi-commands-info.hx
 create mode 100644 hmp-scsi-commands.hx
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 hw/proxy/proxy-lsi53c895a.c
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/memory-sync.h
 create mode 100644 include/hw/proxy/proxy-lsi53c895a.h
 create mode 100644 include/hw/proxy/qemu-proxy.h
 create mode 100644 include/io/proxy-link.h
 create mode 100644 include/remote/iohub.h
 create mode 100644 include/remote/machine.h
 create mode 100644 include/remote/memory.h
 create mode 100644 include/remote/pcihost.h
 create mode 100644 io/proxy-link.c
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/iohub.c
 create mode 100644 remote/machine.c
 create mode 100644 remote/memory.c
 create mode 100644 remote/pcihost.c
 create mode 100644 remote/remote-main.c
 create mode 100644 remote/remote-opts.c
 create mode 100644 remote/remote-opts.h
 create mode 100644 stubs/migration.c
 create mode 100644 stubs/net-stub.c
 create mode 100644 stubs/qapi-misc.c
 create mode 100644 stubs/qapi-target.c
 create mode 100644 stubs/ui-stub.c
 create mode 100644 stubs/vl-stub.c
 create mode 100644 stubs/xen-mapcache.c
 create mode 100644 vl-parse.c
 create mode 100644 vl.h

--=20
1.8.3.1


