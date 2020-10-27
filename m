Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD0C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AD0207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIijWV1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AD0207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNUS-0004lg-Ov
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXN06-0001gl-Oi
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:18:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXN04-0003gC-7e
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:18:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so1428465wrv.7
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/JAMWTyJxknfjwX2Imb1ga8zIqZIhso4vz4zfe3br3s=;
 b=WIijWV1CTQlUFL/rT+qNQri0YuvyHUzCh4NmfTMW1cHuhKO0bpnGBzTOKEndN2C1Xd
 juznBQyPXYST6YTzeJsPTi9gBDRUcHFSyrT14cpIacXABBI3Gec9ZTWSPUjD7aEqAfY1
 CzGI8gpMDwRY7klXFGFE59dtCWDd4x5YTqpRBfp+wcqfFjN8oXOojb/iESaSPyR9qY+a
 Jy10WkmWwsgPFlpKKRqYby/O9dFl/33AA+YybLnTbCN6KlgxbDmuSozKodXobxbFSLAQ
 6IK7pu2xI+Mk0SfDlXDcnI3hVyYBNff5/0SD+oUe+m3XrUg+LjaoGSeQlkCYvbzsUEls
 DeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/JAMWTyJxknfjwX2Imb1ga8zIqZIhso4vz4zfe3br3s=;
 b=tvP9XfT+kD2Eep22VynBMxs1yNlf6271ooN2Pp82CSOF/b8BRyBAmDLwjmLwLT2kSC
 lR+1rn8vvFyUZT287vqkBxm22Jr9aF4zya5f4BVzgx3KLC9NDdauZgWlGpLM4LWJB88V
 QTg87l/j3knbNX7LmpmECQbbYJXMq2McUvSUn/uZet7jjQep9VOE+0sjxsIVQRsOtE9E
 AgZ5U4rjwoGkAVer5OU4PU2QUgAg/o5PlopCM0THt3GkALKFOQbrrj/orXmkfIeoTEN0
 USVtP/2st75TxkP1KR7qKq9FIX7EKDsJL0LN2l/2V1Bem7qlVlw1itBzhP7GQojl0cJv
 KShQ==
X-Gm-Message-State: AOAM5305oujcCoPpknsIbv4QodwoBDesSIb9Ge+E+yijcmEs0jucooYV
 EB2CHjiyjp+GTHUDqdZ8FY7F1WG4XK4YQg==
X-Google-Smtp-Source: ABdhPJwGVmUzNORg94z7kxwoCVA4gYJ5UEvDkfcYpUOGJkE+4TleVt537Pifcj9ytBajnu03VPcYAg==
X-Received: by 2002:adf:f305:: with SMTP id i5mr2270910wro.346.1603797525510; 
 Tue, 27 Oct 2020 04:18:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n9sm1622150wrq.72.2020.10.27.04.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:18:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9D3241FF7E;
 Tue, 27 Oct 2020 11:18:43 +0000 (GMT)
References: <20201021205716.2359430-1-pbonzini@redhat.com>
 <20201021205716.2359430-2-pbonzini@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/22] semihosting: fix order of initialization functions
In-reply-to: <20201021205716.2359430-2-pbonzini@redhat.com>
Date: Tue, 27 Oct 2020 11:18:43 +0000
Message-ID: <87sg9zex2k.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org, berrange@redhat.com, jsnow@redhat.com,
 ehabkost@redhat.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> qemu_semihosting_console_init uses semihosting.chardev which is set
> by qemu_semihosting_connect_chardevs.  Thus qemu_semihosting_connect_char=
devs
> has to be called first.

It looks like this is reverting 619985e9 ("semihosting: defer
connect_chardevs a little more to use serialx"). Looking back at the
history it seems the two calls had different results:

  Right - can confirm the difference between:

    ./aarch64-softmmu/qemu-system-aarch64 -cpu max -serial mon:stdio -M vir=
t -display none -semihosting -kernel ./tests/tcg/aarch64-softmmu/memory

  and

    ./aarch64-softmmu/qemu-system-aarch64 -cpu max -serial mon:stdio -M vir=
t -display none -semihosting-config chardev=3Dserial0 -kernel ./tests/tcg/a=
arch64-softmmu/memory

With this patch applied it breaks the later invocation:

  ./aarch64-softmmu/qemu-system-aarch64  -cpu max -serial mon:stdio -M virt=
 -display none -semihosting-config chardev=3Dserial0 -kernel ./tests/tcg/aa=
rch64-softmmu/memory
  qemu-system-aarch64: semihosting chardev 'serial0' not found

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  softmmu/vl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 6f5b000f07..42314e6ff9 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4288,7 +4288,8 @@ void qemu_init(int argc, char **argv, char **envp)
>      qemu_opts_foreach(qemu_find_opts("mon"),
>                        mon_init_func, NULL, &error_fatal);
>=20=20
> -    /* connect semihosting console input if requested */
> +    /* now chardevs have been created we may have semihosting to connect=
 */
> +    qemu_semihosting_connect_chardevs();
>      qemu_semihosting_console_init();

Maybe instead of this we should:

>=20=20
>      if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
> @@ -4298,9 +4299,6 @@ void qemu_init(int argc, char **argv, char **envp)
>      if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>          exit(1);
>=20=20
> -    /* now chardevs have been created we may have semihosting to connect=
 */
> -    qemu_semihosting_connect_chardevs();
> -

Move both here:

    if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
        exit(1);

    /* now chardevs have been created we may have semihosting to connect */
    qemu_semihosting_connect_chardevs();
    qemu_semihosting_console_init();


>      /* If no default VGA is requested, the default is "none".  */
>      if (default_vga) {
>          vga_model =3D get_default_vga_model(machine_class);


--=20
Alex Benn=C3=A9e

