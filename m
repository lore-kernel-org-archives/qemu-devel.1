Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD7FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E26F2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hkp2ybh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E26F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Cca-00038m-8a
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Cbz-0002fW-Sj
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:33:31 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Cby-0004mp-7a
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 14:33:31 -0400
Received: by mail-oi1-x242.google.com with SMTP id u24so9793282oiv.7
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2H871CO4w8Pd0dhiNTjhlI9fZBP7GOPsGacSNhMxTBU=;
 b=Hkp2ybh2BScX7iplDoJlljdbaMx59cIR2Vm/+rcRovHUa1VEsPyRIkNBj23Ao3oR+4
 MuMCbfiJnb3lIYUy3bXOKuKnAfyEN1dNgWrrP+xVoy4gZAk956d/jpajD2S0MUzWJJ+l
 ZQJR939MOLo/1bVr2fy5014Aue1BX2LMzf1dG4cgwZ4Wb39p/aT4YdoQwkezMM6gcrsD
 tA6N/XkCEws6d7LWcmD8nPPQM4yHJIKBrsi2UeFQ9lqIHildEN3oD2BuBBcXSkWvp4jy
 gx4iNGeF2iKVLNNPOxRoizIVmMwUfz1g8rkhbZk1Er2LX2Rbv73feszwEZeqFrX7ZeUW
 /i1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2H871CO4w8Pd0dhiNTjhlI9fZBP7GOPsGacSNhMxTBU=;
 b=c/QmxrDQkckbBTkeaLaAjK3EbgcIBd1fkztDr3WHB51BRgsUhfWgCxhuGpzErliJpN
 b5Ens477JIHqFiyq9ORigPcwkANaPySt4MX6wrNmOGO0UR6274Xd3oZTnGcqmzfrYDqk
 SeK3YmlHUvoPwMlIOT5TbEq3ZDvclNmvdYu8Z6l/bREsIM1KTF9QtRgFb1pNWmmWPVFP
 30c+cOUNJugn8mMcVP7CDefVtUMrL+mV5tHNGaV2DVDwmgGTmjAe6V8fwK9RTn44gzzG
 yXEa1OWyfYEKlHQb2RbO90fgSB2zEwWSgMaEfciItbStj/JJKqYbljv+WATkvsgH/Ccj
 7MiA==
X-Gm-Message-State: AOAM5308yAtXFMA1kzi1s5u/beN7Ml/A2TvO0dovVubq48Wty6j24/j6
 aMDIMgzMsS7WHpe/eEDqmRy8Rzdwvq+fx6g93fKJmw==
X-Google-Smtp-Source: ABdhPJwaCEsGVhpR3nPkPnO/ctu/aYoXcCUKaMhTPXMiOfUjwDzxI0RDvRxzfEsNiaC9+rGbyl1jyTWgsfRWyiSupL0=
X-Received: by 2002:aca:5703:: with SMTP id l3mr467103oib.48.1597084408765;
 Mon, 10 Aug 2020 11:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-136-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-136-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 19:33:17 +0100
Message-ID: <CAFEAcA8J3-Sb4r4CqmLE=cmZHL311_B4EZD7L5+N-OhHD+X9jg@mail.gmail.com>
Subject: Re: [PATCH 135/147] meson: sphinx-build
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 19:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> diff --git a/configure b/configure
> index 21b9ed2..7e7b4d8 100755
> --- a/configure
> +++ b/configure
> @@ -7768,7 +7768,6 @@ echo "INSTALL_PROG=3D$install -c -m 0755" >> $confi=
g_host_mak
>  echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak
>  echo "PYTHON=3D$python" >> $config_host_mak
>  echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak
> -echo "SPHINX_WERROR=3D$sphinx_werror" >> $config_host_mak

Shouldn't we also be deleting the code in configure that
sets $sphinx_werror if we're no longer using it ?

> +    these_man_pages =3D []
> +    install_dirs =3D []
> +    foreach page, section : man_pages.get(manual, {})
> +      these_man_pages +=3D page
> +      install_dirs +=3D section =3D=3D '' ? false : get_option('mandir')=
 / section
> +    endforeach
> +    if these_man_pages.length() > 0
> +      sphinxmans +=3D custom_target(manual + ' man pages',
> +                         build_always_stale: true,
> +                         build_by_default: build_docs,
> +                         output: these_man_pages,
> +                         install: build_docs,
> +                         install_dir: install_dirs,
> +                         command: [SPHINX_ARGS, '-b', 'man', '-d', priva=
te_dir,
> +                                   input_dir, meson.current_build_dir()]=
)
> +    endif
> +  endforeach
> +  alias_target('sphinxdocs', sphinxdocs)
> +  alias_target('man', sphinxmans)

Does "build_always_stale: true" do what I guess it does from the
name? Does this mean we're discarding the makefile's approach of
only running sphinx if it's necessary in favour of always running
half a dozen sphinx invocations every build ?

thanks
-- PMM

