Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069FFC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C79208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghCHnCEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C79208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55763 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9ds-00064K-1W
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 08:01:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQ9XE-0000l5-Fo
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQ9Pr-0003ej-4l
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:46:49 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:44194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQ9Pn-0003cO-Jh
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:46:45 -0400
Received: by mail-oi1-x235.google.com with SMTP id z65so1818260oia.11
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Q9SOicrrtTczbrcda5tZpSyF/s7AqO5v7E7dfJBVzaA=;
	b=ghCHnCEqpesKGm+kztjg7F7ZVroDFsMY6MAaMPjMGBl5rJYSqg86Qmlq8GSRKHu/tM
	ec7JrnHVihlbPRvOpwh5t9/aBseE7eQw4VDUGtPDDdhClKLdgYO5gt2XkVZlx6zm6Klj
	MDfRZMaf+D00yuTkRDBn7c1VkoJQNgA/brhQ5OZ4U+RsZwHz39GhN+Ebe1vPRVd8TY0o
	PaGy46uHiuswaSl1V3uCrpxPQYooylp4baDLHrt8uTThK2sm3uOGlQUzoaIKbZILRhpA
	FIFSbEo5NiJIeNaQDwLH1+ne65LdObSdzquyfbqxQuXwXYrwIw5KLaTM9jbEEoLOc6cc
	k9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Q9SOicrrtTczbrcda5tZpSyF/s7AqO5v7E7dfJBVzaA=;
	b=DXcnjK+WdVApu9u2GgpW6i+XEPkBlKKWDytPVy1/qNnawB8xMshQtEbCu4g3SptcTn
	C9xUn4CNhO+eYZQVL9gmt1sf4iF+B7JNJnb8PUyESC9+MaGBzG1V4EE+1dBKqZgAdvG3
	/huyZGFz+ZfOCYtptCo+3A4P1ZfswrNVwwXdy2PoP8a7/+Ok9BVbu3SlhH/PW5dK6zqr
	ffkq7fUghL6+HI3y1x3YH9ZFeuNRdpNyp4bcCJwX118Eowr9mR/vssMRaY0irPrkrnPj
	j4QtXPhcBfttqgc2tF3iFBZ8258J5dxEvpy6qLo83O9/lu+/vp1/gZikxD4i7s2u/Ugj
	klbg==
X-Gm-Message-State: APjAAAVey0WkleW/BB9DQ2Hd6d5VtbMY22nWQbbMbRIVuBViP+X3xo+U
	dZr+PvceuD02SsH6QyxzH94zLV75foA9wFvTMVBQXA==
X-Google-Smtp-Source: APXvYqxEG0FbIhRiz1TUHdFCMvqRbVpnhX3xmCFcwS9bXvmW5tXDBgAboehUbG9OqNZmrwFq4R75G9yaFstUZHDqMAQ=
X-Received: by 2002:aca:5785:: with SMTP id l127mr12235653oib.48.1557748000634;
	Mon, 13 May 2019 04:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190510200101.31096-1-alex.bennee@linaro.org>
In-Reply-To: <20190510200101.31096-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 12:46:29 +0100
Message-ID: <CAFEAcA9Mn5pP5XSEjtnmd2N7XqhmQ_7FGHHBPh1B0ciXpifWDA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: Re: [Qemu-devel] [PULL 0/5] demacro SoftMMU
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

On Fri, 10 May 2019 at 21:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04=
f7:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2019-05-03 15:26:09 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-demacro-softmmu-100519-1
>
> for you to fetch changes up to 4601f8d10d7628bcaf2a8179af36e04b42879e91:
>
>   cputlb: Do unaligned store recursion to outermost function (2019-05-10 =
20:23:21 +0100)
>
> ----------------------------------------------------------------
> Demacrofy the SoftMMU
>
>   - the demacro itself
>   - refactor TLB_RECHECK and fix bug
>   - move unaligned handler out
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

