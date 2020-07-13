Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8253BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F7B206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/mqKLzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F7B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juyIG-0006Ez-JB
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 09:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juyHU-0005gB-Rf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:14:05 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:46572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juyHQ-0006b7-Vi
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:14:04 -0400
Received: by mail-ot1-x332.google.com with SMTP id n24so9427747otr.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wi2y8B/kxUO6uxbWhWcAoCCVK8MlS9K3d4lBVA5Npkk=;
 b=I/mqKLzGWBf8gqO/bg6FoA6j50r8ZiF3aO5Ds9D2otCWEOE916aC5MFNHpsL4ZWk98
 WQXmuGgzjre1tFgFgicjeUgnxDanvwhk9GMxnro4Cgr0AlCfUlIobuHxiB5KRy/XLQOJ
 Lyw5FfU83gw3sads2nx2NHd4pLHecMd6ZzzP2nvUKY7O34AapaN5Z8pItXRQKiGn2Djo
 1L2Ry4r/dZWCBTUhS60QFm08PCyw8n4UcF2W+wZ6KRMDk8JiSNWbwvk2AWoWCKxNQ7jz
 GsoCZhpmPhsakg1B8lDyM1YF7J+eMadjfw65l+2EsJQ3315pGAipyR+ccN0LsdhLprQo
 /QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wi2y8B/kxUO6uxbWhWcAoCCVK8MlS9K3d4lBVA5Npkk=;
 b=Z6VZbkdJJ5nzr6Gh1HsGQH1Ss7OSH0hjVTUTw4AVVG84J/nOUQDbJWirFJtscvYbTO
 SYhsodRm17V14m5tx8CfmKqUHYg3hEYd3BZkvCazWvfOEh3lLV0Tg8yGi9l3APwgABfV
 P1vWLivhO7UZN9kiRprqIodIEfEenhJ2DxpsoRufn2vgM9FAIeHtG0LEngmWQGMzN0px
 zfswmMCd6GYupeq1teOMcZzAqxne84aiIX7no4Cqda6SYSOPh3baY5mBEhWstWL5xOvZ
 o0xyprWInoUaAgJzpM3u6GS/GEEllcxiYETISwsnFzrbJiqjqxEoLVruHFkY4ZgFI/TO
 VV3Q==
X-Gm-Message-State: AOAM533ALdRYA+aBia5RCk2cuMSYgYF6dIeIMGFt4rQG35LL4Q55UWmH
 /mPuhp4EGGTyZDSt1HV1oEIQXeReoFK/9pCy+mqSRQ==
X-Google-Smtp-Source: ABdhPJxtMRR2lO3NcgnCnrqQUEq9dD1/0RAzHP40F5d8/Az557MLtmDwZpNzj7yQhlp9iaV/H4sGTcqKFAQYdCu1qMA=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr62980868oto.135.1594646039882; 
 Mon, 13 Jul 2020 06:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200704163927.28188-1-philmd@redhat.com>
 <20200704163927.28188-4-philmd@redhat.com>
In-Reply-To: <20200704163927.28188-4-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 14:13:49 +0100
Message-ID: <CAFEAcA8v2rEC0T_=D1Bat9DQJ=YS57fRUDDQyFdxJsEB=OEPMw@mail.gmail.com>
Subject: Re: [PULL 3/5] softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Jul 2020 at 17:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> The 'gen_id' argument refers to a QOM object able to produce
> data consumable by the fw_cfg device. The producer object must
> implement the FW_CFG_DATA_GENERATOR interface.
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-Id: <20200623172726.21040-4-philmd@redhat.com>

Coverity points out (CID 1430396) an issue with the error handling
in this patch:


> @@ -2052,6 +2056,15 @@ static int parse_fw_cfg(void *opaque, QemuOpts *op=
ts, Error **errp)
>      if (nonempty_str(str)) {
>          size =3D strlen(str); /* NUL terminator NOT included in fw_cfg b=
lob */
>          buf =3D g_memdup(str, size);
> +    } else if (nonempty_str(gen_id)) {
> +        Error *local_err =3D NULL;

We set local_err to NULL here...

> +
> +        fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);

...but we don't pass it to the function here...

> +        if (local_err) {

...so this condition is always false and the body of the if is dead code.

> +            error_propagate(errp, local_err);
> +            return -1;
> +        }
> +        return 0;
>      } else {
>          GError *err =3D NULL;
>          if (!g_file_get_contents(file, &buf, &size, &err)) {

thanks
-- PMM

