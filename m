Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E625C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BD120820
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BD120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx7zl-0006Np-Do
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 06:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57577)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hx7zA-0005xC-4k
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hx7z8-0001B9-Qg
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:55:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hx7z8-00019K-Ju
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:55:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id e8so10310575wme.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 03:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UcYD+uy8SvM4JxD6aB3NDt9FRGMKi2DzJkbm7ZSMFbw=;
 b=NnX/dn/rDTNCgXaiz/7kN25BwiZ27CYQJ2XrCpNzCxqRg1w1HAimrdH+BkW+MGfTqS
 59JuGp27AL9LPD9LuqiGSmyvqH2H/4I5Qjde7R7hJl3tpiF/EdQ2eG4+AhxW4liKbTqj
 7EIWqnP5HP67KBD4iNY86d17MoCX+ZhiIR2uttacllFUVYPWewZRkDyQeXlT8KbqsHHk
 f/ySg4p01Dxf/pAhxWQwepWAwqIrxjjDVEl407rukcSEi81UJnKUHpJ//uCYxlFgAVIX
 dBtccQg0gvhba1VtMqGG81bZwsl3B2Oa8Nsw7J+8iOIoby2kFt6aytUfLHCSxsmCUNXU
 NyRA==
X-Gm-Message-State: APjAAAXhbTKmST7Feej18fzW54A21JLXRMf7aLEKIxSsXeinNt05DoDd
 D6nAXwtLHGbziWuj5V5zX4G8DJgxOzw=
X-Google-Smtp-Source: APXvYqyeEu9bkojYaMxpEoIOdm8pHT0viCgIH9GoAXz15tfJPaXZjM7BCMrt2OOmpAcKxSAw4Q5A2Q==
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr19592612wmj.112.1565607329393; 
 Mon, 12 Aug 2019 03:55:29 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id q3sm6922004wma.48.2019.08.12.03.55.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 03:55:28 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-21-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <802f5f60-1be0-5bb6-d224-dc566fa38747@redhat.com>
Date: Mon, 12 Aug 2019 12:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190812052359.30071-21-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v4 20/29] Include qemu/main-loop.h less
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

