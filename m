Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBECC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A437520848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKLSDtit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A437520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRfgj-000482-V9
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 12:26:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRffc-0003Wf-4n
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRffb-0005TJ-5q
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:25:20 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:40406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRffb-0005Qu-0n
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:25:19 -0400
Received: by mail-ot1-x32a.google.com with SMTP id u11so7244438otq.7
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=U48aRi7omJubd9bWaOB2fGobeAXR+PakuTESB829Jb0=;
	b=CKLSDtitqey7de03pSe5kx+TB2Jt7GxHDPF5LeXElVL9XM07vK7fhX+YAZtYzlekBc
	BfCFUeVHI2bLWBkIqFXP8dxLlZe/PYWrJtwdXeK42a0I1hGIXDuSyQ7nXb0t1DmXe74t
	iaQpLa4oXw3LYp4Dsls4Bxj5cOWC43XA4TIdBejS79xLpp8qPxXkCFcx0Hl1C9+8TtLc
	5vS44BtgPC8x1kj4J5nRtpUsSJd7LD6HG2/dY02TymImyKk9t+aDgKpYx7znDnUKVAtz
	sbdbDPtvvpHyeurJzXrCxuH6YBHQS9xIIYwvoDBmkqPMyKrfZmBOr0dpEPbRwVWDEc87
	HCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=U48aRi7omJubd9bWaOB2fGobeAXR+PakuTESB829Jb0=;
	b=WcVu80zXZRTZcNveb9cF/nnzsqsyMZyMcJq0guJI/InOBRW8/h5ArhFPdnhM80bUGQ
	pUVL0tg9rSQcIyGNX4hzz8yrYOR7HxntQAD30cGjANTAKbop93cLlDObq9ZgEwGdK+yM
	FtPSUjWeaC1MFzR5YwFQfRJd61CZGytY1DomAHOxBOQntEM+DHxN5MQMd9bvmB8qsBv9
	hhHDKl65CIuELVSzUtgvpHduE2430OQkO8dmwEQymDFUP2QjD01aupbGH6V+Rnd+AcxQ
	KviiDq+cB9Can9EyDXJIgB7Cfhb99w1zmzkLOeOfjDalxwi3Kz9VWr3nZC5rIwxfqwgi
	6+Bw==
X-Gm-Message-State: APjAAAUIFPS1b7g2i00eBha6gSDQ+2PwYWf760X8f2f6YPRANlrPwGZB
	tg3DKKfVTDnSdjkULv8toonuIQm3MBMwHTZJ/qKQ1A==
X-Google-Smtp-Source: APXvYqx9G2xWU4KQCPfnZJiDjx+GGTYV49u6xBQYKl97XtGAZRXQFOUhiHXFoo/Dt6e5LOaKxl+VtAAQ2LNoo/rUQ3M=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr5859049otq.221.1558110316760; 
	Fri, 17 May 2019 09:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <1558099699-55793-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1558099699-55793-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 May 2019 17:25:05 +0100
Message-ID: <CAFEAcA-mctP9B=Jh6EKFLjpcuL+-vYezUcYT43BSycjxFnvyrQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32a
Subject: Re: [Qemu-devel] [PULL v3 00/21] Misc patches for 2019-05-15
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

On Fri, 17 May 2019 at 14:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e329ad2ab72c43b56df88b34954c2c7d839bb373:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190513' into staging (2019-05-14 10:08:47 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7a188f2b5744c0492de1c8eea315f259e0256a1e:
>
>   hw/net/ne2000: Extract the PCI device from the chipset common code (2019-05-17 15:19:39 +0200)
>
> ----------------------------------------------------------------
> Mostly bugfixes and cleanups, the most important being
> "megasas: fix mapped frame size" from Peter Lieven.
> In addition, -realtime is marked as deprecated.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

