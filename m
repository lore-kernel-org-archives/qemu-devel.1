Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B606C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 18:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF09B22284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 18:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODky0azv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF09B22284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQxTx-0003ef-3z
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 14:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQxRw-0002QM-Gj
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 14:49:05 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQxRv-0005WO-6F
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 14:49:04 -0400
Received: by mail-ej1-x643.google.com with SMTP id qp15so14546235ejb.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=/4tbkoVkdabXMCxk3mKB0iMGsQAJwJqjQPGk0gGd6TU=;
 b=ODky0azvzakForx+i+ayKwkRJRQ6IXRsbO8CNeJ0TkXKttjFLCHitu+xWKLaE+czLJ
 ONHDibwfzZd2yyR+P9RpDVDn4azgxIExoRBihCE3DRGkQDUT/sKcQdLcqPQX1F58cSEF
 hRjKKhmKYE5uIeXjiMal9n3GQHp/GCdgDW4R3P/eY0t1rf5TqV+9WxsvBp6vuLZt4gCf
 /FCWAxk/3FKomaxyD9JtfsimnJerDQZHtAc60wLKVnHBLu5D/KA4+h0ZWbPDrBbC+FFS
 av3a+7UnLOHpSuj9UW39UPhe1hBVOSWwZP2h5VfiS/KGUocmd6WK7Q9n2KnQam3QwOAS
 2r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=/4tbkoVkdabXMCxk3mKB0iMGsQAJwJqjQPGk0gGd6TU=;
 b=p3yk/rxYJVFDW9aVCCf5izjIbdCHU5ZdvfkgTLGPUnsMloKQ9McVg+eZj26U1pWya8
 aU+PSRhcqOYnP7Kr3YGxojrMpRKD5p6RJTwU6k3/boWzsI9KFY0TAVC6Tx5R3GsM6Qtz
 X9Jn5JmOo2a9BagEPUWxvKcP2E9ilSwGuaEqp5tjWgiPZLUfzCeEmxNSXomBagLFMgN4
 NdTOknfXlYxTHjNyqTjXUk3N1vA7yKaHufQ3TIKVXiE+P4uVbBewNyieKhIWB8xo0quI
 9nXEB0Jb+e/pA/F0sNX92K+r/5a+6Jdxi9tI1JXynRYWSlpE3Q4IpMCmX2CZQFwtPj6e
 3UQw==
X-Gm-Message-State: AOAM532Z86UGs7FGr3vNc72EfWlBFYIyLIp1L2twS+6DCMSPdtQRLSiR
 0bcWQMh/9Ndc39VB6Iiba0b3RhM0auQSwsT1V0quyQ==
X-Google-Smtp-Source: ABdhPJxcM22sZlKhexNa3kEkH7gRAjPRssaMR02IH3O8SnIvu7qmUdN10Lk6jpLmsiBCkPS+jjoa3VpXb8Gi5NJSm18=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr15459855ejk.407.1602269340281; 
 Fri, 09 Oct 2020 11:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201009144712.11187-1-peter.maydell@linaro.org>
In-Reply-To: <20201009144712.11187-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Oct 2020 19:48:48 +0100
Message-ID: <CAFEAcA8BiQcJJr3hkzTqnFLpYtXf1xbDf+GpgvYnPjJr_FAEUA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix SMLAD incorrect setting of Q bit
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Oct 2020 at 15:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> +        tcg_gen_extr_i64_i32(t1, t2, p64);

Oh, I forgot to mention, but it looks like extr_i64_i32
isn't documented in tcg/README. Is that because it isn't
really a TCG IR op, or just an omission?

thanks
-- PMM

