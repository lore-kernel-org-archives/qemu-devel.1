Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12251C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B2420661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 20:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgCXnO3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B2420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW4Pi-00021T-UI
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 16:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW4Ox-0001Bj-TH; Tue, 05 May 2020 16:42:51 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW4Ow-0002AH-SP; Tue, 05 May 2020 16:42:51 -0400
Received: by mail-io1-xd44.google.com with SMTP id y26so2294350ioj.2;
 Tue, 05 May 2020 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3Eth4CMOOoQHY8/U7tUUCT82w6CNgbOBNH3GligiDao=;
 b=pgCXnO3S8wUi01S/yu3hroaAZrWVfYL/v23/hgORUCzS6RbxlRdqHMz5utXOcinaN3
 eoAbbk4jQcC8bduRkUPyD6ORTxMWVHGABP20/C/+/rywq3OKzQGXkQlXn7o0Dz2wNS97
 JS4Ket97xI+Byw/N6JtDChwOdk8oY+UJNFLqFqdojh3wl8ljY967QG4nC6bytPfJUVFz
 l2Lm4RGlO7bVDZ7DjzP3HQCjgo9f893XcH1ps1KOFcvBACF7iyz+GgXMcCYGshl+1oKC
 7IfQE6/V13gwOBiMeJuDizxFmsoNg3y5d5X2lFn3Rgy28k8smPJrJxRRtR9nJGlveb1d
 ARpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3Eth4CMOOoQHY8/U7tUUCT82w6CNgbOBNH3GligiDao=;
 b=Bjl7QYYSagMSj9KcVtYMdikqtbvm9XkR+4HkbDKTXV+SAVkUmq2wMhdhqQU2XHIyW/
 VZzezqw9NQoMa+1/Gm5UsIHbulnW9c6PSdcPTEN9IHf9A5r19c/iyjeLG5MOlaWh08u1
 LwhTXrrDPyfi8OjHFBgr12aWEIms48FQ5dddlSfl432UONvcXBqtGQHanMg5dQEdxL17
 u4QMM+X3xEvPgM6FODKB09DKM0UrWlA1tFKoE2iMTXJPAxYFIhvxEOdMQpNLAHy3Ssj7
 eyAT0xVnbavfcBxN85DXnBlczPd/qKzm1oBLWhS1cevzE2G7LX/PTsFjGBbc6zxMRrbC
 XjnA==
X-Gm-Message-State: AGi0PuZjhsFEf42+Ah5FNs6K8uzH6Mix7KGTL5++JXMG7nhMw3sMB5yG
 F7c7NdGU+/6evKG/LMJ8Uh1iemVZVw2PthwiEw4=
X-Google-Smtp-Source: APiQypLoVzIfgO0LFZ37/u2V9qND2Vh5YkV0Vqg21NFHck9HmnozHtMiAwmVpS9nR1uje99tjg/qiMqHTXEh0gZntoE=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr5403197iol.105.1588711369390; 
 Tue, 05 May 2020 13:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <1588335545-649-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588335545-649-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2020 13:34:06 -0700
Message-ID: <CAKmqyKMdmVrvYDNVtm6_iviDT_mofGZO9DC2vtZdZaHN31T07A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Change the default behavior if no -bios option is
 specified
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 5:21 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Per QEMU deprecated doc, QEMU 4.1 introduced support for the -bios
> option in QEMU for RISC-V for the virt machine and sifive_u machine.
> The default behavior has been that QEMU does not automatically load
> any firmware if no -bios option is included.
>
> Now 2 releases passed, it's time to change the default behavior to
> load the default OpenSBI firmware automatically. The firmware is
> included with the QEMU release and no user interaction is required.
> All a user needs to do is specify the kernel they want to boot with
> the -kernel option.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Thanks!

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Applied to the RISC-V tree.

Alistair

> ---
>
>  hw/riscv/boot.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 726300a..b76b2f3 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -41,34 +41,11 @@ void riscv_find_and_load_firmware(MachineState *machine,
>  {
>      char *firmware_filename = NULL;
>
> -    if (!machine->firmware) {
> +    if ((!machine->firmware) || (!strcmp(machine->firmware, "default"))) {
>          /*
> -         * The user didn't specify -bios.
> -         * At the moment we default to loading nothing when this hapens.
> -         * In the future this defaul will change to loading the prebuilt
> -         * OpenSBI firmware. Let's warn the user and then continue.
> -        */
> -        if (!qtest_enabled()) {
> -            warn_report("No -bios option specified. Not loading a firmware.");
> -            warn_report("This default will change in a future QEMU release. " \
> -                        "Please use the -bios option to avoid breakages when "\
> -                        "this happens.");
> -            warn_report("See QEMU's deprecation documentation for details.");
> -        }
> -        return;
> -    }
> -
> -    if (!strcmp(machine->firmware, "default")) {
> -        /*
> -         * The user has specified "-bios default". That means we are going to
> -         * load the OpenSBI binary included in the QEMU source.
> -         *
> -         * We can't load the binary by default as it will break existing users
> -         * as users are already loading their own firmware.
> -         *
> -         * Let's try to get everyone to specify the -bios option at all times,
> -         * so then in the future we can make "-bios default" the default option
> -         * if no -bios option is set without breaking anything.
> +         * The user didn't specify -bios, or has specified "-bios default".
> +         * That means we are going to load the OpenSBI binary included in
> +         * the QEMU source.
>           */
>          firmware_filename = riscv_find_firmware(default_machine_firmware);
>      } else if (strcmp(machine->firmware, "none")) {
> --
> 2.7.4
>
>

