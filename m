Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E7FC3F2C0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80780246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+pgoBYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80780246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7QTc-00061N-H9
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanrin@gmail.com>) id 1j7QSx-0005TO-6B
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanrin@gmail.com>) id 1j7QSw-0006Qd-9v
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:13:07 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133]:37807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanrin@gmail.com>)
 id 1j7QSu-0006Pt-22; Thu, 27 Feb 2020 16:13:04 -0500
Received: by mail-il1-x133.google.com with SMTP id a6so876252ilc.4;
 Thu, 27 Feb 2020 13:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=/olHdzrkj73AN1Et6BS2Kq1lsHM3BB4/3t0JX3wBqa0=;
 b=Z+pgoBYV0ej1mFdU8Sm5LMKdsaIyTPtc0lGNKTHfxfwhz8EnaTtMrsIohKCkhlsPlZ
 15ODlk5tp0dD9FPjoaYWdGy0SQoeh7JskzJ1VllfunAiszde3qV6GnLE/YmaE15QhPK8
 Yw6jx/oWq+zngyKPObqr6+6z7bltnxVSNlFPLjxqZwmSrP3RKcpp5a8HKK3uQiAkM9kC
 0rRp6pkMogJqwGdsBZbcxjeRwnsBWUaURjF0y1mf9QZ7ck6Pw7Vo3rmA7BIVz+5Ur51Y
 jlR3IpTK41gDOGaD/TWiSN4oqybJ6UrgLIA6xJecbfvZvIvyd8wmwYfWgA2ifojtyT8a
 ocCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=/olHdzrkj73AN1Et6BS2Kq1lsHM3BB4/3t0JX3wBqa0=;
 b=nU+x7G52P/VuaSpamS1is7iAIJSnmbWKA1xNAaIzmHylNOS5Fdyp+URraxBqXq9hXl
 Hq0aib4Y7CpC/VQ/O3EfM1keshhvI0YPtYfSGpLWZCjxn1X99P0GqW9KOW+qV5m2NbpY
 HgAJc5eLjV76Fueemw5RFN3wYu8OMFD2VVeQCj58AB2Hs7aI1LcuJwFPqXQVYP7Og+Ap
 tXfHuQozi97UIiVtQ7qCBAGRuwVHGm/sLtfTvEmKCiIukRIpA9GeyDtefGPKTILamjmf
 rdv99WKskRhLgE7FMU6MDDjxbB2UHMhQVfeE9dK/wPtVf3mQA+26n2zqneiuA3TujFDv
 WcCA==
X-Gm-Message-State: APjAAAVATMfV8VPYyW+tWP54F35EIkr2hVxw1pCVOKWzkleefJxT4fRv
 YflW/2PY2lI/9e+9RXoO1w4h/obYBoBnpYffaGzPTA==
X-Google-Smtp-Source: APXvYqyX3/rhHrdzATf3VZepAQJSdKmWGeXrTVwZoUkoSDd8ZePTe3s8L78Awys2Bx67Ntl6c/vJ6VSnK6FkPj7ApcA=
X-Received: by 2002:a92:844b:: with SMTP id l72mr1243521ild.262.1582837982321; 
 Thu, 27 Feb 2020 13:13:02 -0800 (PST)
MIME-Version: 1.0
References: <CAAxjCEzHQz4cG_8m7S6=CwCBoN5daQs+KVyuU5GL5Tq3Bky1NA@mail.gmail.com>
 <CAAxjCEx79Fkjw9tFbSMo+b1LGv2LNivLRXf1GS9JsYnXrNVVkQ@mail.gmail.com>
 <CAAxjCEwv61e87ZUz-jueL9AkzaNbY3pRoFmf2dah-p9W8nosWA@mail.gmail.com>
In-Reply-To: <CAAxjCEwv61e87ZUz-jueL9AkzaNbY3pRoFmf2dah-p9W8nosWA@mail.gmail.com>
From: Stefan Ring <stefanrin@gmail.com>
Date: Thu, 27 Feb 2020 22:12:50 +0100
Message-ID: <CAAxjCEx__TsY75b0iecG1a_wUO2MF2UMVP50nFHQi2Ouyu0znw@mail.gmail.com>
Subject: Re: Strange data corruption issue with gluster (libgfapi) and ZFS
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, integration@gluster.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::133
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 3:12 PM Stefan Ring <stefanrin@gmail.com> wrote:
>
> I find many instances with the following pattern:
>
> current file length (= max position + size written): p
> write request n writes from (p + hole_size), thus leaving a hole
> request n+1 writes exactly hole_size, starting from p, thus completely
> filling the hole
> The two requests' in-flight times overlap.
> hole_size can be almost any value (7-127).

Victory! I have a reproducer in the form of a plain C libgfapi client.

However, I have not been able to trigger corruption by just executing
the simple pattern in an artificial way. Currently, I need to feed my
reproducer 2 GB of data that I streamed out of the qemu block driver.
I get two possible end states out of my reproducer: The correct one or
a corrupted one, where 48 KB are zeroed out. It takes no more than 10
runs to get each of them at least once. The corrupted end state is
exactly the same that I got from the real qemu process from where I
obtained the streamed trace. This gives me a lot of confidence in the
soundness of my reproducer.

More details will follow.

