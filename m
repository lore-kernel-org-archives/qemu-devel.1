Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8316AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB962065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByHt/9ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB962065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvjC8-0001bQ-Jx
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1jvjBD-0000w8-Vx; Wed, 15 Jul 2020 11:18:44 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1jvjBC-0000pw-J5; Wed, 15 Jul 2020 11:18:43 -0400
Received: by mail-oi1-x242.google.com with SMTP id y22so2463921oie.8;
 Wed, 15 Jul 2020 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UPvuWRYXTVA3B60MP/QbVBgMswQXDg7xP/5F3R71GG8=;
 b=ByHt/9ZUzS5CoUrYrBDqAG3avK3LIzjJxFYl98osEQ6JZlqXNtEg/FE0v/aLvAckrD
 yudppeoZF+E0GfRXrM2wwLdVbhorZQL4srFJD7TmgFF1rKjgCC7RSc41iEQAE1ZXgmmS
 YpCC5lnleO7izUHQQ5WTT3nXyb1geE+eBlhXtJp3Q1l/6+UsBnBLWKAuTxPsirjFybTh
 IM09tdGRpMHeIMC+4W1tpW+3cSxn3Qiwr/Q0sYV/sitUu32yVhQ0DT4/kAFygv+mDwW8
 XEpLlECjq+0Swv0TfLa3WPahso8PReMaaYNTDrSmz3SR/tgeQ9qZahaOEXn0Y1u6dqjr
 fmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UPvuWRYXTVA3B60MP/QbVBgMswQXDg7xP/5F3R71GG8=;
 b=dh5KeclsErbV9kjnk8IVRplGAn0O8MFUASTZb+HiKd5W8AKwdLRfUrwR8yUDu1862V
 v4e9sKXHzuSkvTDSrLcbeYfb5zkqzShJh0wMHGFZYzoFd5rFFxd/VnW7QDax91dTmiAd
 zAt0J/6dj4/5QmhhgQi9xyu6IiJXMeQVmFARdMgMuo7tLn6mwYBfs+mM8Fzf6bLkQM+r
 Z4tT0NeE4bk7UUOBvCaCopIIO1pViyxfVbUS58QRr9HRH9yLJkNSUsySz0MuogKuikOF
 E+3Pka1ROIJMOvKP+mjVFQONB6DTQuzDjVK+gqzwSXikKIGrp10xzDno7jwwWKopC3IF
 Xivg==
X-Gm-Message-State: AOAM531j3PZbh+QgxQVbLfSuhcfaDQ5IaLS26aadgp4C+ZbPCammN0tB
 +uQej0oIJV3b5pba46WVNpzOhv4uEqhLIEf32Z8=
X-Google-Smtp-Source: ABdhPJz6wfZoT1Ufr+BH/NhQgUO3+VGUQFJauFw7XwO9wQv23Rw9ebHiLlqIkXXS4rI7t9o+o9b2yt3TYddKSXC9Yto=
X-Received: by 2002:a05:6808:486:: with SMTP id z6mr214517oid.56.1594826317753; 
 Wed, 15 Jul 2020 08:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200714160202.3121879-1-armbru@redhat.com>
 <20200714160202.3121879-2-armbru@redhat.com>
In-Reply-To: <20200714160202.3121879-2-armbru@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 Jul 2020 23:18:01 +0800
Message-ID: <CAKXe6SKGDrR=JfyURTE0TR49xF4CKzzLiAzByhCGcFExOg0rPw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 1/5] qdev: Fix device_add DRIVER,
 help to print to monitor
To: Markus Armbruster <armbru@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org,
 Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:09=E5=86=99=E9=81=93=EF=BC=9A
>
> Help on device properties gets printed to stdout instead of the
> monitor.  If you have the monitor anywhere else, no help for you.
> Broken when commit e1043d674d "qdev: use object_property_help()"
> accidentally switched from qemu_printf() to printf().  Switch right
> back.
>
> Fixes: e1043d674d792ff64aebae1a3eafc08b38a8a085
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  qdev-monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 71ebce19df..e9b7228480 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -300,7 +300,7 @@ int qdev_device_help(QemuOpts *opts)
>      }
>      g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
>      for (i =3D 0; i < array->len; i++) {
> -        printf("%s\n", (char *)array->pdata[i]);
> +        qemu_printf("%s\n", (char *)array->pdata[i]);
>      }
>      g_ptr_array_set_free_func(array, g_free);
>      g_ptr_array_free(array, true);
> --
> 2.26.2
>
>

