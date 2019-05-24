Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11639C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28EC205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpvO2qDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28EC205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6FJ-0001Qm-61
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:12:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU6EX-0001A1-Uv
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU6EX-0001lB-1A
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:11:25 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:45827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU6EW-0001ki-Sc
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:11:24 -0400
Received: by mail-ot1-x329.google.com with SMTP id t24so8036047otl.12
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ikgRwL02VztjU/1j5p9cuP00PENvW6qYICekrMv7j6E=;
	b=SpvO2qDgMnIucYWOOpu+Gg0PYLicAwjGjvERCNBpNDoxhz3/hO/epbNQaWUvPvetD9
	2jE7rzVHTIlEu6NNXRLm6sxnbpdB9B9UbA/S0k6B8I7GwjsoLOCINZm8+BqjZ0Zs0Mot
	wauoE06Iuy43BH5VlSMGIaswk7UTbK2pyYBKcPerFmRrlBhSwZOlm7HgOUfk2gH6mndH
	SsGnGZJJuh+nOos65kp7SXENw4fjRuEUqxYTiq/1gNhW17hM/X/nMeBoFORuFd2oHPUw
	idqa7/B5DgPCyLBiw8OYEdgu1zWCynXAEiwGuo/m5QGlntgWxdbxOBbgeKKfT7qA+CzW
	suug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ikgRwL02VztjU/1j5p9cuP00PENvW6qYICekrMv7j6E=;
	b=gaDjhBk/p2PSroFqWSFo4YXgLmTa8PH/Pb1/jDxRAnJ79s1wlbqO3GenrGsAMhC/gg
	9XCVQKD9Jn8hKWXuaGv4hipWoJtQML8MK5Sp5Ug8VVJ1x0yz7c/XVBkzTaimkQaNfdXW
	R92TikCp5UsYAg0g1MdF/uotNtKehO1qr1lN/BYneWtTShSEV/iUuEtCBbVd7Ryl0Crj
	Xb1mPikcg/Yf3jOZ8tHIeZHHVrUS9id9QY3Fh8PKbI2rcgEJ3Rn01y+hGpTIlx3H+m+O
	7LXdNW28aexSNXHXJY6hWyqs8xCmGWuIX+G2XiuS3tbtxBvh/Nm6tToQvsw6hwt4adwU
	jXbw==
X-Gm-Message-State: APjAAAVEhuazwzxK1MYzPGqJGWSZZdjcr4D8pMgnxXGwhZ/oDJIin9fN
	SQLCarJNCXwX0bvWRF5qswOrir2U70Ve0DwMONHCpw==
X-Google-Smtp-Source: APXvYqyyJHeqyqRjfazMcwuhHVF6ibxBb3PaLdVYpgThGJEZnd53awEi0B3ytfKYDZJ/KAm+uuLL17fXZgwqPkrf5IM=
X-Received: by 2002:a9d:77d5:: with SMTP id w21mr40198otl.97.1558689083845;
	Fri, 24 May 2019 02:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-7-armbru@redhat.com>
In-Reply-To: <20190523081538.2291-7-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 10:11:12 +0100
Message-ID: <CAFEAcA_b-rPUuDF_A2Q112-aJEqfSA17kJjD3W0aKaOOP7-hjA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [RFC v4 6/7] tests: Don't limit check-headers to
 include/
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 09:15, Markus Armbruster <armbru@redhat.com> wrote:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

>  432 files changed, 1035 insertions(+), 8 deletions(-)
>
> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index 685602b076..352da0c745 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -18,6 +18,9 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
>
> +/* NOTE: May only be included into target-dependent code */
> +/* FIXME Does not pass make check-headers, yet! */
> +

I'm not sure I see much point in touching several hundred
header files just to add a FIXME note. We can fix them,
or we can just leave things as they are...

thanks
-- PMM

