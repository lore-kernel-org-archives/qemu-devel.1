Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47BCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CACA20767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEi0rkuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CACA20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8o6-0008Gn-Ol
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8nK-0007hR-Ti
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:26:19 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:43001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8nI-0000q7-Sk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:26:18 -0400
Received: by mail-oo1-xc41.google.com with SMTP id 127so1680274ooc.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TagrXxMco/bVd5aQvDXBMDyoFAwI0Sy4YIAMKuyqlfY=;
 b=bEi0rkuUhuaCI+t7xE64Wsmq8USacDXNQsZgxl3zB18qbCSPCZliMa8iNeUud6AU5e
 KTGG+LW0USL/EU2xxr/dyMeggD5+5uPzm1ugeK8Pq/IGo52YQYcaJkFMAcV1mh6x3j/1
 7k69lv1TlpRQZDAuMg5TS4E5dAjeoZanQBdSVN/WtyYYrsfB65ruYGeJbY+wW4TthDzn
 H5WgNBPDHGapRtHmCBYHeF1Fea0R/U1KozJa9hLRBq9BLcFl5lmg2BX0lFR1Y17zgVb0
 f7EspWvggErQkbgUVD3hysMB8iH9vJO6IrE+INuREzYG+a6f4/wImsapQ0wfaZDUCJZJ
 nlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TagrXxMco/bVd5aQvDXBMDyoFAwI0Sy4YIAMKuyqlfY=;
 b=W3YuA0y84WUzfqm+Oio6b3Jk1l8DccJbN6vxIVT7LAMVkdcaZ5fhCXWlkGeFoGrpuo
 TMJS7UlvkFSpABi6PQrpuCdQHraXRLnIkU8SqAA+zOB+QGqtX5tRwsoaIno6VVpt7mhF
 7xHMQlYGQEqbGkUH++7TbD/4mrQYLmmcznu8rzaHJYLiGzelxxUnYWCFFdZup3HIXzBN
 wrI5emT/qsNukqbvDLKzEnW5ZubbGro+vBBY9C1vDyT+AyaCMHvPuqbUahYwCi+Y0+JJ
 hYDvYh+QEI6IdhM+F9EcpdqPcwZbHOhneT5V/evxJi0/cYOVdJHKjGEguNA6ao34CYRY
 Q2Xg==
X-Gm-Message-State: AOAM5320edH38+ttBdvVvlEhNJEibS76ALMSEb069QJOFkdFnLdGtFBN
 QFYMvEaMHr68VwzjWyOKaAkqviJO99jfRKbL6VBOJw==
X-Google-Smtp-Source: ABdhPJwQrxqgQWX8xHvKxb1Qe0rWV3Q355YojfPeBAOV3cl89GXzUqbvs/vBktZCXGqu2hvHNI0M9m7Yd4arYZjRDZU=
X-Received: by 2002:a4a:a20b:: with SMTP id m11mr1813539ool.20.1592303175800; 
 Tue, 16 Jun 2020 03:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200616063157.16389-1-f4bug@amsat.org>
 <20200616063157.16389-7-f4bug@amsat.org>
In-Reply-To: <20200616063157.16389-7-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 11:26:04 +0100
Message-ID: <CAFEAcA8HKmMpgZMTuL6PSQNd2gy8h8HSvu6GwvTy8_h93teHjg@mail.gmail.com>
Subject: Re: [PATCH 6/7] hw/arm/mps2: Map the FPGA I/O block
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 07:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

> @@ -337,6 +339,11 @@ static void mps2_common_init(MachineState *machine)
>
>          sysbus_create_simple("versatile_i2c", i2cbase[i], NULL);
>      }
> +    sysbus_init_child_obj(OBJECT(mms), "fpgaio", &mms->fpgaio,
> +                          sizeof(mms->fpgaio), TYPE_MPS2_FPGAIO);
> +    object_property_set_bool(OBJECT(&mms->fpgaio), true, "realized",
> +                             &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0x40028000);

AN385 TRM isn't entirely clear but I suspect that you need to set
the FPGAIO's prescale-clk property because the default of 20MHz
isn't what the AN385 runs at. The FPGAIO model's default is written
to match the AN505, which is 20MHz, but AN385 and AN511 are both
25MHz:
https://developer.arm.com/tools-and-software/development-boards/fpga-protot=
yping-boards/mps2

thanks
-- PMM

