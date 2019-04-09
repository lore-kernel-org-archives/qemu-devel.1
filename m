Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842BCC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487E920880
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zK4jD8zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487E920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37819 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmf7-00038i-Jc
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:03:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDmeG-0002rl-7A
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDmeE-0000EU-TG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:02:32 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:35709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDmeE-0000EK-Kt
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:02:30 -0400
Received: by mail-ot1-x330.google.com with SMTP id m10so14879791otp.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=6/y1si9xn3zD3GQZ5ouIuQfK7Kito+ook9eyBf8lQTA=;
	b=zK4jD8zOkVS/OU2ZeHSPsD0llX0K7sta05K00vUmNO5PeFBU6JyZX7C562RCY4cYkL
	VrFAuO52TEw2LqIDZ3toB84/QKY7PcQB8vjKbDadmlLWS+mz1NHk0DAq/4i/Xj7UwIMR
	GmFpK6mkqjgDStcq7W+NRoNywlyzOtKmGAhNZo5V9jbKlJBGUxYoD2BOppX8zT86Ku1L
	Q01046AS3T8J8rS5sGVYKshXz7ES8oPQEj5Rj2Ni+O19dFEkZ9lSbTydeK5T/O8PMqaR
	45/oAQwkQ0OlXZG5T6BEuGAo8PsCUlW/9BTUI8F0p1H13SXOPWDCpVl7NQpYli1rAj8K
	pkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=6/y1si9xn3zD3GQZ5ouIuQfK7Kito+ook9eyBf8lQTA=;
	b=KMlo2QHFIlFiVc2x7002g3+t6Syqwv/18AX2VXRsCPynih6DTKjzx2JZBhQGElM4Sm
	tPkJL8c64pn6nJAhU+mLBdoupEpy30WJeoNT8Mzg93UEc04x2ri7o4CDfncKl1vWaqrZ
	a+KqcH+GuTpPVjsNjNI6Gz4W+B9hf6emYpF8T8RlLMzDirt34mv/3exdeXF2p+/cdR6A
	NT2sA6TCrGbwU016fWc9ZoEboTOT1iS+9EFFIs+I4jt8CF7VHWRdebxL6dj4Ca06jQzP
	W5WNq+G6DUKaqoZrQZG1UK+MimAUBMDFFMqgOY6l/+ZMIvoEivkxU94QmAd2m/tP13lh
	cONw==
X-Gm-Message-State: APjAAAU74V+oNiaj88pKnarAduLmJstHXKJrfTYwtzjPx3pFZh7Qfzzn
	9FxPtk1UfVJBLooDkRfal6BiF9o9ze1sRalbNhoThg==
X-Google-Smtp-Source: APXvYqx5hyUMsKuvwYTk4kGC+tHah9P/NyA/+f5AvYeku5mkOr/e602kDaMuKIp4qOccQUph2YUOj34o4ZXMSlglhvc=
X-Received: by 2002:a05:6830:1044:: with SMTP id
	b4mr23830524otp.274.1554800549483; 
	Tue, 09 Apr 2019 02:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190408190233.10321-1-eblake@redhat.com>
In-Reply-To: <20190408190233.10321-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 10:02:18 +0100
Message-ID:
 <CAFEAcA8U2CqknBTMUuMgAP8qd0rUo-5d5FfW74UfS4m4q=qmQg@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL 0/4] NBD patches for 4.0-rc3
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
Message-ID: <20190409090218.piQzPsMbY6K7ApHDIyG21OTWibEVSgt_r9b5rtyokOQ@z>

On Mon, 8 Apr 2019 at 20:04, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 2c573106279495795449b0d0373464b597dfe316:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-04-08' into staging (2019-04-08 15:21:11 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-04-08
>
> for you to fetch changes up to e53f88df77e70350b0eda92a2e5e39f67792008f:
>
>   nbd/client: Fix error message for server with unusable sizing (2019-04-08 13:51:25 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2019-04-08
>
> - Fix minor issues in recent alignment patches
>
> ----------------------------------------------------------------
> Eric Blake (4):
>       nbd/server: Fix blockstatus trace
>       nbd/server: Trace client noncompliance on unaligned requests
>       nbd/server: Don't fail NBD_OPT_INFO for byte-aligned sources
>       nbd/client: Fix error message for server with unusable sizing
>
>  nbd/client.c     |  2 +-
>  nbd/server.c     | 39 +++++++++++++++++++++++++++------------
>  nbd/trace-events |  1 +
>  3 files changed, 29 insertions(+), 13 deletions(-)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

