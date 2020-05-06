Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C88C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FDC2075E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sH73flY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FDC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWRCP-0007b0-1u
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 17:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jWRBJ-00077P-Tg; Wed, 06 May 2020 17:02:18 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:44537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jWRBI-0002aP-OY; Wed, 06 May 2020 17:02:17 -0400
Received: by mail-il1-x142.google.com with SMTP id s10so595485iln.11;
 Wed, 06 May 2020 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m/VcMjoyLBrv3KMvD0BpDh3FiQ3MRQzBtiCoTsP9dKc=;
 b=sH73flY9b4G4DysDFMsKo0CqhRUaspMkF6zimoclRBNEdaFoVmaBCt+db7Rj76iaNs
 KNg+dPlk27W0wiQmEjabGi2SrFpPr4IfdOhUzXMHf8yE5RrSf8XyAhK9txxmTt742qxE
 59X1KJL2ihMVWPem4+qCzvmQqml+fkho/xNHTis1MW6vM0ttg40/FS1REGMxpPh5LBSA
 QDX40fZEDZH4b86IL4FnPbIXQp0tX2U7O7dIv8rZLnSWc9dsbdOMSyB/1aMfC9m9+Flm
 TOcpHTCJ1Ln6xZcTQBhWQ4Lwo9G1CFoRfLxgRyKVL5cZOfMeC5WTSp+uUsVcV9VuGHlx
 iquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m/VcMjoyLBrv3KMvD0BpDh3FiQ3MRQzBtiCoTsP9dKc=;
 b=G44L/MfSfUP/06CQqzrkKN2U1zZod9MqwIzTvcY1WjCSlSz2A0sGKVH53n+985RcJh
 /Y7q7gDPNSHpdD9QtBYX97IFwMydM406WIWXk2JNUpEapBWCT37q4Jg4HJGNcFnQ/Ne8
 39jYwg9bmrQQiXTzR6dVUQyusvnlZph/5LezRWX08ZHG79GcuPp74K0KXwIi7OKWCMcC
 T2H3Hp9IUr4tagllNpvjXXq0sVR7+pYQ1idnsJ5NEH7VVQ9vX0+g674bHThnoJl0B5p1
 sGI6+Vs+SFVZd6AW4uPYPQVA+7p6lDXNeWtSsKPWYwv+pn43Zip/Mn1wlCB+CegZ5CX6
 mZOQ==
X-Gm-Message-State: AGi0PuZ/8A3lAEk1A+WKm6HP7M317yenTmnZF6SJl05Cpi+cqspQwGgX
 t8hODVqtP2YRf0uTEhYwV76QO/EVgsAfSyZrFEXuSpIo
X-Google-Smtp-Source: APiQypJe97WVQUHU3eLDsc9TfsC9+9xavHMpIYbmLgiI/H0VuYhwaDvXCT6V/cR3x2cHSgKMoAjyy1fgQRBPmE0wtIs=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr11291956ili.40.1588798934917; 
 Wed, 06 May 2020 14:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <1588335545-649-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKMdmVrvYDNVtm6_iviDT_mofGZO9DC2vtZdZaHN31T07A@mail.gmail.com>
 <CAKmqyKO6HGQrMxsNovPkoB4TncEmeD=uFV_oXEpQ0t+=g20Wfw@mail.gmail.com>
 <CAEUhbmVTg+521EHutukOod_PKx0RQ-s=EgnKu=JM-vduMn4mNA@mail.gmail.com>
In-Reply-To: <CAEUhbmVTg+521EHutukOod_PKx0RQ-s=EgnKu=JM-vduMn4mNA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 May 2020 13:53:31 -0700
Message-ID: <CAKmqyKPdjBFmPcQY+O4zsaTHYeLVC9zanXhS5CBovfn4LLRdJg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Change the default behavior if no -bios option is
 specified
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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

On Tue, May 5, 2020 at 6:34 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Wed, May 6, 2020 at 6:37 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Tue, May 5, 2020 at 1:34 PM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Fri, May 1, 2020 at 5:21 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > From: Bin Meng <bin.meng@windriver.com>
> > > >
> > > > Per QEMU deprecated doc, QEMU 4.1 introduced support for the -bios
> > > > option in QEMU for RISC-V for the virt machine and sifive_u machine.
> > > > The default behavior has been that QEMU does not automatically load
> > > > any firmware if no -bios option is included.
> > > >
> > > > Now 2 releases passed, it's time to change the default behavior to
> > > > load the default OpenSBI firmware automatically. The firmware is
> > > > included with the QEMU release and no user interaction is required.
> > > > All a user needs to do is specify the kernel they want to boot with
> > > > the -kernel option.
> > > >
> > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > >
> > > Thanks!
> > >
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Applied to the RISC-V tree.
> >
> > This fails `make check`
> >
> > qemu-system-riscv64: Unable to load the RISC-V firmware
> > "opensbi-riscv64-spike-fw_jump.elf"
> > Broken pipe
> > /scratch/alistair/software/qemu/tests/qtest/libqtest.c:166:
> > kill_qemu() tried to terminate QEMU process but encountered exit
> > status 1 (expected 0)
> > ERROR - too few tests run (expected 7, got 2)
> > make: *** [/scratch/alistair/software/qemu/tests/Makefile.include:637:
> > check-qtest-riscv64] Error 1
> >
>
> Please apply this patch to fix the "make check" as well.
>
> [5/5] riscv: Suppress the error report for QEMU testing with
> riscv_find_firmware()
> http://patchwork.ozlabs.org/project/qemu-devel/patch/1588348254-7241-6-git-send-email-bmeng.cn@gmail.com/

In future please send all related patches in a single series.

I have applied those two patches.

Alistair

>
> Regards,
> Bin

