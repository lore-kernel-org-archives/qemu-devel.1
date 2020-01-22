Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A2AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 00:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E617321734
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 00:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMuI2fAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E617321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu3h0-0006ct-2E
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 19:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu3gH-00068c-IK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 19:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu3gG-0004Ug-BK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 19:15:37 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu3gG-0004Sz-49
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 19:15:36 -0500
Received: by mail-pj1-x1042.google.com with SMTP id bg7so2451001pjb.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 16:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JP2A2A+YwbCKbxa2Lfh+e4kBFhR2R3kmpg0TJ84tCqA=;
 b=ZMuI2fAUGh6ngLzN8F7QHnAjMVQG5VGIdbw5cOROcJ7RzofrXZkCjClddU5wCBCOT5
 QGNV3602dVQOq0im60oeoCoJk65YVeGaTnUAyNlOxdaHzdlMqkuJI8KbGU4BCuUQCP/B
 I/cdOB4LEs0xnRdKkc41kVY+L+bTMfOtPj1cvOwxDZX3S3bp9cM5hXnY3nd6jD37uGxX
 9G8ZP11R+u5Oa0cG6rp7KfZv5m30QqPPy1KZNEC5Iq/cbyTQ3b4r5oPhTLKCijnTr7gC
 LD1jvL4WJbrdPUDhsHbGCTYO6O8jcEF1KJnJZywB+VUi5lbrBIBTOWT93cBdflvteyWs
 cceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JP2A2A+YwbCKbxa2Lfh+e4kBFhR2R3kmpg0TJ84tCqA=;
 b=Tzw8zO6P21TzSbeTB1AWSmcDAMy5F+KXqW+ZkgAxF7m03Wd4QCwMDN+zgujScjN5y3
 FOht9h7+L33lTH6YehcrG+d1A6wLLZ2XWKB05V3DB2+N40Y5eJTyk7uvrArjsR4tXy9m
 XPuz1Ivi9Bw+Svxnlz8s6oP6v1E2MNAY8PrDbggO2DKzUO1sgbyyLjMFMKcuIvBQA9j1
 PyrzsFRlBiDi4sF76dUHyL3EwadGJMP5epk/n8ECGKDm80rZnP9s8sVLjalg8daKViHJ
 7qFlnVKyYmp/dbMMVz1+LVPwldX2WyhPfQHUx7kwxLo3dFTLIByPXHWIWxLw7/uDkvua
 /reg==
X-Gm-Message-State: APjAAAVTgAC1GvtC8115+eNncfRi/qPGUJYZhqbLH1xFhUw3LuZqwemu
 qE0OzJqBDCD8w+C8T9t08pR66w==
X-Google-Smtp-Source: APXvYqw4lyxyXDsSoTVoUYbn/uPEslyqLKdvf3KG+fvkUz4Z8S84tPxS7kIa9jYqhlIYAmQDFgK1wg==
X-Received: by 2002:a17:902:463:: with SMTP id
 90mr8408800ple.213.1579652134724; 
 Tue, 21 Jan 2020 16:15:34 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id 65sm45476273pfu.140.2020.01.21.16.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 16:15:33 -0800 (PST)
Subject: Re: [PATCH 2/5] docs/sphinx: Add new hxtool Sphinx extension
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200121191033.28195-1-peter.maydell@linaro.org>
 <20200121191033.28195-3-peter.maydell@linaro.org>
 <5fa9a519-d9c8-13b6-2d38-efa12c29780d@linaro.org>
 <CAFEAcA9ty4srYsjbGDEQshttcA97yFco=7fLGV8SV2oT7FeQ+A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7a086da-a9d0-57f4-0f93-d43928872c16@linaro.org>
Date: Tue, 21 Jan 2020 14:15:30 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ty4srYsjbGDEQshttcA97yFco=7fLGV8SV2oT7FeQ+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 12:22 PM, Peter Maydell wrote:
>> This doesn't seem to work for me.
>>
>> make[1]: Leaving directory '/home/rth/qemu/qemu/slirp'
>> CONFDIR="/home/rth/qemu/run/etc/qemu" sphinx-build  -W -b html -D
>> version=4.2.50 -D release="4.2.50 (rth)" -d .doctrees/devel-html
>> /home/rth/qemu/qemu/docs/devel docs/devel
>> Running Sphinx v1.8.5
>>
>> Extension error:
>> Could not import extension hxtool (exception: cannot import name ExtensionError)
>> make: *** [Makefile:1022: docs/devel/index.html] Error 2
> 
> I suspect this is an incompatibility (or possibly just a
> dropped back-compatibility I was accidentally relying on)
> between Sphinx 1.7 and 1.8. (I tested with a 1.6 and a 1.7.)
> 
> It looks like ExtensionError is now in sphinx.errors, so if you
> change
> +from sphinx.application import ExtensionError
> 
> to "from sphinx.errors import ExtensionError" does that help?

Yep, that's it.  Thanks,


r~

