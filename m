Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686EDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3858D20674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzV7M0Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3858D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiKH-0006HD-BA
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaiIg-0003gB-SJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:07:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaiIf-0005DG-Gw
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:07:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id h17so12495931wrc.8
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hvJjkvu0hFdbDOkrhSU4rue+dHtMD/GZv8fiFE3vp3U=;
 b=CzV7M0IljdHb3MUcbXVcibVXofKuoPlM6P6PjSMn4TAkNhk3mEhUklJXmaPQO4ceMi
 9OyrmN/yUNvhUNhXT8GmOevDqlztQGJC4ZPfoY4pP3OHjEJ/xZo8znLr4lUSjwxAkMuZ
 Oa56bh23feAl+Ve3/N8ROaHyGOFZVK+0hRmzvNPtaylg41YteovoM7BEsGXrk07rK914
 z8+wA0ouYDtwp550RnRUPGdYxD3x/LSWbFB5Ep4yG9KzTg34zENUb1nde/PP6ZY2pqqi
 L2nelekp+x8lu/bomaxVYp8kedN5dzVJIg9fGwITsEO8xywRJIRwtpenqc7DyoE2cJtK
 iUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hvJjkvu0hFdbDOkrhSU4rue+dHtMD/GZv8fiFE3vp3U=;
 b=gjmtAWdt2+06/G+5aYQOluNto6oXlxWAp+6MEqI0QSPkkfcXrCMh6NSy72TsCVee3G
 +c5XbbViPAilGiCDVZUmK5OLgRSGZX7ZqNRk79R+TKTSZ/2SHV/ccfaBlI+GDF0IARev
 AKfXF4k686bta3pJyJdiVWcN+2ayQ4vyYM8q1BjkUaJC9W/PNkYVTkbJa8fiFNHsyWBh
 yc7J0M7oFnnIVRRiyGH2Wb2esWh4mZv99x1hhHKu2IyD+GGEex+fzLsvc25/aV1AKRLe
 dDTZqqCMAfxiOWuDxUMXgbNDqGZ1QlSa3HvkjoMNdzsMajS/iqfuHC4qmZLXsKXD+t3o
 r25w==
X-Gm-Message-State: AOAM532FfOuFr2qiLssZTo4bJQD5KXGo24jvWoWCrmb2BMxbQXnivi5w
 JsNVi3nAyqxDFhBfJyu/uV5wRw==
X-Google-Smtp-Source: ABdhPJwv2dLz5cId7BRgj3XrZitflsOqN6KfORXSiASLy6vn4OCY3QSc00QdFDsNE8wy/HFUpyeK/Q==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr20105022wrt.267.1589818051888; 
 Mon, 18 May 2020 09:07:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d1sm17609499wrc.26.2020.05.18.09.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:07:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9BCB01FF7E;
 Mon, 18 May 2020 17:07:29 +0100 (BST)
References: <158823999490.29783.7079486043043163164.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH] replay: implement fair mutex
In-reply-to: <158823999490.29783.7079486043043163164.stgit@pasha-ThinkPad-X280>
Date: Mon, 18 May 2020 17:07:29 +0100
Message-ID: <87tv0djkfy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
 pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:

> In record/replay icount mode main loop thread and vCPU thread
> do not perform simultaneously. They take replay mutex to synchronize
> the actions. Sometimes vCPU thread waits for locking the mutex for
> very long time, because main loop releases the mutex and takes it
> back again.

Where in the main loop do we keep bouncing the mutex like this? Surely
that is the problem we should fix?

> Standard qemu mutex do not provide the ordering
> capabilities.
>
> This patch adds a "queue" for replay mutex. Therefore thread ordering
> becomes more "fair". Threads are executed in the same order as
> they are trying to take the mutex.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  replay/replay-internal.c |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/replay/replay-internal.c b/replay/replay-internal.c
> index eba8246aae..2e8a3e947a 100644
> --- a/replay/replay-internal.c
> +++ b/replay/replay-internal.c
> @@ -22,6 +22,9 @@
>     It also protects replay events queue which stores events to be
>     written or read to the log. */
>  static QemuMutex lock;
> +/* Condition and queue for fair ordering of mutex lock requests. */
> +static QemuCond mutex_cond;
> +static unsigned long mutex_head, mutex_tail;
>=20=20
>  /* File for replay writing */
>  static bool write_error;
> @@ -197,9 +200,10 @@ static __thread bool replay_locked;
>  void replay_mutex_init(void)
>  {
>      qemu_mutex_init(&lock);
> +    qemu_cond_init(&mutex_cond);
>      /* Hold the mutex while we start-up */
> -    qemu_mutex_lock(&lock);
>      replay_locked =3D true;
> +    ++mutex_tail;
>  }
>=20=20
>  bool replay_mutex_locked(void)
> @@ -211,10 +215,16 @@ bool replay_mutex_locked(void)
>  void replay_mutex_lock(void)
>  {
>      if (replay_mode !=3D REPLAY_MODE_NONE) {
> +        unsigned long id;
>          g_assert(!qemu_mutex_iothread_locked());
>          g_assert(!replay_mutex_locked());
>          qemu_mutex_lock(&lock);
> +        id =3D mutex_tail++;
> +        while (id !=3D mutex_head) {
> +            qemu_cond_wait(&mutex_cond, &lock);
> +        }
>          replay_locked =3D true;
> +        qemu_mutex_unlock(&lock);
>      }
>  }
>=20=20
> @@ -222,7 +232,10 @@ void replay_mutex_unlock(void)
>  {
>      if (replay_mode !=3D REPLAY_MODE_NONE) {
>          g_assert(replay_mutex_locked());
> +        qemu_mutex_lock(&lock);
> +        ++mutex_head;
>          replay_locked =3D false;
> +        qemu_cond_broadcast(&mutex_cond);
>          qemu_mutex_unlock(&lock);
>      }
>  }


--=20
Alex Benn=C3=A9e

