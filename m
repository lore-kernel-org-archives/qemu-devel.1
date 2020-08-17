Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0592FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C14720772
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjQBfCBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C14720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hpy-0008VF-NX
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hmA-0001c2-Np
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:14:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k7hm6-0004Ma-44
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597680857;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JVcWO40yqjkk2x4rWwpmMLo4Du+ozJEVA0LJuCsd20=;
 b=EjQBfCBptEv54xHTghphhdzKsOaF1kAOAwIW2pj7hozAk/LDrg1MWx3EPBexjWvy2+hHGw
 lrstUx0XcYjZKB4yV3hIZLPdMKo5blfz7nQ6YmwhKMO2FhW8Ll326iRUCsWAJmoaM/z8DE
 ZHE3HfeQZDchDKSQJmc83GZd+jbcKXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-or0bc-rUO82eFFgHXObsYA-1; Mon, 17 Aug 2020 12:14:14 -0400
X-MC-Unique: or0bc-rUO82eFFgHXObsYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DF1D801AC3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 16:14:13 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C15395D9E2;
 Mon, 17 Aug 2020 16:14:11 +0000 (UTC)
Date: Mon, 17 Aug 2020 17:14:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 34/41] [automated] Use TYPE_INFO macro
Message-ID: <20200817161408.GF4775@redhat.com>
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-35-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-35-ehabkost@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 06:26:18PM -0400, Eduardo Habkost wrote:
> Generated using:
>   $ ./scripts/codeconverter/converter.py -i --passes=2 \
>     --pattern=TypeRegisterCall,TypeInitMacro $(git grep -l TypeInfo -- '*.[ch]')
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

One notable difference is that files declaring multiple types
will now have multiple separate __construtor__ functions
declared, instead of one for all types.

I don't think that actually matters in practice but probably
worth mentioning in the commit message as a FYI in case
anyone has cause to look back.

