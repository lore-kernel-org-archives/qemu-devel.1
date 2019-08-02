Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C424C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3989B217D6
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 12:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuCmXm90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3989B217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htWIf-0005CV-CK
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 08:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htWIG-0004me-Of
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htWIF-0006Fr-Jx
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:04:20 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:43079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htWIF-0006Eh-Ek
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 08:04:19 -0400
Received: by mail-ot1-x32a.google.com with SMTP id j11so20570814otp.10
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0TirKnq/HLPV0JrxItVLN3w5lyDZcKMGJj4l0N19fL4=;
 b=VuCmXm90/2+eTzvFIvdlzIejLg1rWnlNug/wJNJQsH3QP5JxOUyc2K/Zk3VOSV2AbW
 xLLR3gXXc0lKabtfv54NZvJdaSl0LQjRCxQIeSxTVC32kq38DDCFBkqIQnZZ9Ypjb0tU
 gS80HtMnUM5mGQwMA7CILz+F8dywuyjeKmYhn8K5BT875wIOHShRJluk4vHcl2GIjENl
 2P9b9vdIrMvYvMWSge1xGWHvUjb21qT7j2oZOOqwtgzFDHcAPl393HFE11kH6mPpJ02k
 pxNLloqniDCjohrP54FXhc5QBM1o1PMy1hlDEAGM65HoborI0AfL/ciTlqlVZmyQpzhW
 gbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0TirKnq/HLPV0JrxItVLN3w5lyDZcKMGJj4l0N19fL4=;
 b=CGV+REx/VtMhdknbxYoeV7wh9+b91nBwQdS/aZo5Dmc8uUvbqA5lgPKkNQ6sRcmHFF
 kJ2qUbm6m0FdbqzRkGnNpd7C0tV6WRSgobVjpgBdKUcPYu1eEPVa52BZTosUrWy4E/tr
 UxG2XcYOGh5FZeWE5hHSnHon/pWH4YjMBi7Pl5DCBqZ0co4k3P5RMwmiwbqQz0eUh55z
 rctrJDMjwwJmx3ZT621v2xZsKSHPJfUnRmMDzzza50FxvFi7ETvXVW8dcBQYEQqYeLA6
 J1EX2nzlZGycvYRvNkjkWOeYkUfS+CuB6jNXM4eAEDlQADgfoTKM2zGvW6hfURTcen19
 lI/Q==
X-Gm-Message-State: APjAAAWJjWlgNvNRH8+EYVQu8+vhP73mkkhXJ0OMIBZbXmQFiQA/8mcW
 rLdD3l8aBTErssK/5UVv7dLN6m++Oj3pnUJqi0E/ig==
X-Google-Smtp-Source: APXvYqwLGfH3GfqRsxdupzjRtId3umS7f3NM/ZfIzNac+JOMYPI+J7wnlOlsd9VI5jEC4iF53SIF+XucbK5gwNHdmlk=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr18112033otk.221.1564747457306; 
 Fri, 02 Aug 2019 05:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190802111833.32187-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190802111833.32187-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2019 13:04:06 +0100
Message-ID: <CAFEAcA8Eu-yF9Zf7p8J4_D-obZGwH8djP2nXJbYbrpRrHz4k3g@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
Subject: Re: [Qemu-devel] [PULL 0/1] Slirp cve 2019 14378 patches
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

On Fri, 2 Aug 2019 at 12:18, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 3bd6cbbb181b6ae60a1d1f33ccd325b45f71aa=
2a:
>
>   Update version for v4.1.0-rc3 release (2019-07-30 22:02:05 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/slirp-CVE-2019-14378-pull-requ=
est
>
> for you to fetch changes up to e1a4a24d262ba5ac74ea1795adb3ab1cd574c7fb:
>
>   slirp: update with CVE-2019-14378 fix (2019-08-02 15:14:56 +0400)
>
> ----------------------------------------------------------------
> Slirp CVE-2019-14378 pull request
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   slirp: update with CVE-2019-14378 fix

Changes here since the last submodule update:

126c04a Fix heap overflow in ip_reass on big packet input
113a219 Update README.md build instructions
bc814a7 build-sys: rename project to libslirp

Ideally we'd just take the fix and no other changes,
but a readme change is harmless and the build-sys
change only affects builds with meson which QEMU
doesn't use, so this should be OK.

thanks
-- PMM

