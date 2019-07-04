Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B081BC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7784121721
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPzLPUeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7784121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4rX-0002ga-KQ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48979)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hj4pH-00019O-0i
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hj4pF-0008K5-LM
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:43:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hj4pF-0008JH-Cd
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:43:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id f17so6779838wme.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Tp4Wu5LiPCdRor0HI3gefVRjXcDxalH8b04z47vPtbI=;
 b=iPzLPUePF7Pr5wL+XFrMB9NdO3BiVG0pokTxbBApMnB3bo9vR+REZx3Ru962UdqWHl
 h924A+zSYkKHsZm3+XmypskK4ZmyrEwcagDKH5QAxN97NUH7kyZ8xkx4noAPHJo8wliq
 0ebBqyd/G0bc/wN8oY5tBEszw1hUiVweg0j8tMn3TEDabda99DOesV7Foi8TfbP5ArMO
 X9cAbjHWyoVgYnfz8VIKFNA/btdk6CGe+Rr90ZmR0dB5ulkA0BgmVqxBg6994kVfxnUg
 LMNoQCSLj+rdFCYF5CRK46iXKeFEveQs03MM+LbOb8gq5AhfozBMVRRZyiUngAcQjbzg
 jmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Tp4Wu5LiPCdRor0HI3gefVRjXcDxalH8b04z47vPtbI=;
 b=mvisrGTo/Qy0w9RMd/IILQaJn4fiPLJOTJbAYf0tFjlBJcbb1eQPliukumoPJgdWXu
 NkPBBMjHzuMS9m4cNrvK+lBR4kZsBJG0f6Oi7fF57k9667RMOLXrJugf6L+AteeEBwhS
 h78a88dLt8+qYAZf6jpVu3zSa+PgqrPieja2YeTuoO3ixz+oUUqLPAa24753qTSLHQad
 6GlT89f+Zndk+vV8sjJ1ytPnZsAK2+fGw7rARwy8nJL3EVryvtNyMcsMoYYpfA8OzyZu
 xMA/N8pSo9qXDaNfcs5vcCuzDZ7OHXI4fNh6MnEIeLfk0Q4Ee0Xf4eMWZQZBs0EE3p1G
 +pEA==
X-Gm-Message-State: APjAAAWpQg1p5orlgwH7FBMZU4tYSV3rLhsgD/Pw9PXflMkwSuPEvFvU
 hV3UVIkxzjf1iwyn9GTNnhhYzA==
X-Google-Smtp-Source: APXvYqxCdXyACMavFWZIGVH5+uExNviHM1UG/NyaTO+wraTHt71R2P4Z40wKTBca5FzqgO7Y60htuw==
X-Received: by 2002:a1c:9813:: with SMTP id a19mr286297wme.11.1562258591348;
 Thu, 04 Jul 2019 09:43:11 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id i18sm3549234wrp.91.2019.07.04.09.43.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:43:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6FA2F1FF87;
 Thu,  4 Jul 2019 17:43:10 +0100 (BST)
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
 <20190702210017.4275-6-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190702210017.4275-6-vandersonmr2@gmail.com>
Date: Thu, 04 Jul 2019 17:43:10 +0100
Message-ID: <871rz5wy1t.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 6/6] monitor: adding start_stats to
 monitor
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
Cc: vandersonmr <vandersonmr2@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


vandersonmr <vandersonmr2@gmail.com> writes:

> adding the option to start collecting the tb
> statistics later using the start_stats command.
>
> Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
> ---
>  hmp-commands.hx | 15 +++++++++++++++
>  monitor/misc.c  | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index bfa5681dd2..616b9f7388 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1885,6 +1885,21 @@ STEXI
>  @findex qemu-io
>  Executes a qemu-io command on the given block device.
>
> +ETEXI
> +
> +    {
> +        .name       =3D "start_stats",

Maybe tb_stats? with an inferred "start" or a "reset" option? And then
an extensible set of options to expand what we record.

> +        .args_type  =3D "",
> +        .params     =3D "",
> +        .help       =3D "(re)start recording tb statistics",
> +        .cmd        =3D hmp_tbstats_start,
> +    },
> +
> +STEXI
> +@item start_stats
> +@findex
> +(Re)start recording tb statistics
> +
>  ETEXI
>
>      {
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 1fb4d75871..d39a048fd7 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -469,6 +469,21 @@ static void hmp_info_jit(Monitor *mon, const QDict *=
qdict)
>      dump_drift_info();
>  }
>
> +static void hmp_tbstats_start(Monitor *mon, const QDict *qdict)
> +{
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=3Dtcg"=
);
> +        return;
> +    }
> +    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
> +        error_report("TB information already being recorded");
> +        return;
> +    }

As mentioned before lets have an internal flags for this.

> +    qht_init(&tb_ctx.tb_stats, tb_stats_cmp, CODE_GEN_HTABLE_SIZE,
> +                QHT_MODE_AUTO_RESIZE);
> +    qemu_set_log(qemu_loglevel | CPU_LOG_HOT_TBS);

I suspect we want to safe work this so we can a) flush existing tb stats
for a reset and b) ensure we do a tb_flush() when we enable stats
(otherwise we won't collect anything).

> +}
> +
>  static void hmp_info_tbs(Monitor *mon, const QDict *qdict)
>  {
>      int n;


--
Alex Benn=C3=A9e

