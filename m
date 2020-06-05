Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB72CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB11C2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5gWNuag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB11C2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGnP-0002f5-VJ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhGmh-0002Ey-Pi
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:09:39 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhGmg-0002BJ-Of
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:09:39 -0400
Received: by mail-oi1-x242.google.com with SMTP id d67so8986363oig.6
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q4YC3wO915Po7XSyhexS+l59tp9txAcIDr7ZQ+wB1J4=;
 b=t5gWNuagxzXIfr6kPjDIY36QcowFBI3asGTC2g0FEkv6QH5joWnigxxPyrN4QgMVjS
 ti4EBYRs1EF25Azlp+jnzzVuUY49SgjBvcIFqqOB5VudzsEGHQgcxQfo7nexwA7GwoH6
 towAOyP8kUIiTtia6x1I8aLzu87d6ZnJNk0mbFtUKbWxeV6ZaaWqbzLWtw6UQzktOUfM
 5LEQZgfnoW11DQDfmR5cGTqU/ncIKcIqG0fkqyOpglGOgqh6RsCkpmABSvBDPTA12+sK
 k0QHzzOHU5jAPF7CX4qkxttq1Dm3Hd87EY/dlkRAlss7JLq16IyEvRMqLYUA8+mpjnFk
 EKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q4YC3wO915Po7XSyhexS+l59tp9txAcIDr7ZQ+wB1J4=;
 b=doyvlXNqQOyffur2dIP06fAc6fgdif7jyx4iDu+W78jWPOQFYNI0TZ+6Vt/mYXYHh8
 jc9OTuiZPZjQ+MbSY57y/zMvP8BcTgKfnyH+q8fCGNpSRsZtCb2UeAp3OICls4Vl3IN5
 Eb8zzRaKY7995sxgeweaAvOMW9QggYm42xKRBmlsm3Z7jcTIZ44Zx0Gmk01aOPL4PleX
 JFm+tC2SiRxEwOkkzCqEAyg46quTXM/BWLJ1UP3gyS+J9VzKTKwbZaaGqAE233AiEKHo
 TvVbs7ACh8TodGTsld6bNAQD3uly4ufd1FSZXYMHNemTeZ+6/uK78BfDMGCbzMLF9hmb
 qLQQ==
X-Gm-Message-State: AOAM533odmSV8hu1wDjvpBx3czcWOEuCAsf5624rnfcwplcA/f8sRiTz
 /NVmIlLH/DxQgNMsk//jPQC5zvDu3fDBOAQJ8jIrTw==
X-Google-Smtp-Source: ABdhPJyb0HTrsQ7s4TUcgZtKpbOtTxSl4YUcHI2IQDcBD9akwHSwgcrDn5kje0BAFviCnKhsx70gw4m+kPehUVfeilo=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2587465oib.146.1591380577050; 
 Fri, 05 Jun 2020 11:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200604034513.75103-1-richard.henderson@linaro.org>
 <87bllx4igz.fsf@linaro.org> <535cf85f-96d7-0e98-c69e-c09b976bc251@linaro.org>
In-Reply-To: <535cf85f-96d7-0e98-c69e-c09b976bc251@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 19:09:26 +0100
Message-ID: <CAFEAcA88+W6PR2K5rmov7fM9+vyCuWW9u3mxg=61B1r9kYQT2g@mail.gmail.com>
Subject: Re: [PATCH] configure: Disable -Wtautological-type-limit-compare
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 18:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/5/20 8:53 AM, Alex Benn=C3=A9e wrote:
> >> --- a/configure
> >> +++ b/configure
> >> @@ -2009,6 +2009,8 @@ gcc_flags=3D"-Wno-missing-include-dirs -Wempty-b=
ody -Wnested-externs $gcc_flags"
> >>  gcc_flags=3D"-Wendif-labels -Wno-shift-negative-value $gcc_flags"
> >>  gcc_flags=3D"-Wno-initializer-overrides -Wexpansion-to-defined $gcc_f=
lags"
> >>  gcc_flags=3D"-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flag=
s"
> >> +gcc_flags=3D"$gcc_flags -Wno-tautological-type-limit-compare"
> >> +
> >
> > nit: the pattern is reversed compared to the previous lines (foo $gcc_f=
lags)
>
> Not a nit.  The -Wno- must follow -Wtype-limit, or -Wtype-limit will turn=
 it
> back on.

If there's an ordering requirement here we should make it clearer,
or somebody is going to do the obvious "tidying up" at some point
in the future.

Perhaps this whole set of lines should be rearranged, something like:

# Enable these warnings if the compiler supports them:
warn_flags=3D"-Wold-style-declaration -Wold-style-definition -Wtype-limits"
warn_flags=3D"-Wformat-security -Wformat-y2k -Winit-self
-Wignored-qualifiers $warn_flags"
warn_flags=3D"-Wno-missing-include-dirs -Wempty-body -Wnested-externs $warn=
_flags"
warn_flags=3D"-Wendif-labels -Wexpansion-to-defined $warn_flags"
# Now disable sub-types of warning we don't want but which are
# enabled by some of the warning flags we do want; these must come
# later in the compiler command line than the enabling warning options.
nowarn_flags=3D"-Wno-missing-include-dirs -Wno-shift-negative-value"
nowarn_flags=3D"-Wno-initializer-overrides $nowarn_flags"
nowarn_flags=3D"-Wno-string-plus-int -Wno-typedef-redefinition $nowarn_flag=
s"
warn_flags=3D"$warn_flags $nowarn_flags"

(is there a nicer shell idiom for creating a variable that's
a long string of stuff without having over-long lines?)

It's also tempting to pull the handful of warning related
options currently set directly in QEMU_CFLAGS (-Wall, etc) into
this same set of variables.

thanks
-- PMM

