Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A15EC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 11:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B2B20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 11:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yL1nVFzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B2B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49218 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM9XV-0000i4-6u
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 07:06:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM9WR-00005b-3q
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM9WM-0006i6-Rz
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:05:01 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:43778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hM9WK-0006eB-GS
	for qemu-devel@nongnu.org; Thu, 02 May 2019 07:04:58 -0400
Received: by mail-ot1-x332.google.com with SMTP id e108so1634117ote.10
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=yE0I1xWURVrQVbj7Vfl82OHn557M4cVJKgatl4uxJgA=;
	b=yL1nVFzhOFc7COo4ooXM/N30dlLhAdi/U2tGSDwOcgjzeyQnQ3fGhq6u5WE6CPUkmS
	jXpheun+t97CF6G2x2eHWVG1MflaaSmjL9pMfMQKN/BJF5hPhXbbLkNVF86qN9X+ZYhQ
	E8E5SejFXPPHPkOZiBh9fSDwxKvLBNgtTUZgFLuSWRG/2r92w2ijNxjct7tMSPdlQLNx
	0BCI2iyBVVZjeXHXJLCXXBLlOSdTCmhGKte9y5xZOUBxiG++x++HGrySQ9YDlKW79Owt
	b6CEbq9lhNEg6rczqLdQHY7qpQIvAbVesHBeKgz0opfD586/WtrFiye82F9OeWTCwPs9
	aG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=yE0I1xWURVrQVbj7Vfl82OHn557M4cVJKgatl4uxJgA=;
	b=Dp4of3Fexhbhbc9HaGbfBXjGhZm5kDHa4PUGU9NavLOyANMFeg+SOG1T6rYYe98EWi
	suzLvCRYsQGHEKaVSzAdHhw14gN4iOfgmenJRh99WeTmSzPI3kX0FSLQv6wntoc/YNGc
	CScTVedPbckq475JwqUuBNcM7Ep9755nkCBO4mOLEWHQlFAaVNE9+A18YvaztJP20db+
	p8reFLFYgkN0+RC8TT3N2xbcYjKXwn6mKcVJ7AcHxaV5JCrP9j9Y7LAXYoJ7pvsnc1a1
	/6L5Q+OT91HPEQCEv93XFA7HKYbGqvV7KKMnyB3IN7w3qTBr9WAjSNEPjzyH1tfTc2Ls
	amUA==
X-Gm-Message-State: APjAAAWYh5QfzR5JEGH43ArA9CVBevWrfvrPIioDsQ9ukwRmv8pBTBky
	4jpi46eaKCoSRigaoyc3GnJyf2lwYtePJL9b4MP3JA==
X-Google-Smtp-Source: APXvYqwpfuuNhUgK43i+WEHYC2E26VBfoV6eGQuBFHrLU5sXls4BTx51eIh7zSSdFd48qVpctJryoV4oyGutxyGFOm4=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr1929166otk.316.1556795089168; 
	Thu, 02 May 2019 04:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190501105904.29907-1-dgilbert@redhat.com>
In-Reply-To: <20190501105904.29907-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 12:04:38 +0100
Message-ID:
 <CAFEAcA-RkbwHbAigw7cezfVbCPspahBNEn_J1LCvcYYRjFg+vw@mail.gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: Re: [Qemu-devel] [PULL 0/2] hmp queue
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502110438.UEJ1Bq5Y6FQHey5mTvwC2rW4AKDEQAKumkUb2rCSd5Y@z>

On Wed, 1 May 2019 at 12:00, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit f75d15231e56cb0f2bafe19faf1229c459a60731:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-04-30 17:06:57 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20190501
>
> for you to fetch changes up to 574d96933ceff60b2d13fe97602572fc7e95f7c6:
>
>   hmp: gva2gpa debug command (2019-05-01 10:46:59 +0100)
>
> ----------------------------------------------------------------
> HMP pull
>
> New gva2gpa command
> delvm now uses hmp_handle_error so gets Error: prefix in messages
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