On 8/12/19 7:23 AM, Markus Armbruster wrote:
> In my "build everything" tree, changing qemu/main-loop.h triggers a
> recompile of some 5600 out of 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h).  It includes block/aio.h,
> which in turn includes qemu/event_notifier.h, qemu/notify.h,
> qemu/processor.h, qemu/qsp.h, qemu/queue.h, qemu/thread-posix.h,
> qemu/thread.h, qemu/timer.h, and a few more.
> 
> Include qemu/main-loop.h only where it's needed.  Touching it now
> recompiles only some 1700 objects.  For block/aio.h and
> qemu/event_notifier.h, these numbers drop from 5600 to 2800.  For the
> others, they shrink only slightly.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  fsdev/qemu-fsdev-throttle.h     | 1 -
>  hw/9pfs/coth.h                  | 1 -
>  include/block/block_int.h       | 1 -
>  include/chardev/char-fe.h       | 1 +
>  include/chardev/char-io.h       | 1 +
>  include/chardev/char.h          | 2 +-
>  include/hw/scsi/scsi.h          | 1 +
>  include/sysemu/sysemu.h         | 1 -
>  nbd/nbd-internal.h              | 1 -
>  ui/vnc-auth-sasl.h              | 1 -
>  accel/kvm/kvm-all.c             | 1 +
>  block.c                         | 1 +
>  block/block-backend.c           | 1 +
>  block/create.c                  | 1 +
>  block/io.c                      | 1 +
>  block/nbd.c                     | 1 +
>  block/nfs.c                     | 1 +
>  block/nvme.c                    | 1 +
>  block/qcow2.c                   | 1 +
>  block/qed.c                     | 1 +
>  block/sheepdog.c                | 1 +
>  block/throttle-groups.c         | 1 +
>  blockdev.c                      | 1 +
>  blockjob.c                      | 1 +
>  chardev/baum.c                  | 1 +
>  chardev/char-pipe.c             | 1 +
>  chardev/char-win-stdio.c        | 1 +
>  chardev/char-win.c              | 1 +
>  dump/dump.c                     | 1 +
>  fsdev/qemu-fsdev-throttle.c     | 1 +
>  hw/9pfs/9p.c                    | 1 +
>  hw/9pfs/codir.c                 | 1 +
>  hw/9pfs/cofile.c                | 1 +
>  hw/9pfs/cofs.c                  | 1 +
>  hw/9pfs/coth.c                  | 1 +
>  hw/9pfs/coxattr.c               | 1 +
>  hw/9pfs/xen-9p-backend.c        | 1 +
>  hw/arm/omap1.c                  | 1 +
>  hw/block/dataplane/virtio-blk.c | 1 +
>  hw/block/dataplane/xen-block.c  | 1 +
>  hw/block/fdc.c                  | 1 +
>  hw/block/xen-block.c            | 1 +
>  hw/char/virtio-serial-bus.c     | 1 +
>  hw/core/machine-qmp-cmds.c      | 1 +
>  hw/display/qxl.c                | 1 +
>  hw/dma/etraxfs_dma.c            | 1 +
>  hw/i386/intel_iommu.c           | 1 +
>  hw/i386/xen/xen-hvm.c           | 1 +
>  hw/ide/ahci.c                   | 1 +
>  hw/ide/core.c                   | 1 +
>  hw/ide/qdev.c                   | 1 +
>  hw/intc/s390_flic.c             | 1 +
>  hw/m68k/mcf5206.c               | 1 +
>  hw/m68k/mcf5208.c               | 1 +
>  hw/misc/imx6_src.c              | 1 +
>  hw/net/fsl_etsec/etsec.c        | 1 +
>  hw/net/lan9118.c                | 1 +
>  hw/net/vhost_net.c              | 2 +-
>  hw/net/virtio-net.c             | 1 +
>  hw/ppc/ppc.c                    | 1 +
>  hw/ppc/ppc440_uc.c              | 1 +
>  hw/ppc/spapr_hcall.c            | 1 +
>  hw/ppc/spapr_rng.c              | 1 +
>  hw/scsi/mptsas.c                | 1 +
>  hw/scsi/scsi-disk.c             | 1 +
>  hw/scsi/vmw_pvscsi.c            | 1 +
>  hw/timer/allwinner-a10-pit.c    | 1 +
>  hw/timer/altera_timer.c         | 1 +
>  hw/timer/etraxfs_timer.c        | 1 +
>  hw/timer/exynos4210_rtc.c       | 1 +
>  hw/timer/milkymist-sysctl.c     | 1 +
>  hw/usb/dev-uas.c                | 1 +
>  hw/usb/hcd-ehci.c               | 1 +
>  hw/usb/host-libusb.c            | 1 +
>  hw/usb/xen-usb.c                | 1 +
>  hw/vfio/ccw.c                   | 1 +
>  hw/vfio/common.c                | 1 +
>  hw/vfio/pci.c                   | 1 +
>  hw/vfio/platform.c              | 1 +
>  hw/virtio/vhost-backend.c       | 1 +
>  hw/virtio/vhost-user.c          | 1 +
>  hw/virtio/virtio-crypto.c       | 1 +
>  hw/virtio/virtio-pmem.c         | 1 +
>  hw/virtio/virtio.c              | 1 +
>  hw/xen/xen-legacy-backend.c     | 1 +
>  hw/xen/xen_pvdev.c              | 1 +
>  memory.c                        | 1 +
>  migration/block.c               | 1 +
>  migration/colo.c                | 1 +
>  migration/migration.c           | 1 +
>  migration/savevm.c              | 1 +
>  net/can/can_socketcan.c         | 1 +
>  net/netmap.c                    | 1 +
>  net/tap-win32.c                 | 1 +
>  net/tap.c                       | 1 +
>  qemu-img.c                      | 1 +
>  qom/cpu.c                       | 1 +
>  replay/replay-internal.c        | 1 +
>  target/arm/helper-a64.c         | 1 +
>  target/arm/helper.c             | 2 ++
>  target/arm/kvm.c                | 1 +
>  target/arm/kvm64.c              | 1 +
>  target/arm/m_helper.c           | 2 ++
>  target/arm/psci.c               | 2 ++
>  target/i386/kvm.c               | 1 +
>  target/lm32/op_helper.c         | 1 +
>  target/mips/kvm.c               | 1 +
>  target/ppc/int_helper.c         | 2 ++
>  target/ppc/kvm.c                | 1 +
>  target/ppc/machine.c            | 1 +
>  target/ppc/mem_helper.c         | 2 ++
>  target/ppc/misc_helper.c        | 2 ++
>  target/ppc/mmu_helper.c         | 2 ++
>  target/ppc/translate.c          | 1 +
>  target/s390x/kvm.c              | 1 +
>  tcg/tcg-op-gvec.c               | 1 +
>  tests/test-bdrv-drain.c         | 1 +
>  tests/test-bdrv-graph-mod.c     | 1 +
>  tests/test-block-backend.c      | 1 +
>  tests/test-block-iothread.c     | 1 +
>  tests/test-image-locking.c      | 1 +
>  tests/test-replication.c        | 1 +
>  tests/test-throttle.c           | 1 +
>  ui/input-linux.c                | 1 +
>  ui/spice-core.c                 | 1 +
>  ui/spice-display.c              | 1 +
>  ui/vnc.c                        | 1 +
>  util/oslib-posix.c              | 1 +
>  ui/cocoa.m                      | 1 +
>  129 files changed, 130 insertions(+), 8 deletions(-)

It is interesting to see what access the main-loop.
Few pieces might be worth a refactor.
Certainly not this patch objective.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

