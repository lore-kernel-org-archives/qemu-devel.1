Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83662C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 20:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A963207FB
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 20:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qdl4PMHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A963207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgDJx-0006yi-Jb
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 16:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgDJC-0006TH-6p
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 16:14:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgDJB-0005yH-1m
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 16:14:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id d128so4440877wmc.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=okTf8NY/wEMu8UU25kwEV3iDev+KZ+6scmOjH9nS7pc=;
 b=Qdl4PMHMJrqfhl6xVoXUPcUQsUphjJEp6DMCpZ+XrC+MCD3d85ekfgQ57kIfHsmdXU
 iRoLaHItyLruYsUCV3JsDv2RvGz0Abb4FnTKeVkXNorjyDU3V89IQ7Py8E2Qi3jqGYFF
 MDoiwbq1ozsInqRTDmbwanF2BjH/1iXCe+kdTT12W1hK+Uh7iJcMSdCuTu17pobrmh67
 a6P28OACdyFKGQBEem45V/jaYqjEGeVXT0aexEHBXvTx9G/Wqf8uqdiKcB1d7pdHUN3N
 IZa26pdfoKjTtTntwgsOpluqvfL/WkWODvxmX4ryuEY2u4X+v8PZDeEuqvu+BRMb4keS
 zb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=okTf8NY/wEMu8UU25kwEV3iDev+KZ+6scmOjH9nS7pc=;
 b=JnSrOvi5VaNDQdd2088Gs+WtY/uA2ulpbJCT/tpsFqQsflqO5kwkfoqf2eRNC6Xixr
 VAH+g48hOAlDcWDCGAXhqrztfE14AN7zT/8/GhMoMhcS4dvwwKgDPJsrmAg4bOhxT5Xg
 gebolQCaTVmnNkk8zqSTPpEqNyie1TnbGHfC0l0Fzf7LMwIMu0zD3CZSoKr+daWk620m
 CQM185MF0lpcBh0dMq4zQcQ7YQ0riWRh3xSjbkAJRdEshJwdS116aJvucBdEqHFcRw+d
 rxOMAmoYWi5N5P5Yd6GS+ep2GB+YKShDRs5Tm48f4HikN/BHpSELeGyBth4b6B3diX7R
 rpBQ==
X-Gm-Message-State: AOAM533v6gcP5WIHiD6awxBin3v12qc1Q3Re0H42MmCRFNuudbe5+s/H
 6VkMxtshVZLxOAoduRd8Uaxwlw==
X-Google-Smtp-Source: ABdhPJxIRuee2YizpPplNRuJiwnwaOXnsCboPRstQiA1nt1XpSe8h5iVIntI0YHrA2YNpcx6Ln+f3w==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr5170500wmj.146.1591128887349; 
 Tue, 02 Jun 2020 13:14:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c6sm60963wro.92.2020.06.02.13.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 13:14:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 224B01FF7E;
 Tue,  2 Jun 2020 21:14:45 +0100 (BST)
References: <20200529132341.755-1-robert.foley@linaro.org>
 <20200529132341.755-8-robert.foley@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 08/12] thread: add tsan annotations to QemuSpin
In-reply-to: <20200529132341.755-8-robert.foley@linaro.org>
Date: Tue, 02 Jun 2020 21:14:45 +0100
Message-ID: <87367d6x8q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qemu/thread.h | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index e50a073889..43fc094b96 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -206,6 +206,10 @@ void qemu_thread_atexit_add(struct Notifier *notifie=
r);
>   */
>  void qemu_thread_atexit_remove(struct Notifier *notifier);
>=20=20
> +#ifdef CONFIG_TSAN
> +#include <sanitizer/tsan_interface.h>
> +#endif
> +
>  struct QemuSpin {
>      int value;
>  };
> @@ -213,23 +217,46 @@ struct QemuSpin {
>  static inline void qemu_spin_init(QemuSpin *spin)
>  {
>      __sync_lock_release(&spin->value);
> +#ifdef CONFIG_TSAN
> +    __tsan_mutex_create(spin, __tsan_mutex_not_static);
> +#endif
>  }
>=20=20
> -static inline void qemu_spin_destroy(QemuSpin *spin)
> -{ }
> +/* const parameter because the only purpose here is the TSAN annotation =
*/
> +static inline void qemu_spin_destroy(const QemuSpin *spin)
> +{
> +#ifdef CONFIG_TSAN
> +    __tsan_mutex_destroy((void *)spin, __tsan_mutex_not_static);
> +#endif
> +}
>=20=20
>  static inline void qemu_spin_lock(QemuSpin *spin)
>  {
> +#ifdef CONFIG_TSAN
> +    __tsan_mutex_pre_lock(spin, 0);
> +#endif
>      while (unlikely(__sync_lock_test_and_set(&spin->value, true))) {
>          while (atomic_read(&spin->value)) {
>              cpu_relax();
>          }
>      }
> +#ifdef CONFIG_TSAN
> +    __tsan_mutex_post_lock(spin, 0, 0);
> +#endif
>  }
>=20=20
>  static inline bool qemu_spin_trylock(QemuSpin *spin)
>  {
> -    return __sync_lock_test_and_set(&spin->value, true);
> +#ifdef CONFIG_TSAN
> +    __tsan_mutex_pre_lock(spin, __tsan_mutex_try_lock);
> +#endif
> +    bool busy =3D __sync_lock_test_and_set(&spin->value, true);
> +#ifdef CONFIG_TSAN
> +    unsigned flags =3D __tsan_mutex_try_lock;
> +    flags |=3D busy ? __tsan_mutex_try_lock_failed : 0;
> +    __tsan_mutex_post_lock(spin, flags, 0);
> +#endif
> +    return busy;
>  }
>=20=20
>  static inline bool qemu_spin_locked(QemuSpin *spin)
> @@ -239,7 +266,13 @@ static inline bool qemu_spin_locked(QemuSpin *spin)
>=20=20
>  static inline void qemu_spin_unlock(QemuSpin *spin)
>  {
> +#ifdef CONFIG_TSAN
> +    __tsan_mutex_pre_unlock(spin, 0);
> +#endif
>      __sync_lock_release(&spin->value);
> +#ifdef CONFIG_TSAN
> +    __tsan_mutex_post_unlock(spin, 0);
> +#endif
>  }
>=20=20
>  struct QemuLockCnt {


--=20
Alex Benn=C3=A9e

