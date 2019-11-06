Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F1C5DF64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F84218AE
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZQ9pJFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F84218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSPXg-0005AV-SO
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 12:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSPW9-0003Qc-Uu
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSPW7-00050l-Tz
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:54:53 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:36901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSPW6-0004tK-5q
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:54:51 -0500
Received: by mail-ot1-x32d.google.com with SMTP id d5so9552048otp.4
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EC1HjdDFD9T2NCXS1uYZjYz0RY/pGZIM8YZj1OM/3g8=;
 b=wZQ9pJFKY4FLZq6kN2yPOEv3ISmOwluK53ASNU74c4kEabl0WvFGdRMctvo6c5DBd0
 wbC5Ds8krjP3Wpjg2joSvkeCEn1/RuoQD9t9NmAHZTFMljsI0UDhVisEzxOG61wSktjy
 plBEBKZmlZdSW/efsQSduwgNiYzUrIHWEWw5oK6+UUyKvWIyu0JHVqM7jgWZPyKJ//lJ
 PgRRaKBIjKG/7k94ovm6ws0i4tU5pPB89Bdeh+w0yq9MFmwSYn3Ot1uOS0rfWLltLgXa
 sW/0uUE6NUSYwrYft5hmaTuIbqcCd+pOyiqu1OtLRaU6EzReSHhw/0+HPBBvwGK5SvcQ
 dfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EC1HjdDFD9T2NCXS1uYZjYz0RY/pGZIM8YZj1OM/3g8=;
 b=FaYPFL1PnV3eXRlkcln5iO96ZsUPxuJ/4XjDG6zjv8iVCg8i8QfiuqnadhEkseW1GC
 u6ycduT+WYEkX7EjulD7Je825wmvSTA+BXFxgIM83qeLyO80LYAcO56/UZ4haeF2lWIj
 QCRM1/YBj5mbiIj0hVHgxhAxeteDCKEmdwNkc1dzzvmsMvt1qAl62lH8hVk/3yTGKUIb
 rL9puISa93wUr30OTkaO/9sT4oVeEOgLNBdwPwVZZGULjjn3go/2VLa/NSvjVgHpzqJf
 xKsduBuY2mKYtjrX7GUPkvN5KTPa5sCQdRijSVf4N/PdxPOftJrgL+Wl2VPpQ23D9zAy
 sDyg==
X-Gm-Message-State: APjAAAW6nWkDiwG+ZZtoPlt2ZC3fJCzOhJ2q3OjBPx1xqpWEctLTFFGt
 GtGnBkJu0ayo3eqnCTipiEafIT3r2Q36BjZ49ifzuQ==
X-Google-Smtp-Source: APXvYqze0eq4nEAVpRYNNmgpMtWfGvB1kusS3g1ohD5SLL/WdVtdPj8VUodoDoa4RKJ/oA/7TpyONUQEcYVtHjumpsg=
X-Received: by 2002:a9d:6844:: with SMTP id c4mr2586345oto.97.1573062888708;
 Wed, 06 Nov 2019 09:54:48 -0800 (PST)
MIME-Version: 1.0
References: <CAOyzTAivEpv1VXzPXVH3Za9Zcz1URFjnpFCZQrRB4K=Z-oy1Dw@mail.gmail.com>
 <cdcb88d9-2754-834e-0ff7-28b5f8adc6c5@redhat.com>
In-Reply-To: <cdcb88d9-2754-834e-0ff7-28b5f8adc6c5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2019 17:54:37 +0000
Message-ID: <CAFEAcA_f5L1sy5jAC8pmFMG1uFpNjGjJ5QaGyLQty_7_skzMCw@mail.gmail.com>
Subject: Re: Feature Recommendations?
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Dinah A Baum <dinahbaum@utexas.edu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 Nov 2019 at 17:42, Eric Blake <eblake@redhat.com> wrote:
>
> On 11/3/19 4:59 AM, Dinah A Baum wrote:
> > Hello all,
> >
> > I am a university student whose Virtualization course has tasked me with
> > contributing to an open source, virtualization related project. I have a
> > little more than a month to complete this. I was wondering if you could
> > recommend a feature you'd like added that could be done in this time frame.
>
> https://wiki.qemu.org/Contribute/BiteSizedTasks might be an interesting
> place to start looking for an idea you are comfortable with.

...but do come back and talk to us before putting any coding
work in on items on that page, because there are some old
stale things and some landmine "not as simple as it sounds"
items too. I keep thinking we should try to put some cleanup
effort into that page (maybe convert it into a list of links to
launchpad bugs tagged as 'easy-task' ?)

thanks
-- PMM

