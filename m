Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62328C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7EE20A8B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg0xLkSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7EE20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0f3-0007qv-Cb
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 06:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX0eB-0006zY-EL
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:54:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX0eA-00066T-B9
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:54:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id r26so10136056wmh.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tRc1wFGoADt31h04bCok03WJLaNfqn/3kUZGVULqzzQ=;
 b=qg0xLkSj0rReMs6wUMdkgawQJduE6glcaZ3M/JJNhVwkt47v2fVBPJJfVKzDv432mw
 ycNE8i27pktwDKHPaeE2/BEh+ZLyMzY1uorEcKg6cQpuYDvvKsZZX6cRFcxS930xQ9d7
 b8c+P0Fv6oahC72K3eG1xJ5V1UetdetBoEL4CBnzGBvSKpvc9X19XtU0Q+vE8Xasm3lM
 /ZqXjKMndFB856wEA0onmOGrGXS8RRGDJMN9GI9tSFRS+3XK2LyYguZgjEMzZEINky13
 ww7r+oMl/P05KRjXICcDy7c1Zy7mFiQEGlESv+q9v67NuzTKadDw9o0BaUecJJySfyUe
 LNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tRc1wFGoADt31h04bCok03WJLaNfqn/3kUZGVULqzzQ=;
 b=iz+Ue+a9bXlPEzN73i50Vf9CAALzVkP80Zgr9O0GyJy3DsKckUsvbX+EuoEfcsXq0/
 8Kar+avkx4TkGItE9+qQOFbwjzmG05Q0dFHvI9q3YymmpIZqQI8XgJlrCUpeHtXcFKKv
 UO/9xK8tyEsQW93KFONdC+ylAvUsOsYTt7BKH8S2WkuACLbKuqQrvLTNRvk23Pe9Pe1o
 vGn6hOZoCVHHDgQI8k2Z9C+YAIQdywccsUmrmsjIAMFncDLUeKSb+p/faJ7sBSyTTAPj
 TXyrzkaEzxjt6BPf+QpzpLM841U+3M+XDkggX/2730J/zgKF0wWMn6aOzy9MuDKj00JG
 MLSQ==
X-Gm-Message-State: AGi0PuabDscl/gtAYdFPS4MTLVQpyUQciRgDZnFXPXzF3SdwYnU+uX3m
 3qRxKx6EZwbgLYA36LmHAVZQoTsZQvjzH68XsM4=
X-Google-Smtp-Source: APiQypJ9ewqTeRIergKcspUnlfNfDA/Isven7yFAosfVEH3inHBXuq+mw/Q2T5qLTRjRDQYvID21eFcXo7IpnBuaqco=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr17073649wmc.168.1588935264569; 
 Fri, 08 May 2020 03:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-8-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-8-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 12:53:35 +0200
Message-ID: <CAHiYmc4auUtJayvB-qTFNsv5BGhe0FaTTRxODZLw+yNRzwHB_Q@mail.gmail.com>
Subject: Re: [PATCH V3 07/14] KVM: MIPS: Use root tlb to control guest's CCA
 for Loongson-3
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
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

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:12 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> KVM guest has two levels of address translation: guest tlb translates
> GVA to GPA, and root tlb translates GPA to HPA. By default guest's CCA
> is controlled by guest tlb, but Loongson-3 maintains all cache coherency
> by hardware (including multi-core coherency and I/O DMA coherency) so it
> prefers all guest mappings be cacheable mappings. Thus, we use root tlb
> to control guest's CCA for Loongson-3.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/kvm/vz.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
> index 422cd06..f9fbbc16 100644
> --- a/arch/mips/kvm/vz.c
> +++ b/arch/mips/kvm/vz.c
> @@ -2871,6 +2871,12 @@ static int kvm_vz_hardware_enable(void)
>         if (cpu_has_guestctl2)
>                 clear_c0_guestctl2(0x3f << 10);
>
> +#ifdef CONFIG_CPU_LOONGSON64
> +       /* Control guest CCA attribute */
> +       if (cpu_has_csr())
> +               csr_writel(csr_readl(0xffffffec) | 0x1, 0xffffffec);
> +#endif
> +
>         return 0;
>  }
>
> --
> 2.7.0
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

