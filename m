Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E862CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5251214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNQI/Gjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5251214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhv3n-0001tV-05
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhv2F-0000qo-Q0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhv2E-0000x5-Kt
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:03:51 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhv2C-0000t2-Jr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:03:50 -0400
Received: by mail-oi1-x241.google.com with SMTP id w196so9719050oie.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2AAfKKzmLdAIFaTaBf7HuSbxroPMPlPB7lCbk6zDrPg=;
 b=nNQI/GjcjI+U6Vg1U/THZ5l5OVd460GzMwahYvitk0ZFCi6RTGPFAZf5FsX8OciEfr
 U287GHhKd4h+xkJ8Y1DXQzCGmxbvjmCLInUxN/IucB3z4bX54eWphFUn1TQ9W7povplY
 Gk+RimbVFtgrGMKU9C8sWaOYTh/5fOxHD+A70hIkYl755Cybyrv5Rg222RLVYP6FeqAi
 itpzlkzXFys66U4k+EZdfglgAZQB4VBB16WCllHdGr0CaAQG1ccpxEawPQ+Epc2ZDo+h
 6E/AiH/9anur/bpIU6H8oyxMGjUO4HqBybEMZvJJRN4qLGwC9/ClfeRpCnKB+Q1UXBed
 25aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2AAfKKzmLdAIFaTaBf7HuSbxroPMPlPB7lCbk6zDrPg=;
 b=EGz52qvbOOYD0Y5Uba9ReW/1ufM1ux60Cr25kR1EykCTdoIU0X82lp6ikN+HqNq82v
 9p+3SUTl6N0XM1wGW9WEECUBJ4y1RcNC7NjB3n7/68tqG2eDq+KNi5JA6CW30MwgnnyN
 SpOfeUtCTZVTyiEavBpCaWySxfolEpbOrcwrlTOK8iMpmjO6WTOC5ISKgJff4svifwt8
 zqchZ47GlqpwgHg39kPEY7AKYwrAX3VIuF8USbnlD4nQpPaXnKndP6K1xSki/c6aVQMi
 g4aT03LKdbBnuIudnDJzaVGYHY7y87ndN/iphR+oof0gkwtNllXYBST0pnGR4rhVFAzs
 Lv9w==
X-Gm-Message-State: APjAAAXSjStPL0muRZ/x6bm1ydJF+SBaRj4RLa0pQYEP3zViu4QKJMLY
 jm+6lrKPJUHFy6VTmA1YW0yNHTRyH8x7bbcZVXjylQ==
X-Google-Smtp-Source: APXvYqw2wIXEpMxE0mIOoQ1msiyxXHhiw3j2/8D9VI6VkomGgjZsDHqQReqknT0IHIipDZgkuytwycbPTCQZV3z1KJA=
X-Received: by 2002:aca:6185:: with SMTP id v127mr6744757oib.163.1561982626028; 
 Mon, 01 Jul 2019 05:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190624144740.5338-1-mreitz@redhat.com>
In-Reply-To: <20190624144740.5338-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 13:03:35 +0100
Message-ID: <CAFEAcA9suWjDxBuB1OeJd97=Fx6YvhD0omJ3z69uOK_X9Ywd1Q@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL v2 0/8] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 at 15:47, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-06-24
>
> for you to fetch changes up to ab5d4a30f7f3803ca5106b370969c1b7b54136f8:
>
>   iotests: Fix 205 for concurrent runs (2019-06-24 16:01:40 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - The SSH block driver now uses libssh instead of libssh2
> - The VMDK block driver gets read-only support for the seSparse
>   subformat
> - Various fixes
>
> ---
>
> v2:
> - Squashed Pino's fix for pre-0.8 libssh into the libssh patch
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

