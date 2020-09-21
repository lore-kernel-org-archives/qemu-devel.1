Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F73C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85ACC20EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1CjE783"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ACC20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKIM-00053D-L3
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kKKG3-0002st-Oo
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:45:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kKKFz-0002Zd-UR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:45:22 -0400
Received: by mail-ot1-x343.google.com with SMTP id o6so12035730ota.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JMmm8TGPn//jd5jY6m0a826oipVywIyf/+rAMPgzmhY=;
 b=E1CjE783yBqOVFbA7nfNzhoK068a9Bua+lm14hHj6GfJz2ivyylrxyoL+0kj0ND3iK
 ipYZC2AXgxyBT0dMwjZ2OK1CT51bIox0/t/8lb3wC999bbZNpVyP69gtXgy+iRWxc75Y
 UaZDYk+c71MuzKKWLrnEJ7+0P6FekD7RDHuWQMPcX9tkRPv4s3e8impRm8Rv2JqgF1QV
 DK7BTLJcgehNiq/6ZeJEmYrzEmfUG04+/QRsceBx7+3mrNBF8i2EOVuoS00Ecaa3V6ZQ
 cGb8ZiTrwn0H2yXKGNdvzbggpBo3ZBk/7Zc6EDCAaJLJemswzGF090qu8EFBzKQkvjZd
 eLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JMmm8TGPn//jd5jY6m0a826oipVywIyf/+rAMPgzmhY=;
 b=USiqFDhh3lc8Hyze1RYBPhAJdr6pH3r3KoDvC7yRSWmNpwzMCDJRpWQxpvR4QwFSi7
 0Ep7kuFemW6yid1jkVvXx2JOSLDWxQnbzVGH+nhHtkSBllGH++WHET6EcE44z6ChtHP8
 Hj7vL9A4nvgDikjcZxeB0dOMKrMx2Sctmi869khswh+pVLbIDypYB82YMBAyrAaKRMw+
 1ywtdfC55kciMwfMW2rIS9JnWsm/JltiuSVg1F1oXQeM7FR3DeHXji1phgncqgq/Jp/w
 1R9fHReEHdBCDQBD9/j6BvqLkBM68hYHVZghAZdbfquXkGo4HjebKs6XL1AXOePEJeO4
 7UHQ==
X-Gm-Message-State: AOAM532LGnWn/o0jqiTiZsqskqFdV9en3sD42eFXEuH/aKK9GQlX1PQA
 nB0oMEcmE+iWZjDHjjyHwKPt8tb8QE7J8unHHtI=
X-Google-Smtp-Source: ABdhPJzkJeC8u4ooJFTQ1jmjg/ogq7a4ZYsHt+9WvC9+NVvl/uQE4JCTwExhCLuaPMxwd4+ez3c3AE22A36bcARU+xI=
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr28975320oti.353.1600688718672; 
 Mon, 21 Sep 2020 04:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200921112913.555392-1-mst@redhat.com>
In-Reply-To: <20200921112913.555392-1-mst@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Sep 2020 19:44:42 +0800
Message-ID: <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:30=E5=86=99=E9=81=93=EF=BC=9A
>
> The following changes since commit 053a4177817db307ec854356e95b5b350800a2=
16:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-2020091=
8' into staging (2020-09-18 16:34:26 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to acbdbd5db6dab68534702987a487360fd8ae02b7:
>
>   virtio-iommu-pci: force virtio version 1 (2020-09-21 06:14:46 -0400)
>
> ----------------------------------------------------------------
> virtio,pc,acpi: fixes, tests
>
> Fixes and tests all over the place.
> Batch iommu updates for vdpa.
> Removal of deprecated cpu hotplug commands.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> David Hildenbrand (1):
>       pc: fix auto_enable_numa_with_memhp/auto_enable_numa_with_memdev fo=
r the 5.0 machine
>
> Dima Stepanov (7):
>       vhost: recheck dev state in the vhost_migration_log routine
>       vhost: check queue state in the vhost_dev_set_log routine
>       tests/qtest/vhost-user-test: prepare the tests for adding new dev c=
lass
>       tests/qtest/libqos/virtio-blk: add support for vhost-user-blk
>       tests/qtest/vhost-user-test: add support for the vhost-user-blk dev=
ice
>       tests/qtest/vhost-user-test: add migrate_reconnect test
>       tests/qtest/vhost-user-test: enable the reconnect tests
>
> Eric Auger (2):
>       virtio-iommu: Check gtrees are non null before destroying them
>       virtio-iommu-pci: force virtio version 1
>
> Igor Mammedov (1):
>       cphp: remove deprecated cpu-add command(s)
>
> Jason Wang (3):
>       linux headers: sync to 5.9-rc4
>       vhost: switch to use IOTLB v2 format
>       vhost-vdpa: batch updating IOTLB mappings
>
> Li Qiang (1):
>       virtio-mem: detach the element from the virtqueue when error occurs

