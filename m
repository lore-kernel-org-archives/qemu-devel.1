Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC482C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758C6206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgZ7XSe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758C6206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhXX-00078H-Jy
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfhWk-0006fU-Fv
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:18:42 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:36778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfhWj-0007y4-PP
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:18:42 -0400
Received: by mail-ed1-x544.google.com with SMTP id q13so6854172edi.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cgVWT/7EaVq3JL2VPCshDy+mnlHKY+STTLQa2AhmFwY=;
 b=IgZ7XSe6gj5DELtOwg+4+KHYsnKWY9cMymOKGWYA/KviKH9KmtvpiEtJDevHwMSJ8/
 9rgoxmL48p8kb+maLsaEWw1H0VcwkQ8NMSrgvBdFrJo6kXUhw8+Lexpu7oqVvrBha6op
 kG3O/KAf21keS8BQZlUkbIp/enFOtto0GNMAR6QFS8FP6LrNsHmHiO4xfP1kijfGxJRX
 b8jxg1MP74QKKBLnZTwMlCcT30NUCr+CimzN9mQLSfT/anL5OGc2hJfV6dTfirCUlg8m
 JwM/Pj2O3BhGT3vXizZBj5LXyxqez+J9W91XUhdIE9iETuSmC8Amc4pg9tg3kOCyVfUP
 0Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cgVWT/7EaVq3JL2VPCshDy+mnlHKY+STTLQa2AhmFwY=;
 b=lOpvaAipsnAAGOMnp2Dlixuv8m8nQGFUPBInOL91hsO65PggzMC6Phf/TzClD5DMiD
 r6YCj0N8h4Lti24PkMW7iUcaciMI0M9LEBIh43YbDcUp1Af6ipmMKnhqatChAsvITEDa
 QZhrAYE0PaE7BfNnVxPteE+7LQkZKYW0xGPUaEkZFsAfQ6GpJq2TJD11dWGfwpikip/u
 v+DL9xZE9ctf0kHcDHq4J/EmLFdUBVUI1buWzAUi8KmH79BHYnVrqFv6MHlMHiJLnU8/
 h5WGyj9JnhPrGLyvA3EqN+eklQGSEUJbNtsQTJe30cS7qepLGBnzf0s32k2W3wtzGGMX
 lsxQ==
X-Gm-Message-State: AOAM531JFPshE898SleGR85v00QTMoUWIcXdRDyPmKiMuFGzbiBsudeH
 SQBvyntOu082hHyP/YA7PWDhxg4OHZUrOwvXh/o=
X-Google-Smtp-Source: ABdhPJz0kkW6TZ0lz8Szd7Cuw1TpIS1YLvBkEy99cabMFXNEUGmpCd2wlRUMQz/YNXX9W8vmtqdmXrtF3iZ5wUi6QTo=
X-Received: by 2002:a05:6402:549:: with SMTP id
 i9mr14163289edx.159.1591006720298; 
 Mon, 01 Jun 2020 03:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1586337380-25217-2-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 12:18:29 +0200
Message-ID: <CAL1e-=ih8KYpLTs8t5oGntcaT7jWFyY+Y1Jzyigf=hF8NXY26g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips/mips_fulong2e: Set preferred page size to 16KB
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 8, 2020 at 4:41 PM Huacai Chen <chenhc@lemote.com> wrote:
>
> Loongson processor prefers 16KB page size in system emulator, so let's
> define mc->minimum_page_bits to 14.
>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---

Applied to MIPS queue.

Many thanks!
Aleksandar

>  hw/mips/mips_fulong2e.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 5040afd..23897d7 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -399,6 +399,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
>      mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
>      mc->default_ram_size = 256 * MiB;
>      mc->default_ram_id = "fulong2e.ram";
> +    mc->minimum_page_bits = 14;
>  }
>
>  DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
> --
> 2.7.0
>
>

