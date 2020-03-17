Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C2C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815062073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bbq6VyiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815062073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38687 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGhg-0005cd-MA
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEGgl-0004Oy-1T
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEGgj-0007ln-HG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:11:38 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEGgj-0007Yi-CE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:11:37 -0400
Received: by mail-oi1-x243.google.com with SMTP id w13so22833922oih.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iUkX8fuwyHhypxL9tKPv2VHnDme+D2YoOp0hvm/rEKA=;
 b=Bbq6VyiAJKQVs9SwsHR0AP4hn5GJ1gvPe38vCf8xELx+PGJfUw+x5LhEs8uf4+kkWs
 4zmEuQpWsJtYebSHmKZX6F06DoLHU9BaWfymeQPm2H40Z7PhWPe1TSRkVyCCPAPAUZjV
 lbZxr8ovxTPA+rsP7UsAXCJrLY3Oyc5N/EWEXPdsiIYPgWW3F+sVtQR51aojF646uvKI
 Gt+S2F2twUqy8izsvJVi1CVKmF985GNNcbizVrI6sIAeJMsr0849jCfJ948PDw8GcfFU
 sChZ6ziYzdLUwTCbh3xKrpoaFeLr9YfqpEag4cbvEd+9slmYm3siYaGRvV99ghm4TgaH
 JaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iUkX8fuwyHhypxL9tKPv2VHnDme+D2YoOp0hvm/rEKA=;
 b=IWPamrwXh1Y9XmiIZgf3GXjkOrp5YLWMvi1du1s9sGq7Ja0+ui5QOb77NQXXZY0zGI
 Fd4o/QRVJegR7SFJ24m+jspy8Ix/x+bvAtjnYbiqAD81D1lAyKS5VQvrGQIcPrx0RDw5
 2PIzRH0gw32m2wbiu57r4LZEKWULyOtqEc5+k+rfnXd1UAVpnHyD6QLNwjEyT+yLqrOl
 mKExhlCzxbxTdmtlBN75sWPsIJqwNfe6fuVLUk4Jmta7oAC4rceJylROsgp8Yg9GgK2S
 VxBMs3umxXfbn9KdiSESWAgYBQPwhR4bnYJ5j+JU36XwiKb1XBAaT+S9dliwbIm+j/i0
 u4FA==
X-Gm-Message-State: ANhLgQ1d+KiQKgxkFdlQFHk3uBCHWQMaPUCh27+QxWEZRGfufqUlWX+i
 tlGIN6w0soGptMBbL8KVTCEAOB7Ksw2w7Hb0EiUWKQ==
X-Google-Smtp-Source: ADFU+vupP9KbTuAebCwLbBMErw1yFVcvsVncdQnfjTF30OG00xU8mtodsYyoe1OEVP+/yJwX0DCg7lYQ3UHfo/bGu0E=
X-Received: by 2002:aca:c608:: with SMTP id w8mr82276oif.163.1584468693785;
 Tue, 17 Mar 2020 11:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200317175534.196295-1-eblake@redhat.com>
In-Reply-To: <20200317175534.196295-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 18:11:22 +0000
Message-ID: <CAFEAcA8qGWhvoRwT1Wcg6RTWONG7gVSzGbhCFtG-AgQYwZHyQA@mail.gmail.com>
Subject: Re: [PATCH] build: Silence clang warning on older glib autoptr usage
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 17:55, Eric Blake <eblake@redhat.com> wrote:
>
> glib's G_DEFINE_AUTOPTR_CLEANUP_FUNC() macro defines several static
> inline functions, often with some of them unused, but prior to 2.57.2
> did not mark the functions as such.  As a result, clang (but not gcc)
> fails to build with older glib unless -Wno-unused-function is enabled.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> Half-tested: I proved to myself that this does NOT enable
> -Wno-unused-function on my setup of glib 2.62.5 and gcc 9.2.1 (Fedora
> 31), but would do so if I introduced an intentional compile error into
> the sample program; but Iwas unable to test that it would prevent the
> build failure encountered by Peter on John's pull request (older glib
> but exact version unknown, clang, on NetBSD).

This wasn't a NetBSD failure. I hit it on my clang-on-x86-64-Ubuntu
setup, and also on FreeBSD. (The latter is just the tests/vm
FreeBSD config, so you can repro that if you need to.)

The ubuntu setup is libglib 2.56.4-0ubuntu0.18.04.4 and
clang 6.0.0-1ubuntu2.

thanks
-- PMM

