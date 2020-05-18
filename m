Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DE4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FBC207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDN3LTry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FBC207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiQq-0008Ox-J3
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaiPI-0006W3-1M
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:14:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaiPF-0006ar-NX
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:14:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id v12so12500310wrp.12
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=14EgnQXdDLU6UwJteERXQ0fKaVmPe5bjR0oM2Xdh7xw=;
 b=iDN3LTryQTw9m8EQf4JTn+VGcvgnSjZ9WlxIfAfBF+FlVPgNfm6LikVAtZJPW1KdIc
 7OxFf6e5cFiFXGheZENUQ1Y+K7iPL7GcWXkJPCvn6eIam7aY3tl5Mncl9hWAQ7JPs4tK
 ujIyDGj1P9SMkgqrqMS6mjwU03QqEBpDusMn2ozCpA/N1sB4bBwfCtA1XvnMgbPN7ZmH
 bEwySpm0pIKTeoekeXKHnk06Ey9iGdWDUDUrMgTVlXw7nA9VJaPd0n0kH+8sGgKymhiZ
 58FtGfbN9EdaRuUhevGAIFwRSVQ7j//tNiKFey7Qk65anWFNhqQmESDfyTmzBWSxcXnP
 2+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=14EgnQXdDLU6UwJteERXQ0fKaVmPe5bjR0oM2Xdh7xw=;
 b=F/dSzTfIooTtlCkeg8FZ2TgW2XerzMVgVDS2680M6EPZrXDUFH/v/AR1S57AvzL6uR
 iaZZ776IZj87CurQpkww9Qf14NQ5vAu6isdjEe/GJS1ONruMwh6AgzHpTxPCx4IlwqPC
 Q6JogyUwmanS3lmLgIGNR3HKyN07HMbjXmVFSH39P0qqR9ZVz8dwIKLKnl45+KsP8SkY
 NL8oi/ezdtj7Xx/Rz7BfF6QXvpR3eChO2cMT3TuG7yFDYUzyDCw0VqeGBrkCvSt3CQtZ
 mckyM4KEzKLBluRmudvbI13c4GNDyr6pnAs3COyUGqqZgQRW6+dE+Ri5i3akZpPZZzHO
 vlxw==
X-Gm-Message-State: AOAM533jLfiKeaLe0QvcogT4FykoT5LgXKW8smYg49+W+dU2akCpDtia
 ByBD0r8vbhs7GCSEuzGfITSqQQ==
X-Google-Smtp-Source: ABdhPJwnTVp6SRCT+Bvpp7CW3q/J5ppBT7E8TWgCloUi/LSbfD+g+XSRJSfraWrP4sGAuNMLB8X+gw==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr19965873wrn.335.1589818460274; 
 Mon, 18 May 2020 09:14:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f5sm17512051wro.18.2020.05.18.09.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:14:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8ACF71FF7E;
 Mon, 18 May 2020 17:14:18 +0100 (BST)
References: <158875154623.957.4036561733593052357.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH] icount: fix shift=auto for record/replay
In-reply-to: <158875154623.957.4036561733593052357.stgit@pasha-ThinkPad-X280>
Date: Mon, 18 May 2020 17:14:18 +0100
Message-ID: <87r1vhjk4l.fsf@linaro.org>
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
Cc: pbonzini@redhat.com, dovgaluk@ispras.ru, qemu-devel@nongnu.org,
 pavel.dovgaluk@ispras.ru, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:

> This patch fixes shift=3Dauto when record/replay is enabled.
> Now user does not need to guess the best shift value.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  cpus.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index 5670c96bcf..dfb9f4717f 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -379,7 +379,8 @@ static void icount_adjust(void)
>=20=20
>      seqlock_write_lock(&timers_state.vm_clock_seqlock,
>                         &timers_state.vm_clock_lock);
> -    cur_time =3D cpu_get_clock_locked();
> +    cur_time =3D REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
> +                                   cpu_get_clock_locked());
>      cur_icount =3D cpu_get_icount_locked();
>=20=20
>      delta =3D cur_icount - cur_time;
> @@ -685,6 +686,7 @@ static const VMStateDescription icount_vmstate_timers=
 =3D {
>      .fields =3D (VMStateField[]) {
>          VMSTATE_INT64(qemu_icount_bias, TimersState),
>          VMSTATE_INT64(qemu_icount, TimersState),
> +        VMSTATE_INT16(icount_time_shift, TimersState),

Surely we should be bumping .version_id/.minimum_version_id here so we
error out gracefully. No recordings pre this change would work right?

>          VMSTATE_END_OF_LIST()
>      },
>      .subsections =3D (const VMStateDescription*[]) {


--=20
Alex Benn=C3=A9e

