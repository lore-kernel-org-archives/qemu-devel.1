Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B22DC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BED6205CA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDttp2hk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BED6205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZT2-00025L-Gt
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQZQa-0000ni-7S
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:10:04 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQZQY-0005jL-Ft
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:10:03 -0400
Received: by mail-ej1-x644.google.com with SMTP id e22so9201473ejr.4
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CK7swgmfyvD9zBARMD2iUzOvMSOZKPh+3+4aCeaWmPQ=;
 b=rDttp2hky+pSeNZJSrcfv2z6iwUORIOkjhTtHSAtSPWzn6DhdNNn1yEDq+JoTyI0Jw
 LONw/htjWGGJCMnjTo7JVYkDZ99vgKnQNT32IU5UZXAUQlPm60e9I67FMREWoNSIkrJs
 nuN54+vzMtkRNW3gwtpnWFGc3OYSHdhSppdBaDes/P+H8YlzcQ0MdM/DobHe2IXYaNza
 Jrmj3tv0IsDC8TqN7jYiH1kXo+YDTKs+KI/HuqPwZfiKDEugpytavapKPoxzYosjzyOg
 3tWU/0Uhz0c2IkjAj6haCigTDCIOiPBKn0V9XSHCZoSZ52qzN2OgE1nWacg6I8tgvmP8
 Mp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CK7swgmfyvD9zBARMD2iUzOvMSOZKPh+3+4aCeaWmPQ=;
 b=BiVRJ1DZhT3zuOpJcmRcmeyCAYSPBkP4t0oBkePgZlhorM4gtwYVt5ARhfRXkZqE6t
 XCx9c0EzmKGMOM4KkVzPfRzJR311LGi91cZYk3kxzr5EkuXMBzIUu5Z4Hzwtg8dHKDm+
 AjqLqQDEbPeen05mq4pisvPjyarWVcCpqsXgKz7wU5U1GOGbfjGGywC2Hqyf+lXdQXsC
 A/XOHC7lgZ3Y0NYAKCsEKYhg6CmP+OJY+qaW890dXlFPkf1x3oJx1E2OXzaebD6jHMvc
 GN0QasUG7DmzSWNss3FsrWiB6g4XK3adptFUU/InQgVrVps7SzyHaJHFnEJ3JRkRElEF
 zwig==
X-Gm-Message-State: AOAM532bVdY7bCy0yXaY8wZAS9pu+TkqBENww6f6gC2zpR48ZyoASWk/
 yf2Ba2+dlBFJYPpH/FuzaSoKh8qhaIgc4rUzbBnRsA==
X-Google-Smtp-Source: ABdhPJxHfHlfytQbO4D7NH/qPhvoAGziY62AwUhJrYUALlCJLCx/Aa/eUA6iOJGRZ5F/LP+COVAAwFLOEdop7HOtWjA=
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr9841811ejk.250.1602177000494; 
 Thu, 08 Oct 2020 10:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201008165953.884599-1-marcandre.lureau@redhat.com>
In-Reply-To: <20201008165953.884599-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 18:09:49 +0100
Message-ID: <CAFEAcA9UviAFngeLruNVFKjeA6gnENw3VRP12DyneL7aSfYxyw@mail.gmail.com>
Subject: Re: [PATCH v2] mingw: fix error __USE_MINGW_ANSI_STDIO redefined
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 at 18:03, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Always put osdep.h first, and remove redundant stdlib.h include.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/dirtyrate.c | 3 ++-
>  tests/test-bitmap.c   | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

