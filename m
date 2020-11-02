Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36EFC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8A121556
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNcw2MDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8A121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYGT-0008Rh-9v
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZYFC-0006w4-Vt
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:43:27 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZYFB-0006a1-C4
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:43:26 -0500
Received: by mail-ej1-x642.google.com with SMTP id p5so18492726ejj.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 03:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Lh4FMiC0ZDtG1v8r5aV0+yTQMHhtss4uQt29DivgaMY=;
 b=ZNcw2MDfvqc7h8uM7BDfegQi4eMuETaw5Hxr5izY87P0McVmFPjADW5IcGeVFGEgbg
 L/61EnYnMiKm/3DqjHhFDHHJob6X94M0aHDfvc5uaL3LtdjEStZ7zu/qxxHQcDoLkOl4
 UB1J99gExCXZeUjaveofmxnttVQc526lHX/xXQhytNa/RuEH+wAs2rsz8LKVmrEa8mms
 bsP2vkNiPyBZhOMOi+vCd+2Ys3kYmP92hIzc3r0EQuoGz5xAQXboW384kYMSVDuhSnta
 SXIJhsURZmTwPEtp1AjeI1Nhk6ztVRVsmyBK4qgt+3HM3Y4mrc0r7XuvhX2+OeOTXKKV
 XXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Lh4FMiC0ZDtG1v8r5aV0+yTQMHhtss4uQt29DivgaMY=;
 b=qhG4NmZwg43hJMq6JDalicqqZ0TyHuqGVtzcoxnpP0yB5HHcTPCAqG4l9RFZz+4QEm
 66jjlYEiKrjasd3kdaULXeIhoLaElhZIIfnxM0oTpe2TyxZLymRhLA5MfF9ADKqdxP1n
 oP3LWAyp14OU0sEY6ygIYgjLvPLvYaPo+VjvlREbq3+SVSK/DiockS6o7NwytQwZPuoA
 5pvs7y6jdSkX+U/4ZVNlViZ35o82ycODfmz6gNF/rFJQKIYptljMqO0l7qG8dzePshOn
 Hp2qrf42bwwRihVb9ne+1MSuHJUer6yzj07ifCbh3V3rZW5pgHJUP6EJjaLBi1pgP5yF
 XSiw==
X-Gm-Message-State: AOAM531HCyNRg+0EsKbB4Mb4kYDbiK+KIAQKQgodKmL5kFQslUgL1KLs
 JKsQD3ZTvcSijKLwOgn+NFw+RWrYOlf8gLXfTDUCTg==
X-Google-Smtp-Source: ABdhPJz6r2+eNvd+prCJq7W+PWEZ91E6L7/nnd66h+ApT+sZbfohTTG2sw25K2BCzgH9+x+2VxVVOT4XWxBQr5e0cSk=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr14391848ejb.85.1604317403905; 
 Mon, 02 Nov 2020 03:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20201030151541.11976-1-remi@remlab.net>
 <e6066544-a259-9739-3acd-2d9abc2d7455@linaro.org>
In-Reply-To: <e6066544-a259-9739-3acd-2d9abc2d7455@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 11:43:12 +0000
Message-ID: <CAFEAcA8wCQrg9zST1eM3Wsa0LPVkG1D=NFjRu__GPYLpssr1ag@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/boot: fix SVE for EL3 direct kernel boot
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 18:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/30/20 8:15 AM, remi@remlab.net wrote:
> > From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> >
> > When booting a CPU with EL3 using the -kernel flag, set up CPTR_EL3 so
> > that SVE will not trap to EL3.
> >
> > Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com=
>
> > ---
> >  hw/arm/boot.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

