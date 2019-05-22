Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3882C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0EC20856
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAihYVWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0EC20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38687 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTN3r-0002Mk-Of
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 04:57:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTN2I-0001Td-Qb
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTMwO-0002FI-Ck
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:49:41 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTMwO-0002EN-66
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:49:40 -0400
Received: by mail-oi1-x241.google.com with SMTP id q186so1020448oia.0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 01:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=kHWMr6d+PgAJocEfaeugsXcX47z/sSq4p3eNUo9/VpQ=;
	b=qAihYVWiYTks6NEPsMveOIm+n1yqjtD+PtOKFveymiCxffpWPALiXKj5rRvjQDCuos
	dBAuoB2hw7/lSnx4EpOTlpRFyWACAvg9v4nkNDfM4VdaOEK+OBOcfFTEvzseh1ZtDo+B
	E4ytik04ilHPbQ9QfgPqDgyHVQkqyYPeqK/tctPtm9EY4j/wuzXsi3p87kddmlLQpTa0
	5SAWvtUARUU5tU4vPmnLDxc79QJZOZ0+cmR7GT8hm8akl0CkTHQsWPsa1lAEKBJBI4DL
	aDam1dgLPCyJunMF/isw3Gj5ZNhxHNuQYPmQrhNx6LEXoNSFohqfqtu3MfGqx+xZGtfI
	NmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=kHWMr6d+PgAJocEfaeugsXcX47z/sSq4p3eNUo9/VpQ=;
	b=R+jJvIhdrJi/Kz3m1SSeSxllXX6oGnWMcS1LF4YNe88oOhvj4N5ZQtEMX8TacNenBz
	t7oqitQQKDlV0P4LGPiDKAYiJc3ZJeCJtd10v7aqForfggaHTLyzntfyQwJ2g81ht6tR
	EfXQqEUal22RqsY2jyDooAJQXjUnDaVwAvdtQfVEain48TANpo2lk+4yzQIrc2r0ZZ+I
	T4iS5wvEjzKuwMoMVlRKEWX9i+GpPSb95v8GW+t7qpU9hwPh79lNfvbtSHS+aQHxtEJe
	hetGLVawfOAwvMcEbVfE5VJyRqjG7Z5cnbAPJxMfsW2M24FHzOX/kJNcwZa+P4Tukidv
	l7jA==
X-Gm-Message-State: APjAAAWL//isORBumSPd7U+UzOY69DlweQTq5DR3DuoVDgRy9CVZbsTl
	f8mR+uRLBARwD5hcSjJeMVa23fq3f7r4dxFR21fnkw==
X-Google-Smtp-Source: APXvYqyQ3RWwwpJ9pitQQqVhdxX3bpWfafx7Z1mnNkLsBtSIjRfTQ8PhgvswIHZGdegtxtFcP9bvV5VmXUaPVrH1L58=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr6649055oib.170.1558514979106; 
	Wed, 22 May 2019 01:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190521200657.5377-1-jsnow@redhat.com>
	<20190521200657.5377-2-jsnow@redhat.com>
In-Reply-To: <20190521200657.5377-2-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 May 2019 09:49:27 +0100
Message-ID: <CAFEAcA9mEHvQ9TBGpvfVoDx-pKB9Cyc-JWeUUh2Hc0Uxb1GjuQ@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 1/2] sphinx: add qmp_lexer
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
Cc: Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 21:07, John Snow <jsnow@redhat.com> wrote:
>
> Sphinx, through Pygments, does not like annotated json examples very
> much. In some versions of Sphinx (1.7), it will render the non-json
> portions of code blocks in red, but in newer versions (2.0) it will
> throw an exception and not highlight the block at all. Though we can
> suppress this warning, it doesn't bring back highlighting on non-strict
> json blocks.
>
> We can alleviate this by creating a custom lexer for QMP examples that
> allows us to properly highlight these examples in a robust way, keeping
> our directionality notations.

> diff --git a/docs/sphinx/qmp_lexer.py b/docs/sphinx/qmp_lexer.py
> new file mode 100644
> index 0000000000..f619f11139
> --- /dev/null
> +++ b/docs/sphinx/qmp_lexer.py
> @@ -0,0 +1,34 @@
> +# QEMU Monitor Protocol Lexer Extension
> +#
> +# Copyright (C) 2019, Red Hat Inc.
> +#
> +# Authors:
> +#  Eduardo Habkost <ehabkost@redhat.com>
> +#  John Snow <jsnow@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.

Did you definitely mean 2-only and not 2-or-later ?

thanks
-- PMM

