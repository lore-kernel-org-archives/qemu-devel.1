Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCE2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F92206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxrMYuTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F92206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY61z-0002C9-Rh
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY609-0008TA-NY
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:49:37 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY608-0000y9-V6
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:49:37 -0400
Received: by mail-ot1-x344.google.com with SMTP id j26so7185206ots.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p/L8YiOMY7moj54hTlWVGnurquvkmgCcL9OxN5wRMgY=;
 b=UxrMYuTVs4ja3V4pdqKqJb4BM5q2mLt2k7jkxgDNIJstfue6bI9BPVMGtmu2+jnqjE
 07SloKweRkO01mzTf0xw8zV8SLzgC3bvitlSHgKN7NxS5yefkMOGFHB61JmUhYQMPJD+
 +5o3KWb0EeCBdCMW5t5VDRDlv6qRsliks4I5VKHVfuYd3NIoOuhGauZhhL/WfwK0v4mA
 UgBYuzx5CcH+L2NTydh8kb+irzJkVjx9QxNFgJvZLoFai5u/9iMHEDIn4GkCjxksBJqL
 6d9jdYfjrV7ApxtIuoyastmqyhR2F7TGUvOTes47B9wvyKdMfQ8XrvAez7A7zQjtXqHW
 mAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p/L8YiOMY7moj54hTlWVGnurquvkmgCcL9OxN5wRMgY=;
 b=r4nNCBf014uCE4jxNEtv4kh8NhiWdUzICArbki7XyaIfZpTkfRqpfLO3imGFr8628E
 K2n2Hm2xAeVhqPQk6XLPUmGa8lU/rEeoht2KHaHPamTrQ6ABs8pGERTiO5jD3R+sBCVa
 cPr1W6AgwRB3xr/0hq+a5hXQZ0qJeDH+yor9LBTEuHtz0BfGuYhm1Vncc64jtsycpmJy
 +qwDRH4vpvbVWB5HJrX6j4X/4fgA0kCeBPhrfPwEIoyaNKILv1+GaMzOOUHuhcEnDe9+
 c8d2HSOFMFqYgZUmAQuZMyrdU3jUVQTWc4g8SncP+jXLPohFxIo6KoioGQunQ3O/aVXs
 VlDg==
X-Gm-Message-State: AGi0PubG+l0SmhYZBrM2RaR0zlWk6IIDWTLIU9MKOo06VWj49xS8exDX
 n2pPEMennHFdxGMlY6dE+cifPkTZJEzPCQDv7m5g8g==
X-Google-Smtp-Source: APiQypKknY2StE2gPeVG8BKrnpo16rxX+QEDBQiju3EB1ws6Ji1M7zJYgXNwAxRgi72X7QCPQYpXf+oF7rBOzxzo7QM=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr11510180otc.221.1589194175902; 
 Mon, 11 May 2020 03:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200505095945.23146-1-f4bug@amsat.org>
In-Reply-To: <20200505095945.23146-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 11:49:25 +0100
Message-ID: <CAFEAcA_dH+xKQegbsQkOM9YASEMZrmLO5HL-L8bWsgUq+hfTsw@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/musicpal: Map the UART devices unconditionally
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 May 2020 at 10:59, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> I can't find proper documentation or datasheet, but it is likely
> a MMIO mapped serial device mapped in the 0x80000000..0x8000ffff
> range belongs to the SoC address space, thus is always mapped in
> the memory bus.
> Map the devices on the bus regardless a chardev is attached to it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> from 2019... found while doing housekeeping
> ---




Applied to target-arm.next, thanks.

-- PMM

