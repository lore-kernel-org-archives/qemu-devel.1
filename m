Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CC7208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQgyAHCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CC7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdvr7-0001I8-Tr
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 09:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdvqa-0000q8-OS
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:11:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jdvqZ-0003Po-Lu
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:11:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id h4so2992471wmb.4
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pvx+DRmkE4yWBHRNSIvM7k3BGtH/OEomD0D7v0enWPI=;
 b=IQgyAHCwZ21yuicpAiVk/S9I2Ih46wOnwQRqnFC485v366vKIjED4BtMkx6vrGqlQ0
 I5F9HS9r2ubjUGzprGjs0o0en9pvwqzYPa/MhvJTUz+kwkCI4OPedlaIwH5NjajNJt5K
 hJS970WzIC7P+k5Se3RY7FQixroDch1b5+3McPrDNdFREMcubc47gAcaSA2tHjcLRJZZ
 g0dwSQhlM9DiMr4fUk+OBmk6GBMFC7OaWIstji9DjK4KpQAj783Gs/jbWERQV/o0oB1f
 s4j8Q4QIf9KjidtHb1KSR+7jlFtquYnqBHLuoLQaAZZQS2RfVnDt7U1I4hlOXHIlF2kt
 PWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pvx+DRmkE4yWBHRNSIvM7k3BGtH/OEomD0D7v0enWPI=;
 b=BKemAJpl30sP5B9AdTs3g6XquYHPHaDzHLl9sPOYTJfEVLy6CM0dPtvkf62VzJiLhT
 fDVwK4T2WLTwbM+lQ+/0L83gnImd32sePwjz6UYgH6sV5gf+UXcTki/5WXE/yNEn31HV
 mhJ0Tow51/cXPfRPVSOV35Cdehe+Y+NA4un+gKqAXh3JNtivJkp/yLUgn78yrs7M1fE5
 a2n4zSOkIbozlnawJNexNeeGrZ4btDhrT6UJaEcQck+rNgLE3ibKueVy/ytuOxBqiUkP
 UysJZIXWk6p5PSkdCODQIBXTdXzv2yS/Vkrti4f8vFsmqxL5lx8La4k8W2ZSL0uihfCE
 pO8w==
X-Gm-Message-State: AOAM532nAKy60uwc3xh7zEgXboIm8qBfPRdQ6g6uqlQzWRbblOfnc+Cy
 RCgx7F/4QV+79OwAhxypb5k=
X-Google-Smtp-Source: ABdhPJypPSPZTyjQBkMHxtbGev4u79fvNTC6c7XwBGMvMZMyp8u23cahC9lrAMQ/82KAxenfIm8xlw==
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr4507079wmi.73.1590585110262; 
 Wed, 27 May 2020 06:11:50 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id k131sm3126783wma.2.2020.05.27.06.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 06:11:49 -0700 (PDT)
Date: Wed, 27 May 2020 14:11:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 2/7] Implement drain_call_rcu and use it in
 hmp_device_del
Message-ID: <20200527131148.GH29137@stefanha-x1.localdomain>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-3-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline
In-Reply-To: <20200511160951.8733-3-mlevitsk@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 07:09:46PM +0300, Maxim Levitsky wrote:
>  /* The operands of the minus operator must have the same type,
>   * which must be the one that we specify in the cast.
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 56cee1483f..70877840a2 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -812,6 +812,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data,=
 Error **errp)
>          return;
>      }
>      dev =3D qdev_device_add(opts, &local_err);
> +    drain_call_rcu();

Please include comments explaining what each drain waits for. Without
comments we'll quickly lose track of why drain_call_rcu() calls are
necessary (similar to documenting memory barrier or refcount inc/dec
pairing).

> diff --git a/util/rcu.c b/util/rcu.c
> index 60a37f72c3..e8b1c4d6c5 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -293,6 +293,39 @@ void call_rcu1(struct rcu_head *node, void (*func)(s=
truct rcu_head *node))
>      qemu_event_set(&rcu_call_ready_event);
>  }
> =20
> +
> +struct rcu_drain {
> +    struct rcu_head rcu;
> +    QemuEvent drain_complete_event;
> +};
> +
> +static void drain_rcu_callback(struct rcu_head *node)
> +{
> +    struct rcu_drain *event =3D (struct rcu_drain *)node;
> +    qemu_event_set(&event->drain_complete_event);

A comment would be nice explaining that callbacks are invoked in
sequence so we're sure that all previously scheduled callbacks have
completed when drain_rcu_callback() is invoked.

> +}
> +
> +void drain_call_rcu(void)

Please document that the main loop mutex is dropped if it's held. This
will prevent surprises and allow callers to think about thread-safety
across this call.

Aside from the comment requests:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7OZxMACgkQnKSrs4Gr
c8hG6ggAm7h9ryuGOGw++qaCcO1kxYV0BQ9Ac3WUrWmmZ/6fT5ddTFX8pbRTd50M
YNVS9kDmR5c79or5CrxWhFTgLJ8uRuHUyIrcDikQVWFY2CwoqIhAcaznDuB259pg
5v/q39qaam2BcOoP0gvy5N07JzTPnQ28PombcjblWPDLQ+pE7BbKVjUFwrwE+Ang
r/N3FM/U5DNCAUcwC1AqpeM9lpjhhIF+fJ4vssTGtT9Z/2e7IfgwtdKjrZVdOqsK
UforjFXcnQHfV10Ye5L7x3kNKpQjqbgX9ewA5+UjITI1LgAPEnaLlp719G8F26M+
VVNR/vgJg+93bT+eUeqq8CHVcjJJMg==
=A4sM
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--

