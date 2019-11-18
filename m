Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5275C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B207C21939
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sJpMgtcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B207C21939
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkZU-0003xd-MW
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWkUB-0006ZC-5c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWkU9-0004ZP-Kh
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:06:46 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:46670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWkU9-0004Z2-FT
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:06:45 -0500
Received: by mail-ot1-x332.google.com with SMTP id n23so15124015otr.13
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qvxf8ueA5CJ5Vu/jLl820jIsDj/xmtDSGAs7zi/qLK4=;
 b=sJpMgtcj5X2behjI6a6CZMk2vS65/XKsf/7q1p56T/N2WABUa+HafrV0PESXUe3MHT
 /MRhmJL6jUJ9TGRKCds66fLXkKCl6Jpe9Wtty2vMoah+uLZfQECtZ/uqllDwBesuJcDq
 EeXy5gLJ98Vdq2ccywRnjiAT9d13XD77INRJ2Dg2CRXCUK2JQUKeu7Oea/eyUSjicvb8
 P81OhUnvkHr6y1Alot+CH4OkBBXugNcztCwIq0Jv8IjhbNKvgeSyHQODS2cH04Flj4Jx
 cJ0HcWReZzX4AzyNQjiCbyjveS7FcenF0Sh6otjNKURI0Ns2ABi6rFzhhCRrRTPDZMLl
 Aw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qvxf8ueA5CJ5Vu/jLl820jIsDj/xmtDSGAs7zi/qLK4=;
 b=ldgGtZmgOn3eiLGEuko5Sp8b8CrlgByxmFdAZyOrDPn5u2b2ZvqnXBxh7aX0qwGAE2
 UE4bRjYyQ5nO1hDKvdaRUkg1q3FL1cuuJT3f0uMsRIeqe6pOQODUkyoquY2+akOLSnke
 ii3LBZRJYpVZVJoCXcIZWUTQ3KTJCMFUN9rgrNpUe8nZ4gPwkYl5cRaOpACnpqqikX+Y
 lcJ9ERpnQ64JUtKKf0n6YXMe5PZLqJObNbLPM9/ZIbmXxCDGepDt4ZBnyyXH7FxgDJKP
 KraSktTWbcB+ANAV8+/gKx1S9OmEKYI8bI5ExwMIaJQOE3reCV7QwIRn4WbdG01ak5AG
 ZNOw==
X-Gm-Message-State: APjAAAXGaIFreF9qMCdBCMPbU8U+Aujuph+EkBwRZDn94upyvf2ERDSy
 9ASh502XT+sFY5/zZytskmwPtRTdSWg15jbWO+4i9A==
X-Google-Smtp-Source: APXvYqzwjmDpeUfdCSIVSiPdgsIOptHVjEVgBuhaOKzM7i8IoMv3XX4HmSZt/7QRmTXbiYobx89f17bGA//Y6s4+VFw=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr250500otg.232.1574096804533; 
 Mon, 18 Nov 2019 09:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20191118142407.6040-1-kraxel@redhat.com>
In-Reply-To: <20191118142407.6040-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 17:06:32 +0000
Message-ID: <CAFEAcA_Eg9MmdSiz8biQrckWoCTBBd0PTeeOxNYeWxG=WQY16A@mail.gmail.com>
Subject: Re: [PULL 0/2] Seabios 20191118 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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

On Mon, 18 Nov 2019 at 14:25, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 9f2ce35dfa4ea4a31dbb765dd02bed2500891887:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20191111' into staging (2019-11-11 16:54:16 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-20191118-pull-request
>
> for you to fetch changes up to 0285747737417a7d154ddc3e5adcf1fd665566fd:
>
>   seabios: update to pre-1.13 snapshot again (2019-11-18 15:04:19 +0100)
>
> ----------------------------------------------------------------
> seabios: update to pre-1.13 snapshot again (lchs fixed)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

