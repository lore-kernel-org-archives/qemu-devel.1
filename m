Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D89EC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DDA2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJ1bLvnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DDA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5eB-0000yL-2e
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY5dH-00089h-1y
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:25:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jY5dG-0004he-18
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:25:58 -0400
Received: by mail-wr1-x443.google.com with SMTP id y16so3059764wrs.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SH2zsrKPoKryaS1XPDVCA9WuLNkkpScdEL2lT6GHl/w=;
 b=SJ1bLvnEPh+JbvlxZVVbES9nb6T/S8f2zQY+cnztLaQgOjiCOsnw+3ZRH9d7BADAqo
 Py2xeN4OJyBnG5qg95JcDCOqISXvJMF2GuL68Z8NV6vrznHoT5YddGC7l8WkvG4AsNSB
 TsySHQW+q4wRs6fwRz5y0nJWHQPrgaX5RxvEghdgDK18GgPsOVj8NDSCOVZ3OcDTWxD7
 lSr24LTvfPnIwUJepYTFGUbsHMMC/MyTvzozEAenI77T8Nz10NILwjhJgeil8hwy5Stb
 MhieEUK8I2f+4i8gRMMkbpqj78XCIZXA5KyCLYodgljJSSXp0SPcnc5BuzDrVqYlxmC6
 jVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SH2zsrKPoKryaS1XPDVCA9WuLNkkpScdEL2lT6GHl/w=;
 b=ZsxvRWMZRhr/06bMD3r6QUIsYHkj/yYvlE68h6Jf+zucilZjTiY61jCjw3WnHd3z5P
 hVZAzDiaRmszRBYSNvaoyE14RrQDF2ym1XA4rLNjjWOZWfCeWMDMHhHL4gVlzqh1QSx+
 mMjB9ThghIa0wM1mL4JzM+QtTYO8Rq5fL33B8MXfhbZVft+xm+zj8wmD71F1J39/QNKH
 7f7BbDdxro+Man55icX/KYrktY86pHon9VNPxxCfb2iSjlTKdwNBuMBdH2h9/tAi+qn6
 YdimVX0OdeQUMC0g0MK/1t9+22cLtpJuGuJ6FRkIQx2jO/OsCmSZ8t+aOIv1xNBCdjEP
 5GyA==
X-Gm-Message-State: AGi0PubHTqBHfrnhborZ99vXpF57S7h2rGzTZb8jxNI2RBmTxXGpqnw9
 U7lVhJZE5G85Bz1WlV77iVjgLg==
X-Google-Smtp-Source: APiQypJ/XdHvFsBcx80iwLJe3HTQneR6lwcHBGxcMQIQZbTIloxGfdd6fGVsWCxRmP2XrCjqr9In4A==
X-Received: by 2002:a5d:5686:: with SMTP id f6mr18488751wrv.168.1589192755980; 
 Mon, 11 May 2020 03:25:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d6sm3458954wra.63.2020.05.11.03.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:25:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 83FB71FF7E;
 Mon, 11 May 2020 11:25:53 +0100 (BST)
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-18-robert.foley@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v8 17/74] hw/semihosting: convert to cpu_halted_set
In-reply-to: <20200326193156.4322-18-robert.foley@linaro.org>
Date: Mon, 11 May 2020 11:25:53 +0100
Message-ID: <87zhaeg43y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: peter.puhov@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/semihosting/console.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
> index 6346bd7f50..f70085f3c1 100644
> --- a/hw/semihosting/console.c
> +++ b/hw/semihosting/console.c
> @@ -131,7 +131,7 @@ static void console_wake_up(gpointer data, gpointer u=
ser_data)
>  {
>      CPUState *cs =3D (CPUState *) data;
>      /* cpu_handle_halt won't know we have work so just unbung here */
> -    cs->halted =3D 0;
> +    cpu_halted_set(cs, 0);
>      qemu_cpu_kick(cs);
>  }
>=20=20
> @@ -154,7 +154,7 @@ target_ulong qemu_semihosting_console_inc(CPUArchStat=
e *env)
>      g_assert(current_cpu);
>      if (fifo8_is_empty(&c->fifo)) {
>          c->sleeping_cpus =3D g_slist_prepend(c->sleeping_cpus, current_c=
pu);
> -        current_cpu->halted =3D 1;
> +        cpu_halted_set(current_cpu, 1);
>          current_cpu->exception_index =3D EXCP_HALTED;
>          cpu_loop_exit(current_cpu);
>          /* never returns */


--=20
Alex Benn=C3=A9e

