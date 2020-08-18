Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8792120706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFw5J86Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8792120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k81OV-0002Hh-QK
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 09:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k81Nn-0001TO-EO
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:10:31 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:39944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k81Nl-00082k-Ih
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:10:31 -0400
Received: by mail-ej1-x642.google.com with SMTP id o18so21994205eje.7
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KPJpiKKEja2NxNlAQMhksdZuGwlN6EjpLB3SFsJsk2E=;
 b=yFw5J86Y0iD88s693HAe0mGtDdx/u19htEl75ExPhD7P2RU2i6XD3XoecUAcZBGQjP
 FI9S/fKQRAgf36ZVXZJMT3j3mUc9Wcm44+vTRMLZa36KZc/AfuURiUDDnb8idOr13oi3
 SKcDVeMsKSFiXj9DRgM0w3OcRpZuxFY3XylK7rC7cgU807qy3F7VBwUPZ9u7stZ6gaq+
 B+QOPqh9Hx2/mOO3tDfiaud3eK9Z8MCzpB0mMZi5M4uqhFRoacFFN4T9Hai34y1ljX1s
 q5k05qHl1khgMz9caBgV++pF/FQotEU3Hs+WiGgs+KgLrALi+nVMTPyA7FXh3yFBxe8+
 6r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KPJpiKKEja2NxNlAQMhksdZuGwlN6EjpLB3SFsJsk2E=;
 b=PS1XqUkTGjghnQ0FD2/kn2kznzAGgk3T4xU2jhFdb0+BzUZyAphj8x2ENj+LteMZLm
 Z/rX9NipUVzuY53kA1xGV4nBcYBuhFrSIyCT37FshJcFN3rTqStviw4U6/zJoziZIPbs
 7c53h4Akj0WDNuR56ZLHlqOmoNJp1QRq8L+hJCWKWnfoGzh9CZJNriomw6AwYwpVS848
 CywlH2jQvZb0fotlgjp0mreMnP6nxMFf9/JJOnw2ZHHjlU/FtQsfeQEX15tIM2w9wf4S
 bWqhlXvM/kvrRRwrSi6lGek2pxHnMWtXPQthBa65yz7WZExxBvYw73E5WrbuFv8mhkON
 7OpA==
X-Gm-Message-State: AOAM532cqIJMh/oRDm4ASmc9ZgM62HImJvjyZGUzdea07/Z1UMJKKgD8
 hFd8EQGCicFlCPw0WasbC1l1ugOCuIPw8PYFszkPeQ==
X-Google-Smtp-Source: ABdhPJxD4EjguFu7WE1fOyaduRJGeIfNw1+xMgcveJ4Mh5tBo7wk07PhBGu+koH8gv0wuD84oaTERHASNNasYivI3tk=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr19343914ejb.382.1597756227481; 
 Tue, 18 Aug 2020 06:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141100.398296-1-marcandre.lureau@redhat.com>
 <8c8090d3-9f81-77ba-6f8e-3f26b11ed77a@redhat.com>
In-Reply-To: <8c8090d3-9f81-77ba-6f8e-3f26b11ed77a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2020 14:10:16 +0100
Message-ID: <CAFEAcA_v0qtNyjOPUZ_erjuF113O3xb9Gr8uC=+TMF-QZ0g55w@mail.gmail.com>
Subject: Re: [RFC PATCH] os-posix: fix regression for install-less datadir
 location
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Joe Slater <joe.slater@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 at 10:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 16/07/20 16:11, Marc-Andr=C3=A9 Lureau wrote:
> > os_find_datadir() used to check the ../share/qemu location (regardless
> > of CONFIG_QEMU_DATADIR). It turns out that people rely on that location
> > for running qemu in an arbitrary "install-less/portable" fashion. Chang=
e
> > the logic to return that directory as a last resort.
> >
> > (this is an alternative to the patch "[PATCH 1/1] os_find_datadir: sear=
ch
> > as in version 4.2" from Joe Slater)
> >
> > Fixes: 6dd2dacedd83d12328 ("os-posix: simplify os_find_datadir")
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> For 5.2 I plan to support fully relocatable installs, so I think this
> will not be needed.
>
> The idea is to write a function like
>
> char *get_relocatable_path(const char *dir);
>
> That takes CONFIG_QEMU_*DIR as the argument, turns it into a path
> relative to bindir, and tacks it to the end of qemu_get_exec_dir().
>
> So for example all references to CONFIG_QEMU_DATADIR would invoke
> get_relocatable_path(CONFIG_QEMU_DATADIR), which would return something
> like "/usr/bin/../share/qemu".

Unless you have that series ready-to-roll, I think it would
be useful to just fix the regression (and cc qemu-stable on it
so it gets backported to 5.1.1) for the moment.

thanks
-- PMM

