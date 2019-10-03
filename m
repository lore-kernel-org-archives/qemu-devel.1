Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEDBC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14646217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGFzASDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14646217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxkx-00008J-2Q
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iFxjJ-0007GV-MW
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iFxjI-0003ES-9e
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:49:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iFxjI-0003E2-2E
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:49:00 -0400
Received: by mail-ot1-x343.google.com with SMTP id 89so1675639oth.13
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 02:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PbLXrGmLvBuBVKVFojmp8JkQKW0ixtsqAXgm/w0U6KE=;
 b=BGFzASDfkEm30UZbSS6xcbqDvwPR5rHgwCXhY9WqnvLlictXopacRuQGcWIMinw/+Q
 t6FXW2Fexl5AGXCY3Bc2tnhv91Gjkg9EuyEuWD0wE3VkS2M+iQRw7euAao1NkwiFfnO9
 raxX7dDOh83Us/NP+Wnr2ei53O7LGKJ1UXRk35x2JYk3hBRJwt5NEO1PxtRDtOrsMPg7
 S/ZrVjpN1JFdUB5wjlJG9/D9JEvkWmUHUMtXaZL44c282gzGf+5Ala5JMFkVnBG0qMro
 KP5S5jyk9EG+4Ee80z7+Rnf4Kjt2CNM+aFx5yny2XaHB/49phDIlhJGHwXIjCLins5W5
 DllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PbLXrGmLvBuBVKVFojmp8JkQKW0ixtsqAXgm/w0U6KE=;
 b=nQy1Inku4iXd2PehHxmOgKqq/94TZyuQSxWERqXUjy/apMWf1ehQSslY/m6hRltYi2
 OXId31vzjKYY1FMOyt/Atw4X2bFuj0C0TSk2XMgGap9cxhIapxDt8wOrWVsYdyXdkzO3
 yq8kJLjkIu52qJaXHHPQoJcspA3DWGl9Lu7nVFYRNjcneJEEMf9C0V9rNqPiAw4vcYPy
 4WbzrVpyZdldqNvghkN93GHtrqdIe+y9ZnWUz7TDh+Qsuhk/aZNkvTEXVbi3x+Tv6ybC
 mChAAt1oVQfr+Lu1L3x6QL/ReP3Bd+A7rHaK9Al3YD091559/OVg1CIFYMYQFPTLuAnv
 UkSg==
X-Gm-Message-State: APjAAAXMv6v1MX3C1wPa4yosAbeG1cVEbo48KzQX76kuT1TSv6ywxAAh
 FN+FAVKaxhKXFmgYt2o9ntouW+Amv2VoD3M+4YtrPA==
X-Google-Smtp-Source: APXvYqwN109iA+lFDYDVaLGjbfIVToqzF1n9wpGHQJQ9PfXvZozqvmtpv+ALqljDWELn794XJ1Lmv1DGK8Rfw2rcNUU=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr5628321otp.221.1570096137983; 
 Thu, 03 Oct 2019 02:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <4cba4d80e570372183b6685a26c72fa3e907bb51.1570051975.git.alistair.francis@wdc.com>
 <CAEUhbmUYTn2+166CAg=uiy-sP7xkcc7mK=v66UGpiqd3tNZMVA@mail.gmail.com>
In-Reply-To: <CAEUhbmUYTn2+166CAg=uiy-sP7xkcc7mK=v66UGpiqd3tNZMVA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2019 10:48:46 +0100
Message-ID: <CAFEAcA9yvouLHnqUeZYtB7uDnbmUoj5kp+2X2nvDsaQkKNmw=g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] riscv/boot: Fix possible memory leak
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Oct 2019 at 01:53, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Thu, Oct 3, 2019 at 5:38 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Coverity (CID 1405786) thinks that there is a possible memory leak as
> > we don't guarentee that the memory allocatd from riscv_find_firmware()
> > is freed. This is a false positive, but let's tidy up the code to fix
> > the warning.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/riscv/boot.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>
> Thanks for the patch. I am not sure how I can easily run Coverity to
> verify the fix though.

You can't; we use the free 'coverity scan' service which just
checks QEMU git master. So we make the fixes we think will
deal with the issues, commit them to master in the usual way,
and then when the scan is rerun we can have another go if
the coverity issue hasn't gone away.

thanks
-- PMM

