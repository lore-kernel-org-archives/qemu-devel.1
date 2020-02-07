Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0717DC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB250214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaVdN8qs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB250214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07yx-0006B4-Vo
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 13:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j07xp-0005MZ-RZ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j07xo-0003zo-Me
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:02:49 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j07xo-0003zM-Hj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:02:48 -0500
Received: by mail-oi1-x241.google.com with SMTP id b18so2849594oie.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 10:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rCMPddFd7BByknka/WYzhaJo2Jnzdjxi2TxULxfQ4A0=;
 b=EaVdN8qshXKZvWoP15B71TgNFQxVXFWF1kcAkTIBiiW4Mr67BgjGOf3vmKU+/fasBR
 Cdhq6BtTafyX4hxvUapEVtfR7vwbvC82tC5yWInrgSFKNe72Dcp7CRNYVSHasI5UUYSA
 scb12CEkPa16A4oWtBAr7eaW5gb8gIMwDzaa1VSmIP8rxLmz1naJj58LEnJ3bEmdbkg/
 bK90FGHZhWzr2PZC7ggXK0jlhru0JDooboAWkjhS6OzoEN6Uw+cdkgG89vGjc+gNCsqm
 OEVbS+S9VoDnByGCtLks3Q+RGU26AmtlAMeoNoZ79M2e+GHiz2DDO4L22WliyBcNRt0C
 KeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rCMPddFd7BByknka/WYzhaJo2Jnzdjxi2TxULxfQ4A0=;
 b=lNxh/F5VkY5aQZou90GRTSQJa4hFOtDvSQRn9mbH0mNfjMp11CLfGIgvuju/NwR/pA
 bi4/03Mi9olqFe5nbkYh78WdD40TWTdrf2sF4vHOESzmm0fvz1p1SUUfRStKCL/KDt2v
 m+S8fME5r012SVHDpx5E9Xvq9+i4nrXjOEmIfQLA7njw9kpb/kGch9xB8xHeLl8Qg4Hd
 FwGBBfm1JQpFl2+SJkigFBiESLj2EZGEbps35hZFB7ysrlcneKzfsrcTmy+RftpDCNBd
 Fl43gZld9Rs9ZuX84VEjGNYirFnLCnQ9BkMHirf2xSiK2jxqSutgTjTexF3CEyzRbeHi
 NxPg==
X-Gm-Message-State: APjAAAU8L8JUata870rGtUd6bTJLaiUrU57HvZulCWTOwsitjh4uKnAw
 jw3kTgiyulYeyieH128s5UJFVeSqbENJAev+FJTzn5LH
X-Google-Smtp-Source: APXvYqxZI1Hn+XKFrqak2PTLzdRR4wKtFOQBW46BjOqAQAkxhZ1gP4UvMdqoAlwTbt1wLzQ1Rfo1aFP+vqdvWS8892o=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2909609oif.163.1581098567658; 
 Fri, 07 Feb 2020 10:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20200207122440.2650229-1-berrange@redhat.com>
In-Reply-To: <20200207122440.2650229-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 18:02:36 +0000
Message-ID: <CAFEAcA__WE-tkKKC6j5JJN=+ZctF9zqpq=N45dXkMCeydnNOtA@mail.gmail.com>
Subject: Re: [PULL 0/3] Misc patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Fri, 7 Feb 2020 at 12:25, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The following changes since commit 5b7686f3fa2092d2b3be92df67b5966ee1b014=
2a:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2020-02-06' i=
nto staging (2020-02-06 18:59:12 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/misc-fixes-pull-request
>
> for you to fetch changes up to 416b71906edfcf280ef31d0e5e607898330b6271:
>
>   docs: stop documenting the e1000 NIC model as the default (2020-02-07 1=
2:22:19 +0000)
>
> ----------------------------------------------------------------
>
> * Use correct constants for 'bool' type
> * Fix compatibility with noVNC in websocket impl
> * Remove inaccurate docs aout default NIC model
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

