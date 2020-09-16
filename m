Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2185D22288
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3/eE+N5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2185D22288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXZl-0004VO-5W
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIXYh-0003Eu-9K
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:33:15 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:42999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIXYf-0005ou-DB
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:33:14 -0400
Received: by mail-ed1-x535.google.com with SMTP id j2so6277025eds.9
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C7yUk7cu+1YU7hT2yaIN+FNVl82uLtIvC9lUwUcMUws=;
 b=g3/eE+N5YNMgKM++EtA0dPl/OlymDqHiXydCwirrmQWKfp7oUv6WDec7fPohNv3kPt
 AkKNr7tcIPe96Wd49/3hkHFoqjSlv7g8Wsqb+5l0u55FPud2JBFYur2Y5cMg2+Q1igvd
 Y8cl9dg3bOO+kDRwdTw3YF/0XV/gnf4N5TApB6O3CElTJV8b75HCd67qiKHuS4zQtH1p
 AVNfeqdconTgBz9I52+0xV2NUARiupuMtat+GweqfBajrtYzYhkiWe6QFjQtuvP4Hk4H
 09oxDfu22OiAqlQw/3ueqlJ+sNFY8hqVcfwXx8Ozs8o6M72zSRoBlN1xqjKsSNm8jtko
 1h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C7yUk7cu+1YU7hT2yaIN+FNVl82uLtIvC9lUwUcMUws=;
 b=MDpOR8LH+XJTUn15ls+ys+PC75TwVKOszBq6Iz84cWaPU9/EInPvi9jiILdKvSS/Sk
 vL9pdA6lyOXyEKRUOHWiej6ooRiYcHRqKRz6r+dZtS/FIXkGWsNeiUoeOcNuq4K/HI8N
 kpt2EheW9garyuc/nukKIsLRNDhlEg3ucX6Cu0+t2XdsW/EnJ7PXnwGvGweqFFfQX5WE
 jQ0ng/oF/uUVFeqFmcPsA3Ldf9Apf8GZSDFrequy9A0iALJaxWUa78qTNB/YOPietyuW
 gDRzWPQrM01sPIsBYlrvdVNpYBohBC1g2+eIYb+dIlCc1jHhz/kMknNoLgz9a3fN81rG
 5gbQ==
X-Gm-Message-State: AOAM530Em8QjA1fqbTxJ5n/2JrH1PwPjEqNdbZbL47TXjvHAFJYhLAdW
 7/bHEVv2Ya2MjW0gqFhDb9wJi2MnPy4sMIWtrlE=
X-Google-Smtp-Source: ABdhPJz8LJuUCwPAQXBEtldx3NAYLkjUFfV/FOw4+7jQKxk4ISTaKMMRRZrJN08Rr+S9k4R6zeBZj7MPKAQ056JgX5I=
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr28568714edo.354.1600263190261; 
 Wed, 16 Sep 2020 06:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200824134431.GA35623@stefanha-x1.localdomain>
