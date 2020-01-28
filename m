Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430A7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D58B214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o88fwNaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D58B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwUMT-0007ic-4W
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iwULi-0006z0-Lc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iwULh-0004QA-41
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:08:26 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:38310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iwULg-0004PS-UA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:08:25 -0500
Received: by mail-oi1-x234.google.com with SMTP id l9so11012543oii.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wmzoqy8k1kzXmOa/zrELDkdQsFfgG9CcwS5D4eS717o=;
 b=o88fwNaAW4J7DSi5BnWVxtEEQWqVZBDOcKBErrorSLf194wJqyml+Gc/HIB0rqNhRf
 p4m5b/SZIebcRLe7SyTn90+wv3j25Dtg15njZUbtUpgK4KVCGLdOtC9Hc6OgXIwGTfYq
 jPZXnMnE6XlsA1pqHU07nOwm83A3Hrpjn6kjdcJ6diRulWZ/cogpucPVyY7/33g6ktBk
 mNF8f57/XfF3MR3Vkth+Zr+Lc0RqxM5zunQi4RAVs8ml0HesGG8blUUnaQyyCgL3q58Y
 kcNWEFLjWvbR81JA0hNv8xRXGfImOF0r2DuNirKY7mE6Tlo00HlWMPke1NinzykO/l6T
 vulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wmzoqy8k1kzXmOa/zrELDkdQsFfgG9CcwS5D4eS717o=;
 b=aeMvzIpA8j9CXJDdgQ5ZNnH32NfLGq9oQotkSXK/hpvzPagrdmLgNrmVkRmm482O5b
 V67asW+V/3b5O9088Zp2SwCiGGRxuAJl/9KD1RGR4sqYtc+i8mjrOx04nTmCQUp39s2f
 q7b4Kh+UkL0KS/Lcx+InSaXyzuJCGhaSuEo1/jQx2r3EgLezS3UrQZ5phox0Q6vd79zp
 OBmiDM7IvQy01kkopdR2oPzeC22OiVRMZi1swcs/RlP/cRNHV9J56Np5aHFTvqVSQCpN
 wWmec8w/0mXhRBM6jtWV2nc17enD8fFGRvIFfUK6BtL+dkgIM2/UL00LS7CpZbZicAlf
 taDw==
X-Gm-Message-State: APjAAAXAfmZlElqOeUnq4+CKCgG5gF1i1R85eft8Ot/aqf3UDvzfYStz
 Qxn4KJUDD58KIuh7B88cZLFiIXqi9ndNtSj1OtI+MQ==
X-Google-Smtp-Source: APXvYqzkKEN+f5bXZD7BDiiatT4qRJoW/GEPRhQ2ci+T0a4vfn4Zy0AQXJJbqaZPSWspjrBKo8xEB3jIc8oes3V84BU=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr3554643oif.163.1580231303773; 
 Tue, 28 Jan 2020 09:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20200127223321.2742-1-quintela@redhat.com>
In-Reply-To: <20200127223321.2742-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2020 17:08:12 +0000
Message-ID: <CAFEAcA-46VVr2sGWEEdxKOCBVxAFZhTJJUiVpVLUO3BTapBu2w@mail.gmail.com>
Subject: Re: [PULL 00/19] 10 next patches
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 at 22:34, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 105b07f1ba462ec48b27e5cb74ddf81c6a79364c:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200127' into staging (2020-01-27 13:02:36 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/10_next-pull-request
>
> for you to fetch changes up to 3189f80ee7b44c968796e63f81c92c915fccdb08:
>
>   migration/compress: compress QEMUFile is not writable (2020-01-27 20:47:24 +0100)
>
> ----------------------------------------------------------------
> Migration pull request
>
> This pull request include:
> - simplify get_qlist (eric)
> - fix null in multifd_send_terminate_threads (zhimin)
> - small fix for compress (wei)
> - migrate multifd + cancel fixes (juan)
> - migrate compression: the bits that are reviewed (juan)
>

Hi -- this passed tests, but half the commits seem to
have incorrectly still got the below-the-'---'-line
remarks in them: could you strip those out and resend,
please?

thanks
-- PMM

