Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DB3C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01BB20665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wV9nDzXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01BB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFch-0002pm-Ux
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42387)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiFZt-0001z7-SU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiFZr-0003Sq-VC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:59:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiFZr-0003RX-2P
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:59:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id s20so16571073otp.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VEzi7K99nRzmSqXHzUjoGbOVGn5aSZfnMNi1nO/c3/k=;
 b=wV9nDzXTAmhFFY3tbEhi/35jONJAW8ChB7DbBjwEtdmnKRAp3qqKhO6aIntFJYvgbS
 7g4PWwpzrlNMaRB0X0HwuxNZnxorZuzlLr6lKUMrFj46RpuqvPYM56Qd7zOrmtvN2+Q8
 Mi0qqb1ruT+7uSOAphHDyxSHBHHw08mSVYA/SCjfO4iBubpEbvb9I7YWpA5JrYSVMNCv
 7IwYahvBVBV3t3xWeWm3yzVUqU6W81DeTL7fWZOB3s/3wN3dGM10ikIp30hGwjjMUh8n
 UZD1YBjC0t1fHQ/PfIStplk7G6D54jmJGHV/0xsqSUWRjc/C/doYzGdbpor/oWaEdDKr
 RXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VEzi7K99nRzmSqXHzUjoGbOVGn5aSZfnMNi1nO/c3/k=;
 b=TZX1NY3YxSxPFYlM2O53C9r6wLqwQIjhWIYrfyUSyiJ1oE7P8q5gbpZ989eFc7x3SJ
 7AkHAMd/Paj2hbKCzI5rpQ/aAU+o3WWnVq/rOYZJFedfUdTG1A7t1zFbNA4dXFtMKGQZ
 hS1pJV4GWVVOZm+XKEmiKCuMw41k6qaa32jJ3gqQkoSguexN/4BAVpb+3yv6IWaBsy59
 RR4TuqW6zyIPgN6gBZO2Pu0QF9MYxlSJUA08hsdC9rfMLeyAXrEGJHdsbOUcQCSEkxlD
 xjk0nhFfoyiQagxzoTXtXE0rYOAnaK7aUP3pEdO/gPhm302eabQKQe/+uK/50OduRQcU
 HZQA==
X-Gm-Message-State: APjAAAWcm2gIfn0pOxa7Ri00VdKbSLq9t5ZICXlC5z1hW9FLdoY3mbhZ
 Er0+BgWLU3pARGWGCgBsq70sDRm9ZCfqKEN/nQgzMw==
X-Google-Smtp-Source: APXvYqxa5NX7oqh3ZJr79rNQiULns7WT+KnmwjerLeQMglOuPePI8SOYt79vOocQ5sHbshhFihLdzcWQ7eX2rNhQXew=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr1629147otk.221.1562061590128; 
 Tue, 02 Jul 2019 02:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190628131347.8679-1-stefanha@redhat.com>
In-Reply-To: <20190628131347.8679-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 10:59:39 +0100
Message-ID: <CAFEAcA90F_A23_uQ7xqq0o1kA4aoABYmq3v-apECzHYKx9DRKA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Jun 2019 at 14:13, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 6c11dda922915aaaa032db4462294e8df45f7441:
>
>   build: use $(DESTDIR)x instead of $(DESTDIR)/x (2019-06-28 14:12:14 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> No user-visible changes.
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   build: use $(DESTDIR)x instead of $(DESTDIR)/x
>
>  Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