In-Reply-To: <20200824134431.GA35623@stefanha-x1.localdomain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 16 Sep 2020 14:32:58 +0100
Message-ID: <CAJSP0QW3xniHzHS=_Ok1D-NuAViHUShCxYs38YDo-YjUxC_+ZA@mail.gmail.com>
Subject: Re: QEMU 5.0 virtio-blk performance regression with high queue depths
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Denis V. Lunev" <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 3:24 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Hi Denis,
> A performance regression was found after the virtio-blk queue-size
> property was increased from 128 to 256 in QEMU 5.0 in commit
> c9b7d9ec21dfca716f0bb3b68dee75660d86629c ("virtio: increase virtqueue
> size for virtio-scsi and virtio-blk"). I wanted to let you know if case
> you have ideas or see something similar.

Ping, have you noticed performance regressions after switching to
virtio-blk queue-size 256?

>
> Throughput and IOPS of the following fio benchmarks dropped by 30-40%:
>
>   # mkfs.xfs /dev/vdb
>   # mount /dev/vdb /mnt
>   # fio --rw=%s --bs=%s --iodepth=64 --runtime=1m --direct=1 --filename=/mnt/%s --name=job1 --ioengine=libaio --thread --group_reporting --numjobs=16 --size=512MB --time_based --output=/tmp/fio_result &> /dev/null
>     - rw: read write
>     - bs: 4k 64k
>
> Note that there are 16 threads submitting 64 requests each! The guest
> block device queue depth will be maxed out. The virtqueue should be full
> most of the time.
>
> Have you seen regressions after virtio-blk queue-size was increased in
> QEMU 5.0?
>
> Here are the details of the host storage:
>
>   # mkfs.xfs /dev/sdb # 60GB SSD drive
>   # mount /dev/sdb /mnt/test
>   # qemu-img create -f qcow2 /mnt/test/storage2.qcow2 40G
>
> The guest command-line is:
>
>   # MALLOC_PERTURB_=1 numactl \
>     -m 1  /usr/libexec/qemu-kvm \
>     -S  \
>     -name 'avocado-vt-vm1'  \
>     -sandbox on  \
>     -machine q35 \
>     -device pcie-root-port,id=pcie-root-port-0,multifunction=on,bus=pcie.0,addr=0x1,chassis=1 \
>     -device pcie-pci-bridge,id=pcie-pci-bridge-0,addr=0x0,bus=pcie-root-port-0  \
>     -nodefaults \
>     -device VGA,bus=pcie.0,addr=0x2 \
>     -m 4096  \
>     -smp 2,maxcpus=2,cores=1,threads=1,dies=1,sockets=2  \
>     -cpu 'IvyBridge',+kvm_pv_unhalt \
>     -chardev socket,server,id=qmp_id_qmpmonitor1,nowait,path=/var/tmp/avocado_bapfdqao/monitor-qmpmonitor1-20200721-014154-5HJGMjxW  \
>     -mon chardev=qmp_id_qmpmonitor1,mode=control \
>     -chardev socket,server,id=qmp_id_catch_monitor,nowait,path=/var/tmp/avocado_bapfdqao/monitor-catch_monitor-20200721-014154-5HJGMjxW  \
>     -mon chardev=qmp_id_catch_monitor,mode=control \
>     -device pvpanic,ioport=0x505,id=id31BN83 \
>     -chardev socket,server,id=chardev_serial0,nowait,path=/var/tmp/avocado_bapfdqao/serial-serial0-20200721-014154-5HJGMjxW \
>     -device isa-serial,id=serial0,chardev=chardev_serial0  \
>     -chardev socket,id=seabioslog_id_20200721-014154-5HJGMjxW,path=/var/tmp/avocado_bapfdqao/seabios-20200721-014154-5HJGMjxW,server,nowait \
>     -device isa-debugcon,chardev=seabioslog_id_20200721-014154-5HJGMjxW,iobase=0x402 \
>     -device pcie-root-port,id=pcie-root-port-1,port=0x1,addr=0x1.0x1,bus=pcie.0,chassis=2 \
>     -device qemu-xhci,id=usb1,bus=pcie-root-port-1,addr=0x0 \
>     -device usb-tablet,id=usb-tablet1,bus=usb1.0,port=1 \
>     -blockdev node-name=file_image1,driver=file,aio=threads,filename=rootfs.qcow2,cache.direct=on,cache.no-flush=off \
>     -blockdev node-name=drive_image1,driver=qcow2,cache.direct=on,cache.no-flush=off,file=file_image1 \
>     -device pcie-root-port,id=pcie-root-port-2,port=0x2,addr=0x1.0x2,bus=pcie.0,chassis=3 \
>     -device virtio-blk-pci,id=image1,drive=drive_image1,bootindex=0,write-cache=on,bus=pcie-root-port-2,addr=0x0 \
>     -blockdev node-name=file_disk1,driver=file,aio=threads,filename=/mnt/test/storage2.qcow2,cache.direct=on,cache.no-flush=off \
>     -blockdev node-name=drive_disk1,driver=qcow2,cache.direct=on,cache.no-flush=off,file=file_disk1 \
>     -device pcie-root-port,id=pcie-root-port-3,port=0x3,addr=0x1.0x3,bus=pcie.0,chassis=4 \
>     -device virtio-blk-pci,id=disk1,drive=drive_disk1,bootindex=1,write-cache=on,bus=pcie-root-port-3,addr=0x0 \
>     -device pcie-root-port,id=pcie-root-port-4,port=0x4,addr=0x1.0x4,bus=pcie.0,chassis=5 \
>     -device virtio-net-pci,mac=9a:37:37:37:37:4e,id=idBMd7vy,netdev=idLb51aS,bus=pcie-root-port-4,addr=0x0  \
>     -netdev tap,id=idLb51aS,fd=14  \
>     -vnc :0  \
>     -rtc base=utc,clock=host,driftfix=slew  \
>     -boot menu=off,order=cdn,once=c,strict=off \
>     -enable-kvm \
>     -device pcie-root-port,id=pcie_extra_root_port_0,multifunction=on,bus=pcie.0,addr=0x3,chassis=6
>
> Stefan

