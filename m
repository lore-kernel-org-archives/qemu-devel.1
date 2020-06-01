Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C14207BB
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTG7Mc8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C14207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfu2V-0005to-1P
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftz6-0002FH-MC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:36:48 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftz5-0005nK-Pn
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:36:48 -0400
Received: by mail-pf1-x442.google.com with SMTP id w68so3372215pfb.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=utp8UPhvpVOjKQDHheJJZxOdw9rN2rKIwvixqFfY6I0=;
 b=xTG7Mc8Ke+P7C8o56JElmLFbH18twbQfttKAc5G/dIXmkm2onWlNspWFfvusLOTgLg
 pTRDJq/tgRyR7y8JuLP6CZFE2Egd7bg09ZKOeD396awq3y3Wt4q7J+Liinm2BBOuvUrx
 PPw+rh9aMrrdNIj2zKTtH0aArySoR9V7wv0LwGc+yun4GQvO89nczwsvBnve0Xlf9HLH
 7jA8bUorURzKagLbFYICNCER7T+CBwhJkzcywpFi0y9NCCGAjDZRm5Uhst8GI6Mk+SKq
 qe0DI8YoF1wc321Lg2a7uLv3QwcS6piwxXYRRqVkl86ZgCgMmu7bDWT6NTv4v2CVRdQd
 XsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=utp8UPhvpVOjKQDHheJJZxOdw9rN2rKIwvixqFfY6I0=;
 b=MUBsaNWQVLk5+PnLiKTfRl9S1CZmTIEcGR+aREiQw4105umtspW+bMIbadGjHWM6Ld
 4h1+vcBS2DNrjkScY61eG9/giN2rXVQnuPlOVG2G9DNKjebvgDKiEfKmz5UUhU4CWuOX
 kj+c8FUawQwgy+USQpv5lbjVVQQqVIg2fp2ZBhjZO3wL5hYmwX/2CL8XPX3H0aIW2lLt
 f+31lvpMSw90aC4mC2DiGPSSdAXUFhX+/u8Onuo5TmytBSxLmkWNq9jlWvK07WBTwxtC
 s+36YUt9z9DKiAYIO7iAhPVhwWf+xBkW3SP0lh5397dSWXsTPpNxt9Fxp/UPKvVtFqn9
 SD9g==
X-Gm-Message-State: AOAM532gnyBbhxAAGIowGZzIFA8yHKFEUIm1a0lI45jxIhXJoXoPxuYn
 htJPk8IEJqVoWnu9bA5+3WAhPg==
X-Google-Smtp-Source: ABdhPJylPCz6NJ8Nv/4CwG5eFZALKyaW9WbeoXC1cmJzPEV4oHq3Rbd3WXYgkQZHOnN28B1WNZx0MQ==
X-Received: by 2002:aa7:8c53:: with SMTP id e19mr22646004pfd.264.1591054606599; 
 Mon, 01 Jun 2020 16:36:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k7sm452101pga.87.2020.06.01.16.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:36:45 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] hw/pci-host: Use the IEC binary prefix definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601142930.29408-1-f4bug@amsat.org>
 <20200601142930.29408-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2aa683fc-ff9d-17ed-a35f-f177bb5c9e77@linaro.org>
Date: Mon, 1 Jun 2020 16:36:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601142930.29408-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
>  hw/pci-host/i440fx.c    | 3 ++-
>  hw/pci-host/q35.c       | 2 +-
>  hw/pci-host/versatile.c | 5 +++--
>  3 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


