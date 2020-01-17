Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A958FC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B66206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0bV7pO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B66206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVPc-0007QJ-Jd
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isVOw-0006kg-Ht
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isVOv-0007iD-AH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:27:18 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:39917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isVOv-0007hc-3S
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:27:17 -0500
Received: by mail-oi1-x22d.google.com with SMTP id a67so22869176oib.6
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 09:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uh2luWmrKFKarfNNeoL+HOddBBD5U7rNQkFM3Qe/rMM=;
 b=h0bV7pO8KhCLdXw8mk3jGaIKpAmQH1MRWtfvfumy+Nx4D6BTsqUoxaDY/guJCKbr5q
 /Pq8PHtAuXESxvVS+RPnQUIU1ufgEVbgEh2T7vKl84cVJ38HIKOKyz9UOTzdZkTJ51cb
 k1us/BD5zczb1fGVX7eI7oU7QP6OmfSLxfx7E5QJ6iGn+nF81ZydcqM0QwoTf47T2ZEg
 QNhy8+8th9/+XekHfXIGgB+plagJm5Oq012UKnEzV8kv8MGMGqX4J5ZuLNExHG4QWzDd
 nRFyK5btZJaskq3nq8Gwpdu44LL1e6g71g7I76T2YBmA9rKZC213qYbCut//LHw6HqPS
 PWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uh2luWmrKFKarfNNeoL+HOddBBD5U7rNQkFM3Qe/rMM=;
 b=MRHVRxyncjEOMhhmDtxIdJ/be3YfhEecACjcvUzCR5ztUxa8IdiYtP5QbUwmZXWOfA
 u2GZoZI9QXjYHYtGSfuh3jq8XI3KduEU6x3C+VohMVUK/e+fpPnzNNLl/tqHEPFgC/Xy
 YecRK2LEkb2tUCGqv748oZLgcuF/5yy0sldPVxMBvVma5CgSzahMzOxsCeegO+ciNAQk
 UoVOJCXKoZuV/AOjNY/4CyePaE6IsJztxwRwlvMQS6LMry5NZRppzB+rZrtqhUxpUhyk
 7Psdh9mKvUB+WiPiBFw9nT2q/ubKW5E3TEnPxqcJgpPNeqCjOIY/ZdtwZ1iCP4TxhDsO
 ckIw==
X-Gm-Message-State: APjAAAV8j1mMzY2NfWGyJyzTQG3RIqviVvyXmQYfvtPAXZAJGUbQuLWL
 t/Icu8JDH3vCiyD7zgVjqQXk1tHMYtXMXsAhXBHsSw==
X-Google-Smtp-Source: APXvYqyaxBSFd4vtJIhA4s5ey7bh7R82fvecPAZSx24QD1nkBlkq/LLbIYeR2FLw8mqqKQfi8HkfC758bEu43uS5gP4=
X-Received: by 2002:aca:f484:: with SMTP id s126mr4063388oih.48.1579282036110; 
 Fri, 17 Jan 2020 09:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20200117110758.1995-1-thuth@redhat.com>
In-Reply-To: <20200117110758.1995-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 17:27:05 +0000
Message-ID: <CAFEAcA_pAHW57e6RhqadbosUjyCiRtwCmf1BX7xsWiaD7Nx=eQ@mail.gmail.com>
Subject: Re: [PULL 0/4] qtests and gitlab-CI
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 at 11:08, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit fee0ec1fd11a6fb960517e18201ed8a686a0d7e8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-01-14 14:11:34 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-01-17
>
> for you to fetch changes up to c82b95489f8c33318101d18e643f7b50259d8e4e:
>
>   gitlab-ci.yml: Run tcg test with tci (2020-01-16 17:01:39 +0100)
>
> ----------------------------------------------------------------
> * Various fixes for qtests
> * Enable TCG tests with TCI in the gitlab CI
> ----------------------------------------------------------------
>
> Laurent Vivier (1):
>       migration-test: ppc64: fix FORTH test program
>
> Shameer Kolothum (1):
>       tests: acpi: update path in rebuild-expected-aml
>
> Thomas Huth (2):
>       tests/qtest/vhost-user-test: Fix memory leaks
>       gitlab-ci.yml: Run tcg test with tci


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

