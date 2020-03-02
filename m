Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCCAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDCC21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5kyQyIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDCC21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kK3-0000p2-2K
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kJT-0000NM-0i
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kJR-0000sd-Vl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:36:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8kJR-0000ra-Oh
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:36:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id x7so12414421wrr.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Y7X9obL5Se/2sKCJiYEMJUeys8MVkKdWtedd3n9ZAVc=;
 b=e5kyQyIC8F3JUWZQC/InuverMqt64RMZSVT7Whg8IZgLhkkxwJSO9VbA5jN7OqAJtS
 f2FIsaOa/SWKnJx44ZzO96xbl83r/ABwNVYqu69kPY7cFO+JHhzs0W1n8gTmDHVE5qUm
 YXcgQ5U8kB1PbhzJKahjB7ow6yrU6f48LWjDTGblCxM3xeTXZZFC4dVxpGjkSh5niDc3
 zlxt+NO0pOw8c+V/xDWjjgtgI9FFy4S1a1FxGG9syjp9K2I+DES+N0G2dUTjGJR/wF+r
 8+EFMVv2lC5EeUGSWpVornpU2LsAtpc1aFtGicR/iztIisziKCR9lpuWqbRoIWGhJ3aj
 WFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Y7X9obL5Se/2sKCJiYEMJUeys8MVkKdWtedd3n9ZAVc=;
 b=UGUcw3RHPp7G3OkOTSPTECUXsB4/fODlPWjDY7GbGVMcMH1JmFeR4Jh6YxUzGjeV9Q
 WCO3TzXcnTMZyF0aV1NmeQVQpqgKEO1lxQSvGeyG1dqlEpZDqLwjsiO5pO2xyRl9ttkr
 3goV058MzGVhQJX8T0pYKphiUP0N07pltQfd2HQ1YRkaX/8i96MZ1mRDks0dfqFvG6TV
 NftMEg8ai+gLeJf6fehzRk/yHkWPmVqg0fjZ7h67yj8KExa3f0IWMsp5F8M28FX80nIX
 w/hwgX1c9OXeUb2mFfg0GWFeFyOQ5qDry+jPRWE+KwvhYfWYwd7y1ZpgKHz15QxF/2ni
 Us1Q==
X-Gm-Message-State: APjAAAW/jTIwoY5UKUdY+raREVnnEidG99HLFmPm0awhk/8WfHscE6Mj
 TuHUnk4d1u5D+QlOGtX/dGGYKA==
X-Google-Smtp-Source: APXvYqxD0U4NJoj17P9OGEVmgUzShBhrecqbUDrMqPOdQWXVFXDPgFc8BoMaGXuM9SfhaHZyzCUv3Q==
X-Received: by 2002:adf:f7c1:: with SMTP id a1mr14930140wrq.299.1583152604704; 
 Mon, 02 Mar 2020 04:36:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w206sm1758182wmg.11.2020.03.02.04.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:36:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DCDBA1FF87;
 Mon,  2 Mar 2020 12:36:42 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-34-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 33/33] *.hx: Remove all the STEXI/ETEXI blocks
In-reply-to: <20200228153619.9906-34-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:36:42 +0000
Message-ID: <87tv377x2d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> We no longer generate texinfo from the hxtool input files,
> so delete all the STEXI/ETEXI blocks.
>
> This commit was created using the following Perl one-liner:
>   perl -i -n -e '$suppress =3D 1,next if /^STEXI/;$suppress=3D0,next if /=
^ETEXI/; print if !$suppress;' *.hx
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hmp-commands-info.hx |  329 ----
>  hmp-commands.hx      |  821 ---------
>  qemu-options.hx      | 4054 ------------------------------------------
>  3 files changed, 5204 deletions(-)
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 1730f866cde..499d6d54b01 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -11,13 +11,6 @@ HXCOMM appears inside the documentation list item for =
the top level
>  HXCOMM "info" documentation entry. The exception is the first SRST
>  HXCOMM fragment that defines that top level entry.

We still mention them in the preamble just before:

  HXCOMM Text between STEXI and ETEXI are copied to texi version and
  HXCOMM discarded from C version

And don't mention the SRST/ERST sections. It might be worth tweaking
that while we are at it.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

