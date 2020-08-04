Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E167CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AC22075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eku4wYHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AC22075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tQA-0005zS-1u
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2tPa-0005YG-0N
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:39:10 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2tPY-0002lT-DI
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:39:09 -0400
Received: by mail-oi1-x242.google.com with SMTP id z22so5196309oid.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 02:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VOF0rmEQJMA+3LXgLXhs/k6HmHhcuaMx71amM82cLO4=;
 b=eku4wYHTjfUav4ALzjqD1its+rFYIdhz6dsaKk3hTFrUgVew20XuNYHYO9weH1Bmus
 M3N15W20SGKdqUPNHgj+/F0WOPOW4dVXauBHKorNEl57+h0ElO6PJbXqAUEijQpPdyAh
 59q4K52+ju+E+1vCSyK9O5k7SkJxwR0Z6JWajuopSNWBXP8YTJOPA5RXAhG3BHEZkUTd
 EIH4WsdRd2L/HtmkAiPcN4CruNSLNWcWvFNJsbTVhAiA/rq9jhBAYN+GGUU3mX9rmrJT
 KbxmRuuM/ptrvE9JG+Xq7cnNuRViLGfsJ68x9zJNCa5Ss/q0lu4E056ygw5DWy8FvbT9
 43kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VOF0rmEQJMA+3LXgLXhs/k6HmHhcuaMx71amM82cLO4=;
 b=cTcLK/d8ERGzI4C9MnQiTkqkXkk3xS8Q/e1B6X6CbbA2grZDAyoU+HQ62OkgSFmKqi
 vF0d0w63uJkmalghR9pg1r1xjy4hGGdqZL2XMqvrRb3/DwwaaOE4maTyfhFghcyxiKFs
 o5Bod8gzOMNxHq3zSJ7idEjRwREM41WK9733962cUDbPxF0mIGe2iX7zfAIpzdQ+gOlP
 kSZ0ivSJBxu6oRABUFxOJovev/rDNXnH5SRkID3ye1Fk2ulJPmMmeYBNt3tBL0zl6Ozb
 9Qmw7Pa6YjZLRKRy1OWAjiPOx3DAZhlvl1YzKFzPd1xbs0blUmVzjR+o+Ihq75DGbW6x
 KHqA==
X-Gm-Message-State: AOAM5317i9xmdoJj2p9u8sJRnkqoPr6QJ4/4xy4v9VDLWcjFW2+MZCtD
 V1KHpENTf9O5h8ZFZCbGh260g2uztI0pFgldlX1bqxFa4gg=
X-Google-Smtp-Source: ABdhPJykJMN6UQCFC2k8Iee1cRLEG5c+uOUk1jkKQmkmLjEJ1GZ2VFFkenl7PdkmsFsDRitItRS9M8tjsgblpXfoWVU=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr2518264oib.146.1596533946945; 
 Tue, 04 Aug 2020 02:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200803205708.315829-1-richard.henderson@linaro.org>
In-Reply-To: <20200803205708.315829-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Aug 2020 10:38:56 +0100
Message-ID: <CAFEAcA9tuO-3EMGk1Yggi_bRE75+0ro=g2r11VKUR9SNAvaPUw@mail.gmail.com>
Subject: Re: [PATCH for-5.1] docs/devel: Document decodetree no-overlap groups
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Aug 2020 at 21:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When support for this feature went in, the update to the
> documentation was forgotten.
>
> Fixes: 067e8b0f45d6
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/devel/decodetree.rst | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)

> @@ -200,7 +207,7 @@ instruction::
>  When the *cf* field is zero, the instruction has no side effects,
>  and may be specialized.  When the *rt* field is zero, the output
>  is discarded and so the instruction has no effect.  When the *rt2*
> -field is zero, the operation is ``reg[rt] | 0`` and so encodes
> +field is zero, the operation is ``reg[r1] | 0`` and so encodes
>  the canonical register copy operation.

Technically a separate change, but a very small one...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

