Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDECC28EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13922083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EChZBs4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13922083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58067 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpq6-0003wf-Th
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:41:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYpoW-0002p6-17
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYphH-0006i4-4Y
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:32:40 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:45260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYphG-0006dd-NC
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:32:39 -0400
Received: by mail-ot1-x336.google.com with SMTP id n2so471727otl.12
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=y7Bf5rX/Ic8M6HBk8DSs2Mgy8ZhmzAejGLk1jC5FdN8=;
	b=EChZBs4Zm3Z3QxUe7dYWIDiP4zBH+Wm1GicgcQ155hetNO22Ct/RiI3yD9p+rTf/aE
	fSEyJD6J1js+iX6SiTU6SoaV9yc4E6m2gt/zEDN0zHeAod8mTFFEwUjpoe/+Nfga7f6n
	Ms8gQS7P+xPAJJqOUVjoNa65h+muph9d177uMq3JLTOu4qMY78q1l2fO+fGgGbrNPQUt
	Kyjk4tcmMdcy/dKE6VW7OSIRn8i5ZFVo0yHOmgEs4bFvBl6k7lZ9450xUEIPoZBNa7n5
	fMwRiFWXGGnEn0jbZci1Grn8UQqEoEXwV7JdeAKUnFtV4qaAJ48xbuy3LID3gnjY5wBS
	piUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=y7Bf5rX/Ic8M6HBk8DSs2Mgy8ZhmzAejGLk1jC5FdN8=;
	b=MT4+zYvPAWFxmiq0u9TPu/eJ8NsLLdPSycE9DVb7yapvImomtqtjwnvsoEr9i8wJSi
	4GdPBXcP8r8eeulzjdRq5gwn1CDRzzBuWSlXhvcCbo9hx+aSORP1IYQKWUodiR6lkLYl
	RVYqfGWc7uIcHo15VND0a7jAxxtmJ5v0Qa4N/ynChA9dpLUMR9UEg2RMTUvHZiE7OmvM
	olRPZcLtSaka0eaX0uI71lT3Aq7lHxL0frKbU+exnjXuMVN+KakvE+fkLWNbr3cltCFE
	JWP0BrWbU60yDwrfUP8ELl2ITbHDuGuR6RyxKwRFsH0aPULe47SpH1R5dh2t+VxPJAJ2
	Kr6w==
X-Gm-Message-State: APjAAAVUnvwlnnMSXYq8APVQF1Xc1oMAIXThnXZd0FGGsdeOiU/iZYuE
	TPTw0/nRLjEA2EGa2Uh4EoSTF1sxAkJWjnwVMfmL3g==
X-Google-Smtp-Source: APXvYqz/gXRnBTh6Ri5QJVNg5tYDOsct1hqMYXkIXvBOvtVo3cviae3UF7VPCLXwguMixA+A49/aAPh8F49PttapHog=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr13831789oti.221.1559817157439; 
	Thu, 06 Jun 2019 03:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190605115318.9972-1-quintela@redhat.com>
In-Reply-To: <20190605115318.9972-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jun 2019 11:32:26 +0100
Message-ID: <CAFEAcA_3y4QKXBPc8Fao9NvRcdtiQmyx398-Hf0fP9CMVYu66Q@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] [PULL 0/5] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Jun 2019 at 12:55, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 47fbad45d47af8af784bb12a5719489edcd89b4c:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-04 17:22:42 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>
> for you to fetch changes up to 03158519384f15890d587937bd1b3ea699898e55:
>
>   migratioin/ram: leave RAMBlock->bmap blank on allocating (2019-06-05 12:44:03 +0200)
>
> ----------------------------------------------------------------
> Migration Pull request
>
> - Fd fixes and test (yuri)
> - several fixes (wei)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

