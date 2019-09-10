Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A636CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704332067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBYstw5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704332067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cxy-0003wW-8w
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7cud-000212-UF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7cuc-0003Ij-EK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:58:15 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:46612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7cuc-0003IJ-6W
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:58:14 -0400
Received: by mail-ot1-x335.google.com with SMTP id g19so17552270otg.13
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IKGpWCaETjPlg4PmIa7agkONcgwBkgwoaMc5lc1/opk=;
 b=QBYstw5CEqweG9s5o43XrFkTUcgQ6mDkWWDkGWkOvr9zhDFNvvlPMPga6ffbmenZi2
 Wqlc+MN/QI4KuUFPoetFHVXjKA1Fjhj+RMGS0VuBOzt7jJDwEJI1OyB1xXOa/8dLkG5Q
 1kOhATlowIsIR14yDTSyRzuQLpWcfl0u0Uni1s8kf+YXVizbDgM2dCL9HOq5vblDKKFn
 2DYLuVRRNwmhZYBhZl+3ZepPq/zNKzzY0S8cm+ATQwzafkHrTzkBjP3fHFYqVb3jTC3z
 typvvW7CEiR2ndC3KMidTlRSrCRmkjJ5fkty2/rBh995fuHNS8GJqPqXIEwl23xCRtPE
 45IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IKGpWCaETjPlg4PmIa7agkONcgwBkgwoaMc5lc1/opk=;
 b=ezXo3vwKbvy5YDTVNnpIhA8SGDWJExvIVXSicpLcM2s3FvXbyJMZgFTti5AOjIl6v+
 EQsBQagBlgMg5q6A8iZLpHYB+Zs4QWV/J3V/vm2NrAXThVie4rjGI0m++RjlQ+PylIar
 +MDYpEy0BrAnxkAC+ggZ0z+whnlOf6/h5XVWNgrwTOVGVR8TNBT+y3W+9AbJBAymv86a
 mkNhXvziCPAmIi5NYuZ5/T3j72Tt7uG0rPpuBa8VSa1y5/6c7gzK6DwryVe2mrDPQkMC
 WUqcDHgpNyGXVCsK8ofqzW0nGXfepL/RNWYNa+2n+VNqqk/HghvyF50zpdV89WRqc8gt
 Xprw==
X-Gm-Message-State: APjAAAWU+9rtFv7Etiq3Zj4OrQq6YKnhTurKYjYnZ7cG4sZDgLTPoe/z
 V0gO/q1rT5DRrTWtvSVd9ShbkY4snjTKcCyDJIViF4u+KHY=
X-Google-Smtp-Source: APXvYqxkpzXlzDEZD2hxAcRF2jjs0ojrhwtrPPK1mv/rz2ruzfHbuOF0zl9gUmPW6bjGdnHITtDnx6odXcNy71FOC1Y=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr15973920oto.232.1568109493320; 
 Tue, 10 Sep 2019 02:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190910084349.28817-1-alex.bennee@linaro.org>
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 10:58:02 +0100
Message-ID: <CAFEAcA_rB21=KXr_kJinkeDa0i3=LAhAYDg50YQC_7v07TKXjA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 00/45] testing updates (fixes, upgrades,
 caching)
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

On Tue, 10 Sep 2019 at 09:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04=
b1:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-0=
9-07' into staging (2019-09-09 09:48:34 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-100919-1
>
> for you to fetch changes up to 4cf22bac5b22a36adf23dc9ec4628c66bbc6f209:
>
>   travis.yml: Install libcap-dev for testing virito-9p (2019-09-10 09:39:=
09 +0100)
>
> ----------------------------------------------------------------
> Testing fixes:
>
>   - podman cleanups
>   - docker.py python3 fixes (encode)
>   - DEF_TARGET_LIST applied to cross build images
>   - move a bunch to Buster based images
>   - enable Travis caching
>   - more common objs for faster builds
>   - stable URLs for acceptance tests
>   - additional travis dependencies

Hi; this seems to break 'check-tcg' (for a linux-user static config):

[...]
  CHECK   debian-ppc64-cross
  BUILD   ppc64-linux-user guest-tests with docker qemu:debian-ppc64-cross
  RUN     tests for ppc64
  TEST    test-mmap (default) on ppc64
  TEST    sha1 on ppc64
  TEST    linux-test on ppc64
  TEST    testthread on ppc64
  BUILD   TCG tests for ppc64abi32-linux-user
  BUILD   ppc64abi32-linux-user guest-tests with powerpc-linux-gnu-gcc
  RUN     TCG tests for ppc64abi32-linux-user
  BUILD   ppc64abi32-linux-user guest-tests with powerpc-linux-gnu-gcc
  RUN     tests for ppc64abi32
  TEST    test-mmap (default) on ppc64abi32
  TEST    sha1 on ppc64abi32
  TEST    linux-test on ppc64abi32
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
timeout: the monitored command dumped core
Segmentation fault
../Makefile.target:116: recipe for target 'run-linux-test' failed


thanks
-- PMM

