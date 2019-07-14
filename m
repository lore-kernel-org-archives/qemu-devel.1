Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626ACC31E40
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 03:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301F0206BB
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 03:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOx4d1Rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301F0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmV6R-0007R2-7O
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 23:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49058)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hmV6G-0006zu-8A
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 23:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hmV6F-0002Ia-7t
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 23:22:56 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:38030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hmV6D-0002EZ-34; Sat, 13 Jul 2019 23:22:53 -0400
Received: by mail-ed1-x541.google.com with SMTP id r12so12366817edo.5;
 Sat, 13 Jul 2019 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q08jYk21ViY8XgmFrkgiDweXa0UOtGJGIiHOB+F8ez4=;
 b=SOx4d1RtgKGlPEYklSi415+eZcmTCC3oyPfUiCbHPwW5OF9XnycOYHw/1JNkYkl7Y2
 42cYqRf89fxWrWgFYTDTSzhNDx/dO+AfzlnoO2sCJAwncXKd/sX3YNl4BUvg8JZ1344F
 z4Bj23NQ/qvyEQX18KtC9Rxw7RXLt1ki++m8jhFeqaZjetYZbDRm/ouYLSFwNC63SSNp
 phJZVH4rHbYuqKXxK+W6xUHDy1DFZ/9+MfMJK+LQm5D3qJHt0KIdS8CYv7QJdWSCSJgx
 HLJ3wxpmtNy3EAUmgmqcMc6arVnIWreRh/dwh+ENPnXg61vXvP4+36/7rESeoAv6MutA
 FifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q08jYk21ViY8XgmFrkgiDweXa0UOtGJGIiHOB+F8ez4=;
 b=hIimuGw/LzM2q2QOYG099xdymGi5lch6xlGxmlncTezbdSLJWI9PPMImiDpK0kzpc0
 MswAeRyGyYM0EpiWH1vmjuXyWmdhHG9kA5c3u9aBUU76kKhcagZn1oKg+x5OJcRtuKR/
 PBoIuw+9VVdkjBiazh3OeeROIFDIykOhYpzmBKvYwOP9g5l9J1AKWmecXz1g11H/rk3d
 KHEQdEvgflKJX6w8tdApraotzK3mUvh502hsRBm2M+b9xGRtQMjxRW8uMTGaoX+w+H+X
 2h2SdjqwIOE+BoM1QSQtVHSdWSiOe/fIMeREPfWMpdq94pEkzVC0x23nEW0sIhoCQyp4
 fg9A==
X-Gm-Message-State: APjAAAVJWU+fhxgwij2VN6KhlHDVRm/6WzwH3Q+J/NOBJ+Y1a264bOk+
 VW2FQI+wnXadq3P0hVOMtZqlF7/j/w4Wl0rDEY2i+Jrq
X-Google-Smtp-Source: APXvYqz6F+JrDB6jRL9xZXNKfnMAlN7NdSQmHKNA12/Ah74h99EDSKIBq4pyx64Nmpzkvx7PAq9X9a+LJZ1dGy5JiAc=
X-Received: by 2002:aa7:d6d3:: with SMTP id x19mr16587926edr.119.1563074571668; 
 Sat, 13 Jul 2019 20:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
 <1558108285-19571-2-git-send-email-bmeng.cn@gmail.com>
 <9338c7b4-6a05-2189-b93d-25cb2bd4dd54@adacore.com>
In-Reply-To: <9338c7b4-6a05-2189-b93d-25cb2bd4dd54@adacore.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 14 Jul 2019 11:22:41 +0800
Message-ID: <CAEUhbmUtdvkYPm4DZL4MSeV5imaj82x2xtPkQ0yLKF599N=vXw@mail.gmail.com>
To: Fabien Chouteau <chouteau@adacore.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH 2/2] riscv: sifive_u: Update
 the plic hart config to support multicore
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Fabien,

On Tue, Jul 9, 2019 at 12:31 AM Fabien Chouteau <chouteau@adacore.com> wrote:
>
> Hi Bin,
>
> Thanks for this patch.
>
> I know I am very late to the game but I have a comment here.
>
> On 17/05/2019 17:51, Bin Meng wrote:
> > +    /* create PLIC hart topology configuration string */
> > +    plic_hart_config_len = (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) * smp_cpus;
> > +    plic_hart_config = g_malloc0(plic_hart_config_len);
> > +    for (i = 0; i < smp_cpus; i++) {
> > +        if (i != 0) {
> > +            strncat(plic_hart_config, ",", plic_hart_config_len);
> > +        }
> > +        strncat(plic_hart_config, SIFIVE_U_PLIC_HART_CONFIG,
> > +                plic_hart_config_len);
> > +        plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
> > +    }
> > +
>
> This will create up to 4 MS PLIC devices. However on the Unleashed FU540 the PLICs are M,MS,MS,MS,MS because of the monitor hart #0.
>
> This means a different memory layout than the real hardware.
>
> For instance address 0x0C00_2080 will be hart #0 S-Mode interrupt enables in QEMU, instead of #1 M-Mode interrupt enables for the real hardware.

Thanks for the notes! I agree to better match the real hardware, it
should be modeled like that. However I am not sure what the original
intention was when creating the "sifive_u" machine. Both OpenSBI and
U-Boot list sifive_u as a special target, instead of the real
Unleashed board hence I assume this is a hypothetical target too, like
the "virt", but was created to best match the real Unleashed board
though.

>
> To fix this I suggest to change this loop to:
>
>     for (i = 0; i < smp_cpus; i++) {
>         if (i != 0) {
>             strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
>                     plic_hart_config_len);
>         } else {
>             strncat(plic_hart_config, "M", plic_hart_config_len);
>         }
>         plic_hart_config_len -= (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1);
>     }
>
> This will make hart #0 PLIC in M mode and the others in MS.
>
> What do you think?


Regards,
Bin

