Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73900C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED4F2177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2egqyeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED4F2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yJS-0003TC-HC
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3yIa-0002d4-9o
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:04:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3yIY-000883-4J
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:04:23 -0400
Received: by mail-ot1-x341.google.com with SMTP id c4so1043248otf.12
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n7oo2PKZscNbkyat5Nj71JY/ddIZsGG1kdsVTNKLq28=;
 b=H2egqyeJTwwQc68DgpBbTYDWb4cp9bpaaqRqLX6Dg67/WA9xgCSbKSsuS0GNCQnRtS
 Q9ZNff5famIaNIIZd9CHLQkdhQFVMV73xeTNV4/+dNlS+3sX9ptjyYBHTj0IiamHT0Ba
 2h/lemruwDWPwHMqMdyZsjjiTRNgCwRZz5GnuiyHYpdAGeqwLZb5Hw9T2+lBLhqma+tK
 8NKlgQ/pFTgX//S5hfcD4O8vH59cja36tecZs83rbVewdCtmA/x6jMTcC1aoCwg39lhF
 jEyJuJroFDguNWxWUf8tD+VV+IP9zhsWzpaUdDvGuen9t16iMuypX26D+bi4MFghpG+Q
 X/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n7oo2PKZscNbkyat5Nj71JY/ddIZsGG1kdsVTNKLq28=;
 b=SlXx2ONVhY4o35j3oGRFsrZTAYSI+xNkCxWcckEfJ4FkOqk4ManehZviUChp39hbwM
 PFibK/47c5pQM1eppEVqXDIouKlc4VSmTvzv+lhyOaC/ClG4mgvEZYMmeYlyGdR1Vysm
 o+tsLazGLLFfwaZnv1FLq7QebCiC+YkLzm4R/TPkVoPFBZQARIDhGJ2hjsSmaEzDMEr1
 HI2etEPUXdNvUrG6LefCXrHtSgOXRiDi9EVLWiSBdEMK7guTee+MD4syTT2QZ1/7e3XP
 NCrwe74Lsr0aMhBYYUZidoqcif+tCIsBZ4C9JQuAJTVHmJNZFgBrCFuVa2D6BzU3t2Tt
 KpYQ==
X-Gm-Message-State: AOAM533Ifbh54eP+olJ22BbQgSA+nSyJzb9VJv3WQgiS5nBeAwkKSmVa
 kCjGf39cxi/Yw3d6ASZJwky2WicJfJ6Cy4qDI8hVMA==
X-Google-Smtp-Source: ABdhPJwYsUJeT1pBIci6e87zYsMjj/wc9znXIkUJjl9Ic7HNp1LbkNUswIGx1x1m0QI2J2X0OFiYXbnzsiyI5jRblQY=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr4594088otq.221.1596791060864; 
 Fri, 07 Aug 2020 02:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-125-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-125-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2020 10:04:09 +0100
Message-ID: <CAFEAcA84DhPcZxa0yhRmZOMiSdPt8L_PBVQacgoOuznbJv7kFg@mail.gmail.com>
Subject: Re: [PATCH 124/143] meson: target
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Thu, 6 Aug 2020 at 21:09, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>



> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 694757b..4cd1e10 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -1257,7 +1257,7 @@ def main():
>      long_opts =3D ['decode=3D', 'translate=3D', 'output=3D', 'insnwidth=
=3D',
>                   'static-decode=3D', 'varinsnwidth=3D']
>      try:
> -        (opts, args) =3D getopt.getopt(sys.argv[1:], 'o:vw:', long_opts)
> +        (opts, args) =3D getopt.gnu_getopt(sys.argv[1:], 'o:vw:', long_o=
pts)
>      except getopt.GetoptError as err:
>          error(0, err)
>      for o, a in opts:

This change to the decodetree script doesn't seem like it
belongs in this patch ?


> --- /dev/null
> +++ b/target/arm/meson.build
> @@ -0,0 +1,62 @@
> +gen =3D [
> +  decodetree.process('sve.decode', extra_args: '--decode=3Ddisas_sve'),
> +  decodetree.process('neon-shared.decode', extra_args: '--static-decode=
=3Ddisas_neon_shared'),
> +  decodetree.process('neon-dp.decode', extra_args: '--static-decode=3Ddi=
sas_neon_dp'),
> +  decodetree.process('neon-ls.decode', extra_args: '--static-decode=3Ddi=
sas_neon_ls'),
> +  decodetree.process('vfp.decode', extra_args: '--static-decode=3Ddisas_=
vfp'),
> +  decodetree.process('vfp-uncond.decode', extra_args: '--static-decode=
=3Ddisas_vfp_uncond'),
> +  decodetree.process('a32.decode', extra_args: '--static-decode=3Ddisas_=
a32'),
> +  decodetree.process('a32-uncond.decode', extra_args: '--static-decode=
=3Ddisas_a32_uncond'),
> +  decodetree.process('t32.decode', extra_args: '--static-decode=3Ddisas_=
t32'),
> +  decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-de=
code=3Ddisas_t16']),
> +]
> +
> +arm_ss =3D ss.source_set()
> +arm_ss.add(gen)
> +arm_ss.add(files(
> +  'cpu.c',
> +  'crypto_helper.c',
> +  'debug_helper.c',
> +  'gdbstub.c',
> +  'helper.c',
> +  'iwmmxt_helper.c',
> +  'm_helper.c',
> +  'neon_helper.c',
> +  'op_helper.c',
> +  'tlb_helper.c',
> +  'translate.c',
> +  'vec_helper.c',
> +  'vfp_helper.c',
> +  'cpu_tcg.c',
> +))
> +arm_ss.add(zlib)

Just to check, does this get the underlying dependencies right?
ie translate.o depends on translate.c and also eg translate-vfp.inc.c,
which in turn depends on vfp.decode ?

It's not clear to me why all the decodetree lines ended up in a
single "gen =3D []" block -- they're independent of each other.

thanks
-- PMM

