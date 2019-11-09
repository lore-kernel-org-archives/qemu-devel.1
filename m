Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10108C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 16:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A6921848
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 16:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPB40RBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A6921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTT9u-0004m0-VI
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 11:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iTT9F-0004FN-Vp
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 10:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iTT9E-0000MR-TJ
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 10:59:37 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iTT9E-0000M3-No
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 10:59:36 -0500
Received: by mail-ot1-x342.google.com with SMTP id f10so7841042oto.3
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 07:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UGGqpT/gP0e7fQ+6MCtKgbbjn+3VKjT+JR7zDj4O5G8=;
 b=aPB40RBcvrYHnkdE8sTfrneeyu1ffg6LGblJlFthmzsR1AR2li65z9OCnUNyvn14Bs
 R/+ajrdR2e1iEkAJYF2BkvA6YfIgMxpm06O1qvZ6AhpqTCF8A3qfZ4mJgbGpak/qJqFG
 NtPmiohiLQuvl4MG8oo+xG1yWfb9tKf4YC6YQPax8c1nrj5jhkZMCzmy6gK7LEXNb59Y
 AI5CXPu3P3BIo3tZ8gKc4b0fg0PGVAXnJGWHuFnYbDlBmOtpbLWVkoJMPC/zyhymC0PL
 h3amHFTZ7dotzMPzV8jp1A+FYH/GiqwOoNxzBIpcFz3KRQmbRYOSErawFZ3WAknqGyzz
 zwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UGGqpT/gP0e7fQ+6MCtKgbbjn+3VKjT+JR7zDj4O5G8=;
 b=g35PCSHaWcPTcHboEd9hf0WCaq+FWRKTHzTEiAT5ekdM1+8oFjyEjPyDOulEJGZd1O
 nDLGn7X35DRb45mFx5w56bZmP9pKsaTfMtWfF/nUAYdD57iE0luiJUO8t4BxKmJdmcCZ
 e4aJ25wHBRnwjG+2j4X2jlDaoEX+OFqa/kKZz4BXyq8JcXkZILduyF+nkHsNEVf3LZs0
 ysrdMCYNq/BmGIS3/BELGu1uxAlC0Vx00V0oDITLU9qnUVr1KVN60SwC8bhLHSOshT0l
 U7pEIJlF9tpVmCKqZOFciRpEK9FRogbJy7Lw083DVOnzVjdqUyPWOGKdJ5ldG4R/pul/
 HFJw==
X-Gm-Message-State: APjAAAXF/30AqPYLLwSeqXsiS44ns3vclGbgav9mFFxDeGUEA0gCrqwA
 5TJ0jvPxGU9Dp9DgB7pRM4rs3fhqQkW9F1Y3xwc1Cg==
X-Google-Smtp-Source: APXvYqw/Xcz8YEkW7c16WutFz4OG+fG7nzQepXTdu5rISugNjVPZixJ25wf4N8W5VEdP6M5uStDXYPOJ2/RtGw9KvNQ=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr13025700otq.221.1573315175828; 
 Sat, 09 Nov 2019 07:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20191108194758.17813-1-palmer@dabbelt.com>
 <20191108194758.17813-2-palmer@dabbelt.com>
In-Reply-To: <20191108194758.17813-2-palmer@dabbelt.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Nov 2019 15:59:24 +0000
Message-ID: <CAFEAcA_3jgn1WrX2wpBd+sCYe=nNaqA2POvaZkj-NsSyT2N9bQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] device_tree: Add a helper function for string
 arrays
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 19:48, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> The device tree format allows for arrays of strings, which are encoded
> with '\0's inside regular strings.  These are ugly to represent in C, so
> the helper function represents them as strings with internal '\0's that
> are terminated with a double '\0'.  In other words, the array
> ["string1", "string2"] is represeted as "string1\0string2\0".
>
> The DTB generated by this function is accepted by DTC and produces an
> array of strings, but I can't find any explicit line in the DT
> specification that defines how these are encoded.

> +/*
> + * This uses a particularly odd encoding: "strings" is a list of strings that
> + * must be terminated by two back-to-back '\0' characters.
> + */
> +int qemu_fdt_setprop_strings(void *fdt, const char *node_path,
> +                             const char *property, const char *strings);

The clean API for this would be to use varargs so you could write

qemu_fdt_setprop_stringlist(fdt, node, prop, "arm,armv8-timer",
                            "arm,armv7-timer");

and have it do the assembly into the encoding that fdt expects.
That would require us to do a bit of allocation-and-freeing
to assemble the string, of course, but then we only do fdt
creation at startup.

NB: I think that this is a good idea but not-for-4.2 material,
so if you wanted your sifive board change to go into 4.2 you
should probably start with the simple approach and leave the
refactoring for the next release cycle.

thanks
-- PMM

