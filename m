Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D9BC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02AE2190D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtTrsa8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02AE2190D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpcKb-0002qr-VO
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpcKR-0002SM-1f
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpcKP-00084m-0E
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:42:26 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpcKM-0007yd-RG
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:42:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id q20so41065736otl.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XjErLDWBOLV/N9/mgOKIvpOAmC9YNtdbiENNijRAyZg=;
 b=vtTrsa8YMWab7BzCBdrjrxZ1lAgfY4kv+jWWgDSU1atlITI1F409zDNfeA/PExLhgW
 +x8Op13CAO23YVHtSo3UrD1av4NaEarrhAUAhc4Hbo45GgURFEzP1XyJ3S01ct5bjYSg
 2e4xx9quISyg6jRWI+ybAYSU+rztD9+IyNxSJAOsKpDBQgzQfX6f9F2L2In+bEukjhtK
 oGlEk1Yt86t5+3FKrdWsJi4f76xdWCDJ5R5G6MBpHH7yI+0sluPokddjrhKHC6+tLFxy
 Ql9It0RWzW6I4h7NsCU6YmYaWM3fM2IKImfwjpAd8EN9w21pFMOCombMiIWlrJYveyAx
 wvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XjErLDWBOLV/N9/mgOKIvpOAmC9YNtdbiENNijRAyZg=;
 b=eFVLyp+H9s/3megHHQUsuA7Q/ceZch7cLlpv6Ti7a1wvYvGipVJEPEKTpLTy5K+U4P
 JsFrBrZX2CaUYF6DWQuNEhiU8AXWIhFOE4CArRIFenkr8AqvVVD84EHWuig8558tsejw
 nSC6YKNWi1AdqdgMYbYVZKfDycARdfRmFukTG7szjrJVNYPgWe7r6V2savRda7ivn1Wx
 wa8FiXqZcO4EZgdVDHYk8YxtHJJ7uqQRqoU0yMcgOpC/1AyycuXY4Lt9x4uX9+P/G0Wo
 r0BhsvK3ghGU0Sh8UiGZaD3c7bntZuI/B7N/Gno9aKWg/rMNATLceYpQex5TcuLhohen
 6GaA==
X-Gm-Message-State: APjAAAU7YNFMVSZxqlpqlftNp9r7MbuxdHg6iS3/GDSKCCPYFIkXsKck
 uPUmQONIrcwpTKJSdC3yrgkInFg3n5JtYNdMQmr6mQ==
X-Google-Smtp-Source: APXvYqzASUnubXKy5bBprutKlhbMqJXvdcUjaGkaHplx+tDaFlEo06IMPEfRLjhq32/65EM3VwL3Lg89EJQMVeDB96I=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr22494766otn.135.1563817332225; 
 Mon, 22 Jul 2019 10:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190722161657.8188-1-pbonzini@redhat.com>
In-Reply-To: <20190722161657.8188-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 18:42:01 +0100
Message-ID: <CAFEAcA_TMSKqAGk0AZy4v9EA15qz8Vu+gzfHb7ngPt5XzWiLFg@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 0/2] More fixes for QEMU 4.1.0-rc2
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jul 2019 at 17:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe96:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190722' into staging (2019-07-22 15:16:48 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 20b25d239ab7a94bb8bff3d0f13a9527ee75cf10:
>
>   i386/kvm: Do not sync nested state during runtime (2019-07-22 18:16:05 +0200)
>
> ----------------------------------------------------------------
> Two more bugfix patches that came in over the weekend.
>
> ----------------------------------------------------------------
> Jan Kiszka (1):
>       i386/kvm: Do not sync nested state during runtime
>
> Zhengui li (1):
>       virtio-scsi: fixed virtio_scsi_ctx_check failed when detaching scsi disk

