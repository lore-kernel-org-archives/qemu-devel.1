Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F687C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FAE206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uj0dvbk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FAE206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMQT-0005Df-Sj
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMOm-0003w1-5v
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMOl-00057Q-7B
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:49:12 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMOl-00054L-0Y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:49:11 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so10104104wma.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 09:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=BvLj2aL2dBkN0RhwvRESfw+tmvWO5glUrSWsN2KQ7m0=;
 b=uj0dvbk5KloQm7L/5A7McDD0dcoFiTwv76Uq+T6WSsGlQxdJGB57HVp8qe+vGltEg0
 nunO3x7wQ+8M7JcEaD83i6hzxn5aq65PlFSIlcLug3V1aULdZjOu3tQwMOkwk+aUBF0t
 2SEPYeaFA7dau8ScsrsGBac0IVJ2GQLKohis/qrKFqioD20ljGYb/D7jLeam4pHXlncc
 tFWfUaOcbq2inpmB/w5TS/0qRDdm6dhQb2iPbX/DX9W9YMFtQjTHR1AUq7Qaq1yoR6V8
 jM0dYy5l20Gyjj/2lCFK13cUqVLnDHPXx/fMQ2EOsEWWYRhE1hobQeTIUFSBRo86zwoo
 njAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BvLj2aL2dBkN0RhwvRESfw+tmvWO5glUrSWsN2KQ7m0=;
 b=i0b8xFynuSSyRT4U6ps9L3qZVpHEVdFWGcTz6S0Zh3g0C2PcLsDJH6dbvfsdYC3jrr
 W6k98DX5+zXoyl1R/t+Mfl4XltWi72ra3sPEqEkiWw8sByReOIVEC9EtYddOGZ8oVc2q
 sIC7o/R2B8Le3LJHj+rYhC8Qh8uGlY1NXXGCnNcMKtD+5Xyhwulqzi2e3pLhGzSPL88G
 VPplnnhFd9K95C2SvEDcbB90Ole6CiUUYXWc2XXtAvvIurkot7YJRo+S/4Jv6+4i+kXA
 mCjIK1kC3Lr5Z4Knphfhf1Qo5Xdt4ACirkpWOXTmfN0xonL+00ecSWNhhBUa8UKzRU0X
 xlVw==
X-Gm-Message-State: APjAAAVFJ4RMMcW0ynRTOV26eNZ38Iyw01Ay6ArnjUSlB1t+lUvfBW+5
 p4bRm2jFyzSesRj3yfU9YP/oqgVO1+M=
X-Google-Smtp-Source: APXvYqyu/fa8BQmpmJJxe/ZFJQYw7O10QNhlBma+NhHexIoy+PfHW8IoeF4+a8s9D7fWvvUK28FyBg==
X-Received: by 2002:a05:600c:246:: with SMTP id
 6mr18085398wmj.122.1576864148688; 
 Fri, 20 Dec 2019 09:49:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f127sm9022111wma.4.2019.12.20.09.49.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 09:49:07 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 974741FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:49:06 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-14-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 13/28] linux-user: Include trace-root.h in
 syscall-trace.h
In-reply-to: <20191216221158.29572-14-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 17:49:06 +0000
Message-ID: <87d0cidh0t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Code movement in an upcoming patch will show that this file
> was implicitly depending on trace-root.h being included beforehand.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/user/syscall-trace.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
> index 9e60473643..79fd3e5aa9 100644
> --- a/include/user/syscall-trace.h
> +++ b/include/user/syscall-trace.h
> @@ -10,6 +10,8 @@
>  #ifndef _SYSCALL_TRACE_H_
>  #define _SYSCALL_TRACE_H_
>=20=20
> +#include "trace-root.h"
> +
>  /*
>   * These helpers just provide a common place for the various
>   * subsystems that want to track syscalls to put their hooks in. We


--=20
Alex Benn=C3=A9e

