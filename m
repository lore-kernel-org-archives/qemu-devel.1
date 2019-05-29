Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C5C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54AC23F25
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 17:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4DniTv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54AC23F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW2Fg-00070f-1H
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 13:20:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <claudio.fontana@gmail.com>) id 1hW2Ed-0006dQ-46
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <claudio.fontana@gmail.com>) id 1hW2Ec-0002kc-2l
	for qemu-devel@nongnu.org; Wed, 29 May 2019 13:19:31 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:38057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <claudio.fontana@gmail.com>)
	id 1hW2Eb-0002kL-Qz; Wed, 29 May 2019 13:19:30 -0400
Received: by mail-vs1-xe41.google.com with SMTP id b10so2425777vsp.5;
	Wed, 29 May 2019 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=s2Vf3XUHOtrZk+kyek2qQBzgKAlez1r7ITBpE4sqocQ=;
	b=M4DniTv17P19RZmh+ZicoUJSIOZ5JRiVr8U3HQa2t5KihSDG7+0qhKWZ9u56plmkwL
	33JSA4v2iICr3rPErgV8pQsBTlKsxZmMzf8eNpzg0xZhCPs4Dbh5Te9Sf0Ix6qVHR6JU
	d2ZEIqGFC6+pwF4Yl1OsY7g1EaXzD6oteV6oYEOxds33YaThAsIc839U40NR5r23T/ao
	0Ry/O1kcQsnJuCqiNN1TEweERMWEgumVNOEth+njDjE/J7i18RqYX2SPqgZT4xjKq0Un
	aHGvS5n+QNH57vYpiDBr0HSSepUFUQ7HAPTzz61Uq4L14Au8OvdcjuqvRxswtsTeSbv/
	td/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=s2Vf3XUHOtrZk+kyek2qQBzgKAlez1r7ITBpE4sqocQ=;
	b=RRJcBBB31frokYazYpjpCUU/MPBG5ceqfFyVy1hkfUulvGKucpvekEli8Xl66V8fOM
	aNFd5NUh1MMYwzATh8oE4eyi7CFGBOBWac0FXpYFLG1A5ty31EGf0IpFnrgl1MHvdp5F
	Q2WBTyzq0L/GdP1sXnZdK8SOKBkp/btAVFbNSgjqzgk7NGym33vT/ia55ID2Z+kNmWXO
	7n887Er3kphTUymJiKvhSaq2+r8eDjUlk3vpUgnd5smTSkZYK1sBFlRz4RDGIcugP+qZ
	cUpId22lyePqUhrl7xesEfwxpC0JWkdfD2JYe/f5kgLXRnhwrS0+MpOp9EQFShpPdUyJ
	JHxw==
X-Gm-Message-State: APjAAAUWUuldRpoJp8xDqka9fwZcp/Te3Gim0K+AFXE6Eng0qt8sBQF5
	1+Y+EGtcjY9CCJ5eH9X9eZjZRHEq881GzoGoVC0=
X-Google-Smtp-Source: APXvYqxgi+e/dWkOpHN0HquZMyehG4V0cPJQfzxc5GV4qTHekabPfHohSXyywS3NSUDs6qOU1Q8vL/0k22xJAX2rsPI=
X-Received: by 2002:a67:c111:: with SMTP id d17mr57768556vsj.176.1559150368772;
	Wed, 29 May 2019 10:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190529140207.20719-1-philmd@redhat.com>
In-Reply-To: <20190529140207.20719-1-philmd@redhat.com>
From: Claudio Fontana <claudio.fontana@gmail.com>
Date: Wed, 29 May 2019 19:17:59 +0200
Message-ID: <CAJuRt+q+KPJGTFoHyNaqV=ZxfLtdLu78xtRS_GV-JHvLJU7uCQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e41
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Remove bouncing email in
 AArch64 target
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
Cc: qemu-trivial@nongnu.org, "open list:AArch64 target" <qemu-arm@nongnu.org>,
	qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Wed, May 29, 2019 at 4:02 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Claudio Fontana's email at Huawei is bouncing: remove it.
>
>     From: Mail Delivery Subsystem <mailer-daemon@googlemail.com>
>     Auto-Submitted: auto-replied
>     Subject: Delivery Status Notification (Failure)
>     X-Failed-Recipients: claudio.fontana@huawei.com
>     ** Address not found **
>     Your message wasn't delivered to claudio.fontana@huawei.com because t=
he address couldn't be found, or is unable to receive mail.
>
> Note that the section still contains his personal email.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I think you can remove my personal email from there as well.

I think that Richard Henderson has been maintaining it in practice,
and that should probably be formalized in the MAINTAINERS file as
well.

Ciao,

Claudio

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f5f8b7a2c..5ed917329d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2290,7 +2290,6 @@ S: Maintained
>  F: tcg/
>
>  AArch64 target
> -M: Claudio Fontana <claudio.fontana@huawei.com>
>  M: Claudio Fontana <claudio.fontana@gmail.com>
>  S: Maintained
>  L: qemu-arm@nongnu.org
> --
> 2.20.1

