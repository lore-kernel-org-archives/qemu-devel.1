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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB7C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 22:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0676F206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 22:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1BSKcMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0676F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW6CO-0003S6-32
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 18:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW6Bj-0002zz-Q2; Tue, 05 May 2020 18:37:19 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW6Bi-0003PW-Si; Tue, 05 May 2020 18:37:19 -0400
Received: by mail-io1-xd43.google.com with SMTP id k18so228839ion.0;
 Tue, 05 May 2020 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mWlQvx7wo4D3bZ2BocGQGaMJLbGsn45Z7hf18L0JGQk=;
 b=T1BSKcMhkcsvyZpWkSVjYBdmwBGdLJ0aUbxT32O8yG5jlLlOiWGCxG83QwkGKRslqM
 Skdur5pokRRn4g2fv8caHtnmXbfBQ+qiYdjGU9Rv84JQsqRwmLSEWPB5/qC/uzvr9qR4
 /NJvz+/pIFWQP4rkCA8Rzlj5dhgFEdxzulGEum5APlodROTcKhoKiPKom12ABjoMdpgu
 t4bW9+DjcMl03bzViT5/pVQqb90+TCIXEX11A6VhnKWkB3J2oi7ki1B+mG662SaQlb8p
 zbksYGKevmagW7VIRwcghF+FyHxzJ7Z3VNcOM+sDV+cnZSaagxmmXxTxhA0+LWemj+z2
 cjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mWlQvx7wo4D3bZ2BocGQGaMJLbGsn45Z7hf18L0JGQk=;
 b=T3u9hqzuyBqp4nM49pNktShinfA64EbyJRuzC2Aq+bozC6DC+3Vz9jUVeBQXYJ1dFG
 hBK67NMNuArynLadFOYLzU+Px5oQj43NYGagARX8kgtFZdfO0cPxK5igHANRUAqOTPLv
 lBkVUrCrrV6/5iSwQCGnbadafq0Hbai3tbuGjRzXKMLQoQ+xiSqmZzZZkr4TD8Dpwngi
 aUb0V35PsFKXN45oTOazoXyC+miB+9OHOC71fq2Rc8xRYvS1mxiepi0AWyHtN8h0fTn2
 VjqXS47dSkhJuxgzWEtSoktgYcS69AqGKROdgk874WDlcNipvG6pHnsHFhehDKTJFu74
 HvwA==
X-Gm-Message-State: AGi0PuYmzpXTNn9jA8hfVeV3uUOuW+98nNCD0L3M9af7veQ/itdzUHU4
 JYyd1DFffGSGI1xOcQCbr+Dz5gQO9Wr+oSHB6T8=
X-Google-Smtp-Source: APiQypJsQgckhP7fOsqe62f8WCr/SrwI/FoBOzazOdXsqxRBLey/kTsbCWuT1xjdkFoWrzM9Z9npAmQSLIEEOjwsA1g=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr5839491ioj.42.1588718237206; 
 Tue, 05 May 2020 15:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <1588335545-649-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKMdmVrvYDNVtm6_iviDT_mofGZO9DC2vtZdZaHN31T07A@mail.gmail.com>
In-Reply-To: <CAKmqyKMdmVrvYDNVtm6_iviDT_mofGZO9DC2vtZdZaHN31T07A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2020 15:28:35 -0700
Message-ID: <CAKmqyKO6HGQrMxsNovPkoB4TncEmeD=uFV_oXEpQ0t+=g20Wfw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Change the default behavior if no -bios option is
 specified
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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

On Tue, May 5, 2020 at 1:34 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Fri, May 1, 2020 at 5:21 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > Per QEMU deprecated doc, QEMU 4.1 introduced support for the -bios
> > option in QEMU for RISC-V for the virt machine and sifive_u machine.
> > The default behavior has been that QEMU does not automatically load
> > any firmware if no -bios option is included.
> >
> > Now 2 releases passed, it's time to change the default behavior to
> > load the default OpenSBI firmware automatically. The firmware is
> > included with the QEMU release and no user interaction is required.
> > All a user needs to do is specify the kernel they want to boot with
> > the -kernel option.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> Thanks!
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Applied to the RISC-V tree.

This fails `make check`

qemu-system-riscv64: Unable to load the RISC-V firmware
"opensbi-riscv64-spike-fw_jump.elf"
Broken pipe
/scratch/alistair/software/qemu/tests/qtest/libqtest.c:166:
kill_qemu() tried to terminate QEMU process but encountered exit
status 1 (expected 0)
ERROR - too few tests run (expected 7, got 2)
make: *** [/scratch/alistair/software/qemu/tests/Makefile.include:637:
check-qtest-riscv64] Error 1

Alistair

>
> Alistair
>
> > ---
> >
> >  hw/riscv/boot.c | 31 ++++---------------------------
> >  1 file changed, 4 insertions(+), 27 deletions(-)
> >
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 726300a..b76b2f3 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -41,34 +41,11 @@ void riscv_find_and_load_firmware(MachineState *machine,
> >  {
> >      char *firmware_filename = NULL;
> >
> > -    if (!machine->firmware) {
> > +    if ((!machine->firmware) || (!strcmp(machine->firmware, "default"))) {
> >          /*
> > -         * The user didn't specify -bios.
> > -         * At the moment we default to loading nothing when this hapens.
> > -         * In the future this defaul will change to loading the prebuilt
> > -         * OpenSBI firmware. Let's warn the user and then continue.
> > -        */
> > -        if (!qtest_enabled()) {
> > -            warn_report("No -bios option specified. Not loading a firmware.");
> > -            warn_report("This default will change in a future QEMU release. " \
> > -                        "Please use the -bios option to avoid breakages when "\
> > -                        "this happens.");
> > -            warn_report("See QEMU's deprecation documentation for details.");
> > -        }
> > -        return;
> > -    }
> > -
> > -    if (!strcmp(machine->firmware, "default")) {
> > -        /*
> > -         * The user has specified "-bios default". That means we are going to
> > -         * load the OpenSBI binary included in the QEMU source.
> > -         *
> > -         * We can't load the binary by default as it will break existing users
> > -         * as users are already loading their own firmware.
> > -         *
> > -         * Let's try to get everyone to specify the -bios option at all times,
> > -         * so then in the future we can make "-bios default" the default option
> > -         * if no -bios option is set without breaking anything.
> > +         * The user didn't specify -bios, or has specified "-bios default".
> > +         * That means we are going to load the OpenSBI binary included in
> > +         * the QEMU source.
> >           */
> >          firmware_filename = riscv_find_firmware(default_machine_firmware);
> >      } else if (strcmp(machine->firmware, "none")) {
> > --
> > 2.7.4
> >
> >

