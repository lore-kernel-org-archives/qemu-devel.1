Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B97C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C2E2173C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ND/Hytvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C2E2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOiIU-0001MA-Rg
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 08:37:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOiHB-0000JM-92
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOiHA-000631-EH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:35:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOiH8-00062O-Of
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:35:51 -0400
Received: by mail-ot1-x343.google.com with SMTP id i8so2082939oth.10
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/c8NpCtB6f7vBdcPoqJZX2eSeWl6Pti4f5HPBrBZ1b0=;
	b=ND/Hytvu7c6FeyNL5vf/yp7JdDXLdj34MDwXYYfRDAVAuZkADSM+fNKXUtiw+zNJsc
	wMGQujsPq5cJJxG1gptjtMm2xdEacib0FoMZkySP5AgOhpfeaeA9raruMx2noC4AjZRD
	M34ybXpmiKU3nDc59iVHi5C+jfokRXm5PM6lyFAjuVJhCxzhhFVx1OHeQIv/bIViXKrM
	qKVi4YVvCo21WzGxods5tJBKuJjFnU0p/XUlUG4Q6XrkoqleFQyui3b8d9epZ0ywpzu5
	BRnr6mH5v7T8MLcCAhcqSpU3YBM+KbVSG3NK6FjnDx04XXXcDiv+feBPTO0wONJmr20i
	Ww5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/c8NpCtB6f7vBdcPoqJZX2eSeWl6Pti4f5HPBrBZ1b0=;
	b=q/dzak652sKTeG9ePB8OpBSmvYXXd+JmxoUVECdVuxMy8fFrsCf0baJxPV7Vu1ln5u
	YSLSfsXsJd+HndjHAS6A+mkYGe8UGeLGG1Te6Eh+EuvTi05SoWQyvZ91MYpGHhK7g6Xg
	Y+jg2IuHwTK8nM3eTDw6/4rZHhaLRr2JyvCej5NTDpm39SSXqJ6JReafGvE2mA3WPN/D
	fN44dv8MK94CjpikPN/AgIuyRGy0J6szRn4nGxpshPrwOGDyPeb1iA5W/2jySx6WtC6F
	CeSY1SpK1IwzRF1G1rRE7kh3LqFV0eYvDyB//LfkcnN7+7M74YtgtSNFmj+1F81LoHo+
	SGNA==
X-Gm-Message-State: APjAAAUeY67Aw4nflhveBwOELQixq96c3Xi1lfv81WgR9/2q/q90Twqx
	JRxg0ewX14ZmF9r0IczdJKw/lMvRK4UeF/073EEvWw==
X-Google-Smtp-Source: APXvYqy07K2JAjrHgxr70bXNP2NdpECTJnEJkIH6gp9TuUedktgjPxyycBtaODJ5e4s4BJazSehdZooyRFK5zoMMAoQ=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr2233139otk.363.1557405349420; 
	Thu, 09 May 2019 05:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190509080105.22228-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190509080105.22228-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 13:35:38 +0100
Message-ID: <CAFEAcA8A8JVZuwrj+yDgQGkN4-UYhy1-_Mq10FbHGLUVMJ5=kQ@mail.gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 0/1] Update upstream slirp
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 09:01, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 30302acee710881cb248ec3391adcd54dcf52396:
>
>   Update upstream slirp (2019-05-09 09:58:57 +0200)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 30302acee710881cb248ec3391adcd54dcf52396:
>
>   Update upstream slirp (2019-05-09 09:58:57 +0200)
>
> ----------------------------------------------------------------
> Update slirp submodule
>
> Samuel Thibault (1):
>   Update upstream slirp
>   Adds gitignore, README file, and fixes ident protocol parsing.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

