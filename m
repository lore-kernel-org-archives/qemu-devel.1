Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54816C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 21:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C21D20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 21:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q90wbtvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C21D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir7cP-0003OP-1Y
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 16:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ir7bX-0002cT-D2
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 16:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ir7bW-0002jJ-5W
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 16:50:34 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:32947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ir7bV-0002il-TO
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 16:50:34 -0500
Received: by mail-pg1-x535.google.com with SMTP id 6so5368971pgk.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 13:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QOe54nuHmXu8lAt3kzbRKI3tdaMi9pSIkVXhMRlCqQU=;
 b=q90wbtvGqj06PmcXrjYI523QdDE+bR8fBB2tPwv5jHLyAMMvY+06s5zDFu+/2Oox6O
 Ovx3/blqFQ4p9nxkNYS8GNOJNcrltVAEaI2gTaDNPfWgPH8rJRKNkoWaPz0EvB8fILYW
 OTR2+OQxh39eodzMigdE6JNciWbE/DV8GLc/hYV3D3TMY/r2HNv0ZNuQQzxy4ObJSAWy
 GZImcbtWGgN/WGtGUTKZX8DqGdHU7ehTdVwD/buxVvkztLKQ4Oo2g9K7vIdWl/5JiE+f
 9n2pclDM+xQ97+oOCF90f9UxrlX4aUsZgJYMMmnrJN4WzZ4desrW/qVyBLjiBLSS9n52
 5N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QOe54nuHmXu8lAt3kzbRKI3tdaMi9pSIkVXhMRlCqQU=;
 b=mnh25zrc7Ac/W0gNcoU4S/Nm5935Qa6bssIlHXN9/IIysuWNIyA5+U9R+2AicGyFsq
 rJ/noCl6zYZn0qyJqWeRWcTyS3lR2Bs0cUx57Cys5F/MtXoZdUNcbGv5asb/98K5TEiX
 Ovz/qgnHhXVzQ/lSN/QMQYvVNQ+xNYZt9cP3AmtLi9oXVow/7UCBuMmsAsdpioXRShJk
 G25T4sRfKNAzYE7to2S9YoniB6vH8Bdi9Jsf+fL1WGFM3XK5t/3RcsOOYhBXkwoYlvQN
 AH472GeBR2aofhYDFbKD+tP/Mt547bcdr9FvADIIZ3TyqB51qw245hE5GEyOTHr2i350
 mQVg==
X-Gm-Message-State: APjAAAXDO4m9u0o+q7MirUBxgKGOJaAHqiVqD6ye7FRA94rJBP4fSGC9
 VhYzrh8D5Sxzfey1NCRTLlkpT4j/um8=
X-Google-Smtp-Source: APXvYqwcIprdfWGvXzbngtOSfCD1D7k0NiSH7cDarRf0Wo4qhsj33ZlugSD+gmPXhjDN8xFFZOiLAw==
X-Received: by 2002:a62:486:: with SMTP id 128mr21759926pfe.236.1578952232363; 
 Mon, 13 Jan 2020 13:50:32 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id q15sm14474010pgi.55.2020.01.13.13.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 13:50:31 -0800 (PST)
Subject: Re: [PULL 00/41] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
 <CAFEAcA9P_3enu_M-55aoqWScFFAhw=Jfs92+vCc+yY-2nXUehA@mail.gmail.com>
 <df405ec5-190e-946d-fc2f-b52c695a39d4@linaro.org>
Message-ID: <d115421a-497d-42d2-5dc5-6a3d4b19b0b0@linaro.org>
Date: Mon, 13 Jan 2020 11:50:27 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <df405ec5-190e-946d-fc2f-b52c695a39d4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::535
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

On 1/13/20 11:10 AM, Richard Henderson wrote:
> Details of this test system?
> 
> I suppose I'll grab your tarball just to see if the binaries are different...

Ho hum.  Something is different.  I reproduce the problem with your tarball.


r~

