Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574A6C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EFB217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9jryh/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EFB217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51525 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6W4-00069P-Fe
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:29:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6Uv-0005Yi-RT
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6Uu-0001yV-Ky
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:28:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hU6Uu-0001xx-AC
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:28:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id t5so8475631wmh.3
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=TA20QyBklaxyPu7Ul/ASsUlluNHGvrn18Z1Zs+dEVSE=;
	b=w9jryh/ndIlSM9GzRkkeHqypeVCks3DKfugHvjTzgiE7j7zr+xDjBqhf95IBH5T885
	NTqI9IDaBNiis3T/n6B/oi6UP/1A09DsojjXLFbvwG/OIpJHVh7Qy1yS3znH6BU/SKKK
	5iOCBu8yQoVHw/m2v+ZJd1N/rFM0rSPH/pn+2cWVQiUKiCwkbrm0ngMpW79JifrYj+vo
	u48Y3vXve0dJSAG/dDYUu5uMQsxy28UszKT3pRNq880GVen56TR+v3eAR0jWzChnHVJL
	s90QmFKVihJPJqKfv5+Yax3ZwBgu90RXbtkhHJDZJx0ahDgtOjanmv4ZJoXL07s/SqOQ
	sTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=TA20QyBklaxyPu7Ul/ASsUlluNHGvrn18Z1Zs+dEVSE=;
	b=qWhJHtCYFEOXVYMJrYE7zJMcPnGL2uv7g4M0ePozUAZHbx9WWwyCQPfSIdip5+ayDy
	IXgPUFL/yYvq+055peOu9wQa40s1PbRLEIVp1QZnNC8uiJnWoaqjcNgRRCLN2YSh3nru
	QdBJEudcKQ9PkF9pPRopBc6dAUy8EFDPd/OOepx14tIOoP/7ZLr+peP6McnL5Zwa04Dg
	8WhAzkVs2QYNnha6rBDJMsuV1ChwBPcSDiePuvxMa+3eOuoDpOYPeiFdcxvpqtaJTw1f
	A54+0nXlqsnH4bPQctx3AX6aH1FvKgIFHVeM5x59IudBx3hPPaFIQQhdRxpoSsUULX20
	KUHg==
X-Gm-Message-State: APjAAAVuHOmC+An6zWM5yZ6RIsJl6IxoPLYUcLY1ywV9NJl/qmqP+PzT
	58RQy/zDF5cDDG3unv4C4v2fGg==
X-Google-Smtp-Source: APXvYqwDuW1lj07hcaEY1ZNsqlPtA6Ceqd3bfX+oSt1iqbC+i/OERfR5MDFf67e/Ppl3TMo5bH+GOg==
X-Received: by 2002:a05:600c:ca:: with SMTP id
	u10mr15856453wmm.33.1558690098643; 
	Fri, 24 May 2019 02:28:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	q15sm1696009wrr.19.2019.05.24.02.28.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 02:28:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A0F6B1FF87;
	Fri, 24 May 2019 10:28:17 +0100 (BST)
References: <20190523204409.21068-1-jan.bobek@gmail.com>
	<20190523204409.21068-8-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190523204409.21068-8-jan.bobek@gmail.com>
Date: Fri, 24 May 2019 10:28:17 +0100
Message-ID: <87d0k819se.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RISU v3 07/11] test_i386: change syntax from nasm
 to gas
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> This allows us to drop dependency on NASM and build the test image
> with GCC only. Adds support for x86_64, too.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile    |  3 +++
>  test_i386.S | 41 +++++++++++++++++++++++++++++++++++++++++
>  test_i386.s | 27 ---------------------------
>  3 files changed, 44 insertions(+), 27 deletions(-)
>  create mode 100644 test_i386.S
>  delete mode 100644 test_i386.s
>
> diff --git a/Makefile b/Makefile
> index b362dbe..6ab014a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -49,6 +49,9 @@ $(PROG): $(OBJS)
>  %_$(ARCH).elf: %_$(ARCH).s
>  	$(AS) -o $@ $<
>
> +%_$(ARCH).elf: %_$(ARCH).S
> +	$(CC) $(CPPFLAGS) -o $@ -c $<
> +
>  clean:
>  	rm -f $(PROG) $(OBJS) $(BINS)
>
> diff --git a/test_i386.S b/test_i386.S
> new file mode 100644
> index 0000000..456b99c
> --- /dev/null
> +++ b/test_i386.S
> @@ -0,0 +1,41 @@
> +/*######################################################################=
#######
> + * Copyright (c) 2010 Linaro Limited
> + * All rights reserved. This program and the accompanying materials
> + * are made available under the terms of the Eclipse Public License v1.0
> + * which accompanies this distribution, and is available at
> + * http://www.eclipse.org/legal/epl-v10.html
> + *
> + * Contributors:
> + *     Peter Maydell (Linaro) - initial implementation
> + *######################################################################=
#####*/
> +
> +/* A trivial test image for x86 */
> +
> +/* Initialise the registers to avoid spurious mismatches */
> +	xor	%eax, %eax
> +	sahf				/* init eflags */
> +
> +	mov	$0x12345678, %eax
> +	mov	$0x9abcdef0, %ebx
> +	mov	$0x97361234, %ecx
> +	mov	$0x84310284, %edx
> +	mov	$0x83624173, %edi
> +	mov	$0xfaebfaeb, %esi
> +	mov	$0x84610123, %ebp
> +
> +#ifdef __x86_64__
> +	movq	$0x123456789abcdef0, %r8
> +	movq	$0xaaaabbbbccccdddd, %r9
> +	movq	$0x1010101010101010, %r10
> +	movq	$0x1111111111111111, %r11
> +	movq	$0x1212121212121212, %r12
> +	movq	$0x1313131313131313, %r13
> +	movq	$0x1414141414141414, %r14
> +	movq	$0x1515151515151515, %r15
> +#endif
> +
> +/* do compare */
> +	ud1	%eax, %eax
> +
> +/* exit test */
> +	ud1	%ecx, %eax
> diff --git a/test_i386.s b/test_i386.s
> deleted file mode 100644
> index a2140a0..0000000
> --- a/test_i386.s
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -;#######################################################################=
########
> -;# Copyright (c) 2010 Linaro Limited
> -;# All rights reserved. This program and the accompanying materials
> -;# are made available under the terms of the Eclipse Public License v1.0
> -;# which accompanies this distribution, and is available at
> -;# http://www.eclipse.org/legal/epl-v10.html
> -;#
> -;# Contributors:
> -;#     Peter Maydell (Linaro) - initial implementation
> -;#######################################################################=
########
> -
> -; A trivial test image for x86
> -
> -BITS 32
> -; Initialise the registers to avoid spurious mismatches
> -mov eax, 0x12345678
> -mov ebx, 0x9abcdef0
> -mov ecx, 0x97361234
> -mov edx, 0x84310284
> -mov edi, 0x83624173
> -mov esi, 0xfaebfaeb
> -mov ebp, 0x84610123
> -; UD1 : do compare
> -UD1
> -
> -; UD2 : exit test
> -UD2


--
Alex Benn=C3=A9e

