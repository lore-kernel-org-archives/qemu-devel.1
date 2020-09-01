Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFE1C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A455F206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKPXdUhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A455F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD4Gx-0004XV-Ml
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kD4G8-0003nd-Nm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:15:28 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kD4G7-0006IH-4r
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 07:15:28 -0400
Received: by mail-oi1-x242.google.com with SMTP id u24so788449oic.7
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o+WdRsrzaXJgVBjiSFWnEjD5HPcR1A+9btYWGAcRI5s=;
 b=QKPXdUhAPzwp01UmSmrjiFh1ZbnSLBzjfYlZ+X0ak7kTP7YlI7ZojL/ErHLALzgWOL
 oiePzZEzGmjjS7+fiaO0LQWEchc+4soSd+vB7DZ2xL6oBguWJ57pvF5absnj5m2R3IKd
 vX0dDi9SHTGniZv5WEjeJr63Bctf4XFDFaI0zwAwZ+1hFXMZffXt+VTlD7+S0efPXwsS
 CVkY005IK5ggrWndVMIXQROw3MsyL2k3Rjo8+HJwtETpz82/FRWEiZfO6xuzNHoCJEe+
 355tG0bbGr9HFJq1TNhMULTQXgGQ1pkebS5kpAoWqry2rmAbMY88pndcl8IyOq/n5LfR
 /LPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o+WdRsrzaXJgVBjiSFWnEjD5HPcR1A+9btYWGAcRI5s=;
 b=NIg0bnSm2Ss5a84XjreebwWc4ZGZVwa7RxGTUSX01uE6y3fRLCIrBbElzQVVGeVaT0
 MnpG4uOXdVAxBKJ8N9xevPirABPE0TlEd7IvlCq4uXOT1Fi7lOQQ44MBHpx01FnHs3R/
 hJ2AYQajlW0nl2BN/xWibc3IM4sec9I/Oz9UmZx/8DPrtDBSnsY6+ayx7+fAEeBKBOYA
 er8WkEN/nv2c10pQuzB7aT3O/96ayL+/idV7hb8byuRIfRVVRQV5D0DYk1A01FClRVVd
 TmM1viOAV0tb8jyS1r0ymPYvUHMCMLGajqp7eRGqvypeo1F4aiDfdu4rMDy5GtYt169M
 pY+Q==
X-Gm-Message-State: AOAM532WkZneaej4t6A8HRwfYeXTqfhOy4EMtOUrtkftksgOXdiE4Gmm
 cwl7E6l0zl18nAIYb8Bd0ttSSGsq7LMjMoVAGZQ=
X-Google-Smtp-Source: ABdhPJwv1TZ9Oz++kSrmORbJGJtKMGSWV5u1aFqtno9tOLOibCTgAPZRRXB3JkQ0hMXMkKbn7RGkuWiVGa2J4f+KmIE=
X-Received: by 2002:a54:400a:: with SMTP id x10mr739626oie.150.1598958926082; 
 Tue, 01 Sep 2020 04:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200831134315.1221-1-pannengyuan@huawei.com>
 <20200831134315.1221-8-pannengyuan@huawei.com>
In-Reply-To: <20200831134315.1221-8-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 1 Sep 2020 19:14:50 +0800
Message-ID: <CAKXe6SKdUe-0N8cjmhD05a_SiFriAin7-Q0roQSFCAE0wmRtBQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] migration/colo: Plug memleaks in
 colo_process_incoming_thread
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8831=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:17=E5=86=99=E9=81=93=EF=BC=9A
>
> 'local_err' forgot to free in colo_process_incoming_thread error path.
> Fix that.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> ---
> - V2: Arrange all 'error_report_err' in 'out' label(suggested by Li Qiang=
).
> ---
>  migration/colo.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index ea7d1e9d4e..2288188fe2 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -888,7 +888,6 @@ void *colo_process_incoming_thread(void *opaque)
>      while (mis->state =3D=3D MIGRATION_STATUS_COLO) {
>          colo_wait_handle_message(mis, fb, bioc, &local_err);
>          if (local_err) {
> -            error_report_err(local_err);
>              break;
>          }
>
> @@ -924,6 +923,10 @@ out:
>          qemu_fclose(fb);
>      }
>
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
> +
>      /* Hope this not to be too long to loop here */
>      qemu_sem_wait(&mis->colo_incoming_sem);
>      qemu_sem_destroy(&mis->colo_incoming_sem);
> --
> 2.18.2
>
>

