Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE7BC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332782085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSe5n18g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332782085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffcR-0006Bh-I2
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <atar4qemu@gmail.com>) id 1hffWd-0002O2-LI
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1hffWZ-0001ry-9v
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:05:53 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:36613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hffWX-0001nm-Re
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:05:50 -0400
Received: by mail-io1-xd41.google.com with SMTP id h6so904658ioh.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1C4B+hlARBNNcnI71RNZNmqn/ceaZrea5U2OySrK9Ns=;
 b=NSe5n18gxqwr9PgyugEZvnJ/g0fWznClE5EDIZIpz8xCMJcwjKI8tJOvXMBCx885n6
 ctzcHBziCg+lYZBCC/ViLfGGsSQWhxiMETqApVYd3nULsYadetPkW7IpfyNWIIxY2KNl
 wqOBkh85itfMV5GRS8Zn0Sp9TBkRhl6LUdDxsBoC1h13dFysFsbdyZm4LlBJ+FapnPlz
 5Rq/Gcm2fg53tUJITk+9gnfIB7SmBRedxxrjj7ugXY6LPNW1MnOBo/s2Bab97E+mk85c
 CbNjoB5Kp8OQ28uTgFvSwkYVwSM40oQSUSkg0IWJI95jK3xPX/P3kZXpj9CO//vTFgsJ
 wWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1C4B+hlARBNNcnI71RNZNmqn/ceaZrea5U2OySrK9Ns=;
 b=WIS/ICyQPHlgRDMsvFdOwYRFNF3AlyKseoqCU50NaLszBC9Ymvs/R8cwyEZQaXVAUP
 02Ojb0PeUGf5+HcQW3Er4VitNA8tDipmAv0GUsMTtCNB5wSDaVWB2/ghBgClRCbbKikY
 MLhhc8uSWkPTyvySkvCm054k6XHkfsvGUA5dtD+PCK92OVDoLOVf0LueygFTb/4W7Xbg
 L3wEOVTRSOKnyF3LnuWybstxANNplJW/sLp2jxCo/BjsyZaC9aBE85XMLIE/ypbYE/SP
 vlalKoBWjeh36QLX8SjPz3TC2H5GbS1PV0mByqSLBLTyuzcmniuMj1sTbzpNjqEzS1YO
 A/6A==
X-Gm-Message-State: APjAAAXDXAlP4Y0CB4xDasgOaMshyxjnAYoZhiRObiEHd+pctxh/qJAB
 H0aIz+CVgwlPd2Q+K1IrapgvzkUxeUNpi6k0wL6pkgI1
X-Google-Smtp-Source: APXvYqyIQswVALhQeWRAwN3DVYtzSfHCtrQO3vmF9Yya5pkfYJiyjOZPYS/Sb9hQJ7+nOyPReECmi2XgzIYsu1UliC8=
X-Received: by 2002:a02:cd82:: with SMTP id l2mr703193jap.96.1561446343504;
 Tue, 25 Jun 2019 00:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190624220056.25861-1-f4bug@amsat.org>
 <20190624220056.25861-6-f4bug@amsat.org>
In-Reply-To: <20190624220056.25861-6-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 25 Jun 2019 09:05:32 +0200
Message-ID: <CACXAS8D0VgXeRfufVLhm8SmtmQ-gK_DX-1OoSQmPLn-aPTcBdQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [PATCH 5/9] hw/misc/empty_slot: Add a qdev
 property 'name'
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 12:01 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> If few commits empty_slot_init() will take 'name' as argument.
> Meanwhile, initialize it as 'empty-slot'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/misc/empty_slot.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
> index ef0a7b99ba..c32241a9e5 100644
> --- a/hw/misc/empty_slot.c
> +++ b/hw/misc/empty_slot.c
> @@ -32,6 +32,7 @@ typedef struct EmptySlot {
>      SysBusDevice parent_obj;
>
>      MemoryRegion iomem;
> +    char *name;
>      uint64_t size;
>  } EmptySlot;
>
> @@ -78,14 +79,18 @@ static void empty_slot_realize(DeviceState *dev, Erro=
r **errp)
>          error_setg(errp, "property 'size' not specified or zero");
>          return;
>      }
> +    if (s->name =3D=3D NULL) {
> +        s->name =3D g_strdup("empty-slot");
> +    }
>
>      memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
> -                          "empty-slot", s->size);
> +                          s->name, s->size);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>  }
>
>  static Property empty_slot_properties[] =3D {
>      DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
> +    DEFINE_PROP_STRING("name", EmptySlot, name),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.19.1
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

