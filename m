Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD0C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E3B20656
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tG7n6Y0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E3B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34596 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSh9o-0005Fc-FF
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:12:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSh8Y-0004ek-MO
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSh8X-0001TG-Ao
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:11:26 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:33736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSh8X-0001SP-2o
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:11:25 -0400
Received: by mail-oi1-x234.google.com with SMTP id q186so3091812oia.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2GiwVXOOQDO6Ra4ZzzeDA+CvsxZLCqvbn/3LZN+HHzQ=;
	b=tG7n6Y0wTj7t9nTZIlbwRN9r5u8jXIa3pxfEkzlS1wmQtGXTCp4Rjw48dR69iDRdMP
	vmEJVq/bYJSd0I6QrjryFu1nkJ6NCb9EyKsmYlA68Md70Nn20I9RUZMPRABWzbaIfTs4
	q+Mdhr0XiysrkvR3a7h4XLbCkqztt8qGs4+UrvAPDCRzF/xneJXxtnN3I14/+O2gKBTw
	T1XtEiKgnHJ+gG47mPjyoYpOPEpjJESTYiH+/M+VKHGbLAAqHbTAMGzZTSAjuu3tRFEA
	w0/EcqNPUxYNvtCrOsgIVB+CKa/QVOqdQvRGnjG8kwGXcaCgHr/44a/R1/N9PIOBp37I
	DLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2GiwVXOOQDO6Ra4ZzzeDA+CvsxZLCqvbn/3LZN+HHzQ=;
	b=qtQHhAwdxTiypMdnW+DkeO6/oMF4lR+JqkMp+VjfmOrUT596W0xGScPh7B0YFdoWIR
	/96Hfzn5jMfkDOkQHLpWm7EcAGipryhg9SK1YF+CLK7oFkeP5UGfNvfvX7fZ+DDh6tjV
	+k6OB7T+FzYhU7uHg6tjLi8tbnwndWzH12TaDdvVn+FWuCs4WrlbKXds3B6xYbpnnfzg
	oJWQ1AQ5xp4O1mNAsyJXjBoPAsPmQ4fZQMVscWc1Cs3BQLpMCELnKxKelmkYNfjuoX38
	dpTJNykB2Y723m84Cpk4nFtO0BLYF4jKON9m32mwQOLsrqkplaUjQSr5hjY8AYxU3wMV
	Kl3g==
X-Gm-Message-State: APjAAAVtOpThZtBea/mILd/4uwgUgT9gBAFSyu08No/KcLDDxjUDFRXC
	CsxsUa2N7sVhoN+DnbCEGci+s/fEvcZt5Dz3niy7MA==
X-Google-Smtp-Source: APXvYqwPy3673eDxT8n2NWLaM8rCwxf/nBthSaCmyxjvBvj5nGKN8juE59KrDTbUX/sJeGK6koL2lBBWD1cBaIHGfhA=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr24112178oif.98.1558354283528;
	Mon, 20 May 2019 05:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2019 13:11:12 +0100
Message-ID: <CAFEAcA842fq=CG+y_qGySWV3i_JNPEk0iQwCJxed6cQcCMidWA@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 19 May 2019 at 11:52, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 1b46b4daa6fbf45eddcf77877379a0afac341df9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190517-pull-request' into staging (2019-05-17 17:25:19 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-may-19-2019
>
> for you to fetch changes up to 71074d1d2fae9a0c8dab87c5bb5271a71d6cb7ab:
>
>   mips: Decide to map PAGE_EXEC in map_address (2019-05-19 12:11:46 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for May 19th, 2019
>
>   * A fix for HelenOS boot hang (related to the flag PAGE_EXEC)
>   * A set of fixes for emulation of MSA ASE on big endian hosts
>   * Improved usage of object_initialize() and object_initialize_child()
>   * Better handling of 'div by zero' cases in MSA ASE
>
> ----------------------------------------------------------------

Hi -- I'm afraid this fails to build with clang:
/home/petmay01/linaro/qemu-for-merges/target/mips/op_helper.c:4536:20:
error: unused function 'ensure_writable_pages'
[-Werror,-Wunused-function]
static inline void ensure_writable_pages(CPUMIPSState *env,
                   ^
1 error generated.

It looks like "target/mips: Fix MSA instructions ST.<B|H|W|D>
on big endian host" removed the last use of this function
but didn't remove the now-unused definition.

(clang is pickier than gcc about not allowing unused 'static
inline' functions -- gcc ignores them anywhere, clang only if
they're in .h files.)

thanks
-- PMm

