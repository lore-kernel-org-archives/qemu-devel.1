Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D6BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1766A206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 10:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIsX8IZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1766A206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZB6w-0005hp-6M
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 06:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZB62-0004sb-Dn
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:28:10 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZB61-0001wp-7Y
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:28:09 -0400
Received: by mail-oi1-x242.google.com with SMTP id i13so24097616oie.9
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 03:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qseEYD2r2Voc0I4EJSD7pCzy50byU3y3vzmuRAIsqbg=;
 b=AIsX8IZR+qrn1DOEUyi4oF2mTCZ/z+akbSljGzln56La9cPdsX0dMSiZY+BV0uum/T
 CBQAmw6e00X3TR+PuAVndvweDFQqrekqwn7S1cRBb6wJKbsGNQIr+0VhvYTU5QWbhxee
 FtaKPoDs1Sheo9BCyTUJrxMWOXJQ/gS3ZxYeNP9gwKJiOfqP/akC/VMZlwXL2T9EM9Z0
 X0gf93YeVAgyQ99AXFW9/6fMx5VIuIMn25z3S5WfT9BazbOxIktAjbQEpKqZuIrlgqLU
 AUQkgGgxF2RGuFBAG861PHOOcx/lWZQvZJqisj+cIP0tXnC7oYkvE7KEqtUBYjN5NVnC
 AXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qseEYD2r2Voc0I4EJSD7pCzy50byU3y3vzmuRAIsqbg=;
 b=SSfz7CO4oVxzoZ1v2QSJ9bVJ1bmuU0AXUtd1nrBAmRj9Av1R41VlGNcpV/ij6RE6Tp
 Zr9fpBKKEp+nlgb63WkvvfrYWeURa9b5VFG7NDWfHCx1OhKn3/Jh1dpW38BZ+K2SA7nA
 g6fJiTdfWHCYeBufls+o2+IdIrrZSgqrx9Sgfs9h2jKl1YFOl8Tnz2cKj2sN/LAPDOCC
 v1c+XV9PTlPCo2g33PBKCUV+H8detwPiX7f+mQdsSK3KZ9LOBzw9t9evjy6ZIbZGppdx
 xr7cg9JeJCmRwTU1zdbEsI+je1jS4plZzxhCpFJclW2bwzH1sX5wsfyNHP40P+sj9T7L
 Cgyw==
X-Gm-Message-State: AGi0PuY8MXI5kZz2iS43FUdGNrDTidnIRG0rNu1UP1V4OOSR6aNEUfu1
 BUzIQUMkdhh9TofHrPKSycERVv4EyjLQ2trSpzSKyQ==
X-Google-Smtp-Source: APiQypImX+gCXLqpKJLkfXgpDgs9wyAwJNwzzM9BTTvaTmP1S0mvC5sUmxr2wb4nLKQPorv4lezimEiH/riGl8iYStw=
X-Received: by 2002:a54:400c:: with SMTP id x12mr29013392oie.146.1589452087751; 
 Thu, 14 May 2020 03:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200513163245.17915-1-richard.henderson@linaro.org>
In-Reply-To: <20200513163245.17915-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 11:27:56 +0100
Message-ID: <CAFEAcA_i7nsD91aNUjGCZzYt3uVN2_wjer_ZB2KTD+PxHixL4Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] target/arm: partial vector cleanup
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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

On Wed, 13 May 2020 at 17:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 4 fixes the VRSRA bug, and updates for other review comments.
>
> For patch 13 "target/arm: Pass pointer to qc to qrdmla/qrdmls",
> I added a note about the type change on the inline functions.
>



Applied to target-arm.next, thanks.

-- PMM

