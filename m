Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD01BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD3E2087C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrye6n/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD3E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtGQ-0006D1-T0
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAt6o-0005GW-U8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:56:50 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:39424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAt6n-0002Fs-Ak
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:56:50 -0400
Received: by mail-oo1-xc43.google.com with SMTP id m4so339173oos.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dHUDqdb/HT8i5I2ok54l02HL0e36Ud4uheYJnGvzDvE=;
 b=lrye6n/8yvQpo8TfNzN+t1EzeF0pJ+xnUKV3dUbqEilnYVDmtz94ekD5gLdBwr7wmN
 6CDtVRJJ+euz3I8NDMPM7LoTsseC+OyCxT3c7RTfc4keuuyk7Dvv//P2JRVSBjdwsxcx
 dsC8RGz+vVJmh21JUgciGw5VfJVyCXV9cTvKrE8nZZXoTbGEalxnqjaI+gEMKGX1Cgk1
 uBAXaW/Kv+TT937uBdpwpYVXF8G+AhqCom/5/uABEuSe7QEMtLYF1oMRzInOiIgOmee8
 NIvip9bL8ztNJwdOBH/49b51UtIjg+snga3TP0WnpyNLamDE34zr32zyYlqtfZv04/Uw
 zjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dHUDqdb/HT8i5I2ok54l02HL0e36Ud4uheYJnGvzDvE=;
 b=aliJMuipZxGtr2ZLaGKzxPFm0SKIr6Es4s+6f9oiGTYiUL3NNMJrBl8/hN/4C6F95M
 oRrCWDzqeh5B2BEopTInwE5oIV+nUyCfORuXmx57l1di1Vur4BtYdopaXAyOs2YxUeNL
 0eRrc1gN0SHhQCccxsNj80MVCA8guTUO9QSzXPMk1gFDy7pk9kevfsxoLSSnEWLNK3sY
 vuYN9Nn9DjA43tlZe2T1w83cEOFtfgMKjxwEX+5p0UOxGDbTDZTL88GWYdFEkeEQVsGT
 Nrt05cYzWQs9x8JeOBYszOnhMOd8DLCMMmDsGJUDlcTsNQVMz9H1tR++v3LCZ0XbkxJk
 9DmA==
X-Gm-Message-State: AOAM53058w7ZRgrlZ/G6KC4e2CRTEW5Ar+fzJRGtSvx6RiNiOcEie04v
 fXLSqilBNZyTBvCZKYMjQ81zHflXipIZQOadMWk=
X-Google-Smtp-Source: ABdhPJysEIlcC9wpSaTld3PQjSN3AaQIFxgRw0WAYf2Jj836X62zUuQ5cIDwpWJvLUdN29J1+i8UKAZYv7rMIg25Nnc=
X-Received: by 2002:a4a:c587:: with SMTP id x7mr10216006oop.60.1598439408173; 
 Wed, 26 Aug 2020 03:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-4-pannengyuan@huawei.com>
In-Reply-To: <20200814160241.7915-4-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 18:56:12 +0800
Message-ID: <CAKXe6SLCwZabTFJ6Hc_V6rLEFqKf_EsHfrimMq9xdybBfBEHig@mail.gmail.com>
Subject: Re: [PATCH 03/12] elf2dmp/qemu_elf: Plug memleak in QEMU_Elf_init
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>, Euler Robot <euler.robot@huawei.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Missing g_error_free in QEMU_Elf_init() error path. Fix that.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> ---
>  contrib/elf2dmp/qemu_elf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
> index 0db7816586..b601b6d7ba 100644
> --- a/contrib/elf2dmp/qemu_elf.c
> +++ b/contrib/elf2dmp/qemu_elf.c
> @@ -126,6 +126,7 @@ int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
>      qe->gmf =3D g_mapped_file_new(filename, TRUE, &gerr);
>      if (gerr) {
>          eprintf("Failed to map ELF dump file \'%s\'\n", filename);
> +        g_error_free(gerr);
>          return 1;
>      }
>
> --
> 2.18.2
>
>

