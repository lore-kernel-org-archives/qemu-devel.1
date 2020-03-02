Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6C1C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97DA2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0fRD6gS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97DA2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jrF-0006Rd-6E
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jnK-00043h-Ou
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8jnJ-00050f-Pg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:03:34 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8jnJ-00050M-KC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:03:33 -0500
Received: by mail-oi1-x241.google.com with SMTP id t24so2810191oij.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xvrzjGN36cRh3bX+Msbr9VgDla31tI4bhi2vHnugGuw=;
 b=H0fRD6gSKDPv2BOx/ac9o9dPrdEsor5fhwOfcDwDrf7AV9jxdf3K8I3kEYegdExbNr
 LnNzv7RMIZ5AKHppzPujmBZlyta89AJivMGajgGokKKZrFIzpDKgYgL8dP/l9MuNyyOf
 Yz765Oj4PU0VRrxEThZmDpCPxjge7EzK5GYcP+PVib0dG27IIb84Pu9ObDJ+CGVdFhgX
 x/Y0F76wl2QsEKgNnasmUTS/7fH+02/gPa6zYlgzGXuh4MJwiLmnAb9VokxqUmELZ5U5
 QVsSuurXmCxxMOvN7RA/ShYD3Jtah+mGdyG5j+GkjSnzYJ6f1mfiST+0aYJ37uzWF09h
 xhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xvrzjGN36cRh3bX+Msbr9VgDla31tI4bhi2vHnugGuw=;
 b=hoV1st4fQjoGAOhAHrZ7Dd9mPpkighnMuLqOeTQjsy3LZYEeaGQ4C3+XT4TkwqlP1Z
 67vHo3M0l2CfsgXmaP24ChKKeSnwGPtBwbB8z0iboIcC059G8F4htpdeqlscDBsd6wpL
 eBtqBYhxqckvqfO+0/v/O2I4cial7du5NjcAp+3oz1V9+Of6GR6hMq0KUnyIOdZ7viFm
 rP49YvTTrwz4SchhOZ9y+FvkQhOPrkc1YGNm+JUqKPXuoZ2Wi4L72SzfhyJ0oN4BB8PH
 gyZbglK3hh6/jqL0B3ml6n2GFFwtGHjK7UT200Y4v56pGGUVMnq3x2j3LXJM17IXABQn
 KVzQ==
X-Gm-Message-State: APjAAAXZMORqEIF1e/KtaDo8jCEDWIx76GS2gbYC4gWf+hZnWIW6+FWO
 x0tYtNCPvvPmRS35UBfVP40lorQ33QjGNlDtSbyB8Q==
X-Google-Smtp-Source: APXvYqzRCxNL7b0cMMSLb8UuLrcxWiyYKAFPk0PmJejI0IcHLEpVxJubWTF24tm2m2Ma4gyGf8rAX4nOYnSzIh4pHI8=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr10877091oic.48.1583150612880; 
 Mon, 02 Mar 2020 04:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20200225031222.15434-1-richard.henderson@linaro.org>
 <20200225031414.15649-1-richard.henderson@linaro.org>
In-Reply-To: <20200225031414.15649-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 12:03:21 +0000
Message-ID: <CAFEAcA_S9SPLoC9E6naZi9pkfxzz=UTvUss=H4jDff4tgdToAQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] target/arm: Optimize cpu_mmu_index
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 03:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We now cache the core mmu_idx in env->hflags.  Rather than recompute
> from scratch, extract the field.  All of the uses of cpu_mmu_index
> within target/arm are within helpers where env->hflags is stable.

Do you mean "within helpers, and env->hflags is always stable in
a helper", or "within helpers, and env->hflags is stable for the
particular set of helpers where we use cpu_mmu_index, though it might
not be in other helpers" ?

thanks
-- PMM

