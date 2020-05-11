Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB75C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438F120735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKZcWQcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438F120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY666-00048Q-Fe
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY65J-0003bu-8f
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:54:57 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY65H-0002Hw-5i
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:54:56 -0400
Received: by mail-oi1-x243.google.com with SMTP id b18so14692627oic.6
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QjaTUArLqqwGoWa/w8L2qR728XtmXgTP5JiymM5u3wY=;
 b=SKZcWQcHnSXpnDa/lTWWyOQ9hVDjzBBUtZVkr36MY4+dFSoqIPzJ1rmRJW1VqEo7Ha
 XBcy9YX8p5WBMLT//m3GvKrrIfPJUFh+bQaE7jtRKP/LhQt4TI5CaIHBLotnubulAKKh
 UcMJEbKyGqA//SuPMFwpxSHvflJsoHlH0jzexEZjCBrZv3ZBv+AO23erAlXqwRe7tsNY
 QiRuaXlFrpY3vcL5RQg6XUcoZgYOfnAnHwEyxbfu7wjD0rCTiQmvNOk80yRyraieBb8u
 p64vlY0A/cq9SWKXF4ino5KMdaE2oDhivl0qqXYtURvBSkXc2+//t/SmZh0KpSpcigBk
 5xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QjaTUArLqqwGoWa/w8L2qR728XtmXgTP5JiymM5u3wY=;
 b=kkXPqscu/yr1Qe6vKzsiZ2PHEmBNoldMm+aJXvdxFzIKKNj1SQoEidcYDsYHh2c+Hw
 raOdLQ5DSeXYRK69VNrjUMFsrT48H/fW2WuZFr0lmtV5UnjE6rEiCR59nOTz9JmNw4n8
 8haTV4qvbNol6srYOw46sYcCkFYNq8LemQlrcUbhYqns7VGHz0l7wym/2VXwxpMRBps2
 12ANAxZo8rWYuvVdNHWMxAEiGE5+1Mx77XLsoRgJIfYHwHCzpE0frhhXuEOUbS5lBZAo
 1LDvbUkjsxpqaNfsKCX+N9K6JqbF9T7Gtqcz8iP+zkm5lHnpyJIXr6FvPlB6gm02gzbT
 S+Ow==
X-Gm-Message-State: AGi0PubNxN/QLvRpywnw5TbuUio8OnJFP2ks/IIVn9u3RwqzDyvCNSbX
 7AGHyUrlNElXGP8SUXV+DH42b9mx5lsJONfNMIr73g==
X-Google-Smtp-Source: APiQypLFthu4QgZlPiyAVnhmYsH7llx9Uq4jNPwPYnSdHGoXnXB9SWbhaqvegLpV/hH0bMWWKg0UhNsVC39pzWK0ZAk=
X-Received: by 2002:a54:400c:: with SMTP id x12mr18504395oie.146.1589194493404; 
 Mon, 11 May 2020 03:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200506173035.2154053-1-patrick@stwcx.xyz>
 <20200506183219.2166987-1-patrick@stwcx.xyz>
In-Reply-To: <20200506183219.2166987-1-patrick@stwcx.xyz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 11:54:42 +0100
Message-ID: <CAFEAcA8RMhq3aZcqzqFkaWCkwkzfptxAyAogEEg+BcqNU1BquA@mail.gmail.com>
Subject: Re: [PATCH v3] aspeed: Add support for the sonorapass-bmc board
To: Patrick Williams <patrick@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Amithash Prasad <amithash@fb.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 May 2020 at 19:32, Patrick Williams <patrick@stwcx.xyz> wrote:
>
> Sonora Pass is a 2 socket x86 motherboard designed by Facebook
> and supported by OpenBMC.  Strapping configuration was obtained
> from hardware and i2c configuration is based on dts found at:
>
> https://github.com/facebook/openbmc-linux/blob/1633c87b8ba7c162095787c988=
979b748ba65dc8/arch/arm/boot/dts/aspeed-bmc-facebook-sonorapass.dts
>
> Booted a test image of http://github.com/facebook/openbmc to login
> prompt.
>
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> Reviewed-by: Amithash Prasad <amithash@fb.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Looking up through the thread I can't find the email where
Amithash gave his reviewed-by tag -- did I miss it?

PS: for the future, v2/v3 etc patches should be sent as
fresh emails, not as followups/replies to the v1.

thanks
-- PMM

