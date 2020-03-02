Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4B4C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5F72084E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsT3qGJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5F72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8n0u-0005aw-50
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8mz5-0003pa-AD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8mz4-0003RF-53
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:27:55 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:33222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8mz3-0003R0-UV
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:27:54 -0500
Received: by mail-ot1-x32d.google.com with SMTP id a20so1403945otl.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 07:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KLwQGBc35XUGJxFZLTPNg64qutbgWPooL8x5/IfhyQU=;
 b=QsT3qGJpcFjrmkTlePLScfMlFGpE+EiDdMSXnJ4GE0Gz96QjcecNh+pd4PYJVlqrDO
 pPaN6eMtJDPdzYNirXlFmeNxBi09sc/KEi7R3j4y6xrqwxFXGs+cHWrxZ3vKjIwwFAWt
 RqimcczXZWsh8CUT9DuiBvGn9JEm4LhUVn1hxkOnkrmbmd6rY0sMzjs/Bp+azrBNgcLq
 6oQqEPVPOnXW9qOr3LVJfkEKNJPr8UsG5dkH8yKoOQERL54AHa7Js3SNc+CYDYMz38Aq
 vTsINhgsfuJSNgDXM9qLp/D+ad7S+GzA/gyXVt+QzMEQWLJIArAZd9bXl11hr0gImQVo
 NwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KLwQGBc35XUGJxFZLTPNg64qutbgWPooL8x5/IfhyQU=;
 b=mYzcVWWhjY9y0HuLtxXl1+imsYGnv3P5EkeQhJm7R/NREgqXZjbwGMBU2bBo85GDKx
 rZqxeY2T/TfaKm8zgLfOODefrr6vB5MyabjDninEdD/dEDLNQkvVtJbtlfpfqQTh6FOv
 m1W279a8a+12hkHrdKdQSN5uLmjSfSXDG24lmZO+JiiOIllYp9zNVeLtxGiza4+Bn29w
 rffKFTuhxcpECP2bMgCu1GNXw7DxXGWUQN5dK+Ci4PJzXAvoeSyx1L1skxCU3PwAl/LL
 IS4FuqK7z7y228hC8/VBR8bDsMqd6WYNGZYgU+8ZZ9j79YJZaGs69PayxtVYsnq/KDkP
 u6GA==
X-Gm-Message-State: APjAAAWVn3ak3XijG5XiS5bBGbSVQjLmj/yAVD+JX5fAT3++O9PEFTkM
 1Ti2wJwZhcASvpF5pC8bUsIxcUlVk6tGcG+aMJpBnw==
X-Google-Smtp-Source: APXvYqxp0unuMZYf+rcrcl7j9hU34uR2wvv4bhyYmRefN0dSZGZtTe8wWHK+Ck3EpPF+Smej1xhd7svfcSJkqcvZA9o=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr13606776oto.135.1583162873135; 
 Mon, 02 Mar 2020 07:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20191202140552.GA5353@localhost.localdomain>
 <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
 <20200203032700.GA12127@localhost.localdomain>
 <CAFEAcA-h3fJaBm+DSn6VQ=sgdS4x67MT_biyeTohk__JzkACMw@mail.gmail.com>
 <20200207203856.GA17041@localhost.localdomain>
 <CAFEAcA9uodvAUzObR1dS3ecm-sqApO3LFHHfzqG_G+n35w_OXw@mail.gmail.com>
In-Reply-To: <CAFEAcA9uodvAUzObR1dS3ecm-sqApO3LFHHfzqG_G+n35w_OXw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 15:27:42 +0000
Message-ID: <CAFEAcA8v9jVODvvqDkZhC9KpRTX1FYBQtHTxiy45UwHLZ73EUg@mail.gmail.com>
Subject: Re: [RFC] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
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
Cc: Jeff Nelson <jen@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 at 13:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 7 Feb 2020 at 20:39, Cleber Rosa <crosa@redhat.com> wrote:
> > On Fri, Feb 07, 2020 at 04:42:10PM +0000, Peter Maydell wrote:
> > > This all sounds like the right thing and great progress. So yes,
> > > I agree that the next step would be to get to a point where you
> > > can give me some instructions on how to say "OK, here's my staging
> > > branch" and run it through the new test process and look at the
> > > results.

Hi -- any progress on this front? (Maybe I missed an email; if
so, sorry about that...)

thanks
-- PMM

