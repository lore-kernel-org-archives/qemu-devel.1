Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BE2C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF76420768
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdEif7Vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF76420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFGye-0002Ys-Kj
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 09:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFGy9-00028f-69
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:14:01 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:34106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFGy7-000771-ER
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:14:00 -0400
Received: by mail-ed1-x531.google.com with SMTP id q21so12807084edv.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6CnHes3W4dmtsUxjMXf6HWaZYHTYGwSu/fTv/hysMUg=;
 b=EdEif7Vk12cp0D+SzeTIIP5+TmEevzIKebZwM8vuxLnFoZtTNx6hwD0uEmATg6YHx3
 6tThzggwuvKAPlryoc+zT0B/368S7eHzDkf0MlcIvyZ8rzuTgu3f38INVF+Sydupeg0b
 Pmf70Dt/hLt0Ofe2rAWCAs2mOORdQyxzlJo6qeUkVONR7dcXSIdDC6sFuV7NWLHnnZtp
 jAy4OZTJWVcNAsCpvsX3DHsr44UxJAaBEPfgMdM4jNQnWsrteHD1GfiIcwlGH4GMXpaq
 qbyetgiyvDGI4/1s2Bl3GruBfGJezW6eJ4SgVUNPdHP/fcbsJ7rJC7kgVrA+a6+WDAtc
 yuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6CnHes3W4dmtsUxjMXf6HWaZYHTYGwSu/fTv/hysMUg=;
 b=kCPuqQbxKMRyWQ2sbex1cPdCxcvQeSiTFuzHjYtwsMCm3k+MVpmOhYNPiFF4cPE8jm
 q1M+G104l4lS1V6yWbnQqZE3etxUs4Jsz/tkAsrJSYc2uKN7Zs9HnDpsHXN3oABVi91z
 3e52ZspU8gRKKiZNROTl5w3+d5O3H4AeA4aWHlrCvzexOx19Y6mQKnEyn4osMVPtZT4o
 I945ox4G7Kn9EwPFkDldXIRD+stvJ5x07JmJ1H12YWzCisKDHhfFExMGvB0aUfwZAA04
 RpoWDW3AcuPWxr3ri0MQhYFUL/EuKisd3Aotbl16rQYSjLOZPfScARMDAJSv7U9r8c8l
 n5bg==
X-Gm-Message-State: AOAM533/eKfgWl/bIDRpfPctPJ2l5LPq72fHl55fbNnYfa6xayk9tgvH
 yUp6nbi3L1h7OyNI3/BixZnn4RsnB6OJ42bSOAkCgg==
X-Google-Smtp-Source: ABdhPJy/ekppVW0+SUhYQuLvfgpMTZQp3mbIkjVZISSWqiNzx6JjLfzIfELtZntThv1KS9VyBX8v7UXj5b4JS7bcpzA=
X-Received: by 2002:a05:6402:1495:: with SMTP id
 e21mr20975867edv.146.1599484437670; 
 Mon, 07 Sep 2020 06:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200622191746.18031-1-f4bug@amsat.org>
 <20200622191746.18031-2-f4bug@amsat.org>
In-Reply-To: <20200622191746.18031-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2020 14:13:46 +0100
Message-ID: <CAFEAcA9SK1BmrY9_LO6ERy-e22rXOVUP1+vSmUYSTEwWywuzuA@mail.gmail.com>
Subject: Re: [PULL v2 13/15] hw/rx: Add RX GDB simulator
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020 at 20:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> Add the RX machine internally simulated in GDB.

Hi; Coverity points out a memory leak (CID 1432307) in this function:

> +static void rx_gdbsim_init(MachineState *machine)
> +{

> +        if (dtb_filename) {
> +            ram_addr_t dtb_offset;
> +            int dtb_size;
> +            void *dtb;
> +
> +            dtb =3D load_device_tree(dtb_filename, &dtb_size);

This allocates memory...

> +            if (dtb =3D=3D NULL) {
> +                error_report("Couldn't open dtb file %s", dtb_filename);
> +                exit(1);
> +            }
> +            if (machine->kernel_cmdline &&
> +                qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
> +                                        machine->kernel_cmdline) < 0) {
> +                error_report("Couldn't set /chosen/bootargs");
> +                exit(1);
> +            }
> +            /* DTB is located at the end of SDRAM space. */
> +            dtb_offset =3D machine->ram_size - dtb_size;
> +            rom_add_blob_fixed("dtb", dtb, dtb_size,
> +                               SDRAM_BASE + dtb_offset);

...and rom_add_blob_fixed() copies that memory, it doesn't take
ownership of it, so after we've called it we need to
    g_free(fdt);

> +            /* Set dtb address to R1 */
> +            RXCPU(first_cpu)->env.regs[1] =3D SDRAM_BASE + dtb_offset;
> +        }
> +    }

thanks
-- PMM

