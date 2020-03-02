Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98554C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E6B2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfg6gN3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E6B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8oqG-0003xV-KO
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8opM-0003R1-ET
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8opL-0003kn-9B
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:26:00 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:41122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8opL-0003kP-3e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:25:59 -0500
Received: by mail-oi1-x22c.google.com with SMTP id i1so11065876oie.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SgdpCcTiKlyKL4criCSyV8KA0Qd6Nz24zaPAxKXITcQ=;
 b=cfg6gN3YxhHnMk9nNTau9BBPsHYm5esqqeg1wGbDe7KF3yL+PSYTQUEpTKAl9iQCJP
 SOF4jyolE3mIvaSUcoy6399OuhuOdPwYPjTSDoMtuebigTK+TClHa0XFbT+zlGChb6eT
 IxNBhjEZFMoWwuP823p9Nuv13F5OiDQXg1DOrZD7nNfWcT9+JFiJc1z9VusXXgwx0HoA
 zpgMAZWVrsE3r2/usUyiDM+7/kn6SruYESrswdP9FeQ/2sSbEwTns3BriE+3Dqxa3qEM
 5iHZPag8GjUEXbxoPM3gqdAnrKPh72KTHTdb4gQWeEx3+FqVeigHu5APazsT4HAx4gwk
 82UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SgdpCcTiKlyKL4criCSyV8KA0Qd6Nz24zaPAxKXITcQ=;
 b=RKMUG+n6GcmypypK3VkEY4kzHStxZZM3HeUf+ulwvlCeuCknL6O/0InDq/AUPlaLQl
 hr8rXOsGF+g+x4l5NI8x57nFEb3lt+QvlYuYhdIz8BPU4z/FNK/Kr6kEKhEHcP6tI49x
 aHPpEI93P6EsAuAHLvRogwb01p5oaHD4RT+bmFrf30UxHQ5nd+rC63ZQgBrVRHXZjjcA
 1YLEAo+LzwNw+sLQSRYvd/tSeR4AvOzADikdV7FopoegQvyjewbltz/WXGvaDKNTQsUc
 i1PPiywUWoY12tHuIcpxrHfxSvxmAHZ9dWsC6OyUW2lv15QLOnHgFvyo/5TX+oxWI2jw
 hQxQ==
X-Gm-Message-State: ANhLgQ3NTraWy4pSopxIaQbpzdXKGDqpin2Y8njttWJW3yDe99WiHWNZ
 fits31o/tunDFK9QYGfMuVUnFNTK6w7y+ODPMEi4hm6x
X-Google-Smtp-Source: ADFU+vtyuN1AKkzpgY0Bi8VBs4ox/TpeWwiyVYgva5Gvwbw3UTriJjVu3guSQwaDEFIMVveDFiGOxMsWgzPK+bhSbds=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr119892oie.146.1583169957939; 
 Mon, 02 Mar 2020 09:25:57 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
In-Reply-To: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 17:25:46 +0000
Message-ID: <CAFEAcA_nmP9iUyw0oO=QJjC-EhN-6NNjx6k+nynsujaG=bdn=w@mail.gmail.com>
Subject: Re: CPU reset vs DeviceState reset
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Doh, I meant to cc Eduardo and Marcel but forgot...

On Mon, 2 Mar 2020 at 17:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; I've just noticed that although TYPE_CPU is a subclass of
> TYPE_DEVICE, it seems to implement its own reset method
> ('reset' field in CPUClass struct) rather than just using the
> DeviceClass's 'reset'.
>
> Is there a reason for doing this, or is it just historical legacy
> from TYPE_CPU originally not being a subclass of TYPE_DEVICE?
>
> I ask because I'd like to be able to use 3-phase reset in the Arm
> CPU, and I'm wondering whether it would be better to make TYPE_CPU
> just use Device's reset system, or to treat TYPE_CPU as its own
> base class and implement Resettable there. The former seems more
> straightforward, unless I'm missing something that means we
> really do need to have the reset method be different.
>
> thanks
> -- PMM

