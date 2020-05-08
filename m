Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776AEC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4283F208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ligq+n58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4283F208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWzuB-0001V1-Fy
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 06:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jWztS-0000zT-Ga
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:06:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jWztQ-0002fA-5c
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:06:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id x4so9617324wmj.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=T5xlC7qPnScxdD8HfkPXyyRLvRSedibj7CnwraNl2wo=;
 b=ligq+n587Hx4n2gUCiSweXFiBtq9wqtVWw1i94hYEQuOFEwLOzUK2AqmeVJrfk8Xwm
 OkUUqBsbITm5nSRLWTuoYJH8LK++ZXDlh/mMFJru9ZlE4aSDvc4n/1XUyX6E/laKqPHM
 HF6FlZcKWLpjuxB+hrneX4v5zBJJTYl9dcEWqejyAp66TdRRd/tn/4Ki17LF+GkNnyWr
 QrmgmoCAiKaCdpI7Y5kKIKzCk2S6uszGqOo5IKQ0EL/s+xrvUBxzDHH+gtBqmXBVybMv
 KiO4s4CMfm3YBwMRgD+keUeWzHZTHQDS6H+2uuqgURebT7cE1ugO4fEZs2SM46p2ZLvm
 YxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T5xlC7qPnScxdD8HfkPXyyRLvRSedibj7CnwraNl2wo=;
 b=fU8XILnKd1o/SKI2GSO5HScaL9p8UGq4o1DpYkhX/Tix9M2xKaOT08GiP/koFO3JZE
 eek5SPZ/EJf2xr6Wb7iW70u3R8OCRZ8vv9jPqbD2AUhpfcw8DVffIcAZW42wTopfBzxC
 m6iUV9akxdv97NuJdQZNH8wBnspAVpHoYgs4tyN5PSz4nK+k4PK7+fBBtH3dslYd/dQO
 qbzsoMOc6e5Y/Z3tJSGiucwDJZIUPKergH76Kq49FV4dVebxDuJDnnDADJKpjCA/2VCt
 iy8yb9TvPvGeiAa4MJpdmDxtsqummyKU2EMOIgyGBpMmeLDNgl9Rv+5XhBq9dM+TcPtr
 6eJQ==
X-Gm-Message-State: AGi0PuZQtHpm8RW4yzLe5pP/yhvyTx4emnbWLsR5vWFNC4o8uTSlBJ2x
 0S0fIDR9lLDKJdA2sYIy7Kv2SRfKHJ/zt+hwhf8=
X-Google-Smtp-Source: APiQypITeNK+k5wXCOBAFXPWVcF9IAiL/o64wDX9ljR63w3WxyhEA1CStyUedfLaHR+RNHQCtwr8y258jLkSDvBRBPA=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr14758749wmk.36.1588932366832; 
 Fri, 08 May 2020 03:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-2-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 12:05:33 +0200
Message-ID: <CAHiYmc41JQ+H+D6rsot34gDoKG1dsyFWCcs_FbuA2neAgReaOw@mail.gmail.com>
Subject: Re: [PATCH V3 01/14] KVM: MIPS: Define KVM_ENTRYHI_ASID to
 cpu_asid_mask(&boot_cpu_data)
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
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
 stable@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-mips@vger.kernel.org,
 Xing Li <lixing@loongson.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:06 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> From: Xing Li <lixing@loongson.cn>
>
> The code in decode_config4() of arch/mips/kernel/cpu-probe.c
>
>         asid_mask =3D MIPS_ENTRYHI_ASID;
>         if (config4 & MIPS_CONF4_AE)
>                 asid_mask |=3D MIPS_ENTRYHI_ASIDX;
>         set_cpu_asid_mask(c, asid_mask);
>
> set asid_mask to cpuinfo->asid_mask.
>
> So in order to support variable ASID_MASK, KVM_ENTRYHI_ASID should also
> be changed to cpu_asid_mask(&boot_cpu_data).
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Xing Li <lixing@loongson.cn>
> [Huacai: Change current_cpu_data to boot_cpu_data for optimization]
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/kvm_host.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

For what is worth:

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm=
_host.h
> index 2c343c3..a01cee9 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -275,7 +275,7 @@ enum emulation_result {
>  #define MIPS3_PG_FRAME         0x3fffffc0
>
>  #define VPN2_MASK              0xffffe000
> -#define KVM_ENTRYHI_ASID       MIPS_ENTRYHI_ASID
> +#define KVM_ENTRYHI_ASID       cpu_asid_mask(&boot_cpu_data)
>  #define TLB_IS_GLOBAL(x)       ((x).tlb_lo[0] & (x).tlb_lo[1] & ENTRYLO_=
G)
>  #define TLB_VPN2(x)            ((x).tlb_hi & VPN2_MASK)
>  #define TLB_ASID(x)            ((x).tlb_hi & KVM_ENTRYHI_ASID)
> --
> 2.7.0
>

