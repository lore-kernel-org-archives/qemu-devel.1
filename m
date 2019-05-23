Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2D6C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED2B20863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brJEw8og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED2B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnol-0001L4-Du
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:31:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTncm-0007GF-DO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTncl-0003T4-IJ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:19:12 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTnXt-0000Gn-1M
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:14:09 -0400
Received: by mail-ot1-x344.google.com with SMTP id i8so5332489oth.10
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=U2iVYj/7S3oFIUn2xzRgUZmnOUcEYNllGFKpnulnzYQ=;
	b=brJEw8og8gg6wi+hx+2u9R7leL5O3vUYTzHxzilRT5eRGPfAMFRWXi7gToZPfsPHUU
	UtwDQ/rNUX/u7DGD3sd85lB/W0NKBl0rnHd0iWNr0bpGfp/85So/MmzYycjHrG+orvVu
	4VS4h5qx0KPq7AVmeq2HFKaEveV1JU0MX0zw5bDdQL2ed3w82fqyTgZH6JTI8oQZ3+5b
	KqUg/qXih1DLxbDnotkCoFxI0WHt9v1dFga+YZrUABMrOsXBxVRfog5GxupdhyGm0/e5
	ugtLbwCkDQ9dFV3xYIuMALCwxnPGzxtQwItm6Z1DEkvdy3RttOnPr5AdGZwTBKY45Njz
	UuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=U2iVYj/7S3oFIUn2xzRgUZmnOUcEYNllGFKpnulnzYQ=;
	b=LSlm72TN/4A9Kupx+AHL6c4bgcrrOohA5kZDgiw4rfQBzXnLBgMo2TziaaptNsKtx4
	prMw2PMvUMSdBbE/K9fuwWo/Tce/fKRHShLx0SSBSDDzYZatpNzg97OEIaKlDDwasvfH
	DWZDNojk9A8IWfdeMPDH00GmERJobx+n38Wzz4camBhzulZ3FFEbg+5FIIG5rt7EQn7a
	JU6Tq62i/ROvCNtQ0zs0evM415TfG8XxiGjkFcrYWPKif0NdB/aP5QE0Or0MgytVOzKo
	UsyqcsYnfKAIrMGQRLNTqyFVuxqb/AV2p49ZbIjXA24eFdETkNxBwvKFdEPqfaCb46mR
	wKPA==
X-Gm-Message-State: APjAAAVgmmq1HIR0Iaxaw8bv2Lw5sMowBqXzfHNEeugPDIgeESygDDem
	0ZNmENSkPt0DI8hY3kKcCSLCH3pB3KR6SObyF15czA==
X-Google-Smtp-Source: APXvYqwNWD8vPnIsDJ5z3VpA4DRRTa057rQHjnPem3IoDj3949SQL7PDIJA+KYIk3S2ZxUAgVwJ/EuwGWXn7eB2RvJA=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr27782769otq.221.1558617236419; 
	Thu, 23 May 2019 06:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-4-alex.bennee@linaro.org>
In-Reply-To: <20190523102532.10486-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 14:13:45 +0100
Message-ID: <CAFEAcA_+=7VfvZRc__q9L3vuHO6YgetrjTPAYJx4eo0mAdcPXg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 03/28] semihosting: implement a
 semihosting console
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 11:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This provides two functions for handling console output that handle
> the common backend behaviour for semihosting.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 08363969c14..b2963547c48 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -44,6 +44,17 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const =
char *fmt, ...);
>   * argument list.
>   */
>  void gdb_do_syscallv(gdb_syscall_complete_cb cb, const char *fmt, va_lis=
t va);
> +/**
> + * gdb_do_console_out:
> + * @gs: guest address of string to send
> + * @len: length of string
> + *
> + * Sends a string to gdb console. Unlike the system call interface
> + * there is no callback and we assume the system call always
> + * succeeds.
> + */
> +void gdb_do_console_out(target_ulong s, int len);

I'm not sure about the "no callback" part of this API. The operation
here is genuinely asynchronous and providing no mechanism for the
caller to be able to say "ok, now wait til it completes" doesn't
seem like a good plan.

thanks
-- PMM

