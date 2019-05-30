Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6C4C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF124257AC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si1MAE/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF124257AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52006 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIoM-00013S-4Q
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:01:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geleman@gmail.com>) id 1hWInS-0000i1-RE
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geleman@gmail.com>) id 1hWInR-0003iK-P5
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:00:34 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:41659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <geleman@gmail.com>) id 1hWInR-0003aQ-IP
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:00:33 -0400
Received: by mail-vs1-xe42.google.com with SMTP id g24so2042408vso.8
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 04:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=lW5xxki/o6CsCWfxBGqWQ/PA8jgHGun1vZIu7u0tq98=;
	b=si1MAE/9rmkLK/HQJ2z/jjQM7qkzflpQMybvfZqDqeJVsiPLlMDqSHD8/ygFq6DjC+
	1Ptl7uAAqSojk7c1LY5c7hza5kgf823UMaP3MTAo4zW2tE0LBmEaeloqWyp9cqv8GFxq
	RR0UFj665d0XW0oFwuv1+TnB2WQwR+cDtuuAIpz9jij52WFNoh4BAkSRs1L3y7RKWIAD
	IbCj3lzdHoHOcqgysiioJS+a0M9dD3MDXuTed95/x4Py0cBcB2SONPHeo1Qce7mHB71o
	qfgD7f/npYaOQXHUT7/x+fVdCgE3ev0Qu8A0dFNmZLLinrhLiw4FJbDJFA/tfiSYdeut
	P2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=lW5xxki/o6CsCWfxBGqWQ/PA8jgHGun1vZIu7u0tq98=;
	b=l5aSP0TLdpmNcwUaVxhJ9q4zDmW1zZSHCIwuroGlt8zir4gIJSnrWVPuTiKZn0dndD
	EjVBQliIg229Zt42nDWeal/ODObPeQuFwl3cOP+UBEXw2gyGHANGCvtLfBqvdpwHXcLY
	pqZj2lqMU1XQkR1MHXdDZ9aZqBFju3Niud1oHfpyXrNW+N8iL0SijLNy5w/jysIm5wvv
	u3+VlSZ8nAwgKfIGAAsZQRw6bZsrYwpHQ4W5gPTJclmdbOeZbLPgMKyXlMRm4RxIlmZA
	tWcBz92Luiy4cKmBtacLqzCm5kcpx/Q3FUym0MB5f91tsMCOBy4y8fxo3dJWcbYk1fbc
	aQug==
X-Gm-Message-State: APjAAAVVmjvCGdSU7jyIiBYHTaIwXyyZPDkWpqrDF0sSQQ85YFwlmvXl
	+NnO7gF54CLHbXNn8qhgQ1PTFx3MRVjAU31havE=
X-Google-Smtp-Source: APXvYqxVDmGPBK7D19Y3zTojrWnqX7qXfOz+j8HkVpV2q7fvDQBCR1w1vnmVD9VLtmKyXN7pBFpHU4VZxFio+YC8M0o=
X-Received: by 2002:a67:f4c6:: with SMTP id s6mr1484754vsn.193.1559214031364; 
	Thu, 30 May 2019 04:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <003a01d51611$6251a2b0$26f4e810$@ru>
In-Reply-To: <003a01d51611$6251a2b0$26f4e810$@ru>
From: TeLeMan <geleman@gmail.com>
Date: Thu, 30 May 2019 19:00:17 +0800
Message-ID: <CAETRQWkhH-ZPkbLcCWE7xiY6eTeTS0Ow=wHwo=iFGp0uy5OwQA@mail.gmail.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e42
Subject: Re: [Qemu-devel] i386: EFER vs 32-bit CPU
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
Cc: ehabkost@redhat.com, Juan Quintela <quintela@redhat.com>,
	dgilbert@redhat.com, qemu-devel <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 7:27 PM Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>
> Hello!
>
>
>
> I found this while debugging the inconsistent saved/restored state of the virtual machine.
>
>
>
> i386 (32 bit) emulation uses this register (in wrmsr and in MMU fault processing).
>
> But it does not included in VMState, because "efer" field is disabled with #ifdef TARGET_X86_64
>
>
>
> I think that efer should be saved for i386 too, but how it should be made to preserve the backward
> compatibility?
>
> Should we add a section for i386, which duplicates efer, or just version_id of the main VMSD should
> be updated?
>
>
>
> Pavel Dovgalyuk
>
>
>

Nobody followed this issue 10 years ago:

https://lists.gnu.org/archive/html/qemu-devel/2009-10/msg01765.html

