Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE290C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD57B2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgTP6deV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD57B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzoh-0005YC-Bq
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 08:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60220)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hmzoX-00058z-T2
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hmzoW-0008GV-Qq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:10:41 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:33367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hmzoW-0008FX-Ih
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:10:40 -0400
Received: by mail-oi1-x232.google.com with SMTP id u15so12464871oiv.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JEUauoOZhjuhUK1CzfXWCZdKHJgUnVMSw5erwuhiuo8=;
 b=MgTP6deV1KA4JfUk5gVukGIMzFeiTr8c2GrB0QLykz2iouI8ylx2R+VwUvw2RmmOdm
 qxw1jqtUBAFmVKxQQ5uFAPjgQttkijeqjdxiC6TwHU4FhyHUfQwP/1pACS1SCcCJfNZC
 JRe3RASyQ+oI63aYhNIx4bolq5KSY2XTt+KrS8HkTasIaDq6eb1XTB9DyWJdGj9ZKKoU
 ItBC0E1E2d9qnX52Suha7uqDN5eid+9yUt9fvBBY3NKHS0dDOR8oCT77BUL69ytqqYp1
 PHI9brRU0UXFHRKQ8Qk5dUiJpwD3StXbFFzDrHrkyBXBTW0wbuBDPg1lwE0kGxvhZ1ZW
 qfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JEUauoOZhjuhUK1CzfXWCZdKHJgUnVMSw5erwuhiuo8=;
 b=Xlwwrp6TRylLAwFx1/3FQArHP1GqY50aTK/G1YRLuwe83YWq96ZlKtbG+EMwcmVEDU
 irmKlOnq7eJ7g1tsdbQBOyWiy9Acb/qfEItFabTwLDy8OXZh0rQKvMZw9niFvqnG5xfj
 o0CPAl+7Ws/N0GLdZhEbp2lk7s9dO9Pl/QrnINc4yUd+Z8TLyDUaByOlAx5Bcrd06usW
 iZxYT0DpkhxUqMURbkW15MnS+U4sP6qG1IvReJ6WpO+xxwIM8qAtZqfRFdKdhMmj0WWN
 Uaz+ugphLtoEeYGJtGYQ171qTyZLXtnq3h5lhv2NSxNpZ8pt4lpQmj4hsmv4VT/F8vB2
 +y/w==
X-Gm-Message-State: APjAAAXaA5AfrmpOjP5hJD+2r4NkW5/0xQoiJjnmSjVv4JjtOLuC+Teq
 sRQRpXxU1ZtASsEb2vdgrbbTNxSB6f4skgdqo/81yA==
X-Google-Smtp-Source: APXvYqxLSyg5wZcV5Cei7cE+7rQbXXSR5JekrJGXtl+/U7+3H3fqpDqMf3L17aK7bl8J+qdMzCt2MXGI5N4OpC/QxXU=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr11732531oib.146.1563192639501; 
 Mon, 15 Jul 2019 05:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190715111501.22368-1-dgilbert@redhat.com>
In-Reply-To: <20190715111501.22368-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 13:10:28 +0100
Message-ID: <CAFEAcA8CEoHmYwoCy+ms0aUGNc1pBHJuz5a5VzPLQga64MrPKw@mail.gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PULL 0/1] hmp queue
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
Cc: dinechin@redhat.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 at 12:15, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 298ad7b5a4519d2ae547df46103b2f8d49ca6f95:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190714' into staging (2019-07-15 09:46:15 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20190715
>
> for you to fetch changes up to ea73f37062a9012a4f151f47f2427011b18569c8:
>
>   Fix build error when VNC is configured out (2019-07-15 11:26:26 +0100)
>
> ----------------------------------------------------------------
> HMP pull 2019-07-15
>
> Just Christophe's build fix
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

