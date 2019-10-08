Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C72C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 08:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5599206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 08:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lc6Cm/o6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5599206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlKx-0001jb-RP
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 04:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHlJF-0000GJ-AH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 04:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHlJD-00011o-V6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 04:57:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHlJD-0000z4-PR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 04:57:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id j18so17597534wrq.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=y+Vidvv7TXrkWbSfZOJ7EI94l8zXl1XzP4pNsdfb2PE=;
 b=Lc6Cm/o69Ydd050ZmFqmISQvAXL7Rs7rP/G3q53g9d7ZJl/YevzdSnGMgeJF8ADw32
 SdHVLK6yuiyPpvHRjD9JUW7X+idiMbcYJWgK/pR+DhyFas1L8J38jUwT+WxlfYNY6ihE
 odPBFcqCG2JhHontvniDQnp05D5ziYTl6OleYQ6rnCqwc6ZBcY7J7B6GZ1KnG7+a6sl5
 0HqlZALOwnzvhqXfQqK8GWIBU05a81In6/KcSfoptGM6//S8W+13H0U4LgPE4DNcXwvj
 G2uLWM5aqykZIuEtBtB2oAJ6i4DCtTdWrn4m+mDiJ/Tt3Vl1Ow+4OcRiBdkuVPCXDo+S
 QX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=y+Vidvv7TXrkWbSfZOJ7EI94l8zXl1XzP4pNsdfb2PE=;
 b=FIngavK7+JfFj1ITCohbb/kHTXyH6684c+rNE3oFikzCpHlNNFnFqkdvH9gO2GTbMV
 bsN1qWNfn7QxIKsxNDZyHMQO4ppTCrgqex9Cgx8emXF3M2o1Vr1UewrCRJEAlUAIrsRK
 WANdiysNrejswRe1dvhowFAus3zdy0Pb44UXBaCwU9+aC5T37QWJp/6PU4++RIvkthwz
 MHVYSDNb/m6JZgEY4UGuXvhKKp9lx0MgnXCa5abY+dHTJkTeOxEJK1pMSn6oGCcrigmZ
 Mk6o2nMiACbzQiMxkFihWGsfvFzyzi09GiMalNI1jf2BpOofy33aG0swgIhdx2IWq5JS
 A9ZQ==
X-Gm-Message-State: APjAAAXm2K8VH20/fSCx/EI8ldkwAwI7839ipvJ+/N0nnJq/JjWnnUcJ
 znDvy0yons35FPZPDmY3KTH/gg==
X-Google-Smtp-Source: APXvYqwxDIaQN0YhK56LvxZIOPT7rYZbVVlYTtSofLSwZJUZUr+iV5GXeyDLqMQblAXxX/Lzv4xI7w==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr15497536wru.327.1570525049607; 
 Tue, 08 Oct 2019 01:57:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a71sm2114958wme.11.2019.10.08.01.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 01:57:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1EFB91FF87;
 Tue,  8 Oct 2019 09:57:28 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-2-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 01/19] hw/arm/raspi: Use the IEC binary prefix definitions
In-reply-to: <20190926173428.10713-2-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 09:57:27 +0100
Message-ID: <875zkzk420.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> IEC binary prefixes ease code review: the unit is explicit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/arm/raspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 74c062d05e..615d755879 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -230,7 +230,7 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->max_cpus =3D BCM283X_NCPUS;
>      mc->min_cpus =3D BCM283X_NCPUS;
>      mc->default_cpus =3D BCM283X_NCPUS;
> -    mc->default_ram_size =3D 1024 * 1024 * 1024;
> +    mc->default_ram_size =3D 1 * GiB;
>      mc->ignore_memory_transaction_failures =3D true;
>  };
>  DEFINE_MACHINE("raspi2", raspi2_machine_init)
> @@ -252,7 +252,7 @@ static void raspi3_machine_init(MachineClass *mc)
>      mc->max_cpus =3D BCM283X_NCPUS;
>      mc->min_cpus =3D BCM283X_NCPUS;
>      mc->default_cpus =3D BCM283X_NCPUS;
> -    mc->default_ram_size =3D 1024 * 1024 * 1024;
> +    mc->default_ram_size =3D 1 * GiB;
>  }
>  DEFINE_MACHINE("raspi3", raspi3_machine_init)
>  #endif


--
Alex Benn=C3=A9e

