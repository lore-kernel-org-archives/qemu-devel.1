Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289E8C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22AE20409
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1yQVV/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22AE20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFE32-0005ZO-3Q
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFE27-0004wn-Em
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFE26-0003kH-6k
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:33:39 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:46738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFE25-0003ir-Tb
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:33:38 -0400
Received: by mail-oi1-x233.google.com with SMTP id x5so5751177oic.13
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QRYBP3Mq6xR9OYUBEyIf0eOu5+mCsd7//Rj6cMY+fVk=;
 b=f1yQVV/4+oilXPr1ZWfmlj6Ztp2/ondW6j8oNLvi1NSszFiLUPb5mi9FJDqhC+LbP9
 aJj2qNwT9M0mJrJh5VURozSbXmO3WTuWz75B2HTD3bLR9eJPtv/C/sW+O2YB5hWdu6qt
 3V6PwlWcbZ9GQ7M1qCQwh+MbXFDUIr1PpFDVBtZ/pbb41MmjZ0Nboasw28MtrCrR9RP4
 VJtObxo5ASqolFd/H4SUUr7WZqF1CoN52Cvc5r7BeMNNsVkCYfMA9ZETcOrl2cHAcUpG
 pjmj4sFRUpFFBfPQTJeQ3lo8uQb377TJmQISJsHEucqIv+ACJOXQesiCl7uGQaeJAbHG
 FTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QRYBP3Mq6xR9OYUBEyIf0eOu5+mCsd7//Rj6cMY+fVk=;
 b=Xn6UiKub06cVj1+hNi4CcSGoSpHNYVzL5XQ32wKlg71CKkvS9bvjjeFoJeLsv09EBK
 FebOgLSmojxpTXBBihbZH9k5XWycmb/uuFesNftpkYH9KDI3pFTqeygmk30WL/oxWbTO
 1QOr5LgggfOD1HhMteN7J/58Sa4Dl/hRlr8MjIr59Tg3F3UxBIIKRwXcZNuoP6BKvFwS
 MCCwwtp1d0SyQD04A4O2Mlp4kVWKhKHCPFb6Zb0dx/HfEisZFueqOPk0gOSIjDYkDm4C
 CpepKxVg1BqGC9ypVAPf1mJozWoOIdnZAK6Nh3f8mxmqjWfdZtoOY0UA70V0VAUhW5pJ
 K5HQ==
X-Gm-Message-State: ANhLgQ0OkiZpV1AwRdSx+3lk8CjJ8LZDFD+TO3c5LUbJGYmTicbX1VeS
 qA/3uWcdEqHQtxLWEhjG2t9QIzVTy/TE0yndZYX7Qw==
X-Google-Smtp-Source: ADFU+vtJ+mnJpfgbvepmWx7HI8pCMFs6AHixuJ7Q5lTRJgZ4l7eo6QtY3iKHtiQy3oHWkMWSH+2CrdwE5eZ8QixgFPw=
X-Received: by 2002:aca:190f:: with SMTP id l15mr5404496oii.48.1584696816805; 
 Fri, 20 Mar 2020 02:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200319112911.353244-1-marcandre.lureau@redhat.com>
 <CAHiYmc6KK3Qiox4byg9FRMCtpMLsvzftOHF05pDTAKK6OvzZgA@mail.gmail.com>
In-Reply-To: <CAHiYmc6KK3Qiox4byg9FRMCtpMLsvzftOHF05pDTAKK6OvzZgA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 09:33:25 +0000
Message-ID: <CAFEAcA-jk-Qmp2SBvk11Go0HSpL=wZwULaPG+YpBR+E6RH0vjg@mail.gmail.com>
Subject: Re: [PULL 0/1] Slirp patches
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "samuel.thibault@ens-lyon.org" <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 08:19, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> This pull request has a very unusual form to me. In its cover letter, it appears as if only one
> line of code is changed, while the patch 1/1 strangely suggests that there are number of
> underlying patches. I am really puzzled how this pill request is created at all, and what
>is its real content.

It's a submodule update -- they always look like this. From the point
of view of the
main QEMU repository, the only change is the one-line "submodule X moves from
commit hash Y to commit hash Z". That represents potentially a large number of
changes inside the submodule's git repository (which has its own git
commit log).

thanks
-- PMM

