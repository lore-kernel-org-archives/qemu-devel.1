Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D817BC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FB820836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIZu7cvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FB820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEC3-0007S0-LN
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUDoU-0000pw-Cn
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUDoT-0002ma-I4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:21:34 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:47002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUDoT-0002fv-1R
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:21:33 -0400
Received: by mail-pg1-x543.google.com with SMTP id q124so3151546pgq.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=zWIIrt8aiUHc320gKFzuO0QrYqzyBKWJBFr0fG5q2Q0=;
 b=gIZu7cvz4COEaemPOK/BFoeGSI5clOSL2C4omleJgA9HNHRopK2tAf8d5j+ulohenU
 9NONpdp62mSkD+l76djYo78spKs0/fbZRXFlX8oIRkaCrWOMTMkm/XkDicDae6RqL7c6
 5eStriPu5FHlZ18F6fEXxC//tUtanGuUBiyZMNfy/TOGAOz7KUs8ljpWLXCspuiy8BCW
 BzsQnnB7CpXnXpSAK5qQJfY1K1MUWhvOFp25CL7vrY+DupuACcUSAuH5TwaGPJYdKFCf
 yg2x8ONmS2MmB/GnUxSEXmEVZHa/7lKk6zWpHRUUyQ4H8URi1+0V+XmQMip/IIUAELhg
 QRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zWIIrt8aiUHc320gKFzuO0QrYqzyBKWJBFr0fG5q2Q0=;
 b=d1T3WyX8barvbi2JtaKwcUAL3kKhITzxtQbe2EffP/NaxpasneqCBz9EvdUw/BPbPG
 A9oFjH3OUpAfKUnlnln1weEYBarqcpgvcubNi8Lu9dUlZmo2qf9iB32iLO8u2/jw2OhS
 5mMzVXmOL39kgRTMLWHWPKY0gs/cs/0TSxs86zHbIyaeeZF3g6QiI8aDVlSc34RCHytb
 pnxw8uTEvjNe27OfJRQo0saJ3xT3nXgtZ09N8qWeU/VfkOjpLgW+jUW3W5dGKRFZ43FA
 DG4lTTM6Ju5nrT9BOeuKTJFV1Xam2NXnLDFiIX4osMxgoC2uKlAyi7kgZsilZAPhFW4b
 vb+Q==
X-Gm-Message-State: AGi0PubNutv3F/+DE17z4aVFSFeg045oMBSLemsli0MvxDn5n7ytgW5x
 UOJHjDt4Kbb4Qv6U/bCn2B2FzRZuZuE=
X-Google-Smtp-Source: APiQypInjYpHZEtRQWwpUwtLtQ/+8WlFA/NUkgaqlWf7atfNYGS30wnmjvppoaDH+/PkQzSrEWhw/A==
X-Received: by 2002:a05:6a00:d:: with SMTP id h13mr24531pfk.254.1588270890890; 
 Thu, 30 Apr 2020 11:21:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id k24sm378820pfk.164.2020.04.30.11.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 11:21:30 -0700 (PDT)
Subject: Re: [PATCH 01/36] target/arm/translate-vfp.inc.c: Remove duplicate
 simd_r32 check
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef477a17-97af-3883-5295-937068d81d03@linaro.org>
Date: Thu, 30 Apr 2020 11:21:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::543
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Somewhere along theline we accidentally added a duplicate
> "using D16-D31 when they don't exist" check to do_vfm_dp()
> (probably an artifact of a patchseries rebase). Remove it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 6 ------
>  1 file changed, 6 deletions(-)

My fault.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

