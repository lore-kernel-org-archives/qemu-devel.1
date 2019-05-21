Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85180C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF4D21479
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWEr/jS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF4D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54425 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5QY-0002xk-IG
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:07:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT5GA-0003A4-71
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT5G8-0008EV-Vw
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:56:54 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:34749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT5G8-0008CW-DV
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:56:52 -0400
Received: by mail-oi1-x233.google.com with SMTP id u64so3612964oib.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QOeA1VEcBG11WiPNZv+y111pQYyByw1kDnHYJuFpXdU=;
	b=FWEr/jS9j5Hzgu6Sz6Ia1rKl2YPA4ozPwcWJjlc++urDHshA4JaEEK9NisXuSe4pPl
	ikbfNm9sMLOIxYX/VFQzZZJ3/8gbs+3cUj94YGpOwWe1bAswO6k9Kuoi6ORgqfKsDyBJ
	Q20y/KbHHKOkjMETKix1EIvaUd1tpPSnq5ep2kdlZopy3U2w907biSIb8AuzQ0/mGoZ/
	5qU0ibVZS5VY2jydo3tV8r6x2SksspYP7Ao5z/HXVuxRppjXNJex4bz+t69LMhXzeXry
	4C2VQp8N222FYGf7BOLxUS/5+Xbxh+EQ7SevS5l1yF5CiN3MejuWHBmIXcrAbnmUWjjC
	McIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QOeA1VEcBG11WiPNZv+y111pQYyByw1kDnHYJuFpXdU=;
	b=EHm7jkGnhDtKBuZ7eFJsW/CkeGXxtFvAva1vWRt2WbZgj+1Z1p7g3YDDjJxdQsW1tP
	lQlhsopYeYcxunUQTSQqSb3KCkpqshnJ9ZKE/F1h4mdlyoB20s/7cjoisbWc1tD4W997
	D/Hs2EI8qibfjiyykAsPFUwimpi2E6jEkPsFqd9OmveAp1ilvMRJgJ5YRycaBl8Dh0rw
	l11QCJJj94M9K1bvyd7uMNO/KH56km+wOX3N+8SyGdEXoKIjX045ATMH6mYZTYRsduDn
	1GoMPWKnR7I6uUmWlJHQcHKHrbogcKzujC5pHBfp4sl7u9cEEcJlq+4icnWsgyhaDrsq
	J+sQ==
X-Gm-Message-State: APjAAAX2+ZlmEx0WSgxdKcEAEp6IkZsx0B/r8B8sqaKVOQmcbUWx1Li3
	B4ogoTM5l7JKMrn9FoIRrxOHnt2BRnC4CqpWovKpTA==
X-Google-Smtp-Source: APXvYqxn1EQKTRczpIm0W8biEX4X6bhphBkm7WZiBIewnRDEpauzX7iPDk9c5kAggmeZjYtviPupmzKl2cFzhKYBTlg=
X-Received: by 2002:aca:cd12:: with SMTP id d18mr3418369oig.146.1558447009689; 
	Tue, 21 May 2019 06:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190521105344.11637-1-thuth@redhat.com>
In-Reply-To: <20190521105344.11637-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 14:56:38 +0100
Message-ID: <CAFEAcA_As+FEizNVnQ_Y0-xNixXj7d4myXwBxk2Y+SEVRz4N6Q@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PULL 00/13] qtests and some iotest patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 11:53, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 2259637b95bef3116cc262459271de08e038cc66:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-05-20 17:22:05 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-21
>
> for you to fetch changes up to b3763a195cc167152df1f762b3c3a73f7db7677b:
>
>   tests/qemu-iotests: Remove the "_supported_os Linux" line from many tests (2019-05-21 10:13:58 +0200)
>
> ----------------------------------------------------------------
> I'll be away from keyboard starting next week, so I'd like to
> get these patches merged before they bitrot again:
> - some qtest patches to get rid of the global_qtest variable in
>   more tests
> - some iotests patches that have multiple reviews and thus should
>   be ready to go
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

