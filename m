Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B038C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A4424A8C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSKAosxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A4424A8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrcB-0005Gg-F6
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:23:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXrXe-0001pj-BG
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXrXd-0001fz-B0
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:18:42 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hXrXd-0001ea-4v
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:18:41 -0400
Received: by mail-oi1-x236.google.com with SMTP id 203so13533795oid.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=WKJWUawff5Jn/35B6H8lKXVx2tuTsRt1smNkaOMSrlU=;
	b=eSKAosxLBF/kq948kqdV0M4E9toDgOkd7L2OKyOiVPaChdtK1370KDSeInDmBnRgRn
	8lmFkscs+XLfUwZ6m8r2jCE/ZpwmN7Ywy+HcPPziY+TO18ZDoppgbvPLq6HNAtd8kgjj
	NKmmHhb/6IL47mVHohfmA5r6tJNRqkuPVisMQwwKOIZbPcoyQgqosV0BJVWs/7+mNEJk
	iZzNIbc+px1CslUDohpgQRVhEE4+IJ8ybMQNZ7PVizZGtlBor1TpSelxDgWxVQDQXtx6
	fa28LUe7xIW6pcDvQuWNY/lgHHMNkoqNPb73lh11OwIt8vfnTGodrYc5+XCto/vaeh8Y
	UwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=WKJWUawff5Jn/35B6H8lKXVx2tuTsRt1smNkaOMSrlU=;
	b=pQ7pdMbanRkZDTWvnyOBjlwtJYx77aWvUjIuV7ULjUbmlVQc4YxfRhkCIGLfzuqHOm
	KYqxZMkzJrNolPCWYi2rI5jckwfgY1TGzA6bQ+S/6ZoVFMIxgKX++zqKOa/avYpV3UMs
	11HnZkfG2e6PJOf8IPXqzpi2kD2DJLZ9T1LnVyYdk0BMPqu0XMmx9FpaZIb4BduKJW4p
	KAcaX1C987N6vuxuAcakxF2nqQUkFNJ6CNU17Yr8pctVC8p/EnwuDS44yENJIlo03eyz
	Q0hVzxaqPctXKjAebb6xIv0+65Lb8NiLYqV5ZHtWy9JUhCnCGJxuXODhDT4vjrs/lkoQ
	GPFg==
X-Gm-Message-State: APjAAAWBrD0ob4m0IHXShi6hk8MdlYhpv6teD0MycJEJAYaglKesoPOd
	I8LXhd3Y32F2Nte6BwOjsshvg2gg82gYRIK4QdJ0LA==
X-Google-Smtp-Source: APXvYqyjSUVpIWMgD8ojD1xnJpHVzBRl8/vci56HRqsNHn4ooxfAbBFrNM3YO9r/yFX5Ci36Nq4DgG4Y8hAbpd/0BrU=
X-Received: by 2002:aca:6cc1:: with SMTP id h184mr1924214oic.170.1559585920220;
	Mon, 03 Jun 2019 11:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2019 19:18:29 +0100
Message-ID: <CAFEAcA_D1RvZ2FuOZkXx_8fYFzkSUsG+sjLptgaFfuxuiYPsmA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL 00/24] Misc patches for 2019-06-03
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Jun 2019 at 18:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit ad88e4252f09c2956b99c90de39e95bab2e8e7=
af:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-1-2=
019' into staging (2019-06-03 10:25:12 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to c87759ce876a7a0b17c2bf4f0b964bd51f0ee871:
>
>   q35: Revert to kernel irqchip (2019-06-03 14:03:03 +0200)
>
> ----------------------------------------------------------------
> * Revert q35 to kernel irqchip (Alex)
> * edu device fixes (Li Qiang)
> * cleanups (Marc-Andr=C3=A9, Peter)
> * Improvements to -accel help
> * Better support for IA32_MISC_ENABLE MSR (Wanpeng)
> * I2C test conversion to qgraph (Paolo)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

