Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092ACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C482D2073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0ouO/8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C482D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfu38-0006wy-3I
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftzi-0002iF-Fo
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:37:26 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftzh-00066G-Gc
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:37:26 -0400
Received: by mail-pl1-x643.google.com with SMTP id x11so555094plv.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PlBT1B/hjs0RZ4Sv/xaBn5v/munjW/EVMnZ0HWetFtY=;
 b=h0ouO/8u5iRqZlDoPrAMhkSSqFRTrfSwQdo19a4i9ahzvmGjW0r6DS5w0CXaMbbJtL
 /So9QK85DTtEQdWnTr0axxftFQZvGnF2jLt5EJ82ylkw5vJgvgWrdemTxnGl2T/EDVPy
 tkR6x9ZtBtuv7G7WnqinFAypKDbsLrHF/El7N5SmOAmTwcd1ObkvDQR+XLnQz3/9dSLv
 0ZcCXDtQJwZmlIpqQUJaKcsDiDMKHRBkg+3uD47Izs61TD3fhbbFgPUiS3tX1lMruyO8
 oXK1ML5f8Zah4SLGKt/6mY+IX6klJBO8Hynj6yjeHoSrie0ul9t9XWocNqYuw8RjfcaO
 h/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PlBT1B/hjs0RZ4Sv/xaBn5v/munjW/EVMnZ0HWetFtY=;
 b=MTQ8iuIV+RXCRnZ+fRrVqtRFfyyF5fsc96ZPQg/Co4KeKMix3r2Qoo6VU5WRn8X9lx
 GBtC+f4x7USAaOChAkcmWCrMj6yWdncpabPEr4i2+DPLSOMFxAFhPy+mq3pI+fQG+Pzy
 Ow8BVrakMvaibermxvwCiPALpU50zZUjn1GGhTOau/bT4J5xwUKAul69ep6BbMyLt4S1
 aipbA0aOWFSd4nc5kzd59R3daMJ3XbGaUSDSOrZDCWeHNuwtLoDWq1cEGYbJL/jkpLU6
 MOxHb9/XMXEhYueyUfkGATmGfs06WzOAE5ZyuzH6stg0hul00p14uBoxxIKbeNz6JCbw
 taBg==
X-Gm-Message-State: AOAM531NmxubYCqUlCAKr7lOkXZ9GA2paInfDhIwi/vFAszdseVrSCbl
 9kOcGqfm0qUQoV4En9q7hb4Muw==
X-Google-Smtp-Source: ABdhPJzzzU+9Uf4BtnV7qNbKvl+iUuKO6qwD6miyTuur8YHPtfQ7XV0BnKoxEbCJaOSgLcuxhYk+Pw==
X-Received: by 2002:a17:902:710b:: with SMTP id
 a11mr6593788pll.156.1591054644135; 
 Mon, 01 Jun 2020 16:37:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l187sm400253pfl.218.2020.06.01.16.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:37:23 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] hw/hppa/dino: Use the IEC binary prefix definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601142930.29408-1-f4bug@amsat.org>
 <20200601142930.29408-7-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57783e28-09e5-8545-7a90-e52ad0dac9d8@linaro.org>
Date: Mon, 1 Jun 2020 16:37:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601142930.29408-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 Paul Durrant <paul@xen.org>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 7:29 AM, Philippe Mathieu-Daudé wrote:
> IEC binary prefixes ease code review: the unit is explicit.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/hppa/dino.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


