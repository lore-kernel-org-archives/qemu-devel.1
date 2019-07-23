Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF6FC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E2F21738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeN5cXaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E2F21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpvQI-00018s-2q
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 10:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43456)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpvPz-00005A-HV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpvPy-0005rE-8N
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:05:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpvPy-0005qg-2A
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:05:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id d17so44170767oth.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jwhOqB5w99+LhfQsDZRaKQg0m6IJdpX8qT0oCvjFA4c=;
 b=YeN5cXaY15HdKCCCenqpvyawKN3kJ2DcFkQJxEAajfCelEXs7Q7J8ktjc/x+bJlJ37
 goaPGvmPeZ5YfFsJyursr/xnAPmdxsa8KQ5CSVon1JNAHOqPrQcKqR+TZo+Aqmmi5CIx
 hbhq4Z1iGhLCOy4rUrBHcZ5WbHvUxSgruEIKTEE7K/COe+vkvFThbJAp7GiLG3VOHFNN
 Ps33do99eKhA6DOyjva4U5bIwwl8nklgjOkV6pw2oeJ4afElBo0QC9a2h6GVMw+5oOvt
 GfQXe39Xjt6pBjqoX97Ys752Uql3hhRozgPb8pMX77DotGyUAQ872SrokisKsLXnK6fX
 U/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jwhOqB5w99+LhfQsDZRaKQg0m6IJdpX8qT0oCvjFA4c=;
 b=TuJ4T6Q+/rqMNU34gYxaqcwsd6hn8VlkGUf+I+gRDuBC8OL0MpbVdGOJM+/S972945
 U5VI02CL8v/QOZLeNAgs2vc74SPLfetEI09Jkk1rmvjoao27txnbDhnkTQtFh2oRFm2R
 7i5jbW/bEw3VFuZSQe9umsZ49wYPaF1i61Ce7Z0A0fZgvfGaUo4fM5Lu25H7GgkLJX6c
 nzX8y4/UkJ/YfhMYcGTeuPx3jzRXVOaNnAZCk8V08JkJiLdLiD07cVR3El6GCqyBtsy/
 hfCIS+HDa5tAHlDLZ8iS5pMpmbr6KAjgcAAkWwQvgt6gADbVTtY0C7zQQpnJ9Rhjiilx
 onSg==
X-Gm-Message-State: APjAAAWDaTzz239H/VqWU2/V3INi6EUEFqNeEovCymCOe595/HKbXwZ+
 rCtUP11xLsQkmGQpfmi4w4+1BKQ0ppsT5ZYFcZIhHQ==
X-Google-Smtp-Source: APXvYqyJzqS3cLOVxoTOSlJvSPHjOSPOFRcKI3aP5x2Y9LBStzpjJX/5zdMijEneaXfA0b0uO9jeX4HMCoqMNhvi9Mg=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr20396906oti.91.1563890724765; 
 Tue, 23 Jul 2019 07:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190723133118.27244-1-alex.bennee@linaro.org>
In-Reply-To: <20190723133118.27244-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 15:05:14 +0100
Message-ID: <CAFEAcA_RaA9+od48doEf2W0DL-gj48AXh6hcX9fw1QQRqhjvng@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL v2 00/22 for 4.1] testing updates
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

On Tue, 23 Jul 2019 at 14:31, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe=
96:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90722' into staging (2019-07-22 15:16:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-230719-2
>
> for you to fetch changes up to e2e767784eec076bc57a1516967661d11e76aee8:
>
>   tests/qemu-iotests: Don't use 'seq' in the iotests (2019-07-23 14:22:02=
 +0100)
>
> ----------------------------------------------------------------
> Final testing updates:
>
>   - docker sphinx updates
>   - windows build re-enabled in CI
>   - travis_retry for make check
>   - build fixes

This has fixed the openbsd issue, but make check-tcg still fails.

thanks
-- PMM

