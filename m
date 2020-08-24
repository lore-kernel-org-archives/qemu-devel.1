Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C5C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F35720706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LaoGrZpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F35720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kABdU-0001wy-LT
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 08:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kABcm-00016N-Ts
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:30:56 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:43882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kABcl-00028l-Ca
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:30:56 -0400
Received: by mail-ej1-x644.google.com with SMTP id m22so11626305eje.10
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dXZhTszVlkVg0cZ3QueoEXrT+cPUerAFKSlxG5lTWCU=;
 b=LaoGrZpxV/57gOPX3aC0hqkEQ0qEkjwr/cYp6nj9CaCTjMJlkMWztUev5hXtXD6R/F
 qYE2u4mIOTBoEa+5u1YPe+uQ89Y+C2/N7nyeycOnMyspnH/2iRYuVzEQsZzTTWD7o/23
 eqLKbIyafTLnwu+2GzK9fEfsAiwx8z+1DXmT58/XZ/aOcboppQpMt6fSogs1tfywFmdJ
 lBgZ/MdtXVwQdl5u0vn7TLIm6hMkr4sPS/huChF32AgtQLjTfuGAsHTAh5TT7el7JDZ2
 NoD5QkAwyHfoxtuT2XL/yzyKiPm4tBJF/yEtkidXKT+IZq2H5lbmahCoT6+EK4qgoUsC
 TngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dXZhTszVlkVg0cZ3QueoEXrT+cPUerAFKSlxG5lTWCU=;
 b=MVl7s8HjplpZm3msFA82+OnxakeWvKay+T7gER62CqBHQgodeudeBRJsieE+ZPbrnT
 IJ185WQhU3To5amgqVB64vn3wtNTOxhLYvhX5nLskKfbSycDXrc/5rXBP5RaYOhmcKl6
 +yPsKBdss87v+L8h6zi3GxlsnjS8KWsk45WA2P1p3VdHO+jZgBYiJ6n1RdE7UY3w6aXj
 AQi3wooCOEalUX2Qey26m5gUIMAvPwBIY0hSIMbDPz8Mwpji2wv7Rq2OSpJjK/I8w5/X
 h5JvNEny9o5Vo/ltpKPTVNCNyDNWtfpT0sr/O36oaE1mS125uiDI78QLd0eOCstfFghw
 HHvg==
X-Gm-Message-State: AOAM5333fAgpVZJS3pc7dthVRBg7AQXJM60w1+6dIXWlvKosbCGRX+Yt
 b+YqfCaKcnEXZIIxDTGe5KPYUTbTdCFQswpDG21XRg==
X-Google-Smtp-Source: ABdhPJxxjW53tsGjf1xZiy6oWe1ipqv5fhiNI+yqfrUhBPvzN//OXKyQ4QYIvzpefo5JUfkNyWunH4hLmfdAD/LmD44=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr5646649ejn.56.1598272254093; 
 Mon, 24 Aug 2020 05:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200812101500.2066-1-zhaolichang@huawei.com>
 <20200812101500.2066-5-zhaolichang@huawei.com>
In-Reply-To: <20200812101500.2066-5-zhaolichang@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 13:30:41 +0100
Message-ID: <CAFEAcA_QyxVTMyFZO=xTVaDdfLGureG1OtbsAN6YdEYfNo7vDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 04/10] scripts/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 at 14:43, zhaolichang <zhaolichang@huawei.com> wrote:
>
> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the scripts folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

