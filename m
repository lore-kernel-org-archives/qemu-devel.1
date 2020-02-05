Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E1EC352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4266720659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWcizOOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4266720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOTF-0008Vw-EU
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOO5-0008UN-Tm
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOO4-0007ca-NG
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:22:53 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOO4-0007Wb-Fq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:22:52 -0500
Received: by mail-wm1-x342.google.com with SMTP id t23so3371312wmi.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=T23HdL0WlsWw0qfUVF3B5ASwCW8vMvp+kxrfLt6J5s4=;
 b=GWcizOOaFiASf525ShRf2qECNCI5GndS8n2OfBiLEyc7nfOP2pvwcdEQjzLBu4VQq4
 66YfQno+tYzXHm0uQTt8kd1Cf+eKEeh9bsUptdodRFCHJzoCnlE+QO2zk9fl7EV13xjJ
 ZDpNNFPI+9+ScOXCG//+iw6UUkwFLuJUX4ltfoqJkUD9tw4EA2MJQWVA09UO01Fcg3KL
 V6QOScflmWUc5l6MtKa4Vi6sol7+gZy6gprCoSs2sXjq5FWJTYXVHsbqOAq92W/biHuF
 B8NvQ86qD9T8hKq4BTzdcSSFs+KKVEO/F5Va2K8qGYqN0sJB58Wf/22T+tWOczDA2TSA
 AH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=T23HdL0WlsWw0qfUVF3B5ASwCW8vMvp+kxrfLt6J5s4=;
 b=YbX3RrJaZQBcXt8Sx3eWEApb9rDkhYXDC6cY86zwitVwiUiUHyT5MHtEi2CNlgMZj1
 cB+RFP3KQYyIodABictLqcl1aqgimyOQ86RWy9ogfY7MskLbpvD/4QqCDJfNxNMQzwKA
 93jWGQXZsPFk91IUYTTmX58F1UIRE5znZxWE2oZmWsInJoTBT6CvyUnCyEqQfopCkdj+
 5aMa4xI6EoFI53/2lcqO+EXXKwCcpTRlHH8ZFMtnt8JKq6IzrF7pZfC3n/R+0B9eBFS0
 j9Qz0/nKOsYhanEeiqpkX//nPmzwVxQ+/foU2LILk/qL4j3iYkSlLsDkadR8hB+gTVg+
 j35A==
X-Gm-Message-State: APjAAAWvImq0+hN0OcB4knBuK4lso08KC5tKF2qYBFKvp+z5dv7mJ7Gx
 YuKYRUhSP3MHHxOYXKIOvqC8FA==
X-Google-Smtp-Source: APXvYqxdsJFRFVlOUxHsFMAi1XmW2BZnhHMOOWxby+uMCsQVMSOCBxOanXbOGm/bxbbggmsIaTt7ng==
X-Received: by 2002:a1c:1d02:: with SMTP id d2mr7145021wmd.185.1580923371026; 
 Wed, 05 Feb 2020 09:22:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm239332wmi.44.2020.02.05.09.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:22:49 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEF2F1FF87;
 Wed,  5 Feb 2020 17:22:48 +0000 (GMT)
References: <20200105072940.32204-1-cota@braap.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH] plugins/core: add missing break in cb_to_tcg_flags
In-reply-to: <20200105072940.32204-1-cota@braap.org>
Date: Wed, 05 Feb 2020 17:22:48 +0000
Message-ID: <87imkl7xuf.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org, Robert Henry <robhenry@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> Reported-by: Robert Henry <robhenry@microsoft.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>


Queued to plugins/next, thanks.

> ---
>  plugins/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/plugins/core.c b/plugins/core.c
> index 9e1b9e7a91..ed863011ba 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -286,6 +286,7 @@ static inline uint32_t cb_to_tcg_flags(enum qemu_plug=
in_cb_flags flags)
>      switch (flags) {
>      case QEMU_PLUGIN_CB_RW_REGS:
>          ret =3D 0;
> +        break;
>      case QEMU_PLUGIN_CB_R_REGS:
>          ret =3D TCG_CALL_NO_WG;
>          break;


--=20
Alex Benn=C3=A9e

