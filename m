Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C7C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37A120881
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjj8fIyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37A120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRa7Y-0007Yx-Rg
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:29:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRa5i-0006HC-D4
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRa2E-0005Yf-8s
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:24:19 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRa2E-0005YC-2c
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:24:18 -0400
Received: by mail-ot1-x342.google.com with SMTP id i2so892926otr.9
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zq+M/vj/EtUDR8Mf56FK00//ETR1jcsL25mj8EgpdQk=;
	b=wjj8fIydwOiAP427QUwm1z2EXlTf+YJWeoHFv49ARkcA9E1ytEg3ktjWzgs0rJv5f0
	qH2KmCRzQQMuP5jJ3S+AZNw51V6VzhyjrevGjYw6Bo/0wudHU/+nremeL74efo4xr91g
	cwqvHItANhAYE7OAWiUNuQYUvy+HEWmgGuskTupVkDkJ6Et7sw4VWBrDljoBdcZswGzw
	h8M9e7DY2g1FqbFlDMaSR1emlT9dg01p5fcsD6JfRy5q4l/FF5T2uoZXpNYgAkZOU7ke
	GTd5vp8w81GnMoVNVjT0+YSvVDY9endiXQxYLMsQOytkY5KNoUtsWythzk36um3c51g0
	k2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=zq+M/vj/EtUDR8Mf56FK00//ETR1jcsL25mj8EgpdQk=;
	b=CzUnDgyFvOkM4FRTdz3EHxhvgW2zGWU37P13RUwKWDhy0JstMGcoEZDaswDa5UZvoY
	ZXDE/kBMyvitJir+2vGXRmLTkusxwVTH6eEHbwx/i+NibWZiUpnxvfa+cB6XZw0A0Mtq
	/P6gjHs6Ivv6CDMYLJaioaRKRlTRf0yzCiXTTaZ+32IaahkX0//PD3jzddGkVA62k7J9
	KRb+QsWHIeKMUk/PBm5bMe5/q4X99L7b/3q0ulqyiYvTNPmRXXDqWmYaH+r20pgD8x1o
	ChXtOBVypU2m06jwOKqEtAgBJJcqGv8CX5CK3A5jnMHuYDqcrs4/b9hsUzRBrHq1BOGU
	zdXQ==
X-Gm-Message-State: APjAAAXb5ABAGwKjGfMg7mF5nP6ooV4Fpf0KJMoHJrShbptZQFfm8iZI
	8Ou9HO5Qbh0NTGn/HlJT5DrYm9f/6OXICU7lTFybGg==
X-Google-Smtp-Source: APXvYqxYYFR7oIomrbPkMfN1IKoIBvjPD4bmAl9eunz6x+f1uVg7R50V7uuE6BMU1hdVlMev3a9yhGhdD8q5CNykZpA=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr4642933otq.221.1558088657287; 
	Fri, 17 May 2019 03:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190516223519.7520-1-laurent@vivier.eu>
In-Reply-To: <20190516223519.7520-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 May 2019 11:24:06 +0100
Message-ID: <CAFEAcA9Jj6BtS_18K0QPS0FGpqrAJbm9L094BVCfBD08w5w23g@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 0/6] M68k staging patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 May 2019 at 23:37, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit c1497fba36465d0259d4d04f2bf09ea59ed42680:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20190514b' into staging (2019-05-16 10:24:08 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-staging-pull-request
>
> for you to fetch changes up to 60d3d0cfeb1658d2827d6a4f0df27252bb36baba:
>
>   target/m68k: Optimize rotate_x() using extract_i32() (2019-05-17 00:30:47 +0200)
>
> ----------------------------------------------------------------
> code cleanup, switch to transaction_failed hook
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

