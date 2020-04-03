Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608F5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE5C2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKgDhWf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE5C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNLk-0005z1-NI
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKNKp-0004vd-Fd
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKNKn-0008KQ-An
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:30:14 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKNKl-0008AE-KJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:30:12 -0400
Received: by mail-oi1-x230.google.com with SMTP id l22so6191500oii.12
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e5yU0lW4ZFb8OqVCgMorUOPRAWFHRZbxYVR3j7F2LVM=;
 b=eKgDhWf0BC2dBb0nZ6ZiiIIIRZDPfH4e12YMqxFDLA143t13hdvQPYziUkbrTygnFV
 RPT7k0mM2/I94jSNceVG1U8CRTOPD9bV3MQGUc75pRG8ahc2XOHJPqErkjxM2FRoqhXE
 zyY975fF5dAvoZBdkXunzg98ZZcCrcyFs7goSXzHSXkJV/wepEXGz9SZQwMvQxrn5vLh
 dx8FJQ8P8jLjN4iPUChuxfZPJQ0/hbHrpBm4+PPaW5PjHf6AczpeLmXPeMAEmUMX2uR7
 r2sdLdA98TasL5DgLhlfuU/4Kx0TcOsm5pHS8jin1Z50jZJy6IWGX8i5ajXxINxIfiN0
 Vfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e5yU0lW4ZFb8OqVCgMorUOPRAWFHRZbxYVR3j7F2LVM=;
 b=Fx0Zqiju2s3YfZ/B4FBH0jqZ7v23EJ2C4pY+HU3WmQ4Qo6xYl1xSub82g9r51hR7jj
 bbVDNLa7y4c90GMo+LVDt65vocoy9HWvgTSR4MI9SC7cg8+X2fS8EcTwVjZGLjazsKEy
 niiOhwO+VD/OcyGZ8x0yxUygKTu2gN7/qvVhH9Bmi9wTazRA9il7vj8C/XRk0f/mJLq+
 iwUk+kuSCnnGuRGBvMfwXsQWZ4FXlzX81i3WNyU7T6742wIhAKHLBpp0UmmmBG9zotYQ
 WhOzHNg+teCoLXNpro/wnqt2kySiv4ltk69FZTAmWmSsbfVwYGiUqwU46ul9mVOeJjgQ
 4sMw==
X-Gm-Message-State: AGi0Pub/2OC5IqErB+Wv2KDOoTwp28z0q94tvpp7gG6Ebz3t/vALcCpP
 5HQjfHRZt5atnM8V/pEZVWzZox7BjNOeqlrawKx60Q==
X-Google-Smtp-Source: APiQypLcv8C10Mm228qurRyu30mm5CONh8CXFxJKQR/qzbsZW+8J6WCITt5/MCBMPWrH6C4+y1pLE9geqFfP8nPuzt4=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr3001670oij.48.1585924209436; 
 Fri, 03 Apr 2020 07:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200403092553.25803-1-cohuck@redhat.com>
In-Reply-To: <20200403092553.25803-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 15:29:58 +0100
Message-ID: <CAFEAcA8Y9Qbo_er1STfV0U2P-DW2KoEomx4Pv98VK9MXAJEpKA@mail.gmail.com>
Subject: Re: [PULL for-5.0 0/2] s390x fixes for -rc2
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 10:26, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 2833ad487cfff7dc33703e4731b75facde1c561e:
>
>   Update version for v5.0.0-rc1 release (2020-03-31 18:02:47 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20200403
>
> for you to fetch changes up to 5c30ef937f522a65df78dd9f496483fe4fc44d5e:
>
>   vl/s390x: fixup ram sizes for compat machines (2020-04-02 17:10:09 +0200)
>
> ----------------------------------------------------------------
> - fix cpu number reporting in the stsi 3.2.2 block for kvm
> - fix migration for old machines with odd ram sizes
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