Hi; this fails "make check" (all hosts):

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm QTEST_QEMU_IMG=qemu-img
tests/qos-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
--test-name="qos-test"
PASS 1 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/ds1338/ds1338-tests/tx-rx
PASS 2 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/pca9552/pca9552-tests/tx-rx
PASS 3 qos-test /arm/imx25-pdk/imx.i2c/i2c-bus/pca9552/pca9552-tests/rx-autoinc
[...]
PASS 35 qos-test
/arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/large_tx/uint_max
PASS 36 qos-test
/arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/large_tx/net_bufsize
PASS 37 qos-test
/arm/virt/virtio-mmio/virtio-bus/virtio-rng-device/virtio/virtio-tests/nop
Broken pipe
/home/linux1/qemu/tests/libqtest.c:145: kill_qemu() detected QEMU
death from signal 11 (Segmentation fault) (core dumped)
Aborted (core dumped)
ERROR - too few tests run (expected 44, got 37)
/home/linux1/qemu/tests/Makefile.include:899: recipe for target
'check-qtest-arm' failed

Segfault seems to be on the test
/arm/virt/virtio-mmio/virtio-bus/virtio-scsi-device/virtio-scsi/virtio-scsi-tests/hotplug

Here's a backtrace (on an s390 box, which happened to be the
easiest to investigate on):

Thread 1 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
0x000000010043feda in aio_disable_external (ctx=0x0) at
/home/linux1/qemu/include/block/aio.h:493
493         atomic_inc(&ctx->external_disable_cnt);
(gdb) bt
#0  0x000000010043feda in aio_disable_external (ctx=0x0) at
/home/linux1/qemu/include/block/aio.h:493
#1  virtio_scsi_hotunplug (hotplug_dev=0x101b19040, dev=0x101c00c00,
errp=0x3ffffffe798)
    at /home/linux1/qemu/hw/scsi/virtio-scsi.c:844
#2  0x000000010053a874 in qdev_unplug (dev=0x101c00c00,
errp=0x3ffffffe848) at /home/linux1/qemu/qdev-monitor.c:831
#3  0x0000000100746c3a in qmp_marshal_device_del (args=<optimized
out>, ret=<optimized out>, errp=0x3ffffffe918)
    at qapi/qapi-commands-qdev.c:99
#4  0x0000000100847f98 in do_qmp_dispatch (errp=0x3ffffffe910,
allow_oob=false, request=0x3ffdc004b00,
    cmds=<optimized out>) at /home/linux1/qemu/qapi/qmp-dispatch.c:131
#5  qmp_dispatch (cmds=<optimized out>, request=0x3ffdc004b00,
allow_oob=<optimized out>)
    at /home/linux1/qemu/qapi/qmp-dispatch.c:174
#6  0x00000001007176a8 in monitor_qmp_dispatch
(mon=mon@entry=0x10123eef0, req=<optimized out>)
    at /home/linux1/qemu/monitor/qmp.c:120
#7  0x0000000100717e92 in monitor_qmp_bh_dispatcher (data=<optimized
out>) at /home/linux1/qemu/monitor/qmp.c:209
#8  0x0000000100894a60 in aio_bh_call (bh=0x10115ec20) at
/home/linux1/qemu/util/async.c:89
#9  aio_bh_poll (ctx=<optimized out>) at /home/linux1/qemu/util/async.c:117
#10 0x0000000100898970 in aio_dispatch (ctx=0x10115e090) at
/home/linux1/qemu/util/aio-posix.c:459
#11 0x00000001008948f0 in aio_ctx_dispatch (source=<optimized out>,
callback=<optimized out>, user_data=<optimized out>)
    at /home/linux1/qemu/util/async.c:260
#12 0x000003fffcb5051e in g_main_context_dispatch () from
/lib/s390x-linux-gnu/libglib-2.0.so.0
#13 0x000000010089778a in glib_pollfds_poll () at
/home/linux1/qemu/util/main-loop.c:218
#14 os_host_main_loop_wait (timeout=<optimized out>) at
/home/linux1/qemu/util/main-loop.c:241
#15 main_loop_wait (nonblocking=<optimized out>) at
/home/linux1/qemu/util/main-loop.c:517
#16 0x000000010053f182 in main_loop () at /home/linux1/qemu/vl.c:1791



You might as well fix the commit message mojibake Philippe pointed
out when you do the respin...

thanks
-- PMM

