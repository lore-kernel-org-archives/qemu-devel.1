Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7CEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD3620786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFokXrsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD3620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDCA-0001iJ-Nx
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlCx2-0007bS-NR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:52:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlCx0-0004Jy-Gb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:52:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id f185so3393629wmf.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1cihiFfCWitvUSWOAYTLl7DtlU9tgPuqHldH8rmG098=;
 b=YFokXrsDCdCmfykzGRM+3ieO4WdeWhC5pjSA0rYvGBHhHDiEzNmmtyL1DfYTCm/6Of
 sCVqk62bk3GUkcdjK9qBNSjEfJf/5fEliLRz+PxPZ5ctZjuRy1JRHhA8E5gAHMshsUSG
 BP0BvgPLXQm2ghaWn7dS3L6zrFfAFvlVj9IzipalMM5UvVAVGlq26jvS9CxLuDYHRBuw
 hDm3CH3Q6Z+OJALQMLvcbg/ZcpWMjgmlLHEHWm7DnwEZ6UYxUPAn1IMtNEB4JmCTCyTi
 KOrq7Noc+2dx3UYhUH8OnLRosTDQYi2lLSWNQ08jMQ3FFWJ1B0BS0+J6C3XTbt8kqCXz
 /6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1cihiFfCWitvUSWOAYTLl7DtlU9tgPuqHldH8rmG098=;
 b=fsjRHCApGhlNBWxZq0+JQQTTHArk46umHkiR4pTOdd3DfWeAjxROgspor8XgW1mHak
 RSHazp98Yv2H46G5qBYLjcgiZtnJNwF8/yUhHGyIjsYSVUQ4aM9ERI58eghcjf0IImfq
 qe7+DgEsFlg2NXtc4rqsF2QaFzt6VrtewP7tRztfwY1tYRHmhsyoWQ/x/k4gBXOOxf8z
 KC0g5OnjDPgPnqerFOHjUcAoZoBV5fXVr75RzvOdha8QI0JU1oTrZ3Rh54YMmXq1SPFi
 wMXYYCu4KVIbn5kxzcNDW3/JezeSyJ698je1rF9a3J8NFYVh9i3K2cV2vQLE2tkOzqKj
 GYTQ==
X-Gm-Message-State: AOAM532wJWWpNG1lHsBUaFaY3Qel0LqAcwlICHMw8lPlNa/1api4NMug
 4za6A+qNCOniG53ykYSel1F0Hg==
X-Google-Smtp-Source: ABdhPJwxWlmOYLmCOf+rNIDKzTNxejYmKx5vhyjkP7iW3YdS7cU8vTmUIqY1ByOKhB8SjUP6odj3ug==
X-Received: by 2002:a1c:2e0e:: with SMTP id u14mr3634052wmu.55.1592319153069; 
 Tue, 16 Jun 2020 07:52:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c206sm4744503wmf.36.2020.06.16.07.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 07:52:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1BA0A1FF7E;
 Tue, 16 Jun 2020 15:52:31 +0100 (BST)
References: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: konrad@adacore.com
Subject: Re: [PATCH v1 1/2] semihosting: defer connect_chardevs a little
 more to use serialx
In-reply-to: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
Date: Tue, 16 Jun 2020 15:52:31 +0100
Message-ID: <87tuzbyseo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


konrad@adacore.com writes:

> From: KONRAD Frederic <frederic.konrad@adacore.com>
>
> With that we can just use chardev=3Dserial0.

I don't quite follow what this means.

./aarch64-softmmu/qemu-system-aarch64 -cpu max -monitor none -chardev=3Dser=
ial0 -M virt -display none -semihosting -kernel ./tests/tcg/aarch64-softmmu=
/memory
qemu-system-aarch64: -chardev=3Dserial0: invalid option

./aarch64-softmmu/qemu-system-aarch64 -cpu max -monitor none -chardev id=3D=
serial0 -M virt -display none -semihosting -kernel ./tests/tcg/aarch64-soft=
mmu/memory
qemu-system-aarch64: -chardev id=3Dserial0: chardev: "serial0" missing back=
end

The run:

./aarch64-softmmu/qemu-system-aarch64 -cpu max -serial mon:stdio -M virt -d=
isplay none -semihosting -kernel ./tests/tcg/aarch64-softmmu/memory

works fine without this patch.

>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  softmmu/vl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index f669c06..9b8b48a 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4123,8 +4123,6 @@ void qemu_init(int argc, char **argv, char **envp)
>=20=20
>      qemu_opts_foreach(qemu_find_opts("chardev"),
>                        chardev_init_func, NULL, &error_fatal);
> -    /* now chardevs have been created we may have semihosting to connect=
 */
> -    qemu_semihosting_connect_chardevs();
>=20=20
>  #ifdef CONFIG_VIRTFS
>      qemu_opts_foreach(qemu_find_opts("fsdev"),
> @@ -4271,6 +4269,9 @@ void qemu_init(int argc, char **argv, char **envp)
>      if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>          exit(1);
>=20=20
> +    /* now chardevs have been created we may have semihosting to connect=
 */
> +    qemu_semihosting_connect_chardevs();
> +
>      /* If no default VGA is requested, the default is "none".  */
>      if (default_vga) {
>          vga_model =3D get_default_vga_model(machine_class);


--=20
Alex Benn=C3=A9e

