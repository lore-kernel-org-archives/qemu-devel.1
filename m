Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1759AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB9922BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1aJlF1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB9922BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHV3-0002jj-0x
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBHUT-00025z-9K
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:58:53 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBHUQ-0000ie-LQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:58:53 -0400
Received: by mail-ed1-x541.google.com with SMTP id n26so385934edv.13
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=znbRqtNim8WpwSphr2Jif35lxatQTIMyD7IaVe0VZ9w=;
 b=j1aJlF1JsDiuZRFA1IlNaW9XWhS9Wutssv/XaacfhEXBPV/eHccmZYU66c23P7N5RD
 AWiGHntZglrDUXvqv5EDBISiUe8iMuvqaeZDYdG2JAD63mENSHQcWZVQVyxIX9qqvrH6
 /JE6rPeQ/NWHsfGTguQd/hx/NiXiNEV7fjkYIQPMGo80S7HmUhDLhgbk2Nq0fjzSr3Tm
 DnfIliyHgaNn4m/UYDJopG1S5WZQ/BGef9bUiWpMlJSSkqvR3wvLtRtfgeCL5byojOSg
 xeYVY3hsCulXYtp2ys/W5VqlNDYU54d21/8k4s5PPVjlRfBbEMjBiP7IRL89/Kvf/NtK
 sgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=znbRqtNim8WpwSphr2Jif35lxatQTIMyD7IaVe0VZ9w=;
 b=cekGgNIgaDNSEjqf7n4pjVEOSVF2zzGLU9dKdKF/RwFdbmXBfnHC+DDnNq50gS9rDk
 Paptr+dxZxNVYK9ZaFOmDtxYZk8njIy932Vu2KnDbVtElilQl0bxgcxTol33HBNE4X4l
 dgMBjW8aXo4KR/hdSvHNqrRmlNvQFwk3XkaQBXhaPXV51fihXscbl+mIs5ywCm2FLtI9
 FD+xA1dV/S1Z8EyyhgpuKE0bSZHK2lXh/QvvhTQLm9L61PnbRXeozcv9h4ruYACBy/eO
 VHbcY1vlHAFjtJ4B8Q6yu59FOPmhpcXN4Nk38nxfvTlbOCQNi6YbcdA0hNuUAno/5Pgp
 m78A==
X-Gm-Message-State: AOAM533+R4PxZm3nw9qLm7QnBf6e+YIvIYnSZoyAUjF/hIt9QNnFhzB6
 vPeTZzrum4thVEM7QeX9tC3mWgoUkjGocLS+A6IiXw==
X-Google-Smtp-Source: ABdhPJzLB+Y7NUeFI5pq2FDPMzs6Cvg3UUVGVfdxvnz6ysdkuz9/sruMderRuA8hsB47uKqfyHdsZ33wyF7vZSb47SY=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr20081606edq.204.1598533129170; 
 Thu, 27 Aug 2020 05:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200812190206.31595-1-f4bug@amsat.org>
 <1ccf070b-7abd-ebfd-2788-92a81b4fc8fe@amsat.org>
 <CAFEAcA-nLLM3dqC=71JSfu9+8=xsnpfavD0Wk4Lkuf+EOytgQA@mail.gmail.com>
 <CAAdtpL6_dxhkoBS2hK8O_8Qj9s-MAtRnrBOTQZyTAEkW5Xwz1A@mail.gmail.com>
In-Reply-To: <CAAdtpL6_dxhkoBS2hK8O_8Qj9s-MAtRnrBOTQZyTAEkW5Xwz1A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 13:58:38 +0100
Message-ID: <CAFEAcA84b3WG5xDg18r4_XK2kZfQcBBqsmAxhroAg2ECbV+MmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/misc/unimp: Improve how offset/value are
 displayed
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 at 10:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>> What tree were you expecting these to go in via? Probably worth
>> being specific about who you're pinging in this kind of case ;-)
>
>
> Ok understood for the next time. In this case you are listed as
> maintainer :)

Oh, so I am, I had forgotten that :-)

Anyway, I'll take it via the arm tree. My point was really just
that if you're asking for something to be done it's useful to
specify who you're asking if it's not completely obvious, because
otherwise everybody's liable to assume somebody else will be
dealing with it...

thanks
-- PMM

