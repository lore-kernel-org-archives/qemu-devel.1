Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22EFC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A464E2084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAtanAmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A464E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0W2-0007nD-Nw
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39614)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0V0-000793-J1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0Uz-0001CK-JJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:53:14 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0Uy-00017m-2R
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:53:13 -0400
Received: by mail-pl1-x641.google.com with SMTP id f97so4810467plb.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=548N7uZYgD0bhTnRkcUs8rfEUH6b6bNcHSf9qBxLrvI=;
 b=IAtanAmPPWxaXr7zX9fj4IUJJxzFBThJSk/2SPAcF6xbrehofMKP5qRsf5DzY6xjLq
 ErawyEloiJXzRL71l6Smx9sNIv7lz2iqYoN7EJo9wHU3xwPg8bA29MYLeSybTkgo8t3i
 vga31oK8PdUyjjBlbXsSlKPReamZvL6DdttRiXdxA34ywn/DVCWVKndIF8zYedQY/nfP
 mT1VEOenF+DFyIkDRqkeoINORw22u1CATvkcfKZthGlyszr23CHX5ryNTGx27DUjaSkW
 6FbJyQ9D52qqHNTQ9xYaq6w7yOKcUOlYlBgfNlTnJCvKLvYPFXGZk35Sdnp4V5jw6EYC
 wW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=548N7uZYgD0bhTnRkcUs8rfEUH6b6bNcHSf9qBxLrvI=;
 b=MvId12+HP3WJjAKHJkE+3w5bv2ApHXqSLJPRfrLtMBbDw3zyirQK4xiodtikOTPSh5
 nLeGjnFYkaZPGY9h/tXEmFKJQ+xBG07B6cGqEvfxIEkcFqqUvJ+u06fhQbfMWwxuKO86
 xdDYm/7VX8hc+cDrTskxArgWepqXj59/CrOA0le1+rqRRwUAryjrq6SnzV+6vo3zzro/
 UaeW+9tba6JaienSzg7H2hpsmnzxoXp5LL7EPk/4QUBSgMjUJbFG5YIVwGGjEtRaR4vh
 9ES9Y+UfRkXDSbTUzI8yoLWYfFmD1jNN2JloadkBDefYRyPK4p04D6zzk8srdB3AacXs
 yirQ==
X-Gm-Message-State: APjAAAWeMANgHvQTqEMxHmPgrzzpR1ve3bohWvkwgQFJrKMncZ3/dR+e
 dIuhFXp/C6D1Pv9IhchOi9W+lg==
X-Google-Smtp-Source: APXvYqzB/3XMnfm53T+0C6iQcv37CjnXHaSNuNf+LXzOqWNGI1onrbdWFkw9ZOGkF5ob/xBt5J4VlA==
X-Received: by 2002:a17:902:bd0a:: with SMTP id
 p10mr35115608pls.134.1560811990446; 
 Mon, 17 Jun 2019 15:53:10 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id 135sm17596158pfb.137.2019.06.17.15.53.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:53:09 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-40-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0906dae0-6ec6-c25b-9959-3b676f5ca3b3@linaro.org>
Date: Mon, 17 Jun 2019 15:53:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-40-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v3 39/50] vl: support -plugin option
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> [ cota: s/instrument/plugin ]
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  qemu-options.hx | 17 +++++++++++++++++
>  vl.c            | 11 +++++++++++
>  2 files changed, 28 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

