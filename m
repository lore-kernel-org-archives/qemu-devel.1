Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF0C38A2C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80D52076C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpvdEQeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80D52076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOSvv-0000RS-1u
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 17:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOSuV-0008CI-36
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOSuT-0000F8-TT
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:15:58 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:36636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOSuQ-0000A4-2g
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:15:57 -0400
Received: by mail-oi1-x235.google.com with SMTP id s202so8524696oih.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4vwvQfSsozUsFwYIr40q4vuNweY5luaTCB4LhB6YvSI=;
 b=DpvdEQeMYsfgvhCqkY3n0JKqnY4U/OrQT3Hwjh3k8fj0RmlokG52adqkVqWbeGxE2p
 kaPNevGR4a6Y0pyJc1S5FcQ6Pttjw6/zvgnxemkIUprb71kDaTnHR2eU5YOmM7NuEU0z
 ctAzfWjlWkziebr44OWNz6ds9wFLT7unpLyh2++D55Uz+KEfYM9bXxCkXLSkxmvLXwSJ
 FR0shRO8UpVsOQ+8quWKwuOVlLL+KJf2m6cuI57K3c1xriYTTYO2niU5diwtlw1tACl1
 FV8OfNhCDRyEx78gddCZdWDvhW+xnX980EynCPbd1isABc5Duk8gyGTjqkXwjoPWjuVd
 0brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4vwvQfSsozUsFwYIr40q4vuNweY5luaTCB4LhB6YvSI=;
 b=GVSGM8nnVUFvoE6rScT0Tiw5Z/l+e5K1H6dtklD3BjTvh/PKsrtIHcbHDRbrIWacmr
 xc/rj0OvTh2p1YvYvuP1kJ058bfeJBnf9dFhK3MFTc/FWfmj5kfXZclaXVAbkHB/wHdd
 WRzszMT6IwIH2fYLjgRyMGINl2UwJrg2p9t/nLbl2DxrrBRcWOQ8tb+r4SPxx1WyLP6G
 en3zBQAHds2o5PNJwqj4VFenfI9IUFctKsGyS7OuCu1l659UgohGEFQVgivTAyuoVQE7
 HOQGKGiOK0nrvGAvbaPIPeIf5T2iKfd3MQT74douo9fiajrbdXZKWb5+QQ+Atb1wXWLc
 b0Cw==
X-Gm-Message-State: AGi0PuYC1+m8daHqkf6KHcbgzBK8nVq3dQicfrqB36TwQvf5PQJD/Qww
 c7TWgFhxhuxe4o0Eh+TSYhIH3+jnLzhoM9XU/1ACGg==
X-Google-Smtp-Source: APiQypL19u0/z9DuVTXVMI/bII/PPTpIE2nifYuaVMpC8SHEitAlIHqT2kBz4oUSSnXwGBkt2jhzT/iLc7RO3gaS9Cw=
X-Received: by 2002:aca:170e:: with SMTP id j14mr339204oii.163.1586898952846; 
 Tue, 14 Apr 2020 14:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200414163937.29669-1-pbonzini@redhat.com>
In-Reply-To: <20200414163937.29669-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 22:15:41 +0100
Message-ID: <CAFEAcA_4h=AZ_qVgBQ1mRC8e5ux+ugJearKb907E-qyrdAr=nQ@mail.gmail.com>
Subject: Re: [PULL 0/3] More misc patches for QEMU 5.0-rc3
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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

On Tue, 14 Apr 2020 at 17:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 267514b33ffa3f315adc26fc14d89f92e90840=
f5:
>
>   module: increase dirs array size by one (2020-04-13 02:56:18 -0400)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 9f5a0664187e9411c5c6b7dbd21a1f50922cf698:
>
>   hax: Windows doesn't like posix device names (2020-04-14 10:37:42 -0400=
)
>
> ----------------------------------------------------------------
> Bugfixes, and reworking of the atomics documentation.
>
> ----------------------------------------------------------------
> Igor Mammedov (2):
>       hostmem: set default prealloc_threads to valid value
>       tests: numa: test one backend with prealloc enabled
>
> Volker R=C3=BCmelin (1):
>       hax: Windows doesn't like posix device names


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

