Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA54C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 17:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E742183F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 17:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXEfOklZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E742183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53499 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG5G8-0008Aa-8D
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 13:19:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG5FH-0007r7-GF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG5FG-0007OJ-GF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:18:15 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hG5FG-0007Nf-8Q
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:18:14 -0400
Received: by mail-ot1-x343.google.com with SMTP id f10so15124870otb.6
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=gMFiX6PzL15kYqCql+x2Gi3I8XkUDj+6YepP2aqWpDQ=;
	b=zXEfOklZR9zfV56Y+wVx6O2119StHIl0dDWce+zOclgG73vcCcMjpveHANmKFm7Vwu
	BbDURE8JQ7Z07jUDuLefy1XmC26lpUiKv/3Dr8+TxuGAQNXLnexB/NWZe+DlqZjspwmX
	5+nE1gOYAcFzhXLl1r5QBz0p6Yoe5ZcbS6K9WRJvS1L0KQLbG/w5nHKN3kh8LAsCj9Zl
	rRbzxdmVa5r8GyBtBnmh0SblXrqzQ1atWUe65U988AHjX9hC1crN+OYrdoU6TU/HDlpe
	0TjHjvxUG0bPGsEnybINgVOpEEraJ/7wnT+lqTmHPbmfeXZX6jl4UP04lMPW4D+wIWHb
	88aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=gMFiX6PzL15kYqCql+x2Gi3I8XkUDj+6YepP2aqWpDQ=;
	b=oPdAi50PdoTiC2TJf/TinAe+VYIMH2myjGPHg8F6YhBijZMuL8PuIKGvl3deq19a2T
	stCv618Y5He8eIXDFCTQ5RO2AZstLYIebb7jNTjuvplJbNaG7TrSXBSo0wpzk6nhTYvt
	fxwufEzQqlu954ehUpjcQEQ9lOz9Ox0KKTMvHkGXDde9Esgq9YBnUQmXyhIactAcTale
	0oOSkmFGzZuE8H1ltzWBPoXDCCm8IJEla5s66ZxcAQ8PwaGWwMySG0DA16XkOsHNBRCt
	eY1tzTnbktWK1zT2R2B1exqJeUu203vCilsZiwnRz/1tlPNRc0+Xoy66KGzW4WlMjH0X
	//Lg==
X-Gm-Message-State: APjAAAWMByeNihNi5trctv5W2PQtNh9PcTC7CwV+go4lyH8eq6UiRx8r
	WXeljbAlDa/tvd/nXmoGGZL61aXyw7pdqV8cYdWKPw==
X-Google-Smtp-Source: APXvYqyujsMBbqPYlikA3Rsu8qUC22FvagrysXLulpdFFtVSasg1jOctX1Y0DWXV+4kLdZHp/w/K2zIKoMVFc8QOeNI=
X-Received: by 2002:a05:6830:1cb:: with SMTP id
	r11mr42195499ota.302.1555348693157; 
	Mon, 15 Apr 2019 10:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190415154503.6758-1-berrange@redhat.com>
	<83042152-1af4-a237-92a1-f56841623e89@redhat.com>
In-Reply-To: <83042152-1af4-a237-92a1-f56841623e89@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2019 18:18:01 +0100
Message-ID:
 <CAFEAcA9ndqdFv8hkMhjVudbajTDLZtcu7rpSdR5OFiqiJtp1bg@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.0? 0/3] usb-mtp: fix ObjectInfo
 request handling
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Greg Kurz <groug@kaod.org>, Bandan Das <bsd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415171801.oHO21RNffjd2OZBv48moNcpxORx9Ptpr_GKOBCPesJ4@z>

On Mon, 15 Apr 2019 at 18:10, Eric Blake <eblake@redhat.com> wrote:
> On 4/15/19 10:45 AM, Daniel P. Berrang=C3=A9 wrote:
> > The 2nd patch in this series is a security flaw fix since the
> > code was not correctly validating guest provided data length.
>
> Given that this is a security flaw, I've added this series to
> https://wiki.qemu.org/Planning/4.0 in case you're hoping to get it in -rc=
4.

What are the consequences of the flaw ? IIRC it's only one
extra byte read?

thanks
-- PMM

