Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1277FC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D666D2084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2zdRneN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D666D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hct1I-0004MP-3v
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43725)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsYb-0004U2-NY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsYZ-00023c-Tc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:24:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsYZ-00022S-AL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:24:23 -0400
Received: by mail-ot1-x343.google.com with SMTP id r21so6542688otq.6
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kYY3Tw0knPndtwsiDs1GZv4xECoZtAkY0sOXh9IHHK4=;
 b=k2zdRneNP0ekAEEFBu9nnSX++rzyKcpbt14h44/F9MhnYIHnOjJagMnRe95s41Hcwm
 edUFHiGUZ4Tr2QNXX/8T2PWMflv0ENbj6HXWzJKfaB8hFagIkr12IA3h9RWFiYFrTlO2
 OUZ3sNOrtfCOl3xEzR7GPTjov4yL7JS0b2q3r3yAH+m2Z7YlIwKb5XzmjpYVSNnb82xr
 HflN7kI2NIJBmpuHIOPm4k12+C/iuhP2BFL/aFlVtAmvf6E5Tlcqp/ixaY2H71Q4JLEo
 DqAe7nPTZphG6O/g/xygAQHa+VjfaKdoBhfT/5mZH3qYenJmmQXE1qGwVtmr0Wa3IPXZ
 jKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kYY3Tw0knPndtwsiDs1GZv4xECoZtAkY0sOXh9IHHK4=;
 b=kIoRWP86OJQSFsYLtBN6fNSsc/AwGt9f12c+EYBJv+nCMMFBYP1sYJTe/BCqnjcI3/
 mOIXEdm+9FP55YsNDnrWvtiGSfee87qz9374HqT3C5xxnYdGwwwLHAFEgia8Og0ef+tf
 7eRKti5MhNq9RuTOdhYuQMOvHJCOdEEZ0XIPpsVviIUMsXi7U8XHEbom0GOiloni3N9J
 Fr8VWVfXvt43zfvCgjNIqe0MD2fVZrj+hrJQGLDWsI49aMVBR+amolkT5/SFbz0mI7WU
 kZae2eueWkf0lxCySGwnaYU+okpaclYKa7iXA0FgAydsh7j0S5j1T1EnwsiEeErmRX8s
 H0RQ==
X-Gm-Message-State: APjAAAW7JB8JL9j+heTJlQ795AYhZA4KR09hj1iKUECRsvBfC1iqf3sB
 fIWMpPGAOspuSffA/dBL1w/0xR0TCwy6HPi2n7sr5g==
X-Google-Smtp-Source: APXvYqz7MitrTuYEj2jv9GbEXdWCc9OwvUkb19zHfPFq5PsjBHOLVapwbzNSCTln5o6ndNeSGGgwrc/e3wuDwjbqhRY=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr57708179oti.221.1560781462050; 
 Mon, 17 Jun 2019 07:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190613143741.15128-1-peter.maydell@linaro.org>
 <724331ba-44ee-c37c-e22b-452b6f25ee7b@linaro.org>
In-Reply-To: <724331ba-44ee-c37c-e22b-452b6f25ee7b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jun 2019 15:24:10 +0100
Message-ID: <CAFEAcA_D_Eyg2fjhcfWYwMhHSVCY5-gr1hJDn+kWBTK=gz-LTA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [RISU PATCH] arm.risu: Avoid VTRN with Vd == Vm
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Jun 2019 at 22:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/13/19 7:37 AM, Peter Maydell wrote:
> > The AArch32 VTRN instruction is specified to give an UNKNOWN
> > result if Vd and Vm are the same register; avoid generating
> > this in risu output, as we already do for VUZP and VZIP.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Alex: this pattern error is why we don't pass your
> > testcases/aarch32-all/insn_VTRN__INC.risu.bin when compared
> > with a real Cortex-A7. You probably want to update that.
> >
> >  arm.risu | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied to risu master, thanks.

-- PMM

