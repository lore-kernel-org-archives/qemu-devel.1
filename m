Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ADDC5DF61
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA08A21929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA08A21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS0Go-0001q4-4X
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 09:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iS0G4-0001OS-Mr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iS0G3-0000It-FG
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:56:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iS0G3-0000IZ-7C
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 09:56:35 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 707CBC04D2F1
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 14:56:33 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id g14so2766455wmk.9
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 06:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YJYDhNRsjTkW0/pccDda6brd1om5OYMob1NBNGRMH9Q=;
 b=tTcXfVDnvyEpl3q8eHn9IEHVG0BzFL9SFPiLJqrrl2K73zmCkTx394WwlGufpud0gh
 TwL4hjBDArbVn7SK79gFvcwIs2OZ0ezjG57oSTCqEfb88TVEL1sz+b804O7nFQSYVkqD
 NrIrk6m7jcMRps3I26F8OS3D4NMz0iWrmbqZuyOD4P+siYb/rhjPueG9+w3bH0Q5fT7r
 gBvwqxyi87xNUG2JIcr9/0Gmo25YTKieT49LDUFb43Ke5ui+BnwvTyvJ1iwW8+uNRZ5K
 AUsy3ZPraBvUJCY9F3EOhQaLzHGRF9aXUt1RacbG5QRw5wQWF6zW02ch9TXq9ww8b6vh
 U0jg==
X-Gm-Message-State: APjAAAWq+khiGputpI1v3dnRt7TeICiNEDAkbGAyaGg51kaVlpyZX4sG
 +GF8JVZBoPdzoHdC0Bj/ufosKwsiOVvAW1U0UFOBoWtsdY9BOmCAvQkJWDpRuhEn3QcNIAl7K8/
 MEC9pGJX/rR6FDzjlm4iWLb/bgK3RnAw=
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr27895920wrv.149.1572965792223; 
 Tue, 05 Nov 2019 06:56:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxC0R+sfU+jHFor8SeUYPT94SnlTQuSrReQMH3DwePL/wG8r9qYpr3VBjxRfZvydoHoeUPfHriG9e4KRf1131Q=
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr27895901wrv.149.1572965791879; 
 Tue, 05 Nov 2019 06:56:31 -0800 (PST)
MIME-Version: 1.0
References: <20191104095530.22091-1-philmd@redhat.com>
In-Reply-To: <20191104095530.22091-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 5 Nov 2019 15:56:20 +0100
Message-ID: <CAP+75-U5hTZxFcPjKBpAnWSdZztphQbd7QudaX7hyt2RXnmOKg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Fix config-devices.mak not regenerated when
 Kconfig updated
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 4, 2019 at 10:55 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> When hw/$DIR/Kconfig is changed, the corresponding generated
> hw/$DIR/config-devices.mak is not being updated.
> Fix this by including all the hw/*/Kconfig files to the prerequisite
> names of the rule generating the config-devices.mak files.

You can see this tread where Peter reported the failure:
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg00125.html

How to reproduce:

  $  git checkout next_branch
  $  make i386-softmmu/all
  $  git checkout prev_branch
  $ make clean
  $ make i386-softmmu/all
    # error
  $  make print-MINIKCONF_INPUTS

> Fixes: e0e312f3525a (build: switch to Kconfig)
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> If OK, I plan to include this fix in the "hw/i386/pc: Split PIIX3
> southbridge from i440FX northbridge" pull request.
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 0e994a275d..c1461b21e8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -384,7 +384,10 @@ MINIKCONF_ARGS =3D \
>      CONFIG_LINUX=3D$(CONFIG_LINUX) \
>      CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
>
> -MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
> +MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig \
> +                   $(patsubst %,$(SRC_PATH)/hw/%,$(shell sed -ne \
> +                                                    's/source \(.*\)/\1/=
p' \
> +                                                    < $(SRC_PATH)/hw/Kco=
nfig))
>  MINIKCONF =3D $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
>
>  $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MIN=
IKCONF_INPUTS) $(BUILD_DIR)/config-host.mak
> --
> 2.21.0
>

