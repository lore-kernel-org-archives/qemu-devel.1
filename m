Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801ECC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E42217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h49vI0FQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E42217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU7i7-0000Vu-VW
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 06:46:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU7gm-0008Az-89
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU7fm-0001Db-Cf
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:43:39 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:32991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU7fm-0001DD-59
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:43:38 -0400
Received: by mail-ot1-x335.google.com with SMTP id 66so8300153otq.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 03:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=7pZqGcghdB6VpENHd3JD/3fA8PmqyDbewDKcTydtRkA=;
	b=h49vI0FQ4OdHJCr6OPdJEaGzLE55KWAhXXJZs87MEqVjpKy5OufKx5MumEpgLnrwW1
	/8b1a4i+/QM2ZoRCCkEkxmJeRRxSvnvbwYKOAeeodRA97jUdhl9IMgYNy6J6dIK9cX1q
	hUca26mKp6TRQF+81d4/UklNMqlPvktpjRKPTJL3tPZ45mUyPdn1CaE/k9l0n1sl8eRW
	U4UQIVT0YWF7cs4EvXXVAc2H9UX0UkfMxD4S1JDTzYeDKW6aPVxzD59hsF4ekHHLkpoF
	B+NVgF9QEsOfsbOXOTWAg1/mh2KQKdnoe6ro96zMg1zeguuzytpSaOGu+pDAyiuxV0SF
	Q3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7pZqGcghdB6VpENHd3JD/3fA8PmqyDbewDKcTydtRkA=;
	b=cz4gT8EsqzTuF7w8IC6djDefolTuGsG62TZFhH+l2UQMkL6q/70eT1e4t9XulP4GS1
	zkOW5MWUsNF0Caf7zuCsIrzg4P8677q5LX488vkGSkl2vvhuawY4IvkzIKR3CW6G4kNp
	NoO//SRCDNHQ0+jSiAJr7h1nseMDj4Knw4nm6re7doNunS73Z/VzpSI7zz87kfaEqNiW
	zobjhUxMPo48BDF5UKio+XOL4gQIJxg46sBMFMZZjdfmZrPF6qeN8TJteMjDOullkeqg
	Wy0vfwpij/uOVO42dd11wYay/TOFrB1m+iIn0DHNzWJ7fFWBVbTinSx5g9fbxDe9uykz
	Hg4Q==
X-Gm-Message-State: APjAAAXIvQ7VnxvOCiLPOgvUmt5oZ3ZsCWntT5HFS1BcKiYM7D5K8C+X
	D3jkgPvvnpXgpTJWF5rX6vYQiqBZMj9170sFCRwMtw==
X-Google-Smtp-Source: APXvYqyoVzxdudCCqVsXKhx0XN/7auvEBTImccTiGxHV0wxANYM5z119UHB1NgXIgbxkbIekuGuEfZ4+NRKpARuMyqo=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr31213680otq.221.1558694617162; 
	Fri, 24 May 2019 03:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190522222821.23850-1-richard.henderson@linaro.org>
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 11:43:25 +0100
Message-ID: <CAFEAcA-hiXiWObwrNLB37boeijr2vh212V9kg1xcqgDfXEZhqA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 00/16] tcg queued patches
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

On Wed, 22 May 2019 at 23:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190522
>
> for you to fetch changes up to 11e2bfef799024be4a08fcf6797fe0b22fb16b58:
>
>   tcg/i386: Use MOVDQA for TCG_TYPE_V128 load/store (2019-05-22 15:09:43 -0400)
>
> ----------------------------------------------------------------
> Misc gvec improvements
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

