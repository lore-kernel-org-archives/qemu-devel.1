Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775F1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D27206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPBPUUL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D27206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icCXN-0004lI-0T
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 13:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icBXd-0006lf-G6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icBXS-0005Nu-8E
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:00:40 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icBXQ-0005AE-Qv
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:00:38 -0500
Received: by mail-wm1-x342.google.com with SMTP id y23so2818154wma.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qMHBDuJy8qR8OMhyawfINjl7rXx5kRoZmY+5nsGw0kM=;
 b=yPBPUUL47jHOapHDYMpp7jDAUCiweF7k3Aez9fJPtfLVAXseGVrE16+LvavySK0Xdn
 trhMzylkxzV927QxM8Qs39FlbAJUigPOKd72i2BDxYM7DPFS11DG7/bp3oVxPfwgj5VX
 or0NVdvOsOiVYP65UqF10onSiOgqznnWMYsAczyerSoPFsAVFaCgk9mIVzzPk9G4Ccej
 qOJhSH710XS4hpt5kkqM6YwQ4feyMV5egtDVer+owklwgSgZ+c0cI6gP8RQBdk0iJwvS
 n1rKoNlq/L4QfUHdxjXUWm08Zluub+eI0LIiglfIPDB6BTwtLk30tcKIGx3InABayTbo
 ygQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qMHBDuJy8qR8OMhyawfINjl7rXx5kRoZmY+5nsGw0kM=;
 b=SHQNaNqHYx0TqX6CRjUgKshdnux2LrlZx3qj5bq5cr8IvvT8JoWYUj9raVzJ+OfTIQ
 LwXrdatSp6mV9q88M/TNZGBYxL6747/3dgHJPSm/G/o75xnMTkd5gPvpfGi1MJCjbdBB
 hdp4xwr3tYhncm6IMev5SElyInRn48H9kpHmT/7FriSaGmvvyaC358DHkVVzl/FLx5d0
 72xF4aBNTthPPo4saizccIoOmOmHt/PGmBetAAxUhcfWU1vIcAsNedXB5j2SLlIeB3Q9
 n52k+jMCnhBbgiRb5WXhSmw2v0d5OwFY+TCSXmIgk4uMPxsYdXw7wq6Gj9dirbVGKU9s
 6FJg==
X-Gm-Message-State: APjAAAUBTlyGeIzFlBd9AddvrUmgqp0u120+gUjX2EBuK9GG60NRXjPs
 olvt2JS48PR4VNiLX4jFiJmFci3T3eY=
X-Google-Smtp-Source: APXvYqzM49uDpvwEcNZ1q/CI/DJzKvrc+BoNn1uja89HopCvL+yoWH8jdVbITUh8iAkJ4bgMnuh8YA==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr29958685wma.134.1575392429401; 
 Tue, 03 Dec 2019 09:00:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a14sm4502459wrx.81.2019.12.03.09.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 09:00:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 96B731FF87;
 Tue,  3 Dec 2019 17:00:27 +0000 (GMT)
References: <20191115180829.10275-1-wainersm@redhat.com>
 <20191115180829.10275-5-wainersm@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 4/4] python/qemu: accel: Add tcg_available() method
In-reply-to: <20191115180829.10275-5-wainersm@redhat.com>
Date: Tue, 03 Dec 2019 17:00:27 +0000
Message-ID: <87o8wp9wes.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: fam@euphon.net, ehabkost@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> This adds a method to check if the tcg accelerator is enabled
> in the QEMU binary.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

So is this series going to be combined with another avocado series?

> ---
>  python/qemu/accel.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> index 1978fbee4e..513904d46d 100644
> --- a/python/qemu/accel.py
> +++ b/python/qemu/accel.py
> @@ -69,3 +69,11 @@ def kvm_available(target_arch=3DNone, qemu_bin=3DNone):
>      if qemu_bin and "kvm" not in list_accel(qemu_bin):
>          return False
>      return True
> +
> +def tcg_available(qemu_bin):
> +    """
> +    Check if TCG is available.
> +
> +    @param qemu_bin (str): path to the QEMU binary
> +    """
> +    return 'tcg' in list_accel(qemu_bin)


--=20
Alex Benn=C3=A9e

