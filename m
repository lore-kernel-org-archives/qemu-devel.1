Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50EFC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A763206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="XTsxQJPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A763206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40190 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNsYR-0003MJ-S8
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 01:22:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hNsW3-0001F8-I7
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hNsW2-0003N2-J9
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:19:47 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hNsVz-0003Kk-O1; Tue, 07 May 2019 01:19:43 -0400
Received: by mail-qk1-x744.google.com with SMTP id z128so6791397qkb.6;
	Mon, 06 May 2019 22:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Q3RTaurrAtxC1189nQE25YPP+zUZ5R6GSlulNjUJF7c=;
	b=XTsxQJPp7kMvQwzfVUiHmEjCNwQZAGU7zUskZ75UVpzCbiW7rYTYvlU26CnmKYuGdC
	vOCN7RQl83WtUaqVlNRCC2E1kD1AWKRKsJX+qaEH+GvLZ9Zc93re5d4mSlGvP1e5SpB0
	J6/3drMq5d3bODLg78pKHw4tZMFYMcVHUWjiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Q3RTaurrAtxC1189nQE25YPP+zUZ5R6GSlulNjUJF7c=;
	b=U6XtyiHas/5XnZsNtTzp+lOaH+7vFZ4KpV+7U+tLHHyvmbtey5MD1NkmTfsRLdx7tu
	p3vUg+2BGeT7W8uyaA0DD1xltsrYLtMMQ5HZfWfXIWLu2ZN5KBDi65Upq4+z8AqwSJsu
	2lAGYoQJbyZRTqOswiyTD9QQZnafxc9bQlSD5+WgCOe/y+iTY6gKBZfapRbREz6SYWXK
	JFxSGhM3H5OSUwVHY+LEJKiFGtoVowDUi4z2n6LlbdLuQfd5qKjfzrMrCZU7tMGPu32N
	OD0zJ/G/BFt94S0HWvtMb0uC4iBMLcjatt/AR1GHAgpKOQ7AIn9uEIQCXBlDDYRfBTU9
	348A==
X-Gm-Message-State: APjAAAXVrIaA5eWblNFMsaJPmZ9zXoO8fKq23ywAnWh2QVYnBY1J8AMT
	t5x7p1O04cD8y4zX7uKJdpPg1F67l7eIH+dBFEE=
X-Google-Smtp-Source: APXvYqwocM44036MknDsz6pJID9LGv1A+V1mtsPUE/oEK52Ep8JnHlgau+ZYqoxG7nSf7uinWEJl8wvkAJWBr3WKr9Q=
X-Received: by 2002:a05:620a:1494:: with SMTP id
	w20mr14213907qkj.336.1557206383069; 
	Mon, 06 May 2019 22:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190506142042.28096-1-clg@kaod.org>
	<20190506142042.28096-3-clg@kaod.org>
In-Reply-To: <20190506142042.28096-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 7 May 2019 05:19:31 +0000
Message-ID: <CACPK8XcKO25K4cfQJCXid8CLZmfPFuggt-mSC03cEvpcORVbrg@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH v2 2/3] aspeed: add a per SoC mapping for
 the memory space
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 May 2019 at 14:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> This will simplify the definition of new SoCs, like the AST2600 which
> should use a slightly different address space and have a different set
> of controllers.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

