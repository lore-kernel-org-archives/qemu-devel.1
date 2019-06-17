Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9919C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF7C205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUSmHmIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF7C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctqu-0008Lc-1D
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54267)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hct7h-0003od-UH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hct7g-0002DY-MV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:00:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hct7g-0002CT-Ax
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:00:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so9472988wmj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HY3BD8sYCqLcyOqfWqDu7wI7eBnmcvXr8D2hlR+aBak=;
 b=kUSmHmIy96MAcWy+7ivCMaZOBtpz1pyqhuQhCX71ipvw/n/vahW9Wegsnqemmb8Fqx
 wMtXr//eaAmqiWAcnmspA8S19TOROPm9h57vuVajuEb2l/NXHu8OZltdtKRldetLYeFn
 aemgnnrIICYjtam4zIh+ttzXYDqaLpMYKej+BkV3akYeDrW3+N3X2LyN6ew4ZtfkFpI3
 XkYCtFrRX/EjUFMaii9+PA1NiWjXcITXIHCT/jUG5YOnAx4q4GyTPLfDu/E7bNDgwFhq
 znL27KSuDVNDfQjQVj12xymTCn8IJ6mMEzQYM4yTdmhNIgYaUM5JJSQ8qvMonw/cV4x4
 xh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HY3BD8sYCqLcyOqfWqDu7wI7eBnmcvXr8D2hlR+aBak=;
 b=mcZIHOMybzWy8f1YcZucsVWeiqSo4p5PNGxp4XhXqRuBkO+B6xWOLS/t0bwNcd3X5c
 QqX9aUtPaNST02fjF1F98uAkSiOqfPddZnSo6vZG/7zFNtRtwPUUTlXdbKXhyAwB58X1
 u5ymlldob3GWW/29N0KXXI2HoWq0YabGYubBs0DmMG0HH5MoiKxu4EYogWciWWzoPWC9
 mrff1qHwKtr5w835fInLtvsvbp7VHw8NnQPC4pwSvEnnaxegY4HjxLMtaqUwRA5GbllV
 +sKbZJq7bF4LgWjblzKGZ2AAzSgLhcPgA9m79xKpN4/cCZL+QxBFhJrMI3B0QnOihsYF
 l2oQ==
X-Gm-Message-State: APjAAAXHG53wpR3+lcnyI4L4VVVqouQP4BtpDNUEwDUhWGqUSoIpgdN0
 wOhNftHfBPqiq0jeAVgRN6gh8Z2eLn7o91EslHyYQGtT8N4=
X-Google-Smtp-Source: APXvYqw807Vvr0p3+jSYlcfqB4T6QVZvfA5HmGAGU8DnN65yDg7de+HmwDgnspcuW7dT7YgSABPteO6ndYbpy/6EfF0=
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr19658984wmk.5.1560783638091; 
 Mon, 17 Jun 2019 08:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190614174901.20359-1-lvivier@redhat.com>
In-Reply-To: <20190614174901.20359-1-lvivier@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Jun 2019 17:00:26 +0200
Message-ID: <CAJ+F1C++N=jDvNXGSjBPMVQ=jBmx1pUApGpt7WwyFJu9AUZQ2Q@mail.gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] helpers: build vhost-user-gpu only for
 softmmu
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 14, 2019 at 8:46 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> with
>
>   ./configure --enable-user --disable-tools --disable-system
>
> it fails with:
>
>   /usr/bin/ld: contrib/vhost-user-gpu/main.o: in function `vg_resource_de=
stroy':
>   .../contrib/vhost-user-gpu/main.c:382: undefined reference to `pixman_i=
mage_unref'
>   /usr/bin/ld: contrib/vhost-user-gpu/main.o: in function `vg_resource_fl=
ush':
>   .../contrib/vhost-user-gpu/main.c:694: undefined reference to `pixman_r=
egion_init_rect'
>   /usr/bin/ld: .../contrib/vhost-user-gpu/main.c:763: undefined reference=
 to `pixman_region_fini'
>
> Fixes: d52c454aadcd ("contrib: add vhost-user-gpu")
> Cc: marcandre.lureau@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 8e2fc6624c31..49ddec1dcf35 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -322,11 +322,13 @@ HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINU=
X)) =3D qemu-bridge-helper$(EXE
>  ifdef CONFIG_LINUX
>  ifdef CONFIG_VIRGL
>  ifdef CONFIG_GBM
> +ifdef CONFIG_SOFTMMU
>  HELPERS-y +=3D vhost-user-gpu$(EXESUF)
>  vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
>  endif
>  endif
>  endif
> +endif
>
>  ifdef BUILD_DOCS
>  DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

