Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F5820899
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXxMuz94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F5820899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlrj3-00017Q-2f
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlrhM-0007Fa-C9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:23:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlrhI-0004y5-3j
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:23:08 -0400
Received: by mail-oi1-x244.google.com with SMTP id k4so4613156oik.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B/98kqpVXzkWPfl1fMf9boAsHII9YUkrJEjCgR3D0WM=;
 b=wXxMuz94J0EEGIEVnibQPBxwQhHt4r+TqjHcTtEz/CAV6HVOOt8FSYiQOL1NUktqlx
 o2q6P6qVaf5OUdiXP8Pd1xuR44N9tE4PqGKygxlKwPJDK7/uuZkjesXrxASAAWbjj3Wp
 DK+ZocCZCD50kGGBRfj4MY0QpxABKDLUbpYgaUlszqrgjWsqVS1y+gOBP24C7kG4/jSA
 PBZ993NZv2M7LcMqq9bkYcvVf36izv/pvOaSEEm0gYDL2ABjq8g/u7jvYDhsvmEFYbUj
 1KIXm7vXV5qXHq97sWhu6WdH5mmKso6WjXuEleSe0wRXAEJmMeP21UX35kgl33xDaYwJ
 D/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B/98kqpVXzkWPfl1fMf9boAsHII9YUkrJEjCgR3D0WM=;
 b=Cjzs3kMhC9xNrtCEttT+hWQ6OKBkwY6uPGbAxV4EswCdpfr1fx6HORxkSK6UaQqxap
 bjHHOYYAKOBGUFje9PPR9qXlzZ3U8QagnrPf2W9Uo/15vcYvAzwudAVJjPmCcszhkSC/
 6h/XL64IP/UZxbsMl/a+sYVIVvkgJNB5Wow2ahFzPBes7D7pntDaRwXOMSMREVw2DUuV
 KR/E9i5D5hqNfR+C0BUTcnchSDOOnw9ZuzIaaoFhYIvHWR7jlrAp2xwyZp5wsExQU8Bb
 O6IHy9CWgQcleq1Nyf+6/Emz02UqtrUWJdaTilL6J7n2zh7kfsYiiAxxTXhXcXPfNbsH
 a3Cw==
X-Gm-Message-State: AOAM532ry3Thq9fPq+fjhlVtBAP1raVzTS5g2unG67zpDZ3xhRLatnMy
 APQKiK3lEPgGwbnQjcycqbBSMxGbsNUu3azF0wIDRg==
X-Google-Smtp-Source: ABdhPJz3Q0GwR1n2B4S97nFq9lijn/CTMQqECMSkXWzumrbTPh63UUmguLkAaDAeDYf5enqoEUvVk2Qu2R86MGeMIb4=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2244852oia.163.1592475782765; 
 Thu, 18 Jun 2020 03:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200617201309.1640952-1-richard.henderson@linaro.org>
In-Reply-To: <20200617201309.1640952-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 11:22:51 +0100
Message-ID: <CAFEAcA8OmoFoPahYU8HS736BbHu1h3onpUADQTYA5Fkz+hxqtQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Vs clang-10 and gcc-9 warnings
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 at 21:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Three of these patches are for cleaning up warnings vs clang-10.
>
> All of the patches from v3 are reviewed.  The final patch is new,
> fixing a problem in "make check" (which I was clearly lax in not
> seeing before).

I've applied patches 1-5 to master in the hope that they
might make patchew's asan builder happier, though it might
still fail on the issue patch 6 is trying to address.

thanks
-- PMM

