Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63043C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F222173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SqBiYp1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F222173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1ATY-0007OG-3N
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1ALu-0000wN-3f
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1ALs-0006Ek-Ph
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:15:41 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:45728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1ALr-0006E5-Ed
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:15:40 -0400
Received: by mail-ot1-x32d.google.com with SMTP id m24so8853746otp.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MGXWHl1yKY1kGbQZQJt7AKbw5Yr+rE86g0L+SPTbFGQ=;
 b=SqBiYp1RNlXFa7N/zyda+z29KTeeMAs1kyf4yhqeZy+MdXSE248zuLLHZneivOi1Th
 EZqWA7Z+Dldwr1yE59ToxYDDjDX0qQqF8JxeBJDd3UlHhcEhcMTedWbg/2Eck4YQnmBR
 ZW13MdQeph/59ySAePFzEdTnPs5ubFIhma8ISWqfIFYRmQyy2aPRvjkGEDyYLsB22dXP
 UuqRFWYn3R6p1bbQOORCfwLpLsZ7atQW+OjLC8fyA1HDLAfJ27M7UI1E5aSgadnbnL/N
 8f/hASG6JmWRE0yxqdeJnFJ+K7Ci4HRxTOXS+clEz7TAcP2ADXAfWaUmMGwih3kvXnFC
 e7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MGXWHl1yKY1kGbQZQJt7AKbw5Yr+rE86g0L+SPTbFGQ=;
 b=tOTBk7AQn0O69Fv3BWilIX6aN0jrVEvzn6fdMyQtSvVy4g+TpHABb2Y4q/6ACcNpje
 7y1j684lLNQH/DpkvF4iYOCHZmBSeVorGw8FSoKpVt4qhOK9Jvd3Ab4HUW72wHkQ9OF0
 eJKntr/+FwwPdXT+x9x+Zq3ljTUN/JFxm8STBs2xcwZvV+cU2qsmjvir8yRwh1B3I6dB
 uLltvF5kdH668huz9ZOPF56IKfT8TwJ+koJsuUREfN0IZTBLSFS6iv227VZFh18AQPXe
 hCNBBInmMW7CPLDAdkH+OUZZuhRe7X17UMGqXBifvcJVZxMkGAPrSK/IEWgqlQZoVZxI
 zYaA==
X-Gm-Message-State: APjAAAWWaVRu4Jys0em3a/mz0sz7aCw9hBh/7/2FuilwuAFtm2HjiFdb
 DXyioW3H56MTwZHlMU4mcW4UshmP14N8UAafPifxlw==
X-Google-Smtp-Source: APXvYqyjms6QgUkippDwtZ1uz3Cw3DN+T7YsZqyOt7xVSZ4owF8LX7u8HtMcD5FpEbD2iiSzrbMPOHgRJgrQ1bGFS68=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr4518387otp.232.1566569738818; 
 Fri, 23 Aug 2019 07:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190822134725.32479-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190822134725.32479-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 15:15:28 +0100
Message-ID: <CAFEAcA_WMPFDoVJho7M2MzUbn78=k1J64vECaSnf7bS+RvEg-w@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
Subject: Re: [Qemu-devel] [PULL 0/6] Podman patches
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 at 14:47, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 810923480863c43ecb22ae1241562983854393=
39:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2019-08-22 13:13:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/podman-pull-request
>
> for you to fetch changes up to a4eb74a66a0f34d53127e240c1eeae42073bc558:
>
>   test: skip tests if socket_check_protocol_support() failed (2019-08-22 =
17:30:25 +0400)
>
> ----------------------------------------------------------------
> tests/docker: add podman support
>
> ----------------------------------------------------------------

Is there a worthwhile update to make to the "Docker based tests"
section in docs/devel/testing.rst here ? (I haven't looked at
the content of the patches, so just guessing based on commit
subjects and the fact it mentions a new option.)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

