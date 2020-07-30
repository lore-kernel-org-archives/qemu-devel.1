Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFF2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DE220809
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiB9E2su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DE220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ChL-00029X-7v
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 13:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k1Cgg-0001h1-Bj
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:49:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k1Cgd-0006IV-AO
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596131385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfHJx02Cm/QuHl52QJFwQO6e6zb63ojHka5Notwn98Q=;
 b=FiB9E2su3mP01dLXRAb0c2axFmT26lTqhfFSPIn9hCUxJatAwd8dJwLiNmHk6ip59b6k+8
 BYQzZ2S40KvrGgz+KT+9suRW3ZMM/Pj7aYk6KdN8FU4WWMD2hGh9o+rJeGbi5nBtuw5rGf
 bomtL+voF/KYQjZrU/rxGQxFIaeXecY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-P_SaYIh_OGGoEpUDHWhcfQ-1; Thu, 30 Jul 2020 13:49:44 -0400
X-MC-Unique: P_SaYIh_OGGoEpUDHWhcfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6E98192376A;
 Thu, 30 Jul 2020 17:49:42 +0000 (UTC)
Received: from work-vm (ovpn-114-102.ams2.redhat.com [10.36.114.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B1B690E76;
 Thu, 30 Jul 2020 17:49:13 +0000 (UTC)
Date: Thu, 30 Jul 2020 18:49:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 00/32] Live Update
Message-ID: <20200730174910.GD2603@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steve Sistare (steven.sistare@oracle.com) wrote:
> Improve and extend the qemu functions that save and restore VM state so a
> guest may be suspended and resumed with minimal pause time.  qemu may be
> updated to a new version in between.

Nice.

> The first set of patches adds the cprsave and cprload commands to save an=
d
> restore VM state, and allow the host kernel to be updated and rebooted in
> between.  The VM must create guest RAM in a persistent shared memory file=
,
> such as /dev/dax0.0 or persistant /dev/shm PKRAM as proposed in=20
> https://lore.kernel.org/lkml/1588812129-8596-1-git-send-email-anthony.yzn=
aga@oracle.com/
>=20
> cprsave stops the VCPUs and saves VM device state in a simple file, and
> thus supports any type of guest image and block device.  The caller must
> not modify the VM's block devices between cprsave and cprload.

can I ask why you don't just add a migration flag to skip the devices
you don't want, and then do a migrate to a file?
(i.e. migrate "exec:cat > afile")
We already have the 'x-ignore-shared' capability that's used for doing
RAM snapshots of VMs; primarily I think for being able to start a VM
from a RAM snapshot as a fast VM start trick.
(There's also a xen_save_devices that does something similar).
If you backed the RAM as you say, enabled x-ignore-shared and then did:

   migrate "exec:cat > afile"

and restarted the destination with:

    migrate_incoming "exec:cat afile"

what is different (except the later stuff about the vfio magic and
chardevs).

Dave

> cprsave and cprload support guests with vfio devices if the caller first
> suspends the guest by issuing guest-suspend-ram to the qemu guest agent.
> The guest drivers suspend methods flush outstanding requests and re-
> initialize the devices, and thus there is no device state to save and
> restore.
>=20
>    1 savevm: add vmstate handler iterators
>    2 savevm: VM handlers mode mask
>    3 savevm: QMP command for cprsave
>    4 savevm: HMP Command for cprsave
>    5 savevm: QMP command for cprload
>    6 savevm: HMP Command for cprload
>    7 savevm: QMP command for cprinfo
>    8 savevm: HMP command for cprinfo
>    9 savevm: prevent cprsave if memory is volatile
>   10 kvmclock: restore paused KVM clock
>   11 cpu: disable ticks when suspended
>   12 vl: pause option
>   13 gdbstub: gdb support for suspended state
>=20
> The next patches add a restart method that eliminates the persistent memo=
ry
> constraint, and allows qemu to be updated across the restart, but does no=
t
> allow host reboot.  Anonymous memory segments used by the guest are
> preserved across a re-exec of qemu, mapped at the same VA, via a proposed
> madvise(MADV_DOEXEC) option in the Linux kernel.  See
> https://lore.kernel.org/lkml/1595869887-23307-1-git-send-email-anthony.yz=
naga@oracle.com/
>=20
>   14 savevm: VMS_RESTART and cprsave restart
>   15 vl: QEMU_START_FREEZE env var
>   16 oslib: add qemu_clr_cloexec
>   17 util: env var helpers
>   18 osdep: import MADV_DOEXEC
>   19 memory: ram_block_add cosmetic changes
>   20 vl: add helper to request re-exec
>   21 exec, memory: exec(3) to restart
>   22 char: qio_channel_socket_accept reuse fd
>   23 char: save/restore chardev socket fds
>   24 ui: save/restore vnc socket fds
>   25 char: save/restore chardev pty fds
>   26 monitor: save/restore QMP negotiation status
>   27 vhost: reset vhost devices upon cprsave
>   28 char: restore terminal on restart
>=20
> The next patches extend the restart method to save and restore vfio-pci
> state, eliminating the requirement for a guest agent.  The vfio container=
,
> group, and device descriptors are preserved across the qemu re-exec.
>=20
>   29 pci: export pci_update_mappings
>   30 vfio-pci: save and restore
>   31 vfio-pci: trace pci config
>   32 vfio-pci: improved tracing
>=20
> Here is an example of updating qemu from v4.2.0 to v4.2.1 using=20
> "cprload restart".  The software update is performed while the guest is
> running to minimize downtime.
>=20
> window 1=09=09=09=09| window 2
> =09=09=09=09=09|
> # qemu-system-x86_64 ... =09=09|
> QEMU 4.2.0 monitor - type 'help' ...=09|
> (qemu) info status=09=09=09|
> VM status: running=09=09=09|
> =09=09=09=09=09| # yum update qemu
> (qemu) cprsave /tmp/qemu.sav restart=09|
> QEMU 4.2.1 monitor - type 'help' ...=09|
> (qemu) info status=09=09=09|
> VM status: paused (prelaunch)=09=09|
> (qemu) cprload /tmp/qemu.sav=09=09|
> (qemu) info status=09=09=09|
> VM status: running=09=09=09|
>=20
>=20
> Here is an example of updating the host kernel using "cprload reboot"
>=20
> window 1=09=09=09=09=09| window 2
> =09=09=09=09=09=09|
> # qemu-system-x86_64 ...mem-path=3D/dev/dax0.0 ...|
> QEMU 4.2.1 monitor - type 'help' ...=09=09|
> (qemu) info status=09=09=09=09|
> VM status: running=09=09=09=09|
> =09=09=09=09=09=09| # yum update kernel-uek
> (qemu) cprsave /tmp/qemu.sav restart=09=09|
> =09=09=09=09=09=09|
> # systemctl kexec=09=09=09=09|
> kexec_core: Starting new kernel=09=09=09|
> ...=09=09=09=09=09=09|
> =09=09=09=09=09=09|
> # qemu-system-x86_64 ...mem-path=3D/dev/dax0.0 ...|
> QEMU 4.2.1 monitor - type 'help' ...=09=09|
> (qemu) info status=09=09=09=09|
> VM status: paused (prelaunch)=09=09=09|
> (qemu) cprload /tmp/qemu.sav=09=09=09|
> (qemu) info status=09=09=09=09|
> VM status: running=09=09=09=09|
>=20
>=20
> Mark Kanda (5):
>   char: qio_channel_socket_accept reuse fd
>   char: save/restore chardev socket fds
>   ui: save/restore vnc socket fds
>   monitor: save/restore QMP negotiation status
>   vhost: reset vhost devices upon cprsave
>=20
> Steve Sistare (27):
>   savevm: add vmstate handler iterators
>   savevm: VM handlers mode mask
>   savevm: QMP command for cprsave
>   savevm: HMP Command for cprsave
>   savevm: QMP command for cprload
>   savevm: HMP Command for cprload
>   savevm: QMP command for cprinfo
>   savevm: HMP command for cprinfo
>   savevm: prevent cprsave if memory is volatile
>   kvmclock: restore paused KVM clock
>   cpu: disable ticks when suspended
>   vl: pause option
>   gdbstub: gdb support for suspended state
>   savevm: VMS_RESTART and cprsave restart
>   vl: QEMU_START_FREEZE env var
>   oslib: add qemu_clr_cloexec
>   util: env var helpers
>   osdep: import MADV_DOEXEC
>   memory: ram_block_add cosmetic changes
>   vl: add helper to request re-exec
>   exec, memory: exec(3) to restart
>   char: save/restore chardev pty fds
>   char: restore terminal on restart
>   pci: export pci_update_mappings
>   vfio-pci: save and restore
>   vfio-pci: trace pci config
>   vfio-pci: improved tracing
>=20
>  MAINTAINERS                    |   7 ++
>  accel/kvm/kvm-all.c            |   8 +-
>  accel/kvm/trace-events         |   3 +-
>  chardev/char-pty.c             |  38 +++++--
>  chardev/char-socket.c          |  35 ++++++
>  chardev/char-stdio.c           |   7 ++
>  chardev/char.c                 |  16 +++
>  exec.c                         |  88 +++++++++++++--
>  gdbstub.c                      |  11 +-
>  hmp-commands.hx                |  46 ++++++++
>  hw/i386/kvm/clock.c            |   6 +-
>  hw/pci/msix.c                  |   1 +
>  hw/pci/pci.c                   |  17 +--
>  hw/pci/trace-events            |   5 +-
>  hw/vfio/common.c               | 115 ++++++++++++++++----
>  hw/vfio/pci.c                  | 179 ++++++++++++++++++++++++++++++-
>  hw/vfio/platform.c             |   2 +-
>  hw/vfio/trace-events           |  11 +-
>  hw/virtio/vhost.c              |  12 +++
>  include/chardev/char.h         |   8 ++
>  include/exec/memory.h          |   4 +
>  include/hw/pci/pci.h           |   2 +
>  include/hw/vfio/vfio-common.h  |   4 +-
>  include/io/channel-socket.h    |   3 +-
>  include/migration/register.h   |   3 +
>  include/migration/vmstate.h    |  11 ++
>  include/monitor/hmp.h          |   3 +
>  include/qemu/cutils.h          |   1 +
>  include/qemu/env.h             |  31 ++++++
>  include/qemu/osdep.h           |   8 ++
>  include/sysemu/sysemu.h        |  10 ++
>  io/channel-socket.c            |  12 ++-
>  io/net-listener.c              |   4 +-
>  migration/block.c              |   1 +
>  migration/migration.c          |   4 +-
>  migration/ram.c                |   1 +
>  migration/savevm.c             | 237 +++++++++++++++++++++++++++++++++++=
+-----
>  migration/savevm.h             |   4 +-
>  monitor/hmp-cmds.c             |  28 +++++
>  monitor/qmp-cmds.c             |  16 +++
>  monitor/qmp.c                  |  42 ++++++++
>  qapi/migration.json            |  35 ++++++
>  qapi/pragma.json               |   1 +
>  qemu-options.hx                |   9 ++
>  scsi/qemu-pr-helper.c          |   2 +-
>  softmmu/vl.c                   |  65 ++++++++++-
>  tests/qtest/tpm-emu.c          |   2 +-
>  tests/test-char.c              |   2 +-
>  tests/test-io-channel-socket.c |   4 +-
>  trace-events                   |   2 +
>  ui/vnc.c                       | 153 +++++++++++++++++++++-----
>  util/Makefile.objs             |   2 +-
>  util/env.c                     | 132 +++++++++++++++++++++++
>  util/oslib-posix.c             |   9 ++
>  util/oslib-win32.c             |   4 +
>  55 files changed, 1331 insertions(+), 135 deletions(-)
>  create mode 100644 include/qemu/env.h
>  create mode 100644 util/env.c
>=20
> --=20
> 1.8.3.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


