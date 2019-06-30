Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7A7C5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 10:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C016720659
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 10:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2b/mc8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C016720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhXTg-0002yU-Lk
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 06:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhXNz-0001Y5-Sd
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhXNy-0002fe-QV
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:48:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhXNv-0002Wz-It
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:48:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so12430475wme.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BZR96Hwa93UJErePYeUQepLKYTaS8LHqJddnHmJaaFo=;
 b=K2b/mc8wN+ax7m1iLfaao5jvx2665dCSIqBr8cB4conoA/H2OyY99RsQZXlHwRsAmE
 RpQYJ+7cExMEBuC0t+U04XkI/emK2RMH61IjT6bK3F5mG5SH23+6CgEeaDT3u48ZviyT
 PLUFGXRTxT7HyazZrsQU6HviKNI3JMN0ql81pwAZAL8rEoAzrdoYIp/mCLNRjE9y45+Y
 03Kl49ZXouUN3tSYk8curG3PPZXwjvfNzIGS53JPWvjCfwv6Um6e81bztBWQBGnjLIPf
 4M5rKxuZVdqK219yJiMWuLGb9Sn2O3Io2Z9ohXdG6/saU4L+5OIm24qlVzMgJ5xbdT3i
 SW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BZR96Hwa93UJErePYeUQepLKYTaS8LHqJddnHmJaaFo=;
 b=O3ln28ZSTACfb1T9Ouhvuggyg5y8SOqh3ZmV2JWg2s40EUQUSNrWvMKvr5Cxx0TsvI
 raMH68KuCMilIn4VeVOj/4sEIyih94/kf/bRsE8xO8owHGBy27ccLIKZMEoEvuJhCrDl
 FyqJBoq6a7yw2DWLo3g8AfofILKuO9nhbbiaDml509CF8h4gw7hD6tH6+eG5RKCQFBnS
 +1ePx/pKh7qL4XT+8U8wTKBpuc35EMztc+IBOuyJG65it8jWxgrDi9z/XDMcHeno9pn+
 B4HXIfc5NzY5n+mYghAPLVASLp9K/1aHnDB1Hq+KzWP7kju37ouV43Eml6NxvrL7dasx
 wCCA==
X-Gm-Message-State: APjAAAWBhROMs9BX1zmslFiX5aenMd648Zu2+LS0aGoBKj5q9FQC9iRk
 x3rd4NJBkbmPX4nYeK0zoWSuog==
X-Google-Smtp-Source: APXvYqzMrCdpnssNyNSK8CnglfI0/PY/PPc/2RCfBu5U8kfTziDquFvkmID1AuToIrYVt6QozSqbuA==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr13059517wme.12.1561891713927; 
 Sun, 30 Jun 2019 03:48:33 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id f190sm7845945wmg.13.2019.06.30.03.48.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Jun 2019 03:48:33 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-5-richard.henderson@linaro.org>
 <CAL1e-=i266juep8-7N1=At680eY3AE-_vyNL_5GO=VRAnH_tig@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1896cde6-ce3a-3aa9-d4ee-c97944374338@linaro.org>
Date: Sun, 30 Jun 2019 12:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i266juep8-7N1=At680eY3AE-_vyNL_5GO=VRAnH_tig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v6 04/16] tcg/ppc: Enable tcg backend
 vector compilation
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
Cc: "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "hsp.cat7@gmail.com" <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/19 11:46 AM, Aleksandar Markovic wrote:
> 
> 
> On Saturday, June 29, 2019, Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     Introduce all of the flags required to enable tcg backend vector support,
>     and a runtime flag to indicate the host supports Altivec instructions.
> 
> 
> If two flags have different purpose and usage, it is better that they
> have different names. (perhaps one of them should have the suffix “_runtime“)

Huh?  They do have different names.  Very different names.

> Also, I am not sure if Altiveec can be reffered as isa, it is a part/extension
> of an isa, so “isa” seems  superfluous here.

It also matches the other existing names, so I'll leave it as is.

> checkpatch warning should also be honored.

It's bogus.

> WARNING: Block comments use a leading /* on a separate line
> #155: FILE: tcg/ppc/tcg-target.inc.c:2842:
> +    if (hwcap & /* PPC_FEATURE_HAS_ALTIVEC -- NOT YET */ 0) {

It's not a block comment; the whole thing is on one line.
I have no idea why it doesn't notice.

In any case, this goes away in patch 13.


r~

