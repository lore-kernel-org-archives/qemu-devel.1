Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA49C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 02:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E349F20731
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 02:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE0pHy3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E349F20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRQx4-0000FS-T8
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 22:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kRQwW-0008HD-8H
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 22:18:36 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:38568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kRQwU-0006jD-9I
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 22:18:35 -0400
Received: by mail-ot1-x336.google.com with SMTP id i12so12648382ota.5
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 19:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X2MojMWifwNabScR2H/536Be4Oh/znpRJCyjLvWLyB0=;
 b=TE0pHy3qEUK+NWmZdBF5PmJTR4MifUq5K61XPtk7St0AiOlPO7DlpL7s4oqR3+pYdF
 t0Fnb2iPVPOHDn/N/NRGxEgY8zwsaOuxXGoEQzXbPm6F1MAF0sJffmTCBwTjfmxFEi1+
 49olfJBEXWrU3JZi6YNon9EsZYlubw/ENP8DAaWAjNjUMYpjcUKnZd4a1+vaP2d1Zcaa
 H2uaPwQ6RnI8/lp5f9WGDmqjj4FfjUJv5udTdJZfbDpPSqb/BJa6RmfThl6EQouBWz3x
 AxyMoUiS/qyFUtwQTb6N+P1Q1al52TDzSo9ZoycARr2KaoIsVAk2W7DSyX5LzllvQrq2
 QDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X2MojMWifwNabScR2H/536Be4Oh/znpRJCyjLvWLyB0=;
 b=jjGOSprkS3so5CZXHAUJuMI6Evhnb4dYAGzea0zqD9TJJIhxH2WGEG1NJvcNOti/96
 GTvldODqGm9yzehPK0XXD8ledFTLLEgO2kqYWhfVrcBxfKZZ3Jw0yDfMR99+qZK4C1vp
 C5D0n6JnwZdEaTGZ4S83RNXQrhP9KbB/yhBdAEbNfQgza1YyrITEFImdLJIpeEaci/S5
 dyu8sbS/hChrFVbCnMFEF5J9EVnh3aWsxnqE+dsKt8u0oQie65Ywyo0OOBu2W+ar2Ts2
 5TUS+bzHaFOb+9vZK1IGZ5xxKLXpSDf3boegKkM+1zMm3xzyOI9vqA45iBoibg/5U/RV
 SG6w==
X-Gm-Message-State: AOAM531y0NsYoLVRw2eKnnEVKhhVSvNkRb+tZFRp8OfYAhI4WXCfkcUT
 vxG5iRyaJ7zo8jOmFzfq4tpFI/JzUtSwmbhMwSs=
X-Google-Smtp-Source: ABdhPJw2ylYtTurz7/BBNeqzaHxCoNHmLEP7lPg4e+hhTce14oXtokBYT+uiiwAkT9HXEYXuY6nCe+9o/nTvFB862wY=
X-Received: by 2002:a9d:1a2:: with SMTP id e31mr10761895ote.181.1602382712828; 
 Sat, 10 Oct 2020 19:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200904134529.1317-1-pannengyuan@huawei.com>
In-Reply-To: <20200904134529.1317-1-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 11 Oct 2020 10:17:56 +0800
Message-ID: <CAKXe6S+Y1FDyWX=onEu7GBiFGwGo+7iUs4B7s-er9QRZEKV_3A@mail.gmail.com>
Subject: Re: [PATCH] target/i386/cpu: add return value verification and ignore
 Error objects
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x336.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=883:19=E5=86=99=E9=81=93=EF=BC=9A
>
> 'err' is unnecessary in x86_cpu_class_check_missing_features(), we can ch=
ange x86_cpu_expand_features()
> to return true on success, false on failure, then pass NULL here to remov=
e it.
>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  target/i386/cpu.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 49d8958528..c3d3766133 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4883,7 +4883,7 @@ static void x86_cpu_parse_featurestr(const char *ty=
pename, char *features,
>      }
>  }
>
> -static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
> +static bool x86_cpu_expand_features(X86CPU *cpu, Error **errp);
>  static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
>
>  /* Build a list with the name of all features on a feature word array */
> @@ -4925,7 +4925,6 @@ static void x86_cpu_class_check_missing_features(X8=
6CPUClass *xcc,
>                                                   strList **missing_feats=
)
>  {
>      X86CPU *xc;
> -    Error *err =3D NULL;
>      strList **next =3D missing_feats;
>
>      if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
> @@ -4937,8 +4936,7 @@ static void x86_cpu_class_check_missing_features(X8=
6CPUClass *xcc,
>
>      xc =3D X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
>
> -    x86_cpu_expand_features(xc, &err);
> -    if (err) {
> +    if (!x86_cpu_expand_features(xc, NULL)) {
>          /* Errors at x86_cpu_expand_features should never happen,
>           * but in case it does, just report the model as not
>           * runnable at all using the "type" property.
> @@ -4947,7 +4945,6 @@ static void x86_cpu_class_check_missing_features(X8=
6CPUClass *xcc,
>          new->value =3D g_strdup("type");
>          *next =3D new;
>          next =3D &new->next;
> -        error_free(err);
>      }
>
>      x86_cpu_filter_features(xc, false);
> @@ -6426,7 +6423,7 @@ static void x86_cpu_enable_xsave_components(X86CPU =
*cpu)
>  /* Expand CPU configuration data, based on configured features
>   * and host/accelerator capabilities when appropriate.
>   */
> -static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> +static bool x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>  {
>      CPUX86State *env =3D &cpu->env;
>      FeatureWord w;
> @@ -6436,14 +6433,14 @@ static void x86_cpu_expand_features(X86CPU *cpu, =
Error **errp)
>      for (l =3D plus_features; l; l =3D l->next) {
>          const char *prop =3D l->data;
>          if (!object_property_set_bool(OBJECT(cpu), prop, true, errp)) {
> -            return;
> +            return false;
>          }
>      }
>
>      for (l =3D minus_features; l; l =3D l->next) {
>          const char *prop =3D l->data;
>          if (!object_property_set_bool(OBJECT(cpu), prop, false, errp)) {
> -            return;
> +            return false;
>          }
>      }
>
> @@ -6540,6 +6537,8 @@ static void x86_cpu_expand_features(X86CPU *cpu, Er=
ror **errp)
>      if (env->cpuid_xlevel2 =3D=3D UINT32_MAX) {
>          env->cpuid_xlevel2 =3D env->cpuid_min_xlevel2;
>      }
> +
> +    return true;
>  }
>
>  /*
> --
> 2.18.2
>
>

