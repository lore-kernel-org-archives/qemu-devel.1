Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFCAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CEC2076C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hO55mg8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CEC2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiHTp-0000yt-0e
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiHT4-0000WZ-NB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:05:34 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29]:37103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiHT0-0000qj-9p
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:05:34 -0400
Received: by mail-oo1-xc29.google.com with SMTP id q188so3435378ooq.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qpoGzWIIzbHiHnx+i3L0+ymWb5wwAFPtsfwtFzbgkKc=;
 b=hO55mg8PivaUX0QzXPymipGgzqaUFUKrbJssKO35MCjkRo3P6XPku8NfubZn8ypttU
 /wW/17SjsCVDeiz+VYHpe1QUsoNypQgaJquk5FRZXcI/ZmOKNNxVP/xYivAtOtty00lN
 CHMOKQkO9glqItJCd2Jssh3h19HysIY+74O1cr4mfMikvh5ME4sxLJT4dmCmEq7zrzXF
 bk7ouzVhT/YihLHng6SPjBEnu1b4Rw55Ly5F0ibBmLJKixbgulL1AIaRUTBdvHSvJQYv
 qK7ijWyZtiqdxYf40Kg+Kxn5/jaQElXe7NHiytxgy3J26ypbUwhPnYYsPiaWmv3Hfqty
 uLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qpoGzWIIzbHiHnx+i3L0+ymWb5wwAFPtsfwtFzbgkKc=;
 b=jIWxDsLZXA4ijPZXpOwKKugEJG7wEpq2ozkb8+ashWmxvijAswnVUt7usF4OTjYNbL
 DHtrfkGV0gon73VYcM+wG9nf2iQKeXK3ztYzcCzEi6+eydfP8u3bdtheqLyPZRCQiNtX
 uXXFLf6We/orOjrFKWzUv4ThaiJrPfty1sUCydKVn15khb7OAc+MaWYdhDF7Jc18+AKw
 LjMeSQTEg2xQMI8OVJUouWnnmSYu9BrWQf7112nT28yr7P6KFe5cxkkh0XEVQ35PYZsJ
 cLYyVQURQ5FylJkc3TySqFlVe4gtrZkfn/A7Q7gS3VcImNo5+NV4hfKI7SHoO+J7i/Wy
 TLQw==
X-Gm-Message-State: AOAM530GOqw8GAuuxpBre/E6en92xPop5jtlSQSOP3X5owenFEgJcPyk
 spS7g0c2mjKie1R8WfzZizGlrolSCQEeBP8vyqqsEXnVaiHhiw==
X-Google-Smtp-Source: ABdhPJwiVjmomK3c8Kz6WW+eqdj5p8uDWkrLOjehowQJ917jPrAJFrJ841E2IaSqoSinZEHT39L6cJoWZDJ2hIob3z4=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr1004442ooi.85.1591621528540; 
 Mon, 08 Jun 2020 06:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 14:05:17 +0100
Message-ID: <CAFEAcA-0Y6rFNrsD2SN13eZArCk3Ydvf6kv7OZaQ07fmFdSZZQ@mail.gmail.com>
Subject: Re: [PULL 00/21] MIPS queue for June 7th, 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc29.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 7 Jun 2020 at 20:46, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> The following changes since commit 175198ad91d8bac540159705873b4ffe4fb94eab:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200605' into staging (2020-06-05 17:45:59 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-june-07-2020
>
> for you to fetch changes up to ffbd8a88e8872d61fa5622a0075eddbe71951067:
>
>   target/mips: Enable hardware page table walker and CMGCR features for P5600 (2020-06-07 21:34:14 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for June 7th, 2020
>
> Highlights:
>
>   - Registring change of email address for two contributors
>   - Cleanup and improvements of FPU helpers
>   - Enabling some features of P5600
>   - Adding two Loongson-3A CPU definitions
>   - Moving futher towards Loongson-3A KVM support
>   - Two checkpatch warnings are known and should be ignored
>

Hi; I'm afraid this fails to build on non-Linux hosts
(OSx, BSDs, Windows):

hw/mips/common.c:21:23: fatal error: linux/kvm.h: No such file or directory

Looking at that file, it also makes the mistake of putting
an include line before osdep.h, which should always be the
first include in a C file.

The more usual way to arrange this kind of "real implementation
of a function for the compiled-with-KVM case, stub for
the #ifndef CONFIG_KVM case" is to put the real implementation
into a C file that's only built for the CONFIG_KVM case:
obj-$(CONFIG_KVM) += whatever.o
(it may be simplest to just put it in the existing target/mips/kvm.c?)
and then either
(a) provide the non-kvm stub version directly in the .h file
that declares the prototype for the kvm case:
#ifdef CONFIG_KVM
int mips_kvm_type(MachineState *machine, const char *vm_type)
#else
static inline mips_kvm_type(MachineState *machine, const char *vm_type)
{
    return 0;
}
#endif
(b) alternatively put the stub code in a built-for-non-KVM
source file:
obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o

i386, s390x and arm all have examples of this kind of "stub
version plus for-kvm version" function that may be useful
as examples.

thanks
-- PMM

