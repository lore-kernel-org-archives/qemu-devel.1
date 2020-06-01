Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BC1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23602073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FatqtVOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23602073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfu3v-0008AG-4C
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfu00-0003HL-HX
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:37:44 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftzy-0006PJ-Nu
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:37:43 -0400
Received: by mail-pf1-x444.google.com with SMTP id a4so4171051pfo.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KUapqzqKD/nil8AJP/KRmcd5zCFEf0jfxXrXYdNEGQI=;
 b=FatqtVOR5hD/fcjlHQiJxex0C6zQusiasYEb/yEipsUHJ8XYLQsy5xfoCZP0e+yu2k
 iuyeevu0q7AhEwUlWsJu32GG5SazukklQ7e67apLyPFjt5a/kRoa7XobmxW3KegBIMKP
 ENP/BSizdgxJ2u8Tvh8iFJAyCgLU5iLwR4aQ1m509XvSedk9+fo6MComm8rgpnGt+o0N
 Q98WvROsPGMZBjMcvm6JrmLaNrnVanswonOdPV+SMxS43AgLRfuApjZXh5bhpv+tDGdz
 MMCTMQ66HTYSfiIMqxA5Ki+niSFNrxoUK9Dpm02g07u76J4kojC7ItRwfO6gs62s6NM6
 DARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KUapqzqKD/nil8AJP/KRmcd5zCFEf0jfxXrXYdNEGQI=;
 b=pfJspHua+bwQ1olMeIUl6qvo8i/QiSSJ4Thh8/pYhG0Z2D5Ez9EO0oEK27x2BjPjVK
 tJrPmXxy+WIYwr+cexdZXLaxzdoZt8de4M/aDj5tSdcuHUaHPe+wTLkHGhx5CkW1p1Hf
 OtiGb9T1lO9oMQAHia/vMYEf9mAnQpMdNxv329IhNh6tDvbjc4v7TKSfCwawCvxwHFmZ
 jVErto6jItokWlt+dDiTung5jn09W0Sp2ii1eF35Uu+9IkQcaMA5cMNO4kfkaCdOsjI2
 5fGr1DRkY0HMWyFHtNygmhJtu3OXZLqH5/B2gNpYQzSxZ3LAY1VzZg8XAwQAZkYWgznI
 U7KA==
X-Gm-Message-State: AOAM531trh9B0FInOKfUnQEF0o1PFLv4UESRWtRWJ9a0ltzIec38JdFB
 pcJxk7eThUsFfmrn8Okb86QLBA==
X-Google-Smtp-Source: ABdhPJxhd+PX2dAfPlV44Fx/pz/N3NFXKQtVkApW6bgZq/7EFs6cRCLgC6WvnR+4RiTgTsBqwCGGXQ==
X-Received: by 2002:a63:6345:: with SMTP id x66mr20915001pgb.156.1591054659488; 
 Mon, 01 Jun 2020 16:37:39 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g19sm415680pfo.209.2020.06.01.16.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:37:38 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] hw/i386/xen/xen-hvm: Use the IEC binary prefix
 definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601142930.29408-1-f4bug@amsat.org>
 <20200601142930.29408-8-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <403c7efe-bfa4-c6e3-7ab7-0592bc16bfc8@linaro.org>
Date: Mon, 1 Jun 2020 16:37:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601142930.29408-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
>  hw/i386/xen/xen-hvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


