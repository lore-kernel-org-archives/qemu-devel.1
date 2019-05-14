Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D32C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D540A20850
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKVfB7Vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D540A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWfh-0000hZ-6P
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:36:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQWeg-0008VY-KT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQWef-0005Jg-HC
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:35:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQWef-0005JD-BA
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:35:37 -0400
Received: by mail-ot1-x342.google.com with SMTP id 66so15051560otq.0
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2D7PpSV+UdBx5+93vtVIaub6OrOfhIvHrseXQQmMzZg=;
	b=xKVfB7VpUu+rwayxan8hAZX7dYZkym+BL07wiOD7EouQHhBWT8rlteGmoDTLmK0gHf
	ccGgyYtLr1qsUihj6NYnoK8oULkHWaS+VOlCLHwunI6rlshSZIsG5NaM+6YOwpQGHFN1
	3yk4D8DNw35SN+Ilcm8v9ZMl2BzZoKGepZoeeTZG3jjoDMbMY9PgvqIBdZYpJISiofhr
	wvKEefxxoTDjD4RYuO6MV9XWs61BUbNKQ4euPYzwHu6vm9UAtmCuALPsh3USipX7XQoc
	SMwucmAV69LrkmIHvn6UKRFWILhVtKZI7GpVWFiXlK7Z5iClYc6DD7Ev73v9I772tmmg
	ejBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2D7PpSV+UdBx5+93vtVIaub6OrOfhIvHrseXQQmMzZg=;
	b=nFw0xGrj9hgnMhpk1aU201zmDiAqyBVbBW9R/m4CeNN0DOv/5W9FJC+4K+1iWaz5jK
	eX5CfkZRAmZNAoIEb/iaJWhEHIGgHScJLvLyhT0stdP9SRv3/GEXzHIyrYp1+IxbA5bR
	n/7FTxKZcxj+jMlRxfbWDBIc+bYfdr2RW6ixNYOiSg8bQ1Ce2UKRgzQLvqA0y6tGIUov
	fIZ3TqieNkKqPfe0wGvZGdDwDFwreAu7WQHqmfUdhwBn15MeSgXEPUz/PSIG7sWJqQ+G
	xeYKjlSFzKov5sSSiuiPchoAeMqtiAZb4ZzoVcFh6wqNb+a3yG570EdOGHxd1SuATAzG
	HjXQ==
X-Gm-Message-State: APjAAAUWton7tkfjZbLMmRUwV6XHR2Y1BBZ2qtPFLhBlSokW9ZgQ9OYe
	MJ3nt7BjaKoTuHSVL8wrOKu1vt9y1zhPba99c0pioQxEd4s=
X-Google-Smtp-Source: APXvYqy0ojY5VWJFn1XKcP1JTO2DXzTRGFJJSu4JEkwQTDal08trzfEwgumsgpcNn2qXpAHnDncZhU96G1csrJ4WW8o=
X-Received: by 2002:a9d:61d5:: with SMTP id h21mr21046070otk.306.1557837336092;
	Tue, 14 May 2019 05:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190514000540.4313-1-richard.henderson@linaro.org>
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 May 2019 13:35:24 +0100
Message-ID: <CAFEAcA-mBHD72e5AhZn7zv4bA_o-k9qwv5CK7bO4X-8GEL+J3Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 00/31] tcg: gvec improvments
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 at 01:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Most of these patches are in support of David's guest vector
> patches for target/s390x.
>
>
> r~
>
>
> The following changes since commit e24f44dbeab8e54c72bdaedbd35453fb2a6c38da:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-05-13' into staging (2019-05-13 16:52:56 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190513
>
> for you to fetch changes up to a7b6d286cfb5205b9f5330aefc5727269b3d810f:
>
>   tcg/aarch64: Do not advertise minmax for MO_64 (2019-05-13 22:52:08 +0000)
>
> ----------------------------------------------------------------
> Improve code generation for vector duplication.
> Add vector expansions for shifts by non-constant scalar.
> Add vector expansions for shifts by vector.
> Add integer and vector expansions for absolute value.
> Several patches in preparation for Altivec.
> Bug fix for tcg/aarch64 vs min/max.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

