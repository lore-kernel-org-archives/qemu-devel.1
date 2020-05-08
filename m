Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47229C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1127C206B9
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QguEcWV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1127C206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0YV-00033H-9W
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 06:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX0Xb-0002dE-UU
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:47:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX0Xb-00080g-1l
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:47:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id 50so780062wrc.11
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k49C5zyuYWcuoY4kwjTau665FvHnQw5Q4jQ2RG6JlUs=;
 b=QguEcWV+11prMAuzF3jYEYwv5SxpfNZG2xQkTu11plqRp90UWMVo0aJa3HsD/iZFX8
 +WP/EuT13v01+If9nilD7Y9tX+8j4BtM86jUgNPW+OLFuoYNG8aDGRWiRLH7xGQPxG/8
 Y6pwl8sULQb4XOK1Y/P9TPGB0hnybV1E+FVKK4HpfIWNNo0MPZf9UoJhC6jeE+TujAd4
 gvFThLks4WjpZK3OEQoyGt32VkLrpEeNGRIOqN1X8uJeSr0yks9W5DPN+YuR0oLJbRE3
 VVujulFL+0Wio0rar075WJ39Lmc4alesuj7pQk9rHAk+D4H4ZcpT2HkwQiyocl2MMOuq
 5khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k49C5zyuYWcuoY4kwjTau665FvHnQw5Q4jQ2RG6JlUs=;
 b=YgVCuzAr2RkPdNlJDHmiFI/zrpBpd4/gNFCKlNs8+N7TRACU0iOp8jGpvVBKBtF2Q1
 CjbzIM1sBpXg/DH8Vg5MFjJadpjbCCks/JqOgCeN8ldoORFQrb8LvNu788tGuAwTQMrD
 s9ygX0f4iAjN7xCuCiirSQSwXvMSJAQEfzeFlrxjJu+ZyoJM8pOf3AuCFKKWMIlptVui
 jWqb0u+aZ8oDPbEpbepi4tdgfMwh1HnOZ1YwxN7NVpPy1eYm/u6vUZrW4ZBymEuMGzEb
 6w2J+z9/ctXrBT45PR7vREPyTeQ34OKmwEi9qeA8SDerjCvGDuQenYFfsfAmCFpHmE1i
 qW5g==
X-Gm-Message-State: AGi0Puadm7/NCTmOwruLrNYl+5WiCXW4c6jfG47AsKYYhK0SDTjH+zy6
 XPcoAEVm65vLwWzhsXxBNtSlK3fpAS5qKhEDrls=
X-Google-Smtp-Source: APiQypImQ782kwPY61AeIdZOXoSu5RXAc69bVqdP/Ob3z4w8gKoCL38Lf2ltKEyIaAFDNueYCjRRdJCrS8Nickb4kkY=
X-Received: by 2002:adf:94a6:: with SMTP id 35mr2213072wrr.420.1588934857318; 
 Fri, 08 May 2020 03:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-6-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-6-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 12:46:12 +0200
Message-ID: <CAHiYmc604JH9YVXMEVCFgrMvWqaAtWqWjF-iQjGTLZzpzC3dKA@mail.gmail.com>
Subject: Re: [PATCH V3 05/14] KVM: MIPS: Use lddir/ldpte instructions to
 lookup gpa_mm.pgd
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm@vger.kernel.org,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:11 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> Loongson-3 can use lddir/ldpte instuctions to accelerate page table
> walking, so use them to lookup gpa_mm.pgd.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/kvm/entry.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
> index 16e1c93..fd71694 100644
> --- a/arch/mips/kvm/entry.c
> +++ b/arch/mips/kvm/entry.c
> @@ -56,6 +56,7 @@
>  #define C0_BADVADDR    8, 0
>  #define C0_BADINSTR    8, 1
>  #define C0_BADINSTRP   8, 2
> +#define C0_PGD         9, 7
>  #define C0_ENTRYHI     10, 0
>  #define C0_GUESTCTL1   10, 4
>  #define C0_STATUS      12, 0
> @@ -307,7 +308,10 @@ static void *kvm_mips_build_enter_guest(void *addr)
>
>  #ifdef CONFIG_KVM_MIPS_VZ
>         /* Save normal linux process pgd (VZ guarantees pgd_reg is set) *=
/
> -       UASM_i_MFC0(&p, K0, c0_kscratch(), pgd_reg);
> +       if (cpu_has_ldpte)
> +               UASM_i_MFC0(&p, K0, C0_PWBASE);
> +       else
> +               UASM_i_MFC0(&p, K0, c0_kscratch(), pgd_reg);
>         UASM_i_SW(&p, K0, offsetof(struct kvm_vcpu_arch, host_pgd), K1);
>
>         /*
> @@ -469,8 +473,10 @@ void *kvm_mips_build_tlb_refill_exception(void *addr=
, void *handler)
>         u32 *p =3D addr;
>         struct uasm_label labels[2];
>         struct uasm_reloc relocs[2];
> +#ifndef CONFIG_CPU_LOONGSON64
>         struct uasm_label *l =3D labels;
>         struct uasm_reloc *r =3D relocs;
> +#endif
>
>         memset(labels, 0, sizeof(labels));
>         memset(relocs, 0, sizeof(relocs));
> @@ -490,6 +496,16 @@ void *kvm_mips_build_tlb_refill_exception(void *addr=
, void *handler)
>          */
>         preempt_disable();
>
> +#ifdef CONFIG_CPU_LOONGSON64
> +       UASM_i_MFC0(&p, K1, C0_PGD);
> +       uasm_i_lddir(&p, K0, K1, 3);  /* global page dir */
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       uasm_i_lddir(&p, K1, K0, 1);  /* middle page dir */
> +#endif
> +       uasm_i_ldpte(&p, K1, 0);      /* even */
> +       uasm_i_ldpte(&p, K1, 1);      /* odd */
> +       uasm_i_tlbwr(&p);
> +#else
>         /*
>          * Now for the actual refill bit. A lot of this can be common wit=
h the
>          * Linux TLB refill handler, however we don't need to handle so m=
any
> @@ -512,6 +528,7 @@ void *kvm_mips_build_tlb_refill_exception(void *addr,=
 void *handler)
>         build_get_ptep(&p, K0, K1);
>         build_update_entries(&p, K0, K1);
>         build_tlb_write_entry(&p, &l, &r, tlb_random);
> +#endif
>
>         preempt_enable();
>
> --
> 2.7.0
>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

