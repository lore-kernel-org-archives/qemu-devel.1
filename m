Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41014C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6D92146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiRXd7Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6D92146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDy2J-0002yP-Qd
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDxzS-0001Qx-5v
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDxzP-0003fJ-Qm
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:41:26 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDxzO-0003dl-OX; Fri, 27 Sep 2019 17:41:22 -0400
Received: by mail-lf1-x141.google.com with SMTP id c195so2949952lfg.9;
 Fri, 27 Sep 2019 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7ai9FymlssHTVJ4+wNEtq7TIzct8wXX8me30CyW3QFY=;
 b=HiRXd7Lhf/8C74qUaHhNE3cN7F/mxSI5XjATRDWQqDuSkMLHEnfu5NSf0bG/20hxFa
 np/DGvZlapEFJuY6Tqq7wjHrRRmqbRdYWu5FXj9ecx5r9lDWtPywyyJZLHGD/OEML5kk
 XWoP7On7xRNOT9Q8FPTX8yd8ZeuBXm4x1jAUUsjdPEA9iNFaJxyQq9q8GLENkKqZVN13
 Baaam1R4x8MduaAWQuh9YzVtcxy5WapuoihmqgjTMt9CX6qfHAhZkabP8wrBEx2KVjXq
 inKgpDHsFh9eUuZmPYvup9H0RLHwyhiEXRMT0tWFRRedmHXuNOIprfUqVT8iEQmXCjoc
 We2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7ai9FymlssHTVJ4+wNEtq7TIzct8wXX8me30CyW3QFY=;
 b=IgbV8QmoeJ6m/40aDBakLLC/6Rixqcf8dAjrEY6FKI3iJB1MF/gnrw1T5/rD1fZWZs
 sHM89yjObq57s4RmOzdMDoPaPoyRQxUFN06dIFcZdf01dfk4r+dmOxJsvbDzVigbJBBG
 csdv00Z9wf67CP66VKk03aoIieSvXHEFQyJfA+aD7eiMQjtKJ1eJc0bBUhqPHenUudMY
 /jyAqi1tmZbyd7l7kwD0cFcPcNocMwBiQDrr5xYJ8DZLOoknOBzc06Ih4rXdWN1BUGG7
 sdQLmPW6k/+8UuqmBCWKbAUM+Sqzd3PXVfcFJCf2OGytfTRvXIxkjwyZ0SRzpOI1FNPV
 lCfw==
X-Gm-Message-State: APjAAAWwxsmtov1jPpSWVTjGwCwftlZQmBG4JqSkbD0W281SMabOSt+1
 dFAqlcOlTj6BZaQFR/hkbKXwmQSadzj9vFwItwE=
X-Google-Smtp-Source: APXvYqyikoO0hAmpIxLPt038QbGZwY51+9x11FqcL9TbxqeLUagE3aKaH+ku9ShiiPDqFU6ILjsx+grv6QikRrdaimE=
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr4207561lfq.5.1569620480935;
 Fri, 27 Sep 2019 14:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-2-f4bug@amsat.org>
In-Reply-To: <20190926173428.10713-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 14:36:33 -0700
Message-ID: <CAKmqyKO4aNVjh+w0MT29etz6tTrH_k1EoQKyi5xG0n9bTW_8kg@mail.gmail.com>
Subject: Re: [PATCH 01/19] hw/arm/raspi: Use the IEC binary prefix definitions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 10:36 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> IEC binary prefixes ease code review: the unit is explicit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 2.20.1
>
>

