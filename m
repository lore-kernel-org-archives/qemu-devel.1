Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE91C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F7620679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+8ecHiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F7620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYcm-00024u-IR
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUYbm-0001ZF-Tz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUYbk-0005Aa-Ol
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:01:34 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:36632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUYbi-00058q-Uh
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:01:32 -0500
Received: by mail-oi1-x22c.google.com with SMTP id j7so15252813oib.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5ymF2OB4TgXN865OozscNvARlVHlepLRjVpi/sX4H1k=;
 b=D+8ecHizUoP9n3DbVloxOVUXNJqzgBzAp0aNVkwZLH3PBJYdAUVo32JFG7eIoBRfTw
 NkMBNrj6IIDtN+bE3tKIbRA6GUO6YOMwg62XxcLl7Ux1LIEdJZKUnQNZ+4qKKtqU+mqN
 gYIZcNLA+Kyfsh4jYL0oyHcl8YzqyV53FSsKKAlgoptEwV7fr2ZyB1713DIsKjN/1Xrb
 OCcdjyZbKDRgJZF47EMen/csyDPQrexzOcBoc+CF5PFfvdknOFWhXaKreyIgV/+L8o+W
 6LwRjsxrodQb/mO5bzS2YoGcooN+Jh7HmlWIB3aD5yKOMRxu50uIehg5+foE+xqZmhsD
 s4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5ymF2OB4TgXN865OozscNvARlVHlepLRjVpi/sX4H1k=;
 b=bvcT0mQ+j+ll9WNU1YK9ZiLRCnnxz9661Ly3WFng0/NmWSPyU/HA7Y5Bd34uwUNELN
 mGrm+QawH8hmFb4zlidCHA9IyfEWrkZOrJrnd4dRUm3yGvIpyQrson+hv18tM5sGA71Y
 6l2LH7gXd/RL0IpxuF5B0VD6NC1GysiTjGITF5tLmuuhQQ6D2zfz4HRoMZWHLI5C2cp2
 rku0Rnkf8BV0q0Ks4WKvGJsafKrOpJ/4tecHTK34r+wFuol1n6z75S0v7oHg4y9k/zsp
 XnUaRUDM7RQT46a9rGOyqr9FtiHALIyVFjhOvcGm9QUFflCe/zJ/JuCkJ1h9iPu0ft3u
 U34w==
X-Gm-Message-State: APjAAAUIsyGkVnS+HxFKHEsvpIXaPwmrUUvl0xp0EIOwFmX5dfumXIAe
 bR0eSQpEcSfSsIIBS+u+dBX0e4JyIPHHjLWPuXvVLA==
X-Google-Smtp-Source: APXvYqwKQu/PIGMHbbB0AcVn520nCzbQ0/mR4WPu9wiFc8B0EnIs4s/Gy3UGhPdK2poHa1bdW/YeKOSamxBlmSAymiY=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr4490165oig.48.1573574486582; 
 Tue, 12 Nov 2019 08:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20191112145028.26386-1-alex.bennee@linaro.org>
In-Reply-To: <20191112145028.26386-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 16:01:15 +0000
Message-ID: <CAFEAcA_9AwoTE9zaKbiF6DkpN+O8LaEKGOct-m5S3yvFBHGK1g@mail.gmail.com>
Subject: Re: [PULL 0/8] testing and tcg plugin api ver
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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

On Tue, 12 Nov 2019 at 14:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 039e285e095c20a88e623b927654b161aaf9d9=
14:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-=
request' into staging (2019-11-12 12:09:19 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-tcg-121119-1
>
> for you to fetch changes up to 3fb356cc86461a14450802e14fa79e8436dbbf31:
>
>   tcg plugins: expose an API version concept (2019-11-12 14:32:55 +0000)
>
> ----------------------------------------------------------------
> Testing and plugins for rc1
>
>   - add plugin API versioning
>   - tests/vm add netbsd autoinstall
>   - disable ipmi-bt-test for non-Linux
>   - single-thread make check


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

PS: just noticed, but shouldn't the plugin-version change
have needed an update to the docs ?

thanks
-- PMM

