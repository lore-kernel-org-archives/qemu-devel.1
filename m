Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3E420738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnVzwDHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3E420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFXj-00064O-On
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFWc-0004my-S0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:40:50 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFWb-0007zC-9B
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:40:50 -0400
Received: by mail-ej1-x643.google.com with SMTP id u21so12087342ejz.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=luFblimsVKxsVLDJxEI1I1dK85GkDA/f/txmY+6eycQ=;
 b=EnVzwDHWcXmnn7rT3G7ocVlln7PVGUZULiQDcOvEUNLi8gyFtm2nlEOUrHHVqyefGS
 1K9lqzwn1ByNE9TS4JlAQ+47wljALENEPYocUFwB+UheWtYHdO4jZP2o+1pH3/kdUkyG
 gH6V23sauEvNwvkL7opDvKC4RIJjgIXJgCCSKoapyy/jNv1Dm1z6G7mRZmz7nnwZZx77
 UsYDJtReipnxqTpU+yAaup8keVnxl5gOPcz33y4wlpkHasQer7IMaXCLRPffUKWysfHj
 q/VksQgJRxecClcz56PJCyqyHqJRfR0pMXo4JxopQ+21iZ6VF0W+aNIbAlDhRHdnx1vk
 SLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=luFblimsVKxsVLDJxEI1I1dK85GkDA/f/txmY+6eycQ=;
 b=Zcod7w6F77BGbq1bBytFj3nt0ehFnwkazdWC1r8HlCzxRwiFUPizAnIutBabZSLCmv
 8maA56i5J29yqnsLvx3L5z/YFrxmwBD4DN0rIGHEZQ2nMGfGleqiqWm2JNDcAh/XBHTE
 mZacFGL/rn6tYzMjz2VKYO5dWQ8YkQfn+2s2rdDfffWdMn5V2zO66zFPwb1pu821upMg
 2ricNDJhT/EjqhujAdj6ZgTfxsQparJrrTcNKVNVjFT3bB735mV+ehwGYVcihwdRcy0k
 eDmLmHLVQfxknimJOBfMGJ/HTyFeYBxi24nSEuXV/pUSMUX2m+qobwMhxgoHBkPw7Pcr
 lhvw==
X-Gm-Message-State: AOAM533rzssfqoIQ8lVrluHe1F3Fb0DFCAQegVy8wDlWARqYWlDuc6Tk
 fIs7O/lrBIgrO3AnkI2RrE7rcfpP14K5bq3JyzxMdg==
X-Google-Smtp-Source: ABdhPJzwFJrYfAmGzmHAFr6zVEq/qNlNbBXca4OnmOSYTByFdb/htJSEIFF8azq/+g1uPmB7rlVUonjfOmSa3ORkijU=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr6734331ejn.56.1598287247810; 
 Mon, 24 Aug 2020 09:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-4-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 17:40:36 +0100
Message-ID: <CAFEAcA8CjUbK=CxYQtDoHgWnFigPj_r12Jmvz0AjmJgE+70mww@mail.gmail.com>
Subject: Re: [PATCH 03/20] target/arm: Split out gen_gvec_fn_zzz, do_zzz_fn
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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

On Sat, 15 Aug 2020 at 02:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Model gen_gvec_fn_zzz on gen_gvec_fn3 in translate-a64.c, but
> indicating which kind of register and in which order.
>
> Model do_zzz_fn on the other do_foo functions that take an
> argument set and verify sve enabled.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