Hello Michael,
It seems you lost the virtio-pmem patch.

https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02639.html

Anyway, it can be queued in the next pr.

Thanks,
Li Qiang

>
>  qapi/machine.json                                  |  24 --
>  include/hw/boards.h                                |   1 -
>  include/hw/i386/pc.h                               |   1 -
>  include/hw/virtio/vhost-backend.h                  |   2 +
>  include/hw/virtio/vhost-user-blk.h                 |  10 +
>  include/hw/virtio/vhost-vdpa.h                     |   1 +
>  include/hw/virtio/vhost.h                          |   1 +
>  include/monitor/hmp.h                              |   1 -
>  include/standard-headers/drm/drm_fourcc.h          | 140 ++++++++++
>  include/standard-headers/linux/ethtool.h           |  87 +++++++
>  include/standard-headers/linux/input-event-codes.h |   3 +-
>  include/standard-headers/linux/vhost_types.h       |  11 +
>  include/standard-headers/linux/virtio_9p.h         |   4 +-
>  include/standard-headers/linux/virtio_blk.h        |  26 +-
>  include/standard-headers/linux/virtio_config.h     |   8 +-
>  include/standard-headers/linux/virtio_console.h    |   8 +-
>  include/standard-headers/linux/virtio_net.h        |   6 +-
>  include/standard-headers/linux/virtio_scsi.h       |  20 +-
>  linux-headers/asm-generic/unistd.h                 |   6 +-
>  linux-headers/asm-mips/unistd_n32.h                |   1 +
>  linux-headers/asm-mips/unistd_n64.h                |   1 +
>  linux-headers/asm-mips/unistd_o32.h                |   1 +
>  linux-headers/asm-powerpc/kvm.h                    |   5 +
>  linux-headers/asm-powerpc/unistd_32.h              |   1 +
>  linux-headers/asm-powerpc/unistd_64.h              |   1 +
>  linux-headers/asm-s390/kvm.h                       |   7 +-
>  linux-headers/asm-s390/unistd_32.h                 |   1 +
>  linux-headers/asm-s390/unistd_64.h                 |   1 +
>  linux-headers/asm-x86/unistd_32.h                  |   1 +
>  linux-headers/asm-x86/unistd_64.h                  |   1 +
>  linux-headers/asm-x86/unistd_x32.h                 |   1 +
>  linux-headers/linux/kvm.h                          |   4 +
>  linux-headers/linux/vfio.h                         |   2 +-
>  linux-headers/linux/vhost.h                        |   2 +
>  hw/block/vhost-user-blk.c                          |  19 +-
>  hw/core/machine-hmp-cmds.c                         |  12 -
>  hw/core/machine-qmp-cmds.c                         |  12 -
>  hw/i386/pc.c                                       |  27 --
>  hw/i386/pc_piix.c                                  |   1 -
>  hw/i386/pc_q35.c                                   |   2 +-
>  hw/s390x/s390-virtio-ccw.c                         |  12 -
>  hw/virtio/vhost-backend.c                          |  88 +++++--
>  hw/virtio/vhost-vdpa.c                             |  66 +++++
>  hw/virtio/vhost.c                                  |  49 +++-
>  hw/virtio/virtio-iommu-pci.c                       |   2 +-
>  hw/virtio/virtio-iommu.c                           |   8 +-
>  hw/virtio/virtio-mem.c                             |   3 +
>  tests/qtest/cpu-plug-test.c                        | 100 +------
>  tests/qtest/libqos/virtio-blk.c                    |  14 +-
>  tests/qtest/test-hmp.c                             |   1 -
>  tests/qtest/vhost-user-test.c                      | 289 +++++++++++++++=
+++---
>  docs/system/deprecated.rst                         |  25 +-
>  hmp-commands.hx                                    |  15 --
>  53 files changed, 812 insertions(+), 323 deletions(-)
>
>

