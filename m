Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C4EC04AA6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6D620673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eci36nsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6D620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL76V-0001TY-QU
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:17:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL739-0007WB-Ho
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL737-00035A-NM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:14:31 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL735-00032l-Ql
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:14:29 -0400
Received: by mail-oi1-x242.google.com with SMTP id k6so8402631oic.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mrosvBI6naAyJ79Lle0Znts2YyeqlMRlc46SLcmxlOc=;
	b=Eci36nsAFvdQg6AZtzfLQhvBwsg0zcANwcQkURnV+UjPRkwfuMwR21cP7mBmEPZ/uZ
	d2aM/WOAZebhzf67noaEeHKaS4wW0YQM8tfSypesIyruzNmJ8sw34rucHbW99gzejyny
	BPJQHYvvkIhtfPaIfL6/oqO3uuRZyVTERhi75Q+2coumW1pJv+7LDlNQCKS96QHhF61Z
	7p/DlynGFty9UPDUMFGPyyS7edCW51xhtTLy2VxtmEKStLFhJ2fPXpMgNc5+g8TkRCnv
	M4cMr/E1pN3UFXPT9VU64dMglF3oCTOkbC/8hLqnLbxpJ96SbFta+p2Rt0ey+poFVpfx
	wsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mrosvBI6naAyJ79Lle0Znts2YyeqlMRlc46SLcmxlOc=;
	b=lLmJJ3a/a2XTiPS85jU79RTp22j+1ufE42X5yr3Ik1/8U1PC+gyRkZu6nljFUK2FCp
	A09Z9Y7qZ36VQ/pRJLpiVZnzeb5p2AMgJVLuC02IUnHlM9XMQDVwWzClKMursPMcoFue
	vYlM7knrvpPGyYslpxspIAq244KvOS0JNIq2ATXR4QcL6576SqLghPWn08q0Sngs5hNj
	Zl6jhxb9bwW3TOg9LkVA2sXp64bkxuAytNdFFMh5EBN0Dw84E5JARiavIshza85SiDiW
	N/n9W6ES8UF/Qw3UXvJgt1eOZvtMsrQHInKWZRHCh1xJd8Qxh6ewpkyC+jw+kpaCc80G
	AaYg==
X-Gm-Message-State: APjAAAUhp741CAMLyrPAqPsPZCdSpfi82mlVH6w/ORrz0Zxa/jupFFad
	qFSDJViKzcg+uMq/XH/0qOzHTac1bdlIKDChZqcRj8WyfIU=
X-Google-Smtp-Source: APXvYqxpkE/rAq3s1Os8a7rigHNOkHw9Oh5LS/P7aza3rgQzi2EHmUs8pshRKa/HiNHZvGEqnhr3qrqThw3Q3aQljO4=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr16902362oif.98.1556547266577;
	Mon, 29 Apr 2019 07:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-15-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:14:15 +0100
Message-ID:
 <CAFEAcA-Zo4tKnNuxqUo9YN5cXXXvbxSTzs+WszeievQU74Xfig@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 14/36] target/m68k: Use env_cpu,
 env_archcpu
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
Message-ID: <20190429141415.mqXiT-Vxd2hv0VJeBustfcwKG6-qE5jl6ByQwTLCgwA@z>

On Thu, 28 Mar 2019 at 23:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

