Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438E5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB9A206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lW+dc3Ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB9A206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieZJx-0007Ev-4T
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 01:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1ieZJ5-0006kg-JN
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 01:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1ieZJ3-0007wL-1R
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 01:47:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1ieZJ2-0007vF-LF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 01:47:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBA6hmPO122766;
 Tue, 10 Dec 2019 06:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=IWvQRsgb/KECNiTypaq2WijCz8qxw19Q7h3IH1e+qkE=;
 b=lW+dc3HaTFvnUYo2QKpVdhGNjvWDuqNre/10IyTwD9h4Vi38v2dscgpiGQ1HdcYcgERJ
 3nqcs5fVdCcJd2z90TnsUB9jXHCUJkqRy25PU/D+KZrv7P6Ah+bsf6LE4AedRxaINvyk
 FbWh6C01pANA7Di1vpycoFDSTxAWwE4Wp0cIfTPr5hVaKLjQhaKMadEoMtcbid1u0LrZ
 O5D1qrGevvHCVP9fcnboXl8CSimO3vydC53ECujb1Rg8kbfJXLUdaIzxwYTp2S30jscC
 7e0gARx+WEu5Pbe96ea9tCVosN9/qulz9JzYiI9iTxWn04R1mZxT/HtX4+E9xK9d4is4 Yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2wrw4n0vxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2019 06:47:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBA6gwDj162349;
 Tue, 10 Dec 2019 06:47:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2wt6ba0f71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2019 06:47:21 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBA6lJMR029926;
 Tue, 10 Dec 2019 06:47:19 GMT
Received: from flaka (/10.159.245.204) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Dec 2019 22:47:19 -0800
Date: Mon, 9 Dec 2019 22:47:17 -0800
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: qemu-devel@nongnu.org
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191210064716.GA6401@flaka>
References: <cover.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9466
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912100059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9466
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912100059
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 xBA6hmPO122766
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, mst@redhat.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, stefanha@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi

We would like to give a short update to the community about the multi-pro=
cess project.

Firstly, we appreciate the feedback and all productive discussions we had
at KVM 2019 forum.
As an outcome of the conference, we have switched gears and are investiga=
ting
the ways of using the muser framework in our project.

At this moment we are working on the evaluation and a first prototype
of qemu-multiprocess based on muser framework.
We first heard about it at the conference from the presentation given by
Thanos Makatos and Swapnil Ingle from Nutanix.
Their presentation is available https://static.sched.com/hosted_files/kvm=
forum2019/3b/muser.pdf
 along with github link to the source repo.
After the conversation we had with a group of people including Felipe Fra=
nciosi,
Stefan Hajnoczi, Daniel Berrang=C3=A9, Konrad Wilk, Peter Maydell, John J=
onson and few others
(apologies if some names are missing), we have gathered important answers=
 on how to move
forward with qemu-multiprocess.

At this moment we are working on the first stage of the project with help=
 of
the Nutanix developers.
The questions we have gathered so far will be addressed with muser
and Qemu developers after we finish the first stage and make sure we unde=
rstand
what it will take for us to move onto the next stage.

We will also incorporate relevant review from Stefan that he provided
on the series 4 of the patchset. Thank you Stefan.

If anyone have any further suggestions or questions about the status,
please reply to this email.

Thank you

JJ, Jag & Elena

