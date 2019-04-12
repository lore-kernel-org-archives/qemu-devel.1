Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F25C10F13
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 02:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411692084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 02:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="KJ1XGA52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411692084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57576 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEliC-0007WZ-Ey
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 22:14:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElhP-0007A4-Mg
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElhO-00071v-So
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:13:51 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hElhG-00070L-Lr; Thu, 11 Apr 2019 22:13:44 -0400
Received: by mail-qk1-x741.google.com with SMTP id a71so4785149qkg.2;
	Thu, 11 Apr 2019 19:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Tj8pyJxNjpOr+pv5EXOpBQDoVitHpGp2jeWgsrxYRE8=;
	b=KJ1XGA52z1MyTIyR3XCLHnxggMjmhfVxP+HdENUN2KKhQM56mjgxJ553Y19Gr5uHN0
	D8/O9J2H0Lxh3Vvr6W2XB2XI0evkMpU0NyBnNni0oTPVcTYOq6q8Ssj+ELBGeqg8tjCI
	Htgbo/ABmeGQnI3+OaoAz1JWuRtXdJg4IEHgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Tj8pyJxNjpOr+pv5EXOpBQDoVitHpGp2jeWgsrxYRE8=;
	b=X5NUF3D93417+WXUjjQQk6uxgL5DQyQ/nLgWf44w7ZN1bZbOoNcgcwbNfrvcQl/idP
	dKee5DVM4mTWx+MWoaaTtIDMHKxhxlnIvlxFTq9xeswsCNL4NeqQ+uLvSH1epWWDViFO
	DCljPoN9/mVVza2gwqm44sRoaQ/a4f/6PG+Yj2ZBTH6vmj/LcnL1nECUNk0mltHU2Z4q
	aETmYlH325HEt5YgeTxuxVjGLyu1Kxclw+TZMJcNkmjnWTNkeAghymUloqrSOQ22mPHt
	XEFoo1D8G17jI4IxOCD1HclvInnXYcMJC2NKMa/II2huvGww0xMKoTgxfEr18Of2gnEL
	EENA==
X-Gm-Message-State: APjAAAUmdlQ9FKkZh7BQrwffanD4RgcxPMBfavLeBmg/ZGs0JEzwlZjp
	O3UUs8t35WjRYuxTwWS9brqZJZ7JxeU8l0t8YLg=
X-Google-Smtp-Source: APXvYqzg6ijOkHsq0tw2Pf4y5WtFRZTtFck0ec1gZUobzbyO16eTC4L9FKSqipcRY2wtOh7r0VOrzBl+8YDKCbyJt0o=
X-Received: by 2002:a05:620a:16aa:: with SMTP id
	s10mr40811395qkj.305.1555035221115; 
	Thu, 11 Apr 2019 19:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-2-clg@kaod.org>
In-Reply-To: <20190411161013.4514-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 Apr 2019 02:13:29 +0000
Message-ID:
 <CACPK8XdBo-QLzkh1qmgA8D1_hN7P_7KcUOvwfm3LYqw_Pzzycg@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: Re: [Qemu-devel] [PATCH 1/3] aspeed: add a per SoC mapping for the
 interrupt space
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
	qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
	Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412021329.uS5RE5tHmY4TEDh0Zyse7dBoxD9C9HPYP9AX5gocCaA@z>

On Thu, 11 Apr 2019 at 16:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> This will simplify the definition of new SoCs, like the AST2600 which
> should use a different CPU and a different IRQ number layout.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

