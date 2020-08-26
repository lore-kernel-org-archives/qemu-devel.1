Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D1BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49ACE214F1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlpMuLCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49ACE214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwWk-0002EX-Gt
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAwVw-0001H2-RV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:35:00 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:42537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAwVu-0005ni-6b
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:35:00 -0400
Received: by mail-ej1-x631.google.com with SMTP id j25so3160741ejk.9
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xgDKtH/NXdlRgfgjFMUYUC3LHsSE3fYVP0eehwAz7Vo=;
 b=OlpMuLCzO8+ySC0jywZ7QYXrKqejqKINzz8SIO1OsJjujyuwIH6UbxtkimPFglxYod
 0SRef3qMJGkHDdKu2B9b5rO9KYEl/LxtIT+6qo8GKAJwO0MrnFlu7A92pVNuthiXNdj4
 mWrb9zuOpHW9+aqQX0XnVJHnH3pHDrnCKcI51RXk1vooOBsuL68Yp85ANjrsQgphcr2r
 zJgoVVeylN34d8AoY6rRw6M2uEvzR4zsuR354CjzuoXqOEoAWw4qvxOilHftnPlVurVb
 mfMzRrbU0U9NYhvFszn6JgYE1sSpcTtixpZM9c5hKIwx8LDq4F31K1Omp3PW+qT2/bFl
 aP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xgDKtH/NXdlRgfgjFMUYUC3LHsSE3fYVP0eehwAz7Vo=;
 b=bvkpEORtnuvKU/vdQ0S3nzlb37KeF5VT6r7ff9LPCgtLxPjYKKryxx6q+oi+yekGnK
 UwDEdQYQlXxKRIHVLAjsbLiJo4donzryVUtHCXbbiEEWm5CMWRqQyVQuKmY7WXcPjtRS
 77q+rSqEoe4xb4W27f6XK4LH9ZCvbdoAaDrVfDeTj1xLAb9/qrCt+YRpM7i1vX1FdeWw
 95l7p53QB7ErR7MCWh4Bh8ba/bPB9zg4KFcpLoXsF95QAAlMKi9cW2t9tOMUXBJmDGPy
 BxSUOQOd4QulaO6XlNn8FUdt30dCAulPl1EJk/Sg1YRIiSFqztFbqqMsEzrKIrELk3yf
 i5Sg==
X-Gm-Message-State: AOAM533mRGxwV+g/H2+IS2LglHOAy3jzd+DQD1qjk3BktT36RccMCBeG
 U3Bxo/aK/R6fGpwwRaX9Br5P7nQ6pypoVnRTstNNrg==
X-Google-Smtp-Source: ABdhPJybH5iOn8ka9jWGYxgOZIs4+xTDk3Nkb1F47ySz55tG8wZ4d3VRBS42a4MJTtm2VCtXnmkmqh1fz4gQ9PGOKXk=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr15543514ejb.407.1598452495804; 
 Wed, 26 Aug 2020 07:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200826075055.779372-1-mreitz@redhat.com>
In-Reply-To: <20200826075055.779372-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Aug 2020 15:34:44 +0100
Message-ID: <CAFEAcA-XdiA0zDp-5pmG84y-9sKHJjYZ3hDatf-j8q4PJfbZXA@mail.gmail.com>
Subject: Re: [PULL v2 00/34] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 at 08:51, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 30aa19446d82358a30eac3b556b4d6641e00b7c1:
>
>   Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200812' into staging (2020-08-24 16:39:53 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-08-26
>
> for you to fetch changes up to a5d3cfa2dc775e5d99f013703b8508f1d989d588:
>
>   iotests: Add tests for qcow2 images with extended L2 entries (2020-08-26 08:49:51 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - qcow2 subclusters (extended L2 entries)
>
> ----------------------------------------------------------------
> v2:
> - Fixed the shebang line in iotest 271


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

