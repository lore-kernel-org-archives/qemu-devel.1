Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0CCC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E892076B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2OG8eHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E892076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHFd-00011q-0v
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJHEM-0007wr-2P
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:19:18 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:38110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJHEK-0000jW-5j
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:19:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id c8so6277751edv.5
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u5OioiHsbiQv5o0uN7SOdtZSGMQUdGFzCm6Bc682+VU=;
 b=a2OG8eHXoJa0eNfE3ZSngFWklnX42AnZ6oMH51iZ9UH9c7YQ52RQOMIVbar/StGtzh
 Quv0q+SGO5rFF0tj2Meg554EZyWlL3lUVg9Nej5w3DDoLiG6+hUXcIQqfCuEKOV95ECA
 p4N7AkiMCq7vufZ7WYY6Kq6E31VW21VxjD62XbBgQnddR03wcJG4cQDn2B7nnB2Ri/yv
 US50/gTDaj3u0xmPqWQq+vyYv7UhwiBx3RKH+Kv1tTndVtUoTEqggTzm1dBxZQaNnb62
 UsyFZNcqd6Vtrvvmt3xvFAW5q39TnXDWRgOsOmPVfBcfwntGnsV4x1BBvA8qGMz9ferb
 i2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u5OioiHsbiQv5o0uN7SOdtZSGMQUdGFzCm6Bc682+VU=;
 b=X4AsLFVEIy6zeBUYK29WjGtOhP4rGgOCUk4VYiP2O6z0yEhDJq1cCL2ORSaat4qfhB
 jTnKd3rgldy/lumwo+hJevm5vG3f9uzxjroTgS8TY0VReEmMZdS3ig44SI1BVf+nstpP
 Dwoa8WBdh5+S5zVtrI4qXjvOxQItk7IppUyka6QjbxuBkpFo8WoHO3Iav6s1v2+GFhKs
 DvBBmZWH2aw6nXSu1yFWDYLWXnlgXWefW8e5Wqqha65yVQGJy81S/X2NaXVSRCLC+Cfv
 GUfG3P9QIHgALvMApKxOtCHbrcgXUumZBhERLQ9Ply5e6todFVXWigCzo2CkRMI2STWb
 bOzA==
X-Gm-Message-State: AOAM5326rbbC2Q/CssINodouzWj3DSb5JFWYhcM+jLoXYc/QfwvJmru/
 oV5HDo5ivBWdd4kjvcS97ohW4ItDbxeVHTaMSk3mUA==
X-Google-Smtp-Source: ABdhPJwFVgiePcSBCK44GiKBaDw4yPkLgXZkcpxuMoF1n93q19yoV+dDP7z0cLL0cebbjR/iRZdXNY/gbpg+lra/4Ms=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr38112456edm.44.1600438752382; 
 Fri, 18 Sep 2020 07:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1CKSBCwWZjdUJ7Q3w5uGvM0ZLe65Vw05mm8v3t6kNLKUzg@mail.gmail.com>
In-Reply-To: <CAJ+F1CKSBCwWZjdUJ7Q3w5uGvM0ZLe65Vw05mm8v3t6kNLKUzg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Sep 2020 15:19:00 +0100
Message-ID: <CAFEAcA8CHK49OChJ9V6g2xj=_9UZLOzy5My0KViWmSEp5Q8_Qg@mail.gmail.com>
Subject: Re: Deprecating --enable-gprof?
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 at 14:27, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> configure has --enable-gprof since its creation, but is it actually being=
 used, or is it sporadic enough that we could deprecate it?

This reminds me (because I can never keep gprof and gcov straight
in my head :-)) that now the meson build has landed we should
probably insist on gcov/gcovr being at least version 4.1, because
older versions don't correctly handle out of tree builds:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05823.html

-- PMM

