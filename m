Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84B7C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9187020880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbQGnD0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9187020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDXUX-0001Oh-Hc
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:51:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDXTf-00015b-Fs
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDXTe-0005fz-HM
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:50:35 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDXTe-0005f4-8i
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:50:34 -0400
Received: by mail-ot1-x32b.google.com with SMTP id o74so12812431ota.3
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1FVduYrkRdG1e7xPqXc4gY5lnfEnERfx9c1+XepQESg=;
	b=xbQGnD0JLMMM24K52l3fYl74qulMofU2JnWblG9QV/cIYGHd6OKeWk5amh1hJ8FdOs
	OJpWwnBnym5XBJPqOjnqncx96ZxUEeTWvRro7+xX925aD8N6flboVOjyEeE9ORE//qJq
	BTiDPnrocLF4q2FJG3ViR7MWU42lhcsooFa6PwiU74m04htUITYpG9M3zZ6igQ8mXX53
	LG9Ph+Lh94r9amREiZ9aK26SbbyPCXLg0yvD/6D3rAm4Zjo3xYzxewpdo0lFSHH9t3OQ
	fpfZoJ41l3PLrwMmNMwC7EHeJZ3XZvzdJsakDmdpUU4FekvfO0MDj1GqEKPRHEhHJsqD
	BoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1FVduYrkRdG1e7xPqXc4gY5lnfEnERfx9c1+XepQESg=;
	b=BaNS5EKoTdrXMS58tnDNHSubsDB7+z2ikfEmCxTOjbkthdmLY2bcEmm4Q7uqM/8n3l
	dJQqket6VWbuh0sugyLAB0FLJF1HvDy690RYZdQBmFSPl5ci74Hn6OqwMcCqAZNlpiAX
	j0qqPELjNGds0gzaYoUmhC8BMo0+euPX/hsyLuju+NxZ7W9a5oCwU+MAPLFwro/Sg9S6
	dZ+WbpnheIca1Cx1JkotgjBS4+aQf1zM+Lawoh4xczJyBIWZeG7mFY6Ps9F1Ki+Lp8K3
	6QNkpvMbQ0fkm1DndRyL0BvLg0IG0Rx2x5fgEI1VZp8lT8i7ZfOtG5BptjtKm/36wUij
	GqAQ==
X-Gm-Message-State: APjAAAULx3/hShYY2y5U9Kyp/6LeqhzRuOKrCSkjR+D86y+tEy3dsHn8
	Ol+wRJiOJwuZ65D+1wc3oxnsD0lp5COc9VkYp7pQXw==
X-Google-Smtp-Source: APXvYqyRvT1nOB2Oe3QeVy5tczjisvSPzaae8wwljLkBZkIFY62tQ1FsVvkrqOq1YPUxDLnRi+P3DPa8ljvMCHb0f70=
X-Received: by 2002:a9d:3b44:: with SMTP id z62mr21107843otb.319.1554742232901;
	Mon, 08 Apr 2019 09:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190408110920.30119-1-thuth@redhat.com>
In-Reply-To: <20190408110920.30119-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 17:50:21 +0100
Message-ID:
 <CAFEAcA8QgQJJi+rH4gFfrx7BKo98fMjtyJgLU1cCkCs15=h4_g@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 0/3] Fixes for libqos
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Jafar Abdi <cafer.abdi@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408165021.RTxBpJog1_xcJLl70_HmtR6Fy_KUEwyDmeM2A-QnQ20@z>

On Mon, 8 Apr 2019 at 12:09, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit f55a585d1037e5de6088f25e75443c2776786e29:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-04-07 14:54:55 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git pull-request-2019-04-08
>
> for you to fetch changes up to c19f2b711e15dac4c2cdbace2f8fb3a45fbed0d2:
>
>   test qgraph.c: Fix segs due to out of scope default (2019-04-08 12:38:07 +0200)
>
> ----------------------------------------------------------------
> - Fix a crash in libqos with GCC 9
> - Fix usage of wrong boolean types in libqos
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

