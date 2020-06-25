Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF2CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45375207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGnpVYBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45375207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPLb-0006lY-ET
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joPKn-00062I-RU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:42:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joPKk-0004yW-Jd
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:42:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id j18so5056860wmi.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4iPg8GiypV4DefkuqhuhE5qLtP/WdgjSeB7qheprsnw=;
 b=mGnpVYBLEb6NIHq/uY9ofX7raN4N2S4gFvgtxDmaSYHlegEcJJ01DHOCCciHsIwmTN
 K6SD7ilpU75Pk0r02J6xfESUu/3Gb2UFVbOMzRpE4wApdzWIrLCQCHTgB2TF6pOuifXJ
 dgKPref6asVmX7IjqWdumjPfwXVQ85uyoOqTokPYnF86mr6nqJqiYjCo7yvMuvCc3FVG
 ichOn9LdCUF/TZsyWIT4+6M+W2R0llj60pBEnlYMJMxzbUgP28Z8qj3bGrGbLv+nqlmC
 dH821dHMF/dag8s47fGPatZSWltZ83GZnkjsl3D3UvlnpuqkKAe+vr0OrwFHcMXLdMDI
 9bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4iPg8GiypV4DefkuqhuhE5qLtP/WdgjSeB7qheprsnw=;
 b=bBfORt8jYJ/nZiDeGbF1au+uTKyZsy36Avvb0G5fqKUej9G+WUzFPGno3O+YN2WPV7
 q9yKW+xi17BiaQb86pFEDtnDPoF9/QSyMbZKbL7N1Rk1ePtypoEbaE9Jj2uky7cyDmfq
 37DqF5EbqZ75PPhPkWSxBdKXin7fyj7IbQZGEc45jcaEXZc2RvPC2aws+QNVGXpb208N
 n6bMjhYKrWsHypVv7pti3Rh1xbDbWL8lpG+ghJsN0aCdU2bjH91/aU/Rbi7Ox4zKYD+z
 juYwNm4hvgirqfs/Y2uytfa8X03E83x6fk277uDJPWTXn7JVsv67C+FYAZFR+UFrrttB
 7DXQ==
X-Gm-Message-State: AOAM533RND9Op2+aqT0HX6MYSHVKsqfLoaFUgcTv21BW+muTYJrAq+vf
 tCe47OrO+L+KVdCBWCOq/S6R0jB6ZOz/T+qcvvk=
X-Google-Smtp-Source: ABdhPJzQ+9zY9+vb6icFRa7XRXO6CBcV6piJwDo/r1BIFnXfhBkrBzP9ZKtApDJeKfN1MKDhzg6bIL8w4STZUNHxuf0=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr2807137wmm.50.1593081737032;
 Thu, 25 Jun 2020 03:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
 <1592995531-32600-5-git-send-email-chenhc@lemote.com>
In-Reply-To: <1592995531-32600-5-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 25 Jun 2020 12:41:50 +0200
Message-ID: <CAHiYmc4NvnzdBscD_JBcnFSbBcvf=9BCENvr5-VJ+nbAw4vFHg@mail.gmail.com>
Subject: Re: [PATCH V6 4/4] MAINTAINERS: Add Loongson-3 maintainer and reviewer
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 24. =D1=98=D1=83=D0=BD 2020. =D1=83 12:45 Huacai Chen <=
zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Add myself as a maintainer of Loongson-3 virtual platform, and also add
> Jiaxun Yang as a reviewer.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

I am inclined to select LIOINTC patch for the next MIPS queue, even if
other patches from this series still await clarification.

If this happens, I will also accept this patch, in a a slightly
modified form, to reflect that only LIOINTC part is accepted.

I will also add this note in the commit message: "All changes related
to Loongson-3 virtual platforms will still be integrated via main MIPS
pull requests."

With these changes:

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51a4570..0226a74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1095,6 +1095,13 @@ F: hw/isa/vt82c686.c
>  F: hw/pci-host/bonito.c
>  F: include/hw/isa/vt82c686.h
>
> +Loongson-3 Virtual Platform
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> +S: Maintained
> +F: hw/mips/loongson3_virt.c
> +F: hw/intc/loongson_liointc.c
> +
>  Boston
>  M: Paul Burton <pburton@wavecomp.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> --
> 2.7.0
>

