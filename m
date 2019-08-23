Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204CDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BE92133F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph1KS7CJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BE92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BQE-0000pM-2O
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i1BPB-0008I7-5A
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i1BPA-0007rz-6p
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:23:08 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i1BP9-0007rL-UI; Fri, 23 Aug 2019 11:23:08 -0400
Received: by mail-lf1-x143.google.com with SMTP id v16so7373010lfg.11;
 Fri, 23 Aug 2019 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qbJ4lagEeZciH+sffYeabCvVwbjwNj/7sds61ms8Evo=;
 b=Ph1KS7CJEEXk+Cv0rS1+7DLQvJk6N5nR1v0KNuCnUnc32cPBvTgjMFYJeEpCKmay1M
 FxMLhfPSf+nB8AJYbg/Mm/8QcGlU9EZn/s7l8jkSPzxVEcsFJWeQCE6na//T4uJrH1F+
 e5sxhatLczTioyuFfaiLG2nmjJYJcSNmX8rhdM11k+NjKphZ1Uhhtb2UdI8D3DWUA1hw
 f7cMPiB5+QafhTdUi2ROe1VvMU21LZCJq2Z7B/an6YfpolgVnuK2hgmhoBfIL0TXiddy
 /UW/MSarwuSb6oXQw6J6/YkpY5DcmCJO0rLdz6BB4YCVi0TzZTgVWbHbHhgyWyv1G7W5
 U+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qbJ4lagEeZciH+sffYeabCvVwbjwNj/7sds61ms8Evo=;
 b=olpAIv6TL+Pbi4e+yuhCxII4PJyq/zSk4wXQ9vLIOoGOCwCOEHFW/5Xa1Jw9wuIM0w
 l8LIMNBVGuaZtNDVgchPJsGFA76e3aQ575EF4lUxnCzktf7eAdlfElG8OXFzHd+4aZUG
 EFz/TiuFtgyxJazakdV9DSNbxbaaHVpyfvi8P4pdgW9NNb6P1TgsnqWfuMztgNd2Tzn+
 uFd7VeyEH5wh4ZjiucTllcj3agS9+reklm0gBF87thc2jKaazLYPjxxRITPZNWXHNwj1
 tpKeC4y5CDJhLCzoP2Q7jBCMGQR24P7Zg7ltG4rXE0kQJHSHJaqBGI2WLk74aEQN2Qo5
 O1Mw==
X-Gm-Message-State: APjAAAVVk5wwOQDSEvW1zyPZ146ig/ytJawmZGlNtRoOHsW7dntmm2lJ
 87ciss5zsH487KBN/nXKSxa6jLa5r3K3eIKA8s0=
X-Google-Smtp-Source: APXvYqz2KHuFVfo+DwZPIdFP/hmuj34haEiJbKNGmak9IJYWROqLrrjACFjpl/Er8bMeZdRFtQ9mLpKRhaXs7y2t0ks=
X-Received: by 2002:ac2:528c:: with SMTP id q12mr2198539lfm.135.1566573786043; 
 Fri, 23 Aug 2019 08:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565904855.git.alistair.francis@wdc.com>
 <7e476df36a8c2ba53162e9a5f62e9fa171da00ad.1565904855.git.alistair.francis@wdc.com>
In-Reply-To: <7e476df36a8c2ba53162e9a5f62e9fa171da00ad.1565904855.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Aug 2019 08:18:59 -0700
Message-ID: <CAKmqyKOaoUBQ5PsOuDB4AZ=XK+p13LVHEn-GGt9+k-LS_MirvA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v3 7/7] target/riscv: Convert mip to
 target_ulong
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 2:38 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> The mip register is an MXLEN-bit long register. Convert it to a
> target_ulong type instead of uint32_t.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

MIP is 32-bit to allow atomic access on 32-bit hosts, so I am going to
send a v4 with this patch dropped.

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2dc9b17678..0a7985c3f7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -130,7 +130,7 @@ struct CPURISCVState {
>       * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-zero.
>       * mip is 32-bits to allow atomic_read on 32-bit hosts.
>       */
> -    uint32_t mip;
> +    target_ulong mip;
>      uint32_t miclaim;
>
>      target_ulong mie;
> --
> 2.22.0
>

