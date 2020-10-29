Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A875C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 01:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F552071A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 01:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F552071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXwLE-0006nV-TU
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 21:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kXwIB-0006BF-FS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 20:59:53 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kXwI9-0003s8-Ui
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 20:59:51 -0400
Received: by mail-il1-f196.google.com with SMTP id v18so1460780ilg.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 17:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0CcegCcCZq36CLLokMXdq/ihVX05ZlbXnFrmL1aRTdU=;
 b=j8W5/rCeAnQsE7/3WCf4GxpkiU28cMta/m1Qe0i/3g/POLNYVJzt9g+fq4/+owqU0D
 mi7Y0PLbuyuqv8BpWadg+FN+Aa2paN7GfMSrLrojre8L9tjqhhwoago8z+r88Slkad3N
 AkF2wfkmJpn7oOAgW1xxKlECAw9F3KgCP0s/AvO3UiQXAOdRKQcfl680WD9Fr9oZEDlM
 O+f8O/aAYupGN/KJerqNV/ak8O7FvqrFDHi8GkxnkzSJFqCRVP6gHEQgZnlzh2A3SYNy
 FA+N0xFMmjCja2yxw0OAOC02AiNxxv9A+6uDK0Jiib4UiJDuTyEP5JbezYHDjYxmDpDR
 obzw==
X-Gm-Message-State: AOAM5317CRw/2omYAj6dv38rzg5nKHgqDKoUr/HU0TJmn3uPQ4RJLaS8
 l18ps+IIz/YhW72WzlLkoyYkBFgxtp8=
X-Google-Smtp-Source: ABdhPJw6PnjzsuHwiPThDiG5Z6zKVm+/v+risNVkA6EVNDy4dtNEtQQL9Ei63gkHhscdRUtyWTEM3w==
X-Received: by 2002:a05:6e02:68f:: with SMTP id
 o15mr1443773ils.263.1603933188855; 
 Wed, 28 Oct 2020 17:59:48 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com.
 [209.85.166.41])
 by smtp.gmail.com with ESMTPSA id o19sm942306ilt.24.2020.10.28.17.59.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 17:59:48 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id z5so1630942iob.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 17:59:48 -0700 (PDT)
X-Received: by 2002:a05:6638:10ef:: with SMTP id
 g15mr1605090jae.85.1603933188380; 
 Wed, 28 Oct 2020 17:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-5-j@getutm.app>
 <20201028114759.GH221115@stefanha-x1.localdomain>
In-Reply-To: <20201028114759.GH221115@stefanha-x1.localdomain>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 28 Oct 2020 17:59:37 -0700
X-Gmail-Original-Message-ID: <CA+E+eSB6jE+fbxtmtAOQYHL1ZY-FNuQGXzryoSzkeVB5woDiWQ@mail.gmail.com>
Message-ID: <CA+E+eSB6jE+fbxtmtAOQYHL1ZY-FNuQGXzryoSzkeVB5woDiWQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] coroutine: add libucontext as external library
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.196; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 20:59:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mirroring the repo by QEMU is fine and preferred. Not sure if anything
is required from my end there.

slirp_opt slipped in from a rebase and should not be there, will fix.

-j

On Wed, Oct 28, 2020 at 4:48 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Oct 27, 2020 at 08:06:58PM -0700, Joelle van Dyne wrote:
>
> I am not a lawyer and haven't consulted any lawyers, but libucontext
> seems compatible with QEMU's license to me. I think QEMU can mirror the
> libucontext repo and ship it like the other submodules. No changes to
> QEMU's ./LICENSE are necessary since it is similar to the other
> permissive licenses already in use.
>
> FWIW I only took a look at
> https://github.com/utmapp/libucontext/blob/master/LICENSE. I did not
> review the actual libucontext source code.
>
> > diff --git a/meson.build b/meson.build
> > index 48c95150fe..0beb199303 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1243,9 +1243,35 @@ if not fdt.found() and fdt_required.length() > 0
> >    error('fdt not available but required by targets ' + ', '.join(fdt_required))
> >  endif
> >
> > +ucontext = not_found
> > +slirp_opt = 'disabled'
>
> Minor issue: the slirp_opt change should probably be part of another patch.

