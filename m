Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77B822282
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+J23zUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77B822282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXPR-0007SJ-UQ
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUXNg-0005lb-BY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:47:28 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUXNe-0007Ww-1D
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:47:28 -0400
Received: by mail-ed1-x542.google.com with SMTP id dn5so10742626edb.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dLwOr1pJHfoZPQ4z0yK4dGfS0b5vrWlpNreL4DO3jS8=;
 b=u+J23zUDFOTE3DIKZzIQDuGppmouhLGqYJMTFxq55tV73tBG5L1/SrpV/JZfG0idlB
 3xrAiFQnV8h01aZijuVCV/EsDQc8He8duzsvcM1Prv+y4nPxvdYHLNpp8rq2BjT3xfNx
 UOaenGaatXDQRGIHtRgGNtreo30G/6sODgKjSyiRtWfhVcC81Oli9a51YydALlACpyC2
 SOujavjTexbKb+A4YPHkFT4rlQFsPRtKuYzp9/uy1A5e5BPcT8zC+a8NyUxaVW0N2MKU
 kL1o9PmRU+XOxyFyYbISkdmV28/HL3/wutrsYOiJx+ABUxYaqy3G0onPtEtq5apeh20Y
 IjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dLwOr1pJHfoZPQ4z0yK4dGfS0b5vrWlpNreL4DO3jS8=;
 b=nn9EyFMpTBNPBYyBLLTpoDIMBJpKgEJvZcj3AAnWAXv+jOy45oR07vPJ18vDd2gfp5
 JRSDivBDgvPeQE51nJPc46tw0ArMrIGyZV9r4zyuPozU0FjxuU9TAeR9+6HdQU4lS9qn
 O/mCf6UQhJR3JP5vRi5n//VCiTDOa+2oRVqUCoqLiqE42OrbKT8x4grplVtkKiVnE50i
 AN4waUUDWhh8TNoXrIviGHxnaCKTaBPF4VU2//4sdmE5/pwQytyDnm2kke+ldZSiZ5N/
 doR7OIG0otF9wsiT9kmQ+T5PClfENftGADY1XMGl9e3cMjqZ59bbkgP7eW6QFIW1QzId
 r/4Q==
X-Gm-Message-State: AOAM5324AlAoVB2+l2tSdzpYgX96iOe12UvzsbpariO9ZfF++i6aokNH
 r7I/VwR9XJGr6riL154a8e0xDa3SlT7yO2/XVGZEvQ==
X-Google-Smtp-Source: ABdhPJy6tEZBNW4FFrL3TLCnOLith9Ms9aXLaKszoTiJfakiY/9SE2E2uweWYQHUvX7Tun/82f0NOCDSjd/hWE8eF1g=
X-Received: by 2002:a05:6402:3133:: with SMTP id
 dd19mr473536edb.100.1603122444568; 
 Mon, 19 Oct 2020 08:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201010203709.3116542-1-f4bug@amsat.org>
In-Reply-To: <20201010203709.3116542-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 16:47:13 +0100
Message-ID: <CAFEAcA8EDw2Usgya3kZamqOwi0OaUT=C_1mv37tftBBt_TX_+A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] hw/arm/raspi: Fix SYS_timer to unbrick Linux
 kernels v3.7+
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Luc Michel <luc@lmichel.fr>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 10 Oct 2020 at 21:37, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> In this series we implement the COMPARE registers of the
> SYS_timer, since they are used by Linux.
>
> This fixes the hang reported by Niek here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg682090.html
>


Applied to target-arm.next, thanks.

-- PMM

