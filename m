Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9154EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B552072E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJPzBCHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B552072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtrl-0001wP-14
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1kMtq8-0000g1-2o
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:09:16 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1kMtq6-0001ZI-Ao
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:09:15 -0400
Received: by mail-ed1-x543.google.com with SMTP id j2so1469040eds.9
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+n6XMSerxV/mN+MG6lr65ui0/eANuaTQ2b8kAEOSL8Y=;
 b=GJPzBCHgwGOtqtijV8yT1ieBqpSbVCV4skRG+MKxhb7UQW9PVI9qQz6hXveeUCZ9UX
 4LcthltyQBA6uN6tgarEY/itbt0OgI3Y6HQdoWM+i6zM9kmPQqftAry8kpB4aL3Z7+fC
 W8lEufEOJ3wl6HJCWqFyZmSYcC5OPAlS2rMB2FRc045916SjVTQM5pmd5fHD7lcCN+tl
 bmFCy17srbuAvB/JkCwRXwOHUfpFJne4ppEsZb0gptlUp8ttIg/hUzOjFhLswGglxju7
 hhYqGOUrsQv90O+KM0E4dmIrj07S1K5uE6g3n1OS5o3DZRsklH0JfBRPOImsGiyxq75Q
 jeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+n6XMSerxV/mN+MG6lr65ui0/eANuaTQ2b8kAEOSL8Y=;
 b=MXA71zsspe1dE6M3ihxWWLoVRF8z2TPZqnhhHnb3D9UqQh1uZLzv6ibVsSE0OHi0zN
 9FGVo389loZlRXtB02FNpfN4IdJ5eaPt5xMsUPFVOLBm8aFa9/6wnCpAATxoVyqFepGP
 wCr6KvQ8pSTg5l++aTYcj0VsNH0lkuiWHkFoJkwNjaAkGzAGu04aOWv1FjT96na/XxF8
 NAcsl4D8ED1VdA7YS0T6zTCLM4CCvqZsFAeSpmvzpu19ObfCjAaeITjiRsVoUvBQE+nH
 /gU0r010Ac5fsrzHDTqmvocIqoIFCjz58RSKUEkLL4N1bYb0b7B25+H9FgDfgyo6agoN
 18XA==
X-Gm-Message-State: AOAM533vY8fWtgYMUSiHCsV1PBKQL6gZP+iNKOgkLlbbwTtoERaeJRol
 Xo4zKpV5QQsyBb/dHiy26uTFsn4T7BcxsCDWD2w=
X-Google-Smtp-Source: ABdhPJxsN418OFJrcWh97pVjk/fYBWlEA7nwZOLmmsr0PfKvaL8eWgVBqKQKS48Hm+QNRNyvPiq8thWYMB1LZp4rVJo=
X-Received: by 2002:a50:9e6a:: with SMTP id z97mr2097404ede.32.1601302151796; 
 Mon, 28 Sep 2020 07:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131934.739451-1-philmd@redhat.com>
 <20200928131934.739451-6-philmd@redhat.com>
In-Reply-To: <20200928131934.739451-6-philmd@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 28 Sep 2020 15:09:01 +0100
Message-ID: <CA+XhMqxdb9Y6HL_0Og4Px5OwdTqK5EKJcnKdafd790nJb8yYEQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] qemu/bswap: Use compiler __builtin_bswap() on Haiku
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Carlo Arenas <carenas@gmail.com>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unfortunately it breaks the build.
Regards.

On Mon, 28 Sep 2020 at 14:20, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Since commit efc6c070aca ("configure: Add a test for the minimum
> compiler version") the minimum compiler version required for GCC
> is 4.8, which supports __builtin_bswap().
> Remove the Haiku specific ifdef'ry.
>
> This reverts commit 652a46ebba970017c7a23767dcc983265cdb8eb7
> ("bswap.h: Include <endian.h> on Haiku for bswap operations").
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: David Carlier <devnexen@gmail.com>
> Cc: Carlo Arenas <carenas@gmail.com>
> ---
>  include/qemu/bswap.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 55916670d39..719d620bfe6 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -8,8 +8,6 @@
>  # include <machine/bswap.h>
>  #elif defined(__FreeBSD__)
>  # include <sys/endian.h>
> -#elif defined(__HAIKU__)
> -# include <endian.h>
>  #else
>  #undef  bswap16
>  #define bswap16(_x) __builtin_bswap16(_x)
> --
> 2.26.2
>

