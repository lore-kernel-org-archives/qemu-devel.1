Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42906C34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9EC206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="2B8eGv6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9EC206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yfq-0002FM-3n
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 03:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yZz-00083f-VW
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yZx-0005OM-F8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:50:07 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:33122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3yZu-0005Fv-Bv; Tue, 18 Feb 2020 03:50:02 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A72F896EF0;
 Tue, 18 Feb 2020 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582015798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DHWFfZ+ONx+uAB+oGFVCcksw9qZAV67jcksubLr09YQ=;
 b=2B8eGv6C9eHdMoKLq+7By1KC53uECffymJoEv5v0n5Ec5Eqc76WQCEdLAITJFwkrvrk6ZW
 DFhXgCvTOSMQxmNNJ2lO25LE9PwhfNbK9IUZK7gsjBk2aqHhEUr0E+z7Cf4sUS3BdrIs8t
 8XpzMaP3C0OrkwZ04nCuSrtq0+H64DA=
Subject: Re: [PATCH v2 13/13] hw/arm/raspi: Add the Raspberry Pi Zero machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-14-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <cccdf237-a477-0662-930b-df05def200d3@greensocs.com>
Date: Tue, 18 Feb 2020 09:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217114533.17779-14-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582015799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DHWFfZ+ONx+uAB+oGFVCcksw9qZAV67jcksubLr09YQ=;
 b=qI5dR7/tpkTqHPyryf9DJfL6duUIA/PdYmLYqiDoPy/LX61v2Sex4TR+1wGca0FBIGid1K
 IjMVYPeeBh62/arxwaMBfrrnlDSKvXmXqvgFX+b62W2kGRFWue1nqKz71UMmmVbAxvHdnT
 +WAlfktzkmzHoH8EYthDxUmyUf2uSC4=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582015799; a=rsa-sha256; cv=none;
 b=VneEHaXdfJvRiPq/fWaLw4sSqZkS+kXF/Ue0OzI+Uvx53b6BWEtRmeBEFS9qsGErgJ30Rp
 AqEZZQHN8Hvm/G8X/7ZS8p7taqsdqCf3RE2NRvxHnCGZqZp2YdEmuq+4B9ENf9f94lPeek
 ggOjP2Ay1L9DfEf3yu0CDJIg57VzhPI=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a Raspberry Pi Zero machine.
>=20
>   $ qemu-system-arm -M raspi0w -serial stdio \
>       -kernel raspberrypi/firmware/boot/kernel.img \
>       -dtb raspberrypi/firmware/boot/bcm2708-rpi-zero-w.dtb \
>       -append 'printk.time=3D0 earlycon=3Dpl011,0x20201000 console=3Dtt=
yAMA0'
>   [    0.000000] Booting Linux on physical CPU 0x0
>   [    0.000000] Linux version 4.19.69+ (dom@buildbot) (gcc version 4.9=
.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep 3 20:21:=
01 BST 2019
>   [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 =
(ARMv7), cr=3D00c5387d
>   [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cac=
he
>   [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W
>   [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
>   [    0.000000] bootconsole [pl11] enabled
>   [    0.000000] Memory policy: Data cache writeback
>   [    0.000000] cma: Reserved 8 MiB at 0x1b800000
>   [    0.000000] random: get_random_bytes called from start_kernel+0x8c=
/0x49c with crng_init=3D0
>   [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:=
 113680
>   [    0.000000] Kernel command line: printk.time=3D0 earlycon=3Dpl011,=
0x20201000 console=3DttyAMA0 root=3D/dev/mmcblk0 rootwait
>   Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>   Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>   Memory: 434380K/458752K available (6971K kernel code, 635K rwdata, 20=
80K rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
>   Virtual kernel memory layout:
>       vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>       fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>       vmalloc : 0xdc800000 - 0xff800000   ( 560 MB)
>       lowmem  : 0xc0000000 - 0xdc000000   ( 448 MB)
>       modules : 0xbf000000 - 0xc0000000   (  16 MB)
>         .text : 0x(ptrval) - 0x(ptrval)   (6973 kB)
>         .init : 0x(ptrval) - 0x(ptrval)   ( 464 kB)
>         .data : 0x(ptrval) - 0x(ptrval)   ( 636 kB)
>          .bss : 0x(ptrval) - 0x(ptrval)   ( 798 kB)
>   SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
>   ftrace: allocating 25193 entries in 74 pages
>   NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
>   sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 21474=
83647500ns
>   clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle=
_ns: 1911260446275 ns
>   bcm2835: system timer (irq =3D 27)
>   Console: colour dummy device 80x30
>   ...
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/raspi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 2d9f4e3085..d59d7c4294 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -324,6 +324,15 @@ static void raspi_machine_class_common_init(Machin=
eClass *mc,
>      mc->default_ram_size =3D board_ram_size(board_rev);
>  };
> =20
> +static void raspi0w_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev =3D 0x9000c1;
> +    raspi_machine_class_common_init(mc, rmc->board_rev);
> +};
> +
>  static void raspi1b_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -357,6 +366,10 @@ static void raspi3b_machine_class_init(ObjectClass=
 *oc, void *data)
> =20
>  static const TypeInfo raspi_machine_types[] =3D {
>      {
> +        .name           =3D MACHINE_TYPE_NAME("raspi0w"),
> +        .parent         =3D TYPE_RASPI_MACHINE,
> +        .class_init     =3D raspi0w_machine_class_init,
> +    }, {
>          .name           =3D MACHINE_TYPE_NAME("raspi1b"),
>          .parent         =3D TYPE_RASPI_MACHINE,
>          .class_init     =3D raspi1b_machine_class_init,
>=20

