Received: from eggs.gnu.org ([2001:4830:134:3::10]:44268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dEDLG-00083k-T7
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dEDLD-0007OW-Oj
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:23:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dEDLD-0007Mg-GE
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:23:35 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CD35C04B31F
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 11:23:34 +0000 (UTC)
Received: from [10.36.117.65] (ovpn-117-65.ams2.redhat.com [10.36.117.65])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v4QBNVYW016095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 07:23:33 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20170524161147.17846-1-pbonzini@redhat.com>
Message-ID: <5ab5824b-9bc5-91d4-734c-83680d013c54@redhat.com>
Date: Fri, 26 May 2017 13:23:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170524161147.17846-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/20] Misc patches for 2017-05-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 24/05/2017 18:11, Paolo Bonzini wrote:
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329ab:
> 
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into staging (2017-05-18 13:36:15 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 46465ffebc75edd75091f4eb0963fd48ce7c02b6:
> 
>   target/i386: use multiple CPU AddressSpaces (2017-05-24 18:09:03 +0200)
> 
> v2 fixes coding style errors in vhost-user-scsi.

NACK, Vladimir sent an updated patch.

Paolo

> ----------------------------------------------------------------
> * virtio-scsi use-after-free fix (Fam)
> * vhost-user-scsi support (Felipe)
> * SMM fixes and improvements for TCG (myself)
> * irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
> * Coverity fix (Stefano)
> * NBD cleanups (Vladimir)
> * RTC accuracy improvements and code cleanups (Guangrong+Yunfang)
> 
> ----------------------------------------------------------------
> Fam Zheng (1):
>       virtio-scsi: Unset hotplug handler when unrealize
> 
> Felipe Franciosi (2):
>       vhost-user-scsi: Introduce vhost-user-scsi host device
>       vhost-user-scsi: Introduce a vhost-user-scsi sample application
> 
> Paolo Bonzini (2):
>       target/i386: enable A20 automatically in system management mode
>       target/i386: use multiple CPU AddressSpaces
> 
> Peter Xu (4):
>       kvm: irqchip: trace changes on msi add/remove
>       msix: trace control bit write op
>       kvm: irqchip: skip update msi when disabled
>       exec: simplify phys_page_find() params
> 
> Stefano Stabellini (1):
>       Check the return value of fcntl in qemu_set_cloexec
> 
> Tai Yunfang (1):
>       mc146818rtc: precisely count the clock for periodic timer
> 
> Vladimir Sementsov-Ogievskiy (5):
>       nbd: strict nbd_wr_syncv
>       nbd: read_sync and friends: return 0 on success
>       nbd: add errp parameter to nbd_wr_syncv()
>       nbd: add errp to read_sync, write_sync and drop_sync
>       nbd/client.c: use errp instead of LOG
> 
> Xiao Guangrong (4):
>       mc146818rtc: update periodic timer only if it is needed
>       mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only enabled on TARGET_I386
>       mc146818rtc: drop unnecessary '#ifdef TARGET_I386'
>       mc146818rtc: embrace all x86 specific code
> 
>  .gitignore                                |   1 +
>  Makefile                                  |   3 +
>  Makefile.objs                             |   4 +
>  block/nbd-client.c                        |  11 +-
>  contrib/libvhost-user/libvhost-user.h     |  11 +-
>  contrib/vhost-user-scsi/Makefile.objs     |   1 +
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 886 ++++++++++++++++++++++++++++++
>  default-configs/pci.mak                   |   1 +
>  default-configs/s390x-softmmu.mak         |   1 +
>  exec.c                                    |  13 +-
>  hw/pci/msix.c                             |  11 +-
>  hw/pci/trace-events                       |   3 +
>  hw/scsi/Makefile.objs                     |   1 +
>  hw/scsi/vhost-user-scsi.c                 | 211 +++++++
>  hw/scsi/virtio-scsi.c                     |   3 +
>  hw/timer/mc146818rtc.c                    | 206 ++++---
>  hw/virtio/virtio-pci.c                    |  54 ++
>  hw/virtio/virtio-pci.h                    |  11 +
>  include/block/nbd.h                       |   8 +-
>  include/hw/virtio/vhost-user-scsi.h       |  35 ++
>  include/hw/virtio/virtio-scsi.h           |   2 +
>  kvm-all.c                                 |   4 +-
>  nbd/client.c                              | 125 ++---
>  nbd/common.c                              |  23 +-
>  nbd/nbd-internal.h                        |  40 +-
>  nbd/server.c                              |  92 ++--
>  qemu-nbd.c                                |   3 +-
>  target/i386/arch_memory_mapping.c         |  18 +-
>  target/i386/cpu.c                         |  15 +-
>  target/i386/cpu.h                         |  20 +-
>  target/i386/helper.c                      |  96 ++--
>  target/i386/kvm.c                         |  12 +-
>  target/i386/machine.c                     |   4 -
>  target/i386/smm_helper.c                  |  18 -
>  trace-events                              |   3 +-
>  util/oslib-posix.c                        |   4 +-
>  36 files changed, 1643 insertions(+), 311 deletions(-)
>  create mode 100644 contrib/vhost-user-scsi/Makefile.objs
>  create mode 100644 contrib/vhost-user-scsi/vhost-user-scsi.c
>  create mode 100644 hw/scsi/vhost-user-scsi.c
>  create mode 100644 include/hw/virtio/vhost-user-scsi.h
> 
