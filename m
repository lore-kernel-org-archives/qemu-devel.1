Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D43C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CDA20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cb1C+uG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CDA20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipv2P-0008QD-Pb
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 09:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipv1e-0007xe-Bs
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipv1c-0006Py-U7
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:12:34 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:37988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipv1c-0006ND-NG
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:12:32 -0500
Received: by mail-ot1-x334.google.com with SMTP id d7so2060850otf.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 06:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mkmGIi/HuHPvk5eDn3All8LMfFLJPGi2E0wyo4wf/4Y=;
 b=Cb1C+uG8pamOt+hF5qfsgcPNo8o0fz3/j099/0svGc8cam/7mpvd/sN9KeSbqxs2WL
 +DnW0Lwgv9I2N/ug0EzVpSnWTXNTPUoWa1UMMpfpsY3zhpbva0c0TkL0cjwI9o/9Ft9z
 /+fpaw0riRjgh75EBDZvIXt71jD0quHD7tKxuci5r90/17SDHwB/4JFjy5ajh23ikQjY
 8CFvnd+PbtgqwTYwLq537f7/LQEBK9U+WIGK7cEDNvrwC0wPNDHOUXAGzHyFUBZ3oom5
 GZHP9vcB/U6Ps/L0WYuBd7Ug7uCjq2nmErPC9UO1jvGOLu4Do269jIfuJeYtQRnx3+yU
 VnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mkmGIi/HuHPvk5eDn3All8LMfFLJPGi2E0wyo4wf/4Y=;
 b=icT6mr1KF8eY3XwbcXGm+aWbrwu4BYywa7GMuYHBk7iSXM6tpZwHZpIeCXc4kjiQWN
 qmuV0pObdqhQtgZBnEsZJgsR5hj28zmjq9Z8RFTP88C7CQMVm4OiCVyMcHyMPX7OTwBg
 ijW9hGrNtDoQzVZ73bJ2zR83iIgQB7mR1a+wDO/N9HNhS9vaQ2VqhmaX5tSFRCD2Kt5O
 5I++JQHQ37eAlp5mwY6qEGXgI3m+g2SGL4szpj26q30Fj2lEtPMdPuHFj7GRnM74LZIH
 2ZoYN4d3uHkExmo8bziTtSqkgHugqUeUPF3H1xPIA68ECuLCUzlv2Fiiaz2oyu7iT473
 xAVw==
X-Gm-Message-State: APjAAAWV5Ksjr2tVjvur3/puJZ5B1ehOwW2+vlcBDU2e93jwChMbWZQe
 rwCq39Rnz8S725w6Np0ssGf9NEAIK3uO7AKWt6oL1A==
X-Google-Smtp-Source: APXvYqwgqKaGhGbETEbYLtx+Rarrsg884cZYty9No5HY4rHE1pxn93uB2icd8yW9b6ckTNiNoUW9R7rEWtCgKfMDwwg=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr2792897otd.91.1578665551584; 
 Fri, 10 Jan 2020 06:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20200109141858.14376-1-alex.bennee@linaro.org>
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 14:12:20 +0000
Message-ID: <CAFEAcA_-06wBANpGdvgfDJLRyWYmGjLqJMqD-1mhXWGs3xz1yg@mail.gmail.com>
Subject: Re: [PULL v2 00/14] testing fixes and semihosting console support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

On Thu, 9 Jan 2020 at 14:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e=
7f:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-req=
uest' into staging (2020-01-07 17:08:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-semihosting-0=
90120-2
>
> for you to fetch changes up to 486e58b188c1b093a8f64d4b5cd11ff5c3514cb2:
>
>   tests/tcg: add user version of dumb-as-bricks semiconsole test (2020-01=
-09 11:41:29 +0000)
>
> ----------------------------------------------------------------
> Testing fixes and semiconsole support:
>
>   - build fix (missing x86-iommu stubs)
>   - python fixes for freebsd and OSX
>   - nicer reporting of acceptance failures
>   - fix build nesting of fp-test (breaks bsds)
>   - semihosting clean-ups
>   - support for blocking semihosting console
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

