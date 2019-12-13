Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E12C2D0CC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257B924680
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrbyF+8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257B924680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifpRz-0000lJ-GU
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 13:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ifpQp-0008RT-PG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 13:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ifpQn-0005T8-T2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 13:12:51 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ifpQn-0005Rf-Kc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 13:12:49 -0500
Received: by mail-oi1-x242.google.com with SMTP id k196so1589545oib.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 10:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2BZH+J6X7Kio36ibcIi9b2fHG77taCK5szwxqioQIVA=;
 b=lrbyF+8+BPPsljUC7cxabD5DiEsts+/9QjAg6EvNRbvUt6HmjBZAS0lc9eth/0cxgm
 9Uie35wwRCrHX1oXT2zFLSOxDUV/Bi91kZySe4d4qHXXt+fIZzpIM+mDV+7/WUiewOh9
 7C+7OlaU15WOIpkEGz/Igmzc968rvvHPPzaMp9EOyUWjz9q2T4vf6Un+RvfaDecQp9aT
 F9USsQNYl5FAhZZQAwWy2kbSCM7wxsBRBUnRZAgDNuvlao1waJKV3ZQ1lprZVhdwPdZr
 YMthq652w1H0UaLa31IIC+zoT4XDs5tOFEorZXneQtAudoqxL3cjCI9iEzUTvX3ApKfh
 EARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2BZH+J6X7Kio36ibcIi9b2fHG77taCK5szwxqioQIVA=;
 b=QWevfIxb7E2IsN+6Gy+3JxEOJQrPEPp4SBIBbSzlq63RrEI5OviFuJ+AK9R22RQyhZ
 2qpWcbh1UUQwLtt3QC2/RxLctB+kOxmHM0QOtKwveO4Xyaknle0368sPHE3slqEc5azV
 6umwgMdfmQBGN2yHclvipZOs4L8DCqH3RFqqoCa+IWZy4PRBJJeNHEzd6YoK2vVDjCLF
 8tDUSpxk+ECrm/FkhEdKO0V+tD7mskOQxkAC7PfL1mBwuPT008KhfWCQDPQ7LnlLnySA
 gD+9h5GEWu210OOEns0hs+A6SmCYfZJj8/+IOv7LzxtbdRFf4ZIpSdk82UvI1U2T663B
 tDsw==
X-Gm-Message-State: APjAAAVOa+wcakh/hwbUxArAH7htdL1FSAHv+L+M8FkJnVmEiL+AKATK
 7Bf8nixJ42Tog9IZklOFiowLEr1buYoiMqXDg3k4uA==
X-Google-Smtp-Source: APXvYqy4EV7S8u8b/1p80WJk4O2e5ylS939wXOmkmCb/lzCBQz88+s2lgzdr85OFEcR4X2xBNeDSYeFeqe2H2tzYDtI=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr7139423oic.146.1576260768467; 
 Fri, 13 Dec 2019 10:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20191213115822.77260-1-dgilbert@redhat.com>
In-Reply-To: <20191213115822.77260-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2019 18:12:37 +0000
Message-ID: <CAFEAcA8KFcKkqJDu=jtGpZ_cXwJ0Zx0orsZUP3xcPXtihdKByQ@mail.gmail.com>
Subject: Re: [PULL 0/2] virtiofs queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Dec 2019 at 11:59, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit b0ca999a43a22b38158a222233d3f5881648bb=
4f:
>
>   Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-virtiofs-20191213a
>
> for you to fetch changes up to 366844f3d1329c6423dd752891a28ccb3ee8fddd:
>
>   virtio-fs: fix MSI-X nvectors calculation (2019-12-13 10:53:57 +0000)
>
> ----------------------------------------------------------------
> virtiofs pull 2019-12-13: Minor fixes and cleanups
>
> Cleanup from Marc-Andr=C3=A9 and MSI-X fix from Stefan.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

