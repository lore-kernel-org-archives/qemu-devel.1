Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA53DC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 04:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A7920888
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 04:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABxgVg3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A7920888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLfQN-0008E8-48
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 00:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kLfOY-0007lm-M7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 00:31:42 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:39376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kLfOW-0000rW-LK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 00:31:42 -0400
Received: by mail-oo1-xc44.google.com with SMTP id c4so444792oou.6
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 21:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cxC/Me4wo8R0Sdcbv7ri3F/8sV9B8UGKFvyhXXhpAHg=;
 b=ABxgVg3ku+0dDEQru3l4+DhaWg7JW6sJc3cnrRcQaQ96dYj4ABwE6MwzErxlQQuhTh
 97bY3pFA+MmDjbTW28GqksA573Wfm4ajn/Yn37zPYhTEzAt2Wl6c3/SJB/G5C8ZHfLsR
 hwlNhm0lkhQFRpAtQf5yDPII5BHK2n0uSa09T1Ch4SkCUkuohdlQ1iRKvR2B/zmGWGMa
 Pq5q3ZoYQ7W349+4zFyC0h+lW/XTv1BcVN9Mzc3NodfW9ysktvyA918a+9qXK4ci39MQ
 TImlK91iKlOt1876FODkXnGmNp3Ypklkos/E5AanVsjk/KzPczvpLbMYDDXdNuaeyWdn
 3F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cxC/Me4wo8R0Sdcbv7ri3F/8sV9B8UGKFvyhXXhpAHg=;
 b=NtBFGl8GlnaxcaL/JEJj0p/pvKy/GmwW+BAHA1HkSNfz+BCu2Vokr+4RLf5XfIUInP
 XtljWdvbTuc/K/6f5rTm82mhwjK3lcDsy6QKTyMAVPU8j/7TdnZokiai4FcUIewiFM21
 EBxvhlyhtkdWzMNrWXFdjecUAOoXtLvOLpwAbiquhaZRmCK3gkcrwT2vEcxnQiQUR0F+
 YhnLBHxo5SUSiBn1M3KdxZNxTIAJmd6PexXnZpKwW814KRNMOAL83EOMjiNcY2vXZqSj
 Rm/t7s4AelYfZdFl7uHmBas7yJwzBiUhOhG2hzS29KYZHgxCjfyoK02lL9YK7mOUEn0S
 HsOA==
X-Gm-Message-State: AOAM531+TieXy5QyhkRV7tdRfqz2qKxNroV/mGcACalndb8o8Y9ZHtPY
 tO55FZKlXgJnBKW+htRV+ZzvE4Kywx3F/Gdc0q8=
X-Google-Smtp-Source: ABdhPJye9Oam4odqDaaA6XwCkPUPhOAgWDPuymwqKauW/QBUPpBQwpL66U7SNP33zJXyIzTDgoi2H8L4Rfgh/70JV/w=
X-Received: by 2002:a4a:5a06:: with SMTP id v6mr1800621ooa.22.1601008298937;
 Thu, 24 Sep 2020 21:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200925021808.26471-1-colin.xu@intel.com>
In-Reply-To: <20200925021808.26471-1-colin.xu@intel.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 25 Sep 2020 12:31:03 +0800
Message-ID: <CAKXe6S+mTnwDEgsk0NQCWaaa+DTedmXOuhPUuyi+pZDynzGNEQ@mail.gmail.com>
Subject: Re: [PATCH] input-linux: Reset il->fd handler before closing it
To: Colin Xu <colin.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Colin Xu <colin.xu@intel.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8810:18=E5=86=99=E9=81=93=EF=BC=9A
>
> If object-del input-linux object on-the-fly, instance finalize will
> close evdev fd without resetting it. However the main thread is still
> trying to lock_acquire/lock_release during ppoll, which leads to a very
> high CPU utilization.
>
> Signed-off-by: Colin Xu <colin.xu@intel.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  ui/input-linux.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ui/input-linux.c b/ui/input-linux.c
> index ab351a418701..34cc531190f9 100644
> --- a/ui/input-linux.c
> +++ b/ui/input-linux.c
> @@ -418,6 +418,7 @@ static void input_linux_instance_finalize(Object *obj=
)
>
>      if (il->initialized) {
>          QTAILQ_REMOVE(&inputs, il, next);
> +        qemu_set_fd_handler(il->fd, NULL, NULL, NULL);
>          close(il->fd);
>      }
>      g_free(il->evdev);
> --
> 2.28.0
>
>

