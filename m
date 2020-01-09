Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A612C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235252075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAyLB6WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235252075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVe1-0003Q5-8K
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipVd9-0002nD-Dn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipVd8-0005tP-5X
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:05:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipVd7-0005o7-Oa
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:05:33 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so6915115wrn.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1oyJg1MoHqOZ0shceuMTfadjeVWQnuEx6gFzwvFBmeU=;
 b=OAyLB6WOdahotMskJs8rC1jQ3vg55G2NFe1IhgksenJNLjO8sW+jK8JeLT1T6AEzZB
 1KFYXnWuwmy3XEp+xkPekJ/H1h6nKd++C6bW9LJTo8mlhZWNmDF8MCG3d9xxvD+OG2p2
 j3VXcthPP5yXTVLnh7VnKZjxlhhgpLQc49OQ1qqXLyZph6ue1iCK/RkmjtfmcLhe3uc+
 5AVGJEsZouwJGTbwVfIIjG6bQNMaTmIwZnbm+zPMTTnf2RAGPpyiuuLob8AL7h/VX5Jj
 ay8houqo+0CUZdIlixn5dSAOO0+rtmT8ErmqAhPkj2ksF48g6hg8ujoorUrCR/cyQH7E
 yY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1oyJg1MoHqOZ0shceuMTfadjeVWQnuEx6gFzwvFBmeU=;
 b=o8o28HwS3v54MQkqpx02rS/vIVRZRV06KY07kLjh8UARcbG4/ZurxPhS3KGtNESKGN
 j8KS52A61rrbrlhYZMY+I3pSQkC4aW5nZPBb2JZ9HZOdrAy6AoVUO/tFp/IKSeNgk2GV
 TIGKpvbfpEW+SJNHoAXecqPIZA1W69rfrezvlOMNGV91Nw6z2YmE6RrPr+e4LTPDGyA1
 WRw5jwFacB6fM/b5xmPGldkPcyv1+DBAfSD5sJJL9reuKT17b4ilfTxZuWYE32VVhasz
 OcOXzA5HQ8sI5TQPDXt37TtU0OarF2qXfcAmX33EnkfKBlC/RBt/E3nl4esNChbwET9I
 RyVA==
X-Gm-Message-State: APjAAAXu/4l+yuSVt8IVHowkzm0SL4pxFNVKyiI+smNNrmimPmh6ZTEj
 ctLeLvX9+zDeh6VFvE6JqbhCMo36QS4=
X-Google-Smtp-Source: APXvYqy22VkmM+NIOx4RvFi4S5Z+8sXBvq+Z+UFXuH/0fX0csvjiVZpax1gBysngmDeaQ1pSdfGEiQ==
X-Received: by 2002:a05:6000:11c6:: with SMTP id
 i6mr10545944wrx.178.1578567931652; 
 Thu, 09 Jan 2020 03:05:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm7842465wrr.95.2020.01.09.03.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:05:30 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 801BF1FF87;
 Thu,  9 Jan 2020 11:05:29 +0000 (GMT)
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] vl: Remove useless test in configure_accelerators
In-reply-to: <20200109021710.1219-4-richard.henderson@linaro.org>
Date: Thu, 09 Jan 2020 11:05:29 +0000
Message-ID: <87v9pkj3eu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The result of g_strsplit is never NULL.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/vl.c b/vl.c
> index c9329fe699..887dbfbb5d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2776,7 +2776,7 @@ static void configure_accelerators(const char *prog=
name)
>=20=20
>          accel_list =3D g_strsplit(accel, ":", 0);
>=20=20
> -        for (tmp =3D accel_list; tmp && *tmp; tmp++) {
> +        for (tmp =3D accel_list; *tmp; tmp++) {
>              /*
>               * Filter invalid accelerators here, to prevent obscenities
>               * such as "-machine accel=3Dtcg,,thread=3Dsingle".


--=20
Alex Benn=C3=A9e

