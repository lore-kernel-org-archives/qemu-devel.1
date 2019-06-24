Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7710C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4417B20679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xhli4+0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4417B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfL6Y-00070M-Lo
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52346)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfL37-0004PU-H1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfL36-0004ju-99
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:14:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfL35-0004hI-W5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:14:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id g135so11995493wme.4
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fECS+Ho6/MQgPPptn3FSlsPIolFdYt6ldUcm+pMJAzE=;
 b=Xhli4+0LE1PeD2XRHTr+2GvKLlm+S3gzTFDd9Wry1P+Av1pYIq+4/DO9HnF5Zl9rf0
 iDt6jwZ0fGoa44rdeBiIzJ0sr7H75HvmBFPq+8+byZ6LH7EZl8Z21+FMSZACpvwu3oIN
 ONgas3LAaGiQ+YDeohImI+HvGSLlVJ3xhjshaflDxXMjswQv1eiGlVx4Iv2ArSPR+QES
 0UckI7gSxyFsh6e1n9hE7zFgbsj/5yDYUO8fqYhNFvs09b5kBuTjTtlE6oq21tZcYBxn
 7TQHt5oPHJ56CLZdOKIKsFLLkfV50jCBPY9syGsE8J83xLfqswnqX6kVlSvRxRwHuxKY
 Qxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fECS+Ho6/MQgPPptn3FSlsPIolFdYt6ldUcm+pMJAzE=;
 b=hjhyt8+4Zr9qpXiCyWY2qn8ZHb0OJx1NgyL/6La6uH/Af6F+io262kc++vOhJqxT/t
 nCrK2YZQGg8HHxu7g/VKbm/olojdDNOuTg6eXji3OrlK0M6TUWGrL8+tCqyF7Kef5RdT
 euBbBNiqCGk6b/331p0VFefbC21wnabCll92WIrIIIrMdCD0EdxMGowPhAPTsXtDVH+U
 jByz2KMyRdoyXd+N43hmX7dGqaB4vT0ttAWArHgdfwX2fRouKIoP+Vjx+1NhI4GY8Gdv
 +989Clz14p9v1aG+NrADaup+nKrjE87d3zJ4lkU/xGYWZGQNioP7ULoAJ4rKBwpzav8x
 SKxw==
X-Gm-Message-State: APjAAAUi/0SBIzNy2ShdrJhtBaW+B7rV3OY/xWTyTWlM2kdit+fescp6
 vRouUUEjusdI7VvgFZjcGcNMrQ==
X-Google-Smtp-Source: APXvYqxIfixMHBvTeJaDoc/fZvC3+Cjx+J1GqZpdFX5d39giasA76uF524FXYyTzfByf+z0gUDKTGw==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr15535566wmj.143.1561367641861; 
 Mon, 24 Jun 2019 02:14:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y19sm13875595wmc.21.2019.06.24.02.14.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 02:14:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EFFB21FF87;
 Mon, 24 Jun 2019 10:14:00 +0100 (BST)
References: <C95C3BAC-3DE1-44F3-BB08-715D3121371A@gmail.com>
 <CAFEAcA8mcQJiYkHdzNJT3m+9-vak_CWaxGBQ0TME1tZQQK7f_w@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA8mcQJiYkHdzNJT3m+9-vak_CWaxGBQ0TME1tZQQK7f_w@mail.gmail.com>
Date: Mon, 24 Jun 2019 10:14:00 +0100
Message-ID: <87v9wv1h2f.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-discuss] qemu-io-cmds does not compile on
 macOS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-discuss <qemu-discuss@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Juan Rafael =?utf-8?Q?Garc=C3=ADa?= Blanco <juanrgar@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Sun, 23 Jun 2019 at 16:22, Juan Rafael Garc=C3=ADa Blanco
> <juanrgar@gmail.com> wrote:
>> I think the latest changes to qemu-io-cmds.c make it impossible to compi=
le under macOS. It now uses clock_gettime, which is not available in this O=
S. I=E2=80=99m using 10.9.5; I think this function is now included in 10.12.
>>
>> I would step up to try to prepare a patch that uses a replacement in cas=
e it is being compiled in a macOS version that does not include that functi=
on. But I do not know if you want to support these =E2=80=98old' macOS vers=
ions=E2=80=A6
>
> Hi; thanks for this report. (This kind of bug report is better sent
> to qemu-devel or to the launchpad bug tracker -- qemu-discuss
> is mostly user-to-user conversations, and developers tend to
> be on -devel; I've cc'd -devel on this.)
>
> Our official support policy is that we support building with the
> two most recent versions of macOS; in practice we might support
> building with some earlier versions; as of commit 5588840ff77800e839
> we definitely dropped support for anything earlier than 10.10.
> So in theory we don't strongly care about anything before 10.13
> at the moment; but if it's easy to avoid the problem it might be
> worth doing that.
>
> Alex, it looks like the relevant commit was one of yours.

Which commit was that?

> Could you have a look at how easy it would be to support
> systems without clock_gettime/CLOCK_MONOTONIC ?
> I notice that other places in QEMU have #ifdeffery for
> a lack of CLOCK_MONOTONIC, so we should ideally be
> consistent, and either support systems without it, or else
> say we require it and remove the remaining legacy ifdefs...

Ahh was this the changes to qemu-iocmds to use proper monotonic clocks
to avoid /0 that was occuring with gettimeofday?

In the main code we have comments about:

        /* XXX: using gettimeofday leads to problems if the date
           changes, so it should be avoided. */

Is this the only option for old MacOS?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