> ---
>  accel/accel.c                       |  6 +-----
>  accel/kvm/kvm-all.c                 |  6 +-----
>  accel/qtest.c                       |  6 +-----
>  accel/tcg/tcg-all.c                 |  6 +-----
>  accel/xen/xen-all.c                 |  6 +-----
>  authz/base.c                        |  6 +-----
>  authz/list.c                        |  7 +------
>  authz/listfile.c                    |  7 +------
>  authz/pamacct.c                     |  7 +------
>  authz/simple.c                      |  7 +------
>  backends/cryptodev-builtin.c        |  7 +------
>  backends/cryptodev-vhost-user.c     |  7 +------
>  backends/cryptodev.c                |  7 +------
>  backends/dbus-vmstate.c             |  7 +------
>  backends/hostmem-file.c             |  6 +-----
>  backends/hostmem-memfd.c            |  2 +-
>  backends/hostmem-ram.c              |  6 +-----
>  backends/hostmem.c                  |  6 +-----
>  backends/rng-builtin.c              |  6 +-----
>  backends/rng-egd.c                  |  6 +-----
>  backends/rng-random.c               |  6 +-----
>  backends/rng.c                      |  6 +-----
>  backends/tpm/tpm_backend.c          |  8 ++------
>  backends/tpm/tpm_emulator.c         |  6 +-----
>  backends/tpm/tpm_passthrough.c      |  6 +-----
>  backends/vhost-user.c               |  6 +-----
>  block/throttle-groups.c             |  6 +-----
>  chardev/baum.c                      |  6 +-----
>  chardev/char-console.c              |  6 +-----
>  chardev/char-fd.c                   |  6 +-----
>  chardev/char-mux.c                  |  6 +-----
>  chardev/char-null.c                 |  6 +-----
>  chardev/char-parallel.c             |  6 +-----
>  chardev/char-pty.c                  |  6 +-----
>  chardev/char-ringbuf.c              |  8 ++------
>  chardev/char-socket.c               |  6 +-----
>  chardev/char-udp.c                  |  6 +-----
>  chardev/char-win-stdio.c            |  6 +-----
>  chardev/char-win.c                  |  6 +-----
>  chardev/char.c                      |  6 +-----
>  chardev/msmouse.c                   |  6 +-----
>  chardev/spice.c                     | 10 +++-------
>  chardev/testdev.c                   |  6 +-----
>  chardev/wctablet.c                  |  6 +-----
>  crypto/secret.c                     |  7 +------
>  crypto/secret_common.c              |  7 +------
>  crypto/secret_keyring.c             |  7 +------
>  crypto/tls-cipher-suites.c          |  6 +-----
>  crypto/tlscreds.c                   |  7 +------
>  crypto/tlscredsanon.c               |  7 +------
>  crypto/tlscredspsk.c                |  7 +------
>  crypto/tlscredsx509.c               |  7 +------
>  gdbstub.c                           |  6 +-----
>  hw/9pfs/virtio-9p-device.c          |  6 +-----
>  hw/acpi/generic_event_device.c      |  6 +-----
>  hw/acpi/piix4.c                     |  6 +-----
>  hw/acpi/vmgenid.c                   |  6 +-----
>  hw/adc/stm32f2xx_adc.c              |  6 +-----
>  hw/alpha/typhoon.c                  |  8 ++------
>  hw/arm/allwinner-a10.c              |  6 +-----
>  hw/arm/allwinner-h3.c               |  6 +-----
>  hw/arm/armsse.c                     |  2 +-
>  hw/arm/armv7m.c                     |  8 ++------
>  hw/arm/bcm2835_peripherals.c        |  6 +-----
>  hw/arm/bcm2836.c                    |  2 +-
>  hw/arm/boot.c                       |  6 +-----
>  hw/arm/collie.c                     |  6 +-----
>  hw/arm/digic.c                      |  6 +-----
>  hw/arm/exynos4210.c                 |  6 +-----
>  hw/arm/exynos4_boards.c             |  8 ++------
>  hw/arm/fsl-imx25.c                  |  6 +-----
>  hw/arm/fsl-imx31.c                  |  6 +-----
>  hw/arm/fsl-imx6.c                   |  6 +-----
>  hw/arm/fsl-imx6ul.c                 |  6 +-----
>  hw/arm/fsl-imx7.c                   |  6 +-----
>  hw/arm/gumstix.c                    |  8 ++------
>  hw/arm/highbank.c                   | 14 +++-----------
>  hw/arm/integratorcp.c               | 10 +++-------
>  hw/arm/microbit.c                   |  6 +-----
>  hw/arm/mps2-tz.c                    | 10 +++-------
>  hw/arm/mps2.c                       | 10 +++-------
>  hw/arm/msf2-soc.c                   |  6 +-----
>  hw/arm/musca.c                      | 10 +++-------
>  hw/arm/musicpal.c                   | 22 +++++++++-------------
>  hw/arm/nrf51_soc.c                  |  6 +-----
>  hw/arm/nseries.c                    |  8 ++------
>  hw/arm/omap_sx1.c                   |  8 ++------
>  hw/arm/palm.c                       |  6 +-----
>  hw/arm/pxa2xx.c                     | 14 +++++---------
>  hw/arm/pxa2xx_gpio.c                |  6 +-----
>  hw/arm/pxa2xx_pic.c                 |  6 +-----
>  hw/arm/realview.c                   | 12 ++++--------
>  hw/arm/sbsa-ref.c                   |  6 +-----
>  hw/arm/smmu-common.c                |  6 +-----
>  hw/arm/spitz.c                      | 28 ++++++++++------------------
>  hw/arm/stellaris.c                  | 18 +++++-------------
>  hw/arm/stm32f205_soc.c              |  6 +-----
>  hw/arm/stm32f405_soc.c              |  6 +-----
>  hw/arm/strongarm.c                  | 16 ++++++----------
>  hw/arm/tosa.c                       | 10 +++-------
>  hw/arm/versatilepb.c                | 14 +++-----------
>  hw/arm/vexpress.c                   | 10 +++-------
>  hw/arm/virt.c                       |  6 +-----
>  hw/arm/xilinx_zynq.c                |  6 +-----
>  hw/arm/xlnx-versal-virt.c           |  6 +-----
>  hw/arm/xlnx-versal.c                |  6 +-----
>  hw/arm/xlnx-zcu102.c                |  6 +-----
>  hw/arm/xlnx-zynqmp.c                |  6 +-----
>  hw/audio/cs4231.c                   |  6 +-----
>  hw/audio/hda-codec.c                | 12 ++++--------
>  hw/audio/intel-hda.c                | 10 +++++-----
>  hw/audio/marvell_88w8618.c          |  6 +-----
>  hw/audio/milkymist-ac97.c           |  6 +-----
>  hw/audio/pcspk.c                    |  2 +-
>  hw/audio/pl041.c                    |  6 +-----
>  hw/audio/wm8750.c                   |  6 +-----
>  hw/block/fdc.c                      | 16 ++++++----------
>  hw/block/m25p80.c                   |  2 +-
>  hw/block/nand.c                     |  6 +-----
>  hw/block/nvme.c                     |  6 +-----
>  hw/block/onenand.c                  |  6 +-----
>  hw/block/pflash_cfi01.c             |  6 +-----
>  hw/block/pflash_cfi02.c             |  6 +-----
>  hw/block/swim.c                     | 10 +++-------
>  hw/block/vhost-user-blk.c           |  6 +-----
>  hw/block/virtio-blk.c               |  6 +-----
>  hw/block/xen-block.c                | 10 +++-------
>  hw/char/avr_usart.c                 |  6 +-----
>  hw/char/bcm2835_aux.c               |  6 +-----
>  hw/char/cadence_uart.c              |  6 +-----
>  hw/char/cmsdk-apb-uart.c            |  6 +-----
>  hw/char/debugcon.c                  |  6 +-----
>  hw/char/digic-uart.c                |  6 +-----
>  hw/char/escc.c                      |  6 +-----
>  hw/char/etraxfs_ser.c               |  6 +-----
>  hw/char/exynos4210_uart.c           |  6 +-----
>  hw/char/grlib_apbuart.c             |  6 +-----
>  hw/char/ibex_uart.c                 |  6 +-----
>  hw/char/imx_serial.c                |  6 +-----
>  hw/char/ipoctal232.c                |  6 +-----
>  hw/char/lm32_juart.c                |  6 +-----
>  hw/char/lm32_uart.c                 |  6 +-----
>  hw/char/mcf_uart.c                  |  6 +-----
>  hw/char/milkymist-uart.c            |  6 +-----
>  hw/char/nrf51_uart.c                |  6 +-----
>  hw/char/parallel.c                  |  6 +-----
>  hw/char/pl011.c                     |  8 ++------
>  hw/char/renesas_sci.c               |  6 +-----
>  hw/char/sclpconsole-lm.c            |  6 +-----
>  hw/char/sclpconsole.c               |  6 +-----
>  hw/char/serial-isa.c                |  6 +-----
>  hw/char/serial-pci-multi.c          |  8 ++------
>  hw/char/serial-pci.c                |  6 +-----
>  hw/char/serial.c                    | 10 +++-------
>  hw/char/spapr_vty.c                 |  2 +-
>  hw/char/stm32f2xx_usart.c           |  6 +-----
>  hw/char/terminal3270.c              |  6 +-----
>  hw/char/virtio-console.c            |  8 ++------
>  hw/char/virtio-serial-bus.c         | 10 +++-------
>  hw/char/xilinx_uartlite.c           |  6 +-----
>  hw/core/bus.c                       |  6 +-----
>  hw/core/clock.c                     |  6 +-----
>  hw/core/cpu.c                       |  6 +-----
>  hw/core/fw-path-provider.c          |  6 +-----
>  hw/core/generic-loader.c            |  6 +-----
>  hw/core/hotplug.c                   |  6 +-----
>  hw/core/irq.c                       |  6 +-----
>  hw/core/machine.c                   |  6 +-----
>  hw/core/nmi.c                       |  6 +-----
>  hw/core/or-irq.c                    |  6 +-----
>  hw/core/platform-bus.c              |  6 +-----
>  hw/core/qdev.c                      |  6 +-----
>  hw/core/register.c                  |  6 +-----
>  hw/core/resettable.c                |  6 +-----
>  hw/core/split-irq.c                 |  6 +-----
>  hw/core/stream.c                    |  6 +-----
>  hw/core/sysbus.c                    |  8 ++------
>  hw/core/vmstate-if.c                |  6 +-----
>  hw/cpu/a15mpcore.c                  |  6 +-----
>  hw/cpu/a9mpcore.c                   |  6 +-----
>  hw/cpu/arm11mpcore.c                |  6 +-----
>  hw/cpu/cluster.c                    |  6 +-----
>  hw/cpu/core.c                       |  6 +-----
>  hw/cpu/realview_mpcore.c            |  6 +-----
>  hw/display/ads7846.c                |  6 +-----
>  hw/display/artist.c                 |  6 +-----
>  hw/display/ati.c                    |  6 +-----
>  hw/display/bcm2835_fb.c             |  6 +-----
>  hw/display/bochs-display.c          |  6 +-----
>  hw/display/cg3.c                    |  6 +-----
>  hw/display/cirrus_vga.c             |  6 +-----
>  hw/display/cirrus_vga_isa.c         |  6 +-----
>  hw/display/dpcd.c                   |  6 +-----
>  hw/display/exynos4210_fimd.c        |  6 +-----
>  hw/display/g364fb.c                 |  6 +-----
>  hw/display/i2c-ddc.c                |  6 +-----
>  hw/display/jazz_led.c               |  6 +-----
>  hw/display/macfb.c                  |  8 ++------
>  hw/display/milkymist-tmu2.c         |  6 +-----
>  hw/display/milkymist-vgafb.c        |  6 +-----
>  hw/display/next-fb.c                |  6 +-----
>  hw/display/pl110.c                  | 10 +++-------
>  hw/display/qxl.c                    | 10 +++-------
>  hw/display/ramfb-standalone.c       |  6 +-----
>  hw/display/sii9022.c                |  6 +-----
>  hw/display/sm501.c                  |  8 ++------
>  hw/display/ssd0303.c                |  6 +-----
>  hw/display/ssd0323.c                |  6 +-----
>  hw/display/tcx.c                    |  6 +-----
>  hw/display/vga-isa.c                |  6 +-----
>  hw/display/vga-pci.c                | 10 +++-------
>  hw/display/vhost-user-gpu.c         |  6 +-----
>  hw/display/virtio-gpu-base.c        |  7 +------
>  hw/display/virtio-gpu-pci.c         |  2 +-
>  hw/display/virtio-gpu.c             |  6 +-----
>  hw/display/virtio-vga.c             |  2 +-
>  hw/display/vmware_vga.c             |  6 +-----
>  hw/display/xlnx_dp.c                |  6 +-----
>  hw/dma/bcm2835_dma.c                |  6 +-----
>  hw/dma/i82374.c                     |  6 +-----
>  hw/dma/i8257.c                      |  6 +-----
>  hw/dma/pl080.c                      |  8 ++------
>  hw/dma/pl330.c                      |  6 +-----
>  hw/dma/puv3_dma.c                   |  6 +-----
>  hw/dma/pxa2xx_dma.c                 |  6 +-----
>  hw/dma/rc4030.c                     |  8 ++------
>  hw/dma/sparc32_dma.c                | 12 ++++--------
>  hw/dma/xilinx_axidma.c              | 10 +++-------
>  hw/dma/xlnx-zdma.c                  |  6 +-----
>  hw/dma/xlnx-zynq-devcfg.c           |  6 +-----
>  hw/dma/xlnx_dpdma.c                 |  6 +-----
>  hw/gpio/aspeed_gpio.c               | 14 +++++---------
>  hw/gpio/bcm2835_gpio.c              |  6 +-----
>  hw/gpio/gpio_key.c                  |  6 +-----
>  hw/gpio/imx_gpio.c                  |  6 +-----
>  hw/gpio/max7310.c                   |  6 +-----
>  hw/gpio/mpc8xxx.c                   |  6 +-----
>  hw/gpio/nrf51_gpio.c                |  6 +-----
>  hw/gpio/omap_gpio.c                 |  8 ++------
>  hw/gpio/pl061.c                     |  8 ++------
>  hw/gpio/puv3_gpio.c                 |  6 +-----
>  hw/gpio/zaurus.c                    |  6 +-----
>  hw/hppa/dino.c                      |  6 +-----
>  hw/hppa/lasi.c                      |  6 +-----
>  hw/hyperv/hyperv.c                  |  6 +-----
>  hw/hyperv/hyperv_testdev.c          |  6 +-----
>  hw/hyperv/vmbus.c                   | 10 +++-------
>  hw/i2c/aspeed_i2c.c                 | 12 ++++--------
>  hw/i2c/bitbang_i2c.c                |  6 +-----
>  hw/i2c/core.c                       |  8 ++------
>  hw/i2c/exynos4210_i2c.c             |  6 +-----
>  hw/i2c/imx_i2c.c                    |  6 +-----
>  hw/i2c/microbit_i2c.c               |  6 +-----
>  hw/i2c/mpc_i2c.c                    |  6 +-----
>  hw/i2c/omap_i2c.c                   |  6 +-----
>  hw/i2c/ppc4xx_i2c.c                 |  6 +-----
>  hw/i2c/smbus_eeprom.c               |  6 +-----
>  hw/i2c/smbus_ich9.c                 |  6 +-----
>  hw/i2c/smbus_slave.c                |  6 +-----
>  hw/i2c/versatile_i2c.c              |  6 +-----
>  hw/i386/amd_iommu.c                 | 10 +++-------
>  hw/i386/intel_iommu.c               |  8 ++------
>  hw/i386/kvm/apic.c                  |  6 +-----
>  hw/i386/kvm/clock.c                 |  6 +-----
>  hw/i386/kvm/i8254.c                 |  6 +-----
>  hw/i386/kvm/i8259.c                 |  6 +-----
>  hw/i386/kvm/ioapic.c                |  6 +-----
>  hw/i386/kvmvapic.c                  |  6 +-----
>  hw/i386/microvm.c                   |  6 +-----
>  hw/i386/pc.c                        |  6 +-----
>  hw/i386/pc_piix.c                   |  6 +-----
>  hw/i386/port92.c                    |  6 +-----
>  hw/i386/vmmouse.c                   |  6 +-----
>  hw/i386/vmport.c                    |  6 +-----
>  hw/i386/x86-iommu.c                 |  6 +-----
>  hw/i386/x86.c                       |  6 +-----
>  hw/i386/xen/xen_apic.c              |  6 +-----
>  hw/i386/xen/xen_platform.c          |  6 +-----
>  hw/i386/xen/xen_pvdevice.c          |  6 +-----
>  hw/ide/ahci-allwinner.c             |  6 +-----
>  hw/ide/ahci.c                       |  6 +-----
>  hw/ide/cmd646.c                     |  6 +-----
>  hw/ide/ich.c                        |  6 +-----
>  hw/ide/isa.c                        |  6 +-----
>  hw/ide/macio.c                      |  6 +-----
>  hw/ide/microdrive.c                 |  8 ++------
>  hw/ide/mmio.c                       |  6 +-----
>  hw/ide/pci.c                        |  6 +-----
>  hw/ide/piix.c                       | 10 +++-------
>  hw/ide/qdev.c                       | 14 +++++---------
>  hw/ide/sii3112.c                    |  6 +-----
>  hw/ide/via.c                        |  6 +-----
>  hw/input/adb-kbd.c                  |  6 +-----
>  hw/input/adb-mouse.c                |  6 +-----
>  hw/input/adb.c                      |  8 ++------
>  hw/input/lm832x.c                   |  6 +-----
>  hw/input/milkymist-softusb.c        |  6 +-----
>  hw/input/pckbd.c                    |  6 +-----
>  hw/input/pl050.c                    | 10 +++-------
>  hw/input/vhost-user-input.c         |  6 +-----
>  hw/input/virtio-input-hid.c         | 12 ++++--------
>  hw/input/virtio-input-host.c        |  6 +-----
>  hw/input/virtio-input.c             |  6 +-----
>  hw/intc/allwinner-a10-pic.c         |  6 +-----
>  hw/intc/apic.c                      |  6 +-----
>  hw/intc/apic_common.c               |  6 +-----
>  hw/intc/arm_gic.c                   |  6 +-----
>  hw/intc/arm_gic_common.c            |  6 +-----
>  hw/intc/arm_gic_kvm.c               |  6 +-----
>  hw/intc/arm_gicv2m.c                |  6 +-----
>  hw/intc/arm_gicv3.c                 |  6 +-----
>  hw/intc/arm_gicv3_common.c          |  6 +-----
>  hw/intc/arm_gicv3_its_common.c      |  6 +-----
>  hw/intc/arm_gicv3_its_kvm.c         |  6 +-----
>  hw/intc/arm_gicv3_kvm.c             |  6 +-----
>  hw/intc/armv7m_nvic.c               |  6 +-----
>  hw/intc/aspeed_vic.c                |  6 +-----
>  hw/intc/bcm2835_ic.c                |  6 +-----
>  hw/intc/bcm2836_control.c           |  6 +-----
>  hw/intc/etraxfs_pic.c               |  6 +-----
>  hw/intc/exynos4210_combiner.c       |  6 +-----
>  hw/intc/exynos4210_gic.c            | 12 ++----------
>  hw/intc/grlib_irqmp.c               |  6 +-----
>  hw/intc/heathrow_pic.c              |  6 +-----
>  hw/intc/i8259.c                     |  6 +-----
>  hw/intc/i8259_common.c              |  6 +-----
>  hw/intc/ibex_plic.c                 |  6 +-----
>  hw/intc/imx_avic.c                  |  6 +-----
>  hw/intc/imx_gpcv2.c                 |  6 +-----
>  hw/intc/intc.c                      |  6 +-----
>  hw/intc/ioapic.c                    |  6 +-----
>  hw/intc/ioapic_common.c             |  6 +-----
>  hw/intc/lm32_pic.c                  |  6 +-----
>  hw/intc/loongson_liointc.c          |  6 +-----
>  hw/intc/mips_gic.c                  |  6 +-----
>  hw/intc/nios2_iic.c                 |  6 +-----
>  hw/intc/omap_intc.c                 | 10 +++-------
>  hw/intc/ompic.c                     |  6 +-----
>  hw/intc/openpic.c                   |  6 +-----
>  hw/intc/openpic_kvm.c               |  6 +-----
>  hw/intc/pl190.c                     |  6 +-----
>  hw/intc/pnv_xive.c                  |  6 +-----
>  hw/intc/puv3_intc.c                 |  6 +-----
>  hw/intc/realview_gic.c              |  6 +-----
>  hw/intc/rx_icu.c                    |  6 +-----
>  hw/intc/s390_flic.c                 |  8 ++------
>  hw/intc/s390_flic_kvm.c             |  6 +-----
>  hw/intc/slavio_intctl.c             |  6 +-----
>  hw/intc/spapr_xive.c                |  6 +-----
>  hw/intc/xics.c                      | 10 +++-------
>  hw/intc/xics_pnv.c                  |  6 +-----
>  hw/intc/xics_spapr.c                |  6 +-----
>  hw/intc/xilinx_intc.c               |  6 +-----
>  hw/intc/xive.c                      | 18 +++++++-----------
>  hw/intc/xlnx-pmu-iomod-intc.c       |  6 +-----
>  hw/intc/xlnx-zynqmp-ipi.c           |  6 +-----
>  hw/ipack/ipack.c                    |  8 ++------
>  hw/ipack/tpci200.c                  |  6 +-----
>  hw/ipmi/ipmi.c                      |  8 ++------
>  hw/ipmi/ipmi_bmc_sim.c              |  6 +-----
>  hw/ipmi/isa_ipmi_bt.c               |  6 +-----
>  hw/ipmi/isa_ipmi_kcs.c              |  6 +-----
>  hw/ipmi/pci_ipmi_bt.c               |  6 +-----
>  hw/ipmi/pci_ipmi_kcs.c              |  6 +-----
>  hw/ipmi/smbus_ipmi.c                |  6 +-----
>  hw/isa/i82378.c                     |  6 +-----
>  hw/isa/isa-bus.c                    | 12 ++++--------
>  hw/isa/isa-superio.c                |  8 ++------
>  hw/isa/lpc_ich9.c                   |  6 +-----
>  hw/isa/pc87312.c                    |  6 +-----
>  hw/isa/piix3.c                      | 10 +++-------
>  hw/isa/piix4.c                      |  6 +-----
>  hw/isa/smc37c669-superio.c          |  6 +-----
>  hw/isa/vt82c686.c                   | 14 +++++---------
>  hw/lm32/lm32_boards.c               |  8 ++------
>  hw/m68k/mcf_intc.c                  |  6 +-----
>  hw/m68k/next-cube.c                 |  6 +-----
>  hw/m68k/next-kbd.c                  |  6 +-----
>  hw/m68k/q800.c                      |  6 +-----
>  hw/mem/memory-device.c              |  6 +-----
>  hw/mem/nvdimm.c                     |  6 +-----
>  hw/mem/pc-dimm.c                    |  6 +-----
>  hw/microblaze/xlnx-zynqmp-pmu.c     |  6 +-----
>  hw/mips/boston.c                    |  6 +-----
>  hw/mips/cps.c                       |  6 +-----
>  hw/mips/gt64xxx_pci.c               |  8 ++------
>  hw/mips/jazz.c                      |  8 ++------
>  hw/mips/malta.c                     |  6 +-----
>  hw/misc/a9scu.c                     |  6 +-----
>  hw/misc/allwinner-cpucfg.c          |  6 +-----
>  hw/misc/allwinner-h3-ccu.c          |  6 +-----
>  hw/misc/allwinner-h3-dramc.c        |  6 +-----
>  hw/misc/allwinner-h3-sysctrl.c      |  6 +-----
>  hw/misc/allwinner-sid.c             |  6 +-----
>  hw/misc/applesmc.c                  |  6 +-----
>  hw/misc/arm11scu.c                  |  6 +-----
>  hw/misc/arm_integrator_debug.c      |  6 +-----
>  hw/misc/arm_l2x0.c                  |  6 +-----
>  hw/misc/arm_sysctl.c                |  6 +-----
>  hw/misc/armsse-cpuid.c              |  6 +-----
>  hw/misc/armsse-mhu.c                |  6 +-----
>  hw/misc/aspeed_scu.c                | 12 ++++--------
>  hw/misc/aspeed_sdmc.c               | 12 ++++--------
>  hw/misc/aspeed_xdma.c               |  6 +-----
>  hw/misc/auxbus.c                    | 10 +++-------
>  hw/misc/avr_power.c                 |  6 +-----
>  hw/misc/bcm2835_mbox.c              |  6 +-----
>  hw/misc/bcm2835_mphi.c              |  6 +-----
>  hw/misc/bcm2835_property.c          |  6 +-----
>  hw/misc/bcm2835_rng.c               |  6 +-----
>  hw/misc/bcm2835_thermal.c           |  6 +-----
>  hw/misc/debugexit.c                 |  6 +-----
>  hw/misc/eccmemctl.c                 |  6 +-----
>  hw/misc/empty_slot.c                |  6 +-----
>  hw/misc/exynos4210_clk.c            |  2 +-
>  hw/misc/exynos4210_pmu.c            |  6 +-----
>  hw/misc/exynos4210_rng.c            |  6 +-----
>  hw/misc/grlib_ahb_apb_pnp.c         |  8 ++------
>  hw/misc/imx25_ccm.c                 |  6 +-----
>  hw/misc/imx31_ccm.c                 |  6 +-----
>  hw/misc/imx6_ccm.c                  |  6 +-----
>  hw/misc/imx6_src.c                  |  6 +-----
>  hw/misc/imx6ul_ccm.c                |  6 +-----
>  hw/misc/imx7_ccm.c                  |  8 ++------
>  hw/misc/imx7_gpr.c                  |  6 +-----
>  hw/misc/imx7_snvs.c                 |  6 +-----
>  hw/misc/imx_ccm.c                   |  6 +-----
>  hw/misc/imx_rngc.c                  |  6 +-----
>  hw/misc/iotkit-secctl.c             |  6 +-----
>  hw/misc/iotkit-sysctl.c             |  6 +-----
>  hw/misc/iotkit-sysinfo.c            |  6 +-----
>  hw/misc/ivshmem.c                   | 10 +++-------
>  hw/misc/mac_via.c                   | 10 +++-------
>  hw/misc/macio/cuda.c                |  8 ++------
>  hw/misc/macio/gpio.c                |  6 +-----
>  hw/misc/macio/mac_dbdma.c           |  6 +-----
>  hw/misc/macio/macio.c               | 12 ++++--------
>  hw/misc/macio/pmu.c                 |  8 ++------
>  hw/misc/max111x.c                   | 10 +++-------
>  hw/misc/milkymist-hpdmc.c           |  6 +-----
>  hw/misc/milkymist-pfpu.c            |  6 +-----
>  hw/misc/mips_cmgcr.c                |  6 +-----
>  hw/misc/mips_cpc.c                  |  6 +-----
>  hw/misc/mips_itu.c                  |  6 +-----
>  hw/misc/mos6522.c                   |  6 +-----
>  hw/misc/mps2-fpgaio.c               |  6 +-----
>  hw/misc/mps2-scc.c                  |  6 +-----
>  hw/misc/msf2-sysreg.c               |  6 +-----
>  hw/misc/mst_fpga.c                  |  6 +-----
>  hw/misc/nrf51_rng.c                 |  6 +-----
>  hw/misc/pc-testdev.c                |  6 +-----
>  hw/misc/pca9552.c                   |  8 ++------
>  hw/misc/pci-testdev.c               |  6 +-----
>  hw/misc/puv3_pm.c                   |  6 +-----
>  hw/misc/pvpanic.c                   |  6 +-----
>  hw/misc/sga.c                       |  6 +-----
>  hw/misc/slavio_misc.c               |  8 ++------
>  hw/misc/stm32f2xx_syscfg.c          |  6 +-----
>  hw/misc/stm32f4xx_exti.c            |  6 +-----
>  hw/misc/stm32f4xx_syscfg.c          |  6 +-----
>  hw/misc/tmp105.c                    |  6 +-----
>  hw/misc/tmp421.c                    |  2 +-
>  hw/misc/tz-mpc.c                    |  8 ++------
>  hw/misc/tz-msc.c                    |  6 +-----
>  hw/misc/tz-ppc.c                    |  6 +-----
>  hw/misc/unimp.c                     |  6 +-----
>  hw/misc/vmcoreinfo.c                |  6 +-----
>  hw/misc/zynq-xadc.c                 |  6 +-----
>  hw/misc/zynq_slcr.c                 |  6 +-----
>  hw/net/allwinner-sun8i-emac.c       |  6 +-----
>  hw/net/allwinner_emac.c             |  6 +-----
>  hw/net/cadence_gem.c                |  6 +-----
>  hw/net/can/can_kvaser_pci.c         |  6 +-----
>  hw/net/can/can_mioe3680_pci.c       |  6 +-----
>  hw/net/can/can_pcm3680_pci.c        |  6 +-----
>  hw/net/dp8393x.c                    |  6 +-----
>  hw/net/e1000.c                      |  2 +-
>  hw/net/e1000e.c                     |  6 +-----
>  hw/net/etraxfs_eth.c                |  6 +-----
>  hw/net/fsl_etsec/etsec.c            |  6 +-----
>  hw/net/ftgmac100.c                  |  8 ++------
>  hw/net/imx_fec.c                    |  8 ++------
>  hw/net/lan9118.c                    |  6 +-----
>  hw/net/lance.c                      |  6 +-----
>  hw/net/lasi_i82596.c                |  6 +-----
>  hw/net/mcf_fec.c                    |  6 +-----
>  hw/net/milkymist-minimac2.c         |  6 +-----
>  hw/net/mipsnet.c                    |  6 +-----
>  hw/net/msf2-emac.c                  |  6 +-----
>  hw/net/ne2000-isa.c                 |  6 +-----
>  hw/net/ne2000-pci.c                 |  6 +-----
>  hw/net/opencores_eth.c              |  6 +-----
>  hw/net/pcnet-pci.c                  |  6 +-----
>  hw/net/rocker/rocker.c              |  6 +-----
>  hw/net/rtl8139.c                    |  6 +-----
>  hw/net/smc91c111.c                  |  6 +-----
>  hw/net/spapr_llan.c                 |  2 +-
>  hw/net/stellaris_enet.c             |  6 +-----
>  hw/net/sungem.c                     |  6 +-----
>  hw/net/sunhme.c                     |  6 +-----
>  hw/net/tulip.c                      |  6 +-----
>  hw/net/virtio-net.c                 |  6 +-----
>  hw/net/vmxnet3.c                    |  2 +-
>  hw/net/xgmac.c                      |  6 +-----
>  hw/net/xilinx_axienet.c             | 10 +++-------
>  hw/net/xilinx_ethlite.c             |  6 +-----
>  hw/nubus/mac-nubus-bridge.c         |  6 +-----
>  hw/nubus/nubus-bridge.c             |  6 +-----
>  hw/nubus/nubus-bus.c                |  6 +-----
>  hw/nubus/nubus-device.c             |  6 +-----
>  hw/nvram/ds1225y.c                  |  6 +-----
>  hw/nvram/eeprom_at24c.c             |  6 +-----
>  hw/nvram/fw_cfg.c                   | 12 ++++--------
>  hw/nvram/mac_nvram.c                |  6 +-----
>  hw/nvram/nrf51_nvm.c                |  6 +-----
>  hw/nvram/spapr_nvram.c              |  6 +-----
>  hw/pci-bridge/dec.c                 | 10 +++-------
>  hw/pci-bridge/i82801b11.c           |  6 +-----
>  hw/pci-bridge/ioh3420.c             |  6 +-----
>  hw/pci-bridge/pci_bridge_dev.c      |  8 ++------
>  hw/pci-bridge/pci_expander_bridge.c | 14 +++++---------
>  hw/pci-bridge/pcie_pci_bridge.c     |  6 +-----
>  hw/pci-bridge/pcie_root_port.c      |  6 +-----
>  hw/pci-bridge/simba.c               |  6 +-----
>  hw/pci-bridge/xio3130_downstream.c  |  6 +-----
>  hw/pci-bridge/xio3130_upstream.c    |  6 +-----
>  hw/pci-host/bonito.c                |  8 ++------
>  hw/pci-host/designware.c            |  8 ++------
>  hw/pci-host/gpex.c                  |  8 ++------
>  hw/pci-host/grackle.c               |  8 ++------
>  hw/pci-host/i440fx.c                |  8 ++------
>  hw/pci-host/pnv_phb3.c              | 12 ++++--------
>  hw/pci-host/pnv_phb3_msi.c          |  6 +-----
>  hw/pci-host/pnv_phb3_pbcq.c         |  6 +-----
>  hw/pci-host/pnv_phb4.c              | 12 ++++--------
>  hw/pci-host/pnv_phb4_pec.c          |  8 ++------
>  hw/pci-host/ppce500.c               |  8 ++------
>  hw/pci-host/prep.c                  |  8 ++------
>  hw/pci-host/q35.c                   |  8 ++------
>  hw/pci-host/sabre.c                 |  8 ++------
>  hw/pci-host/uninorth.c              | 18 +++++++++---------
>  hw/pci-host/versatile.c             | 10 +++-------
>  hw/pci-host/xen_igd_pt.c            |  6 +-----
>  hw/pci-host/xilinx-pcie.c           |  8 ++------
>  hw/pci/pci.c                        | 14 +++++---------
>  hw/pci/pci_bridge.c                 |  6 +-----
>  hw/pci/pci_host.c                   |  6 +-----
>  hw/pci/pcie_host.c                  |  6 +-----
>  hw/pci/pcie_port.c                  |  8 ++------
>  hw/pcmcia/pcmcia.c                  |  6 +-----
>  hw/pcmcia/pxa2xx.c                  |  6 +-----
>  hw/ppc/e500.c                       |  8 ++------
>  hw/ppc/e500plat.c                   |  6 +-----
>  hw/ppc/mac_newworld.c               |  6 +-----
>  hw/ppc/mac_oldworld.c               |  6 +-----
>  hw/ppc/mpc8544_guts.c               |  6 +-----
>  hw/ppc/mpc8544ds.c                  |  6 +-----
>  hw/ppc/pnv_core.c                   |  6 +-----
>  hw/ppc/pnv_homer.c                  | 10 +++-------
>  hw/ppc/pnv_lpc.c                    | 12 ++++--------
>  hw/ppc/pnv_occ.c                    | 10 +++-------
>  hw/ppc/pnv_pnor.c                   |  6 +-----
>  hw/ppc/pnv_psi.c                    | 12 ++++--------
>  hw/ppc/pnv_xscom.c                  |  6 +-----
>  hw/ppc/ppc405_boards.c              |  8 ++------
>  hw/ppc/ppc440_pcix.c                |  6 +-----
>  hw/ppc/ppc440_uc.c                  |  6 +-----
>  hw/ppc/ppc4xx_pci.c                 |  8 ++------
>  hw/ppc/ppce500_spin.c               |  6 +-----
>  hw/ppc/prep_systemio.c              |  6 +-----
>  hw/ppc/rs6000_mc.c                  |  6 +-----
>  hw/ppc/spapr.c                      |  6 +-----
>  hw/ppc/spapr_drc.c                  | 16 ++++++++--------
>  hw/ppc/spapr_iommu.c                |  8 ++------
>  hw/ppc/spapr_irq.c                  |  6 +-----
>  hw/ppc/spapr_pci.c                  |  6 +-----
>  hw/ppc/spapr_rng.c                  |  6 +-----
>  hw/ppc/spapr_rtc.c                  |  6 +-----
>  hw/ppc/spapr_tpm_proxy.c            |  2 +-
>  hw/ppc/spapr_vio.c                  | 10 +++-------
>  hw/rdma/rdma.c                      |  6 +-----
>  hw/rdma/vmw/pvrdma_main.c           |  6 +-----
>  hw/riscv/opentitan.c                |  6 +-----
>  hw/riscv/riscv_hart.c               |  6 +-----
>  hw/riscv/sifive_clint.c             |  6 +-----
>  hw/riscv/sifive_e.c                 | 12 ++----------
>  hw/riscv/sifive_e_prci.c            |  6 +-----
>  hw/riscv/sifive_gpio.c              |  6 +-----
>  hw/riscv/sifive_plic.c              |  6 +-----
>  hw/riscv/sifive_test.c              |  6 +-----
>  hw/riscv/sifive_u.c                 | 12 ++----------
>  hw/riscv/sifive_u_otp.c             |  6 +-----
>  hw/riscv/sifive_u_prci.c            |  6 +-----
>  hw/riscv/virt.c                     |  6 +-----
>  hw/rtc/allwinner-rtc.c              | 12 ++++--------
>  hw/rtc/aspeed_rtc.c                 |  6 +-----
>  hw/rtc/ds1338.c                     |  6 +-----
>  hw/rtc/exynos4210_rtc.c             |  6 +-----
>  hw/rtc/goldfish_rtc.c               |  6 +-----
>  hw/rtc/m41t80.c                     |  6 +-----
>  hw/rtc/m48t59-isa.c                 |  2 +-
>  hw/rtc/m48t59.c                     |  4 ++--
>  hw/rtc/mc146818rtc.c                |  6 +-----
>  hw/rtc/pl031.c                      |  6 +-----
>  hw/rtc/sun4v-rtc.c                  |  6 +-----
>  hw/rtc/twl92230.c                   |  6 +-----
>  hw/rtc/xlnx-zynqmp-rtc.c            |  6 +-----
>  hw/s390x/3270-ccw.c                 |  6 +-----
>  hw/s390x/ap-bridge.c                |  8 ++------
>  hw/s390x/ap-device.c                |  6 +-----
>  hw/s390x/ccw-device.c               |  6 +-----
>  hw/s390x/css-bridge.c               |  8 ++------
>  hw/s390x/event-facility.c           | 10 +++-------
>  hw/s390x/ipl.c                      |  6 +-----
>  hw/s390x/s390-ccw.c                 |  6 +-----
>  hw/s390x/s390-pci-bus.c             | 14 +++++---------
>  hw/s390x/s390-skeys-kvm.c           |  6 +-----
>  hw/s390x/s390-skeys.c               |  8 ++------
>  hw/s390x/s390-stattrib-kvm.c        |  6 +-----
>  hw/s390x/s390-stattrib.c            |  8 ++------
>  hw/s390x/s390-virtio-ccw.c          |  6 +-----
>  hw/s390x/sclp.c                     |  6 +-----
>  hw/s390x/sclpcpu.c                  |  6 +-----
>  hw/s390x/sclpquiesce.c              |  6 +-----
>  hw/s390x/tod-kvm.c                  |  6 +-----
>  hw/s390x/tod-qemu.c                 |  6 +-----
>  hw/s390x/tod.c                      |  6 +-----
>  hw/s390x/vhost-vsock-ccw.c          |  6 +-----
>  hw/s390x/virtio-ccw-9p.c            |  6 +-----
>  hw/s390x/virtio-ccw-balloon.c       |  6 +-----
>  hw/s390x/virtio-ccw-blk.c           |  6 +-----
>  hw/s390x/virtio-ccw-crypto.c        |  6 +-----
>  hw/s390x/virtio-ccw-gpu.c           |  6 +-----
>  hw/s390x/virtio-ccw-input.c         | 14 +++++---------
>  hw/s390x/virtio-ccw-net.c           |  6 +-----
>  hw/s390x/virtio-ccw-rng.c           |  6 +-----
>  hw/s390x/virtio-ccw-scsi.c          |  4 ++--
>  hw/s390x/virtio-ccw-serial.c        |  6 +-----
>  hw/s390x/virtio-ccw.c               |  8 ++------
>  hw/scsi/esp-pci.c                   |  8 ++------
>  hw/scsi/esp.c                       |  6 +-----
>  hw/scsi/lsi53c895a.c                |  8 ++------
>  hw/scsi/megasas.c                   |  2 +-
>  hw/scsi/scsi-bus.c                  |  8 ++------
>  hw/scsi/scsi-disk.c                 | 10 +++++-----
>  hw/scsi/scsi-generic.c              |  6 +-----
>  hw/scsi/spapr_vscsi.c               |  6 +-----
>  hw/scsi/vhost-scsi-common.c         |  6 +-----
>  hw/scsi/vhost-scsi.c                |  6 +-----
>  hw/scsi/vhost-user-scsi.c           |  6 +-----
>  hw/scsi/virtio-scsi.c               |  8 ++------
>  hw/scsi/vmw_pvscsi.c                |  7 +------
>  hw/sd/allwinner-sdhost.c            | 12 ++++--------
>  hw/sd/aspeed_sdhci.c                |  6 +-----
>  hw/sd/bcm2835_sdhost.c              |  8 ++------
>  hw/sd/core.c                        |  6 +-----
>  hw/sd/milkymist-memcard.c           |  6 +-----
>  hw/sd/pl181.c                       |  6 +-----
>  hw/sd/pxa2xx_mmci.c                 |  8 ++------
>  hw/sd/sd.c                          |  6 +-----
>  hw/sd/sdhci-pci.c                   |  6 +-----
>  hw/sd/sdhci.c                       | 12 ++++--------
>  hw/sd/ssi-sd.c                      |  6 +-----
>  hw/sh4/sh_pci.c                     |  8 ++------
>  hw/sparc/sun4m.c                    | 28 ++++++++++++++--------------
>  hw/sparc/sun4m_iommu.c              |  8 ++------
>  hw/sparc64/niagara.c                |  6 +-----
>  hw/sparc64/sun4u.c                  | 12 ++++++------
>  hw/sparc64/sun4u_iommu.c            |  8 ++------
>  hw/ssi/aspeed_smc.c                 |  2 +-
>  hw/ssi/imx_spi.c                    |  6 +-----
>  hw/ssi/mss-spi.c                    |  6 +-----
>  hw/ssi/pl022.c                      |  6 +-----
>  hw/ssi/ssi.c                        |  8 ++------
>  hw/ssi/stm32f2xx_spi.c              |  6 +-----
>  hw/ssi/xilinx_spi.c                 |  6 +-----
>  hw/ssi/xilinx_spips.c               | 10 +++-------
>  hw/timer/a9gtimer.c                 |  6 +-----
>  hw/timer/allwinner-a10-pit.c        |  6 +-----
>  hw/timer/altera_timer.c             |  6 +-----
>  hw/timer/arm_mptimer.c              |  6 +-----
>  hw/timer/arm_timer.c                |  8 ++------
>  hw/timer/armv7m_systick.c           |  6 +-----
>  hw/timer/aspeed_timer.c             | 12 ++++--------
>  hw/timer/avr_timer16.c              |  6 +-----
>  hw/timer/bcm2835_systmr.c           |  6 +-----
>  hw/timer/cadence_ttc.c              |  6 +-----
>  hw/timer/cmsdk-apb-dualtimer.c      |  6 +-----
>  hw/timer/cmsdk-apb-timer.c          |  6 +-----
>  hw/timer/digic-timer.c              |  6 +-----
>  hw/timer/etraxfs_timer.c            |  6 +-----
>  hw/timer/exynos4210_mct.c           |  6 +-----
>  hw/timer/exynos4210_pwm.c           |  6 +-----
>  hw/timer/grlib_gptimer.c            |  6 +-----
>  hw/timer/hpet.c                     |  6 +-----
>  hw/timer/i8254.c                    |  6 +-----
>  hw/timer/i8254_common.c             |  6 +-----
>  hw/timer/imx_epit.c                 |  6 +-----
>  hw/timer/imx_gpt.c                  | 12 ++++--------
>  hw/timer/lm32_timer.c               |  6 +-----
>  hw/timer/milkymist-sysctl.c         |  6 +-----
>  hw/timer/mss-timer.c                |  6 +-----
>  hw/timer/nrf51_timer.c              |  6 +-----
>  hw/timer/puv3_ost.c                 |  6 +-----
>  hw/timer/pxa2xx_timer.c             | 10 +++-------
>  hw/timer/renesas_cmt.c              |  6 +-----
>  hw/timer/renesas_tmr.c              |  6 +-----
>  hw/timer/slavio_timer.c             |  6 +-----
>  hw/timer/stm32f2xx_timer.c          |  6 +-----
>  hw/timer/xilinx_timer.c             |  6 +-----
>  hw/tpm/tpm_crb.c                    |  6 +-----
>  hw/tpm/tpm_spapr.c                  |  6 +-----
>  hw/tpm/tpm_tis_isa.c                |  6 +-----
>  hw/tpm/tpm_tis_sysbus.c             |  6 +-----
>  hw/usb/bus.c                        |  8 ++------
>  hw/usb/ccid-card-emulated.c         |  6 +-----
>  hw/usb/ccid-card-passthru.c         |  6 +-----
>  hw/usb/chipidea.c                   |  6 +-----
>  hw/usb/dev-audio.c                  |  2 +-
>  hw/usb/dev-hid.c                    |  8 ++++----
>  hw/usb/dev-hub.c                    |  6 +-----
>  hw/usb/dev-mtp.c                    |  6 +-----
>  hw/usb/dev-network.c                |  6 +-----
>  hw/usb/dev-serial.c                 |  6 +++---
>  hw/usb/dev-smartcard-reader.c       |  6 +++---
>  hw/usb/dev-storage.c                | 10 +++-------
>  hw/usb/dev-uas.c                    |  6 +-----
>  hw/usb/dev-wacom.c                  |  2 +-
>  hw/usb/hcd-dwc2.c                   |  6 +-----
>  hw/usb/hcd-ehci-pci.c               |  2 +-
>  hw/usb/hcd-ehci-sysbus.c            | 18 +++++++-----------
>  hw/usb/hcd-ohci-pci.c               |  6 +-----
>  hw/usb/hcd-ohci.c                   |  6 +-----
>  hw/usb/hcd-uhci.c                   |  2 +-
>  hw/usb/hcd-xhci-nec.c               |  6 +-----
>  hw/usb/hcd-xhci.c                   |  8 ++------
>  hw/usb/host-libusb.c                |  6 +-----
>  hw/usb/imx-usb-phy.c                |  6 +-----
>  hw/usb/redirect.c                   |  6 +-----
>  hw/usb/tusb6010.c                   |  6 +-----
>  hw/vfio/amd-xgbe.c                  |  6 +-----
>  hw/vfio/ap.c                        |  6 +-----
>  hw/vfio/calxeda-xgmac.c             |  6 +-----
>  hw/vfio/ccw.c                       |  6 +-----
>  hw/vfio/igd.c                       |  6 +-----
>  hw/vfio/pci.c                       |  8 ++------
>  hw/vfio/platform.c                  |  6 +-----
>  hw/virtio/vhost-user-fs.c           |  6 +-----
>  hw/virtio/vhost-user-vsock.c        |  6 +-----
>  hw/virtio/vhost-vsock-common.c      |  6 +-----
>  hw/virtio/vhost-vsock.c             |  6 +-----
>  hw/virtio/virtio-balloon.c          |  6 +-----
>  hw/virtio/virtio-bus.c              |  6 +-----
>  hw/virtio/virtio-crypto.c           |  6 +-----
>  hw/virtio/virtio-input-pci.c        |  4 ++--
>  hw/virtio/virtio-iommu.c            |  8 ++------
>  hw/virtio/virtio-mem.c              |  6 +-----
>  hw/virtio/virtio-mmio.c             |  8 ++------
>  hw/virtio/virtio-pci.c              |  4 ++--
>  hw/virtio/virtio-pmem.c             |  6 +-----
>  hw/virtio/virtio-rng.c              |  6 +-----
>  hw/virtio/virtio.c                  |  6 +-----
>  hw/watchdog/cmsdk-apb-watchdog.c    |  8 ++------
>  hw/watchdog/wdt_aspeed.c            |  8 ++++----
>  hw/watchdog/wdt_diag288.c           |  2 +-
>  hw/watchdog/wdt_i6300esb.c          |  2 +-
>  hw/watchdog/wdt_ib700.c             |  2 +-
>  hw/watchdog/wdt_imx2.c              |  2 +-
>  hw/xen/xen-bus.c                    | 10 +++-------
>  hw/xen/xen-legacy-backend.c         | 10 +++-------
>  hw/xen/xen_pt.c                     |  6 +-----
>  hw/xtensa/xtfpga.c                  | 20 ++++++++------------
>  io/channel-buffer.c                 |  6 +-----
>  io/channel-command.c                |  6 +-----
>  io/channel-file.c                   |  6 +-----
>  io/channel-socket.c                 |  6 +-----
>  io/channel-tls.c                    |  6 +-----
>  io/channel-websock.c                |  6 +-----
>  io/channel.c                        |  6 +-----
>  io/dns-resolver.c                   |  6 +-----
>  io/net-listener.c                   |  6 +-----
>  iothread.c                          |  6 +-----
>  migration/migration.c               |  6 +-----
>  migration/rdma.c                    |  6 +-----
>  net/can/can_core.c                  |  6 +-----
>  net/can/can_host.c                  |  6 +-----
>  net/can/can_socketcan.c             |  6 +-----
>  net/colo-compare.c                  |  6 +-----
>  net/dump.c                          |  6 +-----
>  net/filter-buffer.c                 |  6 +-----
>  net/filter-mirror.c                 |  8 ++------
>  net/filter-replay.c                 |  6 +-----
>  net/filter-rewriter.c               |  6 +-----
>  net/filter.c                        |  6 +-----
>  qom/container.c                     |  6 +-----
>  scsi/pr-manager-helper.c            |  6 +-----
>  scsi/pr-manager.c                   |  7 +------
>  softmmu/memory.c                    |  8 ++------
>  target/arm/cpu.c                    |  4 ++--
>  target/arm/cpu64.c                  |  2 +-
>  target/hppa/cpu.c                   |  6 +-----
>  target/i386/cpu.c                   |  8 ++++----
>  target/i386/hax-all.c               |  6 +-----
>  target/i386/hvf/hvf.c               |  6 +-----
>  target/i386/sev.c                   |  7 +------
>  target/i386/whpx-all.c              |  6 +-----
>  target/microblaze/cpu.c             |  6 +-----
>  target/mips/cpu.c                   |  2 +-
>  target/nios2/cpu.c                  |  6 +-----
>  target/ppc/translate_init.inc.c     |  4 ++--
>  target/rx/cpu.c                     |  8 ++------
>  target/s390x/cpu.c                  |  6 +-----
>  target/s390x/cpu_models.c           |  6 +++---
>  target/sparc/cpu.c                  |  2 +-
>  target/tilegx/cpu.c                 |  6 +-----
>  target/xtensa/cpu.c                 |  6 +-----
>  ui/console.c                        |  6 +-----
>  ui/input-barrier.c                  |  6 +-----
>  ui/input-linux.c                    |  6 +-----
>  819 files changed, 1183 insertions(+), 4322 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


