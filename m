Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02914C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C437420708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFiVpB4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C437420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWSC-0001Lx-44
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtWRZ-0000ax-D8
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:18:29 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:37302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtWRX-0001Up-KK
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:18:28 -0400
Received: by mail-oo1-xc42.google.com with SMTP id t6so338718ooh.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ZY8bGxqxcWM00BH3NHEsaeW1z3uQMbHXaqbyT5Dk3U=;
 b=jFiVpB4bH4ALqrDQrPlrRt64pM73t6TM2+h0zzq9Cnx4F6dDgJBLjYt0U4N+1QVLKF
 2o1+IJ86BIYPJkMLsKDdOg/h0F+E3LIs+HbCHt4W83Ysz3q3JhcJSEjFi2bknx0PwnBg
 eDGCBfVdx9jpqPIVhNjMK7Fwb8aOB4coWFsDhJtueDCa7WWwgCtNgmxhB74c61gIlcJF
 P7fc+R3X4DaVf6XMkVWWdVSKGopdxR1As6ggqKomGj1xZ4kqHGJzpj1vdX5CYaZ4JvFb
 8a6WhJ8zIiF2X2BS9IkAB6W993Ygg0lvPRA/EuMpd7DKfubljZWUF3AoJJ2zOSJxVUf0
 wJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ZY8bGxqxcWM00BH3NHEsaeW1z3uQMbHXaqbyT5Dk3U=;
 b=f/HVJHbAV20mgf/S8cLx3GeS5TN+5j/eMrPwun2t10zm1mX7u/Ayv7ldQb+HXW6m+r
 +VbK/4vEdnl+itqBgzxRFLvb2D2uNrYogX/fCmcfCtbmQvHdNhDNMeSddb+2c447eG3X
 svSuXgVuiT8Sde5s+covhFlGmozYJjLLk2Jg/qpuUMCjHJS3tCmC6a+51IyeQwyu/3kv
 TN0D56cmM14L3utBfGjsTeW6As1eoVIw+Fng00DSzR/bzJ+XXRYpUUT33vNG4Ovq69v1
 tPGgl2JCWpiww+9lkM0LFRumaWpEm4hUWwoUwJQWrYW9G6lr72Za4wbBUWNOUtUQ0MYL
 iY+Q==
X-Gm-Message-State: AOAM533opICiGUi/iz7V2ykS+HVzt4JNCoMh/5G0xm02N/og9VR4khZf
 Ke/Yo+u6fgfCxpFuN4cVK7lGvF/ZPHd4dTHcYDTA5w==
X-Google-Smtp-Source: ABdhPJxZQqSRBSLDI9EUzJT+l1FIZoC3Opr6HMvoXfkZdku2CgGW48hq5XoMaEbrAAmd/nYdovkROxLRFFgRTXOMVog=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr54553250oop.20.1594300706350; 
 Thu, 09 Jul 2020 06:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593806826.git.jcd@tribudubois.net>
In-Reply-To: <cover.1593806826.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 14:18:15 +0100
Message-ID: <CAFEAcA-vXJdepwhYPZggKJgHV1hDhfzZjQmmCsk9RZzZE9tvmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add ability to choose MDIO phy number to i.MX
 processors
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Jul 2020 at 20:12, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>
> This patch set adds the ability to select the Ethernet PHY device number
> for the i.MX25 processor, the i.MX6 processor and the i.MX7 processor.
>
> Note: the i.MX6UL processor was addressed in a previous patch.
>
> Jean-Christophe Dubois (3):
>   Add the ability to change the FEC PHY MDIO device number on i.MX25
>     processor
>   Add the ability to change the FEC PHY MDIO device number on i.MX6
>     processor
>   Add the ability to change the FEC PHY MDIO devices numbers on i.MX7
>     processor



Applied to target-arm.next, thanks.

-- PMM

