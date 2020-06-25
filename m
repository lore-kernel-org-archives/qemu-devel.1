Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFC0206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNQtlz4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFC0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joR92-0006f7-QP
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joR8L-0005YG-5H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:37:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joR8J-0004CR-M7
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:37:36 -0400
Received: by mail-ot1-x343.google.com with SMTP id 5so3073445oty.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4ZFHpMOYtCIzEJVrMkx6YgojfrBC/z+eBsvCmd/37V8=;
 b=CNQtlz4NVl0V/rfr8id1Ogk5TAw4BWUfPwcDP1PTKGVvb1Ua3Bdp8QHQk4delh6e00
 mDUAAKu00kh2ZmJ2V+nYIvJ+GtQz2k3OdO1C6Oosjm2ZGJY7f0Kce+FBX1b7V86b2wnc
 a8BAuOnXB3pdvgD6NJ3HEbhb6kzmMkPHO9ogl07VxlBqL9/qdEoEeWEckIvQxISzjgxn
 IEnbbqA+WX2rdISFskQtLbHh2Em9Y1xCpHOgTa/xucTZVReTEZ/OeGNT0vhxxpK12XgR
 oTgOjMMXfEmTeo3X3YoTbXE9YQGMzIbCj3JyayZ2AowFOwwqAk2xL0Y7SHNHPNQGP4vS
 iUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4ZFHpMOYtCIzEJVrMkx6YgojfrBC/z+eBsvCmd/37V8=;
 b=lnUd/RDvwIKLLqOKfPYY1ah/RuyJNO0jMOd5uju8osKB/YL7Om3yeZ7lxygcLXAqb5
 aYNorMBlGP29cdeoI8kAbEmDyW/APUnQZUgKQzSDJ5bGmpU8j4HJ/ogmno/TQGYD9y5r
 xXZJ45FBaMs9fwkDdL35X+rHEb2gmWj3WM4G3os6UW8CbotsC0ajTJvugRMInrT7ptV+
 csyRJHfVOTCG7hByIqim7qce27NP30NareQw8ghZZ6Xv8IARKk6YOl555QhbyahzTswJ
 5f+2fbVFYpq47c8+T8imPzDkb2zNCHT1+NpNcfRb2L/BaeI1aUu5Je4MJ1997REB6QhX
 8yFA==
X-Gm-Message-State: AOAM532CaobSGH7rzH/XQmR2vEWR4QdDzJ1C7DHXT+bXeiAWshGccceh
 113VgqulUpNvKKyWInDjwZki4Kzrs4p0ORhyWq38IA==
X-Google-Smtp-Source: ABdhPJw8MoPu2B+uzGlbVuRWO/Sqg5/I6d4l8rDShKCnHoGAUMOgLozZhF7Ry7xZu1g/5tMaFqrpPMhwDvQ5BOwgmaI=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr25337868otn.221.1593088654570; 
 Thu, 25 Jun 2020 05:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-35-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 13:37:23 +0100
Message-ID: <CAFEAcA8rv1HEuExEKpfCYbpYium9XNDXdQDS97VUHq-dadJypQ@mail.gmail.com>
Subject: Re: [PATCH v8 34/45] target/arm: Add mte helpers for sve scalar + int
 stores
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Because the elements are sequential, we can eliminate many tests all
> at once when the tag hits TCMA, or if the page(s) are not Tagged.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

