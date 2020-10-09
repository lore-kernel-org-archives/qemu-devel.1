Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50446C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF0A22260
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvTJD6FV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF0A22260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtzz-00011k-OJ
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kQtz4-0000Vi-R4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:07:02 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kQtz2-0002ov-PI
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:07:02 -0400
Received: by mail-oi1-x242.google.com with SMTP id z26so10455455oih.12
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aVWV8axxFHUgN0Swdr732S7Iy4Lvx5YMOPPbvl4+XgE=;
 b=uvTJD6FVC6UDD7f8OvZO4DAZdFEDVRcdoSIj66c2FUGE+FN/YlRp3WL2CtqTRB3rLl
 L2Rs8k1Eq+buvLF6rfYHBBaP+tNo+DIVCSKOS9CUnhGfH3BrXdR7KL4o0JVi0Sd2VmFr
 XBBNKvwbA4J7wvY7hS6xhjwIcfrOmg3109qB1c1bdZm1398H4HdIngVe5UUQE8/cx8Lv
 YGH1OCk9U8legwWNiz6bIXWs7IHwpBgcylGOMLdboC9zVLgAaKVZ76wjrIUKOpKrO/Mf
 2UYfQ8wOjXGm3KvrUL8I5Mp59M2RsnGbo233fqzPXiWnEb6WUTXTiN1GGDUhgbYHyV6m
 ROfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aVWV8axxFHUgN0Swdr732S7Iy4Lvx5YMOPPbvl4+XgE=;
 b=sje42slAqvcxjcPc3ZL16i4te/Mo8A4ooQ8TYOoDIOJlTj2ftG6H9Cmf63S6H75Rtn
 wVtaY1ATcLvR09eOJAtERnX54ZAb80kBBncpooLGweH+cyELFQDn7g4eqU+yGRhi9PZU
 CXcVNbbaZuwdJ4jYDPjC1ptvebY8E6dJLM/XcePKCrc0+UvV0wu6jjGO+GbceGi/3+yP
 QzvCHKtEv3YviJpGtMYEuFjh1rApCca7Fm6wHLtIWn+DIfd7E9sGb2FRJ9c7quZ62vF6
 fuGadap9vdYSudmQPYtA37jcdX64TnENLyWLZZGbkd0rbnvI7iluWWdf9XdM+5fAjq1L
 NPqA==
X-Gm-Message-State: AOAM531r6WPgYDSKC5PACju6PHgWTjmgp4b/jptBTXJhxUhTNleWTcPT
 5ar32aEVDtpfaRF82X4i9M45RS661t7OSwfLV9E=
X-Google-Smtp-Source: ABdhPJzMfBOqpky22cB4EZpuRB/qQ/L3iOXM6bhfd/fnFOxJ++w2dUCriwpnrqbnBwq5ZUj2+DqAu8dO3lZBsKYgTWc=
X-Received: by 2002:aca:49ce:: with SMTP id w197mr2892698oia.56.1602256019254; 
 Fri, 09 Oct 2020 08:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201008202713.1416823-1-ehabkost@redhat.com>
 <20201008202713.1416823-2-ehabkost@redhat.com>
In-Reply-To: <20201008202713.1416823-2-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 9 Oct 2020 23:06:23 +0800
Message-ID: <CAKXe6SJMtw3rnHp8nCtUZMATSA39aqS2=G=ihHWav40UifXi4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] authz-list-file: Fix crash when filename is not set
To: Eduardo Habkost <ehabkost@redhat.com>
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=884:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Fix the following crash:
>
>   $ qemu-system-x86_64 -object authz-list-file,id=3Dobj0
>   qemu-system-x86_64: -object authz-list-file,id=3Dobj0: GLib: g_file_get=
_contents: assertion 'filename !=3D NULL' failed
>   Segmentation fault (core dumped)
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  authz/listfile.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/authz/listfile.c b/authz/listfile.c
> index cd6163aa40..aaf930453d 100644
> --- a/authz/listfile.c
> +++ b/authz/listfile.c
> @@ -122,6 +122,11 @@ qauthz_list_file_complete(UserCreatable *uc, Error *=
*errp)
>      QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(uc);
>      gchar *dir =3D NULL, *file =3D NULL;
>
> +    if (!fauthz->filename) {
> +        error_setg(errp, "filename not provided");
> +        return;
> +    }
> +
>      fauthz->list =3D qauthz_list_file_load(fauthz, errp);
>
>      if (!fauthz->refresh) {
> --
> 2.26.2
>
>

