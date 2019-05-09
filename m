Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5D9C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854072175B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yi3EPxiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854072175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlRN-0007ao-Mc
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:58:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOlQK-0007Ef-NM
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOlQJ-00030k-HN
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:57:32 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOlQJ-00030P-CE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:57:31 -0400
Received: by mail-ot1-x344.google.com with SMTP id l17so2784251otq.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=qqjRnAUHQZOq97eDqTHtPKZCriRWexFdeUB59CxA5Ko=;
	b=yi3EPxiPILCq50HVB4Q+rsVygVTeu3jwsBgkmesVvOhX93Y3yZqlIsyqRb5yKbOYTw
	mhrCpkN/pgusMNLGWqE3hV0EUQOfyy3H7xlHFtpZBtH80YdZc1nFrJ82/MoAANEmgeUw
	5VbEgoiJKXUDBbl2r+2raONauAHsYjc2V2Khkas7894P38fLKB1koPzM0x5xPDVwfa++
	CcLE36ejEG+2hrJ+T5zGkC9Nicae3S22vN/64hgN35O24xLkoKetWCiW4VGlmPvKzXZ/
	AnFOQq3OIGIzLeCqAf+r1fObawg0XHrzeaQ9S8EdHD46LJgtRp2XCmZkQNjcL/Wbm446
	ysag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=qqjRnAUHQZOq97eDqTHtPKZCriRWexFdeUB59CxA5Ko=;
	b=LkAEoeDdy1M3LZRpb2XyXd+tOxgzB62TUTYzxxvNrdCVnjVIrcMPHLmxPczMoL+rcj
	ZsHVq93HE7VQOEmT6YcRdW2KExlNZ+9NpdOD/csIX/CInMyEv6ZAMsOlgYSp6GR4CIyE
	5ofvfVxafuB0AJnEB2lyho/lEmLvqpAJ3CWJeDTD9BB8uwv/sMn5Mnz02NwIUJiVcuCa
	JFi3Rv4cgBY0RaeKn/qyEJqNJzvo7UOBCYCbQBZqCLBjj7zasdbKstljivOWtjLzva81
	Wp3I6GBkLE9vtxoPWgGRHRGIdj0m6glKAVq5Qft8MIXJKJy/dd68WK8n81f7oyoSoLBL
	Ncmg==
X-Gm-Message-State: APjAAAXy8QS7mhHPcgTmIq6KAZ+CD42LS0a7PkMxwHMCL2jbzofWnE+D
	8w1dyQ908+sE73nxzQgFhcuuO7OU0pPdjBOeV0Qzjg==
X-Google-Smtp-Source: APXvYqxkOrKmsk73hz56/lEqR34tiolaVEGP1V9kMTLqa0Th0OTKgLgdqk29X/8NbGVJaVxAKMe33GSCjodyHtREp/Q=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr3033879otk.316.1557417450235; 
	Thu, 09 May 2019 08:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190503122007.lkjsvztgt4ycovac@debian>
	<7fb7832d-4e02-8fb1-f8a3-ed81a71774d5@vivier.eu>
In-Reply-To: <7fb7832d-4e02-8fb1-f8a3-ed81a71774d5@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 16:57:19 +0100
Message-ID: <CAFEAcA9Osnx=Lhq6nRurfaH51cC_cserJLt0tZ=qvxfRLqV1Ag@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: elf: Map empty PT_LOAD
 segments
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 16:50, Laurent Vivier <laurent@vivier.eu> wrote:
>
> On 03/05/2019 14:20, Giuseppe Musacchio wrote:
> > Some PT_LOAD segments may be completely zeroed out and their p_filesize
> > is zero, in that case the loader should just allocate a page that's at
> > least p_memsz bytes large (plus eventual alignment padding).
> >
> > Calling zero_bss does this job for us, all we have to do is make sure we
> > don't try to mmap a zero-length page.
> >
> > Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> I don't find the mail from Peter with his R-b.
> Did I miss it?

Patchew has it:
https://patchew.org/QEMU/20190418153631.rl3lgadzrqqof72p@debian/

thanks
-- PMM

