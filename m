Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B1AC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3211E2168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zz4+H1Tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3211E2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GAT-0001s1-C3
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fik-0006lA-HE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fih-0004FJ-BB
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:44:02 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:37904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fih-0004EP-6C
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:43:59 -0500
Received: by mail-oi1-x233.google.com with SMTP id l9so5980198oii.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EdIIquVlaVgo7mfHphD5U2ozy7v+DidNu+vhtIOws3E=;
 b=Zz4+H1TfLznN3DK2tgOJ9IDkR5ZZDeIvxXejM1kI71oMEfADSi/jw1gWDdLHGbvUmu
 o+pM0NaEUEGEI5XA9zWUtlBX7RA6Kp1HJazW7UPp7OxPyod+ZgKUDvZdb8Y0Q3s53WYp
 DG5cCgLl+K+G4J4DGU7pdLlm2jcTZzpj1AfQclFx/Z/+mm3gXSyuqezqzArhzeSHCCMF
 6Hs36gmZbgKmr9KO08FIqajJ0+OOYXL4kfaj2FckTWN2Na9RzyBRiXKO5Uck/qUFqjVR
 RZ1mSNbbJw/AFke7z23sZWTgCVzCKfmCL3+QACoZjfQWCUkGjTx4uJUQawS2RdyH9BqJ
 XBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EdIIquVlaVgo7mfHphD5U2ozy7v+DidNu+vhtIOws3E=;
 b=F/zzRlT0WBe9G8JQBUYaFrUpCH2siORpiJ4XCOcWQiVdSYouw8KCEiyJIJqQlrMOn8
 QMl9NwpylH9x+TpzwdviZ1vtBmeuGgh8qKKK5oobkJkvVlWoolEvfjsAcBRyQIDvTO1/
 d08WGeeAV1gkVRTHv9M/+SEnhutuBWqnVcbIPxztNv2HQFe3+8y2BcFKWCMJUFvh1sa6
 r3Bo4xB70lAvh5oZ/9XgFTEiUiXBGe1HkYF6T0DuIF4LOMv0dvLGRmREFHxjNo8n3s1n
 Jb45G754l+mh7d/eBfDdeICe6OQfId87iuBkO/jVFBzHn5pZ6FGHFcLdjJAQVsG5bsyi
 qgzw==
X-Gm-Message-State: APjAAAVBuNf49m33AhiA0MaFRCaMjh/sPOqP6xR4DwoqEf1c8r9zmPJA
 n0VCVV0xA5dnh7fcpFfkx3HRKD0wQp1aoYzUO7y0Qg==
X-Google-Smtp-Source: APXvYqwb1oN/l3zFh6SI6rBjG6+bFZ0asq2bMn5UB7AczGf2TYkDqlQ4KcWUNdth/aQWHBlm/TIFAVI/Ka4ctyl6QTE=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3193911oiy.170.1581605038229; 
 Thu, 13 Feb 2020 06:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20200212164129.6968-1-pbonzini@redhat.com>
In-Reply-To: <20200212164129.6968-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 14:43:47 +0000
Message-ID: <CAFEAcA9KtOc+iUHsO_xxnK-EC9zemKRj=at6+JfVCd3r9znuFA@mail.gmail.com>
Subject: Re: [PULL 0/9] Mini misc patches queue for 2020-02-12
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Feb 2020 at 16:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-02-04' into staging (2020-02-04 16:12:31 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to be02cda3afde60d219786e23c3f8edb53aec8e17:
>
>   target/i386: enable monitor and ucode revision with -cpu max (2020-02-12 16:29:51 +0100)
>
> ----------------------------------------------------------------
> * various small fixes and cleanups
> * fixes for the ucode revision patch from the previous pull request
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