On Thu, Oct 24, 2019 at 05:08:41AM -0400, Jagannathan Raman wrote:
> Started with the presentation in October 2017 made by Marc-Andre (Red H=
at)
> and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum 2=
018,
> the multi-process project is now a prototype and presented in this patc=
hset.
> John & Elena will present the status of this project in KVM Forum 2019.
>=20
> This first series enables the emulation of lsi53c895a in a separate pro=
cess.
>=20
> We posted the Proof Of Concept patches [2] before the BoF session in 20=
18.
> Subsequently, we posted RFC v1 [3], RFC v2 [4] and RFC v3 [5] of this s=
eries.=20
>=20
> We want to present version 4 of this series, which incorporates the fee=
dback
> we received for v3 & adds support for live migrating the remote process.
>=20
> Following people contributed to this patchset:
>=20
> John G Johnson <john.g.johnson@oracle.com>
> Jagannathan Raman <jag.raman@oracle.com>
> Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Kanth Ghatraju <kanth.ghatraju@oracle.com>
>=20
> For full concept writeup about QEMU disaggregation refer to
> docs/devel/qemu-multiprocess.rst. Please refer to=20
> docs/qemu-multiprocess.txt for usage information.
>=20
> We are planning on making the following improvements in the future:
>  - Performance improvements
>  - Libvirt support
>  - Enforcement of security policies
>  - blockdev support
>=20
> We welcome all your ideas, concerns, and questions for this patchset.
>=20
> Thank you!
>=20
> [1]: http://events17.linuxfoundation.org/sites/events/files/slides/KVM%=
20FORUM%20multi-process.pdf
> [1]: https://www.youtube.com/watch?v=3DKq1-coHh7lg
> [2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
> [3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg602285.html
> [4]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg624877.html
> [5]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg642000.html
>=20
> Elena Ufimtseva (22):
>   multi-process: add a command line option for debug file
>   multi-process: introduce proxy object
>   mutli-process: build remote command line args
>   multi-process: configure remote side devices
>   multi-process: add qdev_proxy_add to create proxy devices
>   multi-process: remote: add setup_devices and setup_drive msg
>     processing
>   multi-process: remote: use fd for socket from parent process
>   multi-process: remote: add create_done condition
>   multi-process: add processing of remote drive and device command line
>   multi-process: refractor vl.c code to re-use in remote
>   multi-process: add remote option
>   multi-process: add remote options parser
>   multi-process: add parse_cmdline in remote process
>   multi-process: send heartbeat messages to remote
>   multi-process: handle heartbeat messages in remote process
>   multi-process/mon: choose HMP commands based on target
>   multi-process/mig: Load VMSD in the proxy object
>   multi-process/mig: refactor runstate_check into common file
>   multi-process/mig: Synchronize runstate of remote process
>   multi-process/mig: Restore the VMSD in remote process
>   multi-process: Enable support for multiple devices in remote
>   multi-process: add configure and usage information
>=20
> Jagannathan Raman (26):
>   multi-process: memory: alloc RAM from file at offset
>   multi-process: util: Add qemu_thread_cancel() to cancel running threa=
d
>   multi-process: Add stub functions to facilate build of multi-process
>   multi-process: Add config option for multi-process QEMU
>   multi-process: build system for remote device process
>   multi-process: define mpqemu-link object
>   multi-process: add functions to synchronize proxy and remote endpoint=
s
>   multi-process: setup PCI host bridge for remote device
>   multi-process: setup a machine object for remote device process
>   multi-process: setup memory manager for remote device
>   multi-process: remote process initialization
>   multi-process: PCI BAR read/write handling for proxy & remote
>     endpoints
>   multi-process: Add LSI device proxy object
>   multi-process: Synchronize remote memory
>   multi-process: create IOHUB object to handle irq
>   multi-process: Introduce build flags to separate remote process code
>   multi-process: Use separate MMIO communication channel
>   multi-process: perform device reset in the remote process
>   multi-process/mon: stub functions to enable QMP module for remote
>     process
>   multi-process/mon: enable QMP module support in the remote process
>   multi-process/mon: Refactor monitor/chardev functions out of vl.c
>   multi-process/mon: Initialize QMP module for remote processes
>   multi-process: prevent duplicate memory initialization in remote
>   multi-process/mig: build migration module in the remote process
>   multi-process/mig: Enable VMSD save in the Proxy object
>   multi-process/mig: Send VMSD of remote to the Proxy object
>=20
> John G Johnson (1):
>   multi-process: add the concept description to
>     docs/devel/qemu-multiprocess
>=20
>  Makefile                            |    2 +
>  Makefile.objs                       |   39 ++
>  Makefile.target                     |   94 ++-
>  accel/stubs/kvm-stub.c              |    5 +
>  accel/stubs/tcg-stub.c              |  106 ++++
>  backends/Makefile.objs              |    2 +
>  block/Makefile.objs                 |    2 +
>  chardev/char.c                      |   14 +
>  configure                           |   15 +
>  docs/devel/index.rst                |    1 +
>  docs/devel/qemu-multiprocess.rst    | 1102 +++++++++++++++++++++++++++=
++++++++
>  docs/qemu-multiprocess.txt          |   86 +++
>  exec.c                              |   14 +-
>  hmp-commands-info.hx                |   10 +
>  hmp-commands.hx                     |   25 +-
>  hw/Makefile.objs                    |    9 +
>  hw/block/Makefile.objs              |    2 +
>  hw/core/Makefile.objs               |   17 +
>  hw/nvram/Makefile.objs              |    2 +
>  hw/pci/Makefile.objs                |    4 +
>  hw/proxy/Makefile.objs              |    1 +
>  hw/proxy/memory-sync.c              |  226 +++++++
>  hw/proxy/proxy-lsi53c895a.c         |   97 +++
>  hw/proxy/qemu-proxy.c               |  807 +++++++++++++++++++++++++
>  hw/scsi/Makefile.objs               |    2 +
>  include/chardev/char.h              |    1 +
>  include/exec/address-spaces.h       |    2 +
>  include/exec/ram_addr.h             |    2 +-
>  include/hw/pci/pci_ids.h            |    3 +
>  include/hw/proxy/memory-sync.h      |   51 ++
>  include/hw/proxy/proxy-lsi53c895a.h |   42 ++
>  include/hw/proxy/qemu-proxy.h       |  125 ++++
>  include/hw/qdev-core.h              |    2 +
>  include/io/mpqemu-link.h            |  214 +++++++
>  include/monitor/monitor.h           |    2 +
>  include/monitor/qdev.h              |   25 +
>  include/qemu-common.h               |    8 +
>  include/qemu/log.h                  |    1 +
>  include/qemu/mmap-alloc.h           |    3 +-
>  include/qemu/thread.h               |    1 +
>  include/remote/iohub.h              |   63 ++
>  include/remote/machine.h            |   48 ++
>  include/remote/memory.h             |   34 ++
>  include/remote/pcihost.h            |   59 ++
>  include/sysemu/runstate.h           |    3 +
>  io/Makefile.objs                    |    2 +
>  io/mpqemu-link.c                    |  351 +++++++++++
>  memory.c                            |    2 +-
>  migration/Makefile.objs             |   12 +
>  migration/savevm.c                  |   63 ++
>  migration/savevm.h                  |    3 +
>  monitor/Makefile.objs               |    3 +
>  monitor/misc.c                      |   84 +--
>  monitor/monitor-internal.h          |   38 ++
>  monitor/monitor.c                   |   83 ++-
>  net/Makefile.objs                   |    2 +
>  qapi/Makefile.objs                  |    2 +
>  qdev-monitor.c                      |  270 ++++++++-
>  qemu-options.hx                     |   21 +
>  qom/Makefile.objs                   |    4 +
>  remote/Makefile.objs                |    6 +
>  remote/iohub.c                      |  159 +++++
>  remote/machine.c                    |  133 +++++
>  remote/memory.c                     |   99 ++++
>  remote/pcihost.c                    |   85 +++
>  remote/remote-main.c                |  633 ++++++++++++++++++++
>  remote/remote-opts.c                |  131 +++++
>  remote/remote-opts.h                |   31 +
>  replay/Makefile.objs                |    2 +-
>  rules.mak                           |    2 +-
>  runstate.c                          |   41 ++
>  scripts/hxtool                      |   44 +-
>  stubs/audio.c                       |   12 +
>  stubs/gdbstub.c                     |   21 +
>  stubs/machine-init-done.c           |    4 +
>  stubs/migration.c                   |  211 +++++++
>  stubs/monitor.c                     |   72 +++
>  stubs/net-stub.c                    |  121 ++++
>  stubs/qapi-misc.c                   |   43 ++
>  stubs/qapi-target.c                 |   49 ++
>  stubs/replay.c                      |   26 +
>  stubs/runstate-check.c              |    3 +
>  stubs/ui-stub.c                     |  130 +++++
>  stubs/vl-stub.c                     |  193 ++++++
>  stubs/vmstate.c                     |   20 +
>  stubs/xen-mapcache.c                |   22 +
>  ui/Makefile.objs                    |    2 +
>  util/log.c                          |    2 +
>  util/mmap-alloc.c                   |    7 +-
>  util/oslib-posix.c                  |    2 +-
>  util/qemu-thread-posix.c            |   10 +
>  vl-parse.c                          |  161 +++++
>  vl.c                                |  310 ++++------
>  vl.h                                |   54 ++
>  94 files changed, 6908 insertions(+), 246 deletions(-)
>  create mode 100644 docs/devel/qemu-multiprocess.rst
>  create mode 100644 docs/qemu-multiprocess.txt
>  create mode 100644 hw/proxy/Makefile.objs
>  create mode 100644 hw/proxy/memory-sync.c
>  create mode 100644 hw/proxy/proxy-lsi53c895a.c
>  create mode 100644 hw/proxy/qemu-proxy.c
>  create mode 100644 include/hw/proxy/memory-sync.h
>  create mode 100644 include/hw/proxy/proxy-lsi53c895a.h
>  create mode 100644 include/hw/proxy/qemu-proxy.h
>  create mode 100644 include/io/mpqemu-link.h
>  create mode 100644 include/remote/iohub.h
>  create mode 100644 include/remote/machine.h
>  create mode 100644 include/remote/memory.h
>  create mode 100644 include/remote/pcihost.h
>  create mode 100644 io/mpqemu-link.c
>  create mode 100644 remote/Makefile.objs
>  create mode 100644 remote/iohub.c
>  create mode 100644 remote/machine.c
>  create mode 100644 remote/memory.c
>  create mode 100644 remote/pcihost.c
>  create mode 100644 remote/remote-main.c
>  create mode 100644 remote/remote-opts.c
>  create mode 100644 remote/remote-opts.h
>  create mode 100644 runstate.c
>  mode change 100644 =3D> 100755 scripts/hxtool
>  create mode 100644 stubs/audio.c
>  create mode 100644 stubs/migration.c
>  create mode 100644 stubs/net-stub.c
>  create mode 100644 stubs/qapi-misc.c
>  create mode 100644 stubs/qapi-target.c
>  create mode 100644 stubs/ui-stub.c
>  create mode 100644 stubs/vl-stub.c
>  create mode 100644 stubs/xen-mapcache.c
>  create mode 100644 vl-parse.c
>  create mode 100644 vl.h
>=20
> --=20
> 1.8.3.1
>=20

