Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68893C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D6A2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Iv3Zpxeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D6A2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yNm-0002FS-88
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 03:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yLT-0001DU-KH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yLS-0007yQ-7t
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:35:07 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:60896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3yLP-0007x2-7E; Tue, 18 Feb 2020 03:35:03 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 7155C96EF0;
 Tue, 18 Feb 2020 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582014900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpQ7cTYonNORu/XPM9Wsv+wvxFZCfvPzAhLRIqMX0Wg=;
 b=Iv3ZpxeoF0eTXRydjnttsbgY4tGsv6k+7FkFLncujpF0+Apipf7dc7GJF9sASMaSEpyBxg
 PUlQBuisYtry6TcZxVJXFBH4EgLZpp5JNKspUfkbJERLhsxjdTMxovJTWOeizdenfT+Wfj
 vo5XCBaZI9jGZgFjYm9avHgYbbYi3gE=
Subject: Re: [PATCH v2 05/13] hw/arm/raspi: Remove use of the 'version' value
 in the board code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-6-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <74b9a9b5-0929-0b98-61e1-a86ae55971b0@greensocs.com>
Date: Tue, 18 Feb 2020 09:35:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217114533.17779-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582014900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpQ7cTYonNORu/XPM9Wsv+wvxFZCfvPzAhLRIqMX0Wg=;
 b=Ft4r8Hvmf/PaH/rdug8X5czlU4e7jMT3cGd6+TLmPnxlKQTsqLlhUCOJyTPDs7FeuQyAmj
 moU4pS5FqW54fzGVzM5gG0Kyj2PdlUK9ENE2RffF+G+oXAPpviloSdAF7xAxMXEZGC4ZuA
 7BwweP9VPHwXbjLzaRgj7KAYsLABtNY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582014900; a=rsa-sha256; cv=none;
 b=50wpFz/8KMhXSJHujg93ZxVcCgnGhJfTVy0lppvw4fpkAGA8Xn9+JBMd1THZAO4XkebMpD
 KdRx49smCpoWRjmsy01Od1Q+sou044N7f1cx9Rlhj/QGIU0Y994IQl45hXtVzzhS0r0FIu
 BD/aTEz52dZLvX/v9lIR1is0MF0U6X4=
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
> We expected the 'version' ID to match the board processor ID,
> but this is not always true (for example boards with revision
> id 0xa02042/0xa22042 are Raspberry Pi 2 with a BCM2837 SoC).
> This was not important because we were not modelling them, but
> since the recent refactor now allow to model these boards, it
> is safer to check the processor id directly. Remove the version
> check.
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index b628dadf34..fff501affb 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -98,11 +98,6 @@ static RaspiProcessorId board_processor_id(uint32_t =
board_rev)
>      return proc_id;
>  }
> =20
> -static int board_version(uint32_t board_rev)
> -{
> -    return board_processor_id(board_rev) + 1;
> -}
> -
>  static const char *board_soc_type(uint32_t board_rev)
>  {
>      return soc_property[board_processor_id(board_rev)].type;
> @@ -201,7 +196,8 @@ static void reset_secondary(ARMCPU *cpu, const stru=
ct arm_boot_info *info)
>      cpu_set_pc(cs, info->smp_loader_start);
>  }
> =20
> -static void setup_boot(MachineState *machine, int version, size_t ram_=
size)
> +static void setup_boot(MachineState *machine, RaspiProcessorId process=
or_id,
> +                       size_t ram_size)
>  {
>      static struct arm_boot_info binfo;
>      int r;
> @@ -210,12 +206,13 @@ static void setup_boot(MachineState *machine, int=
 version, size_t ram_size)
>      binfo.ram_size =3D ram_size;
>      binfo.nb_cpus =3D machine->smp.cpus;
> =20
> -    if (version <=3D 2) {
> -        /* The rpi1 and 2 require some custom setup code to run in Sec=
ure
> -         * mode before booting a kernel (to set up the SMC vectors so
> -         * that we get a no-op SMC; this is used by Linux to call the
> +    if (processor_id <=3D PROCESSOR_ID_BCM2836) {
> +        /*
> +         * The BCM2835 and BCM2836 require some custom setup code to r=
un
> +         * in Secure mode before booting a kernel (to set up the SMC v=
ectors
> +         * so that we get a no-op SMC; this is used by Linux to call t=
he
>           * firmware for some cache maintenance operations.
> -         * The rpi3 doesn't need this.
> +         * The BCM2837 doesn't need this.
>           */
>          binfo.board_setup_addr =3D BOARDSETUP_ADDR;
>          binfo.write_board_setup =3D write_board_setup;
> @@ -223,10 +220,10 @@ static void setup_boot(MachineState *machine, int=
 version, size_t ram_size)
>          binfo.secure_boot =3D true;
>      }
> =20
> -    /* Pi2 and Pi3 requires SMP setup */
> -    if (version >=3D 2) {
> +    /* BCM2836 and BCM2837 requires SMP setup */
> +    if (processor_id >=3D PROCESSOR_ID_BCM2836) {
>          binfo.smp_loader_start =3D SMPBOOT_ADDR;
> -        if (version =3D=3D 2) {
> +        if (processor_id =3D=3D PROCESSOR_ID_BCM2836) {
>              binfo.write_secondary_boot =3D write_smpboot;
>          } else {
>              binfo.write_secondary_boot =3D write_smpboot64;
> @@ -238,7 +235,13 @@ static void setup_boot(MachineState *machine, int =
version, size_t ram_size)
>       * the normal Linux boot process
>       */
>      if (machine->firmware) {
> -        hwaddr firmware_addr =3D version =3D=3D 3 ? FIRMWARE_ADDR_3 : =
FIRMWARE_ADDR_2;
> +        hwaddr firmware_addr;
> +
> +        if (processor_id =3D=3D PROCESSOR_ID_BCM2837) {
> +            firmware_addr =3D FIRMWARE_ADDR_3;
> +        } else {
> +            firmware_addr =3D FIRMWARE_ADDR_2;
Maybe rename those constants too, because now that the version is gone,
we can wonder what those 2 and 3 mean. By the way since this firmware
address seems processor ID specific, maybe you can put them in your
soc_property structure?

Anyway with or without those modifications:

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> +        }
>          /* load the firmware image (typically kernel.img) */
>          r =3D load_image_targphys(machine->firmware, firmware_addr,
>                                  ram_size - firmware_addr);
> @@ -259,7 +262,6 @@ static void raspi_machine_init(MachineState *machin=
e)
>      RaspiMachineClass *mc =3D RASPI_MACHINE_GET_CLASS(machine);
>      RaspiMachineState *s =3D RASPI_MACHINE(machine);
>      uint32_t board_rev =3D mc->board_rev;
> -    int version =3D board_version(board_rev);
>      uint64_t ram_size =3D board_ram_size(board_rev);
>      uint32_t vcram_size;
>      DriveInfo *di;
> @@ -303,7 +305,8 @@ static void raspi_machine_init(MachineState *machin=
e)
> =20
>      vcram_size =3D object_property_get_uint(OBJECT(&s->soc), "vcram-si=
ze",
>                                            &error_abort);
> -    setup_boot(machine, version, machine->ram_size - vcram_size);
> +    setup_boot(machine, board_processor_id(mc->board_rev),
> +               machine->ram_size - vcram_size);
>  }
> =20
>  static void raspi_machine_class_common_init(MachineClass *mc,
>=20

