Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B0EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5582070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+UDxEiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5582070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrMr5-0005Mt-DD
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrMqW-0004v5-Pj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:39:20 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:44661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrMqU-0002Fh-TQ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:39:20 -0400
Received: by mail-ot1-x332.google.com with SMTP id 5so24824470oty.11
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V1ZTlVGt4iiSH8Ddu86BLRNYPa595TAeN2gP//yZH/c=;
 b=k+UDxEiYUBZRE1GUTm9aASgdjPbUb2GiwE+w8uHDqetE6bwtMwSHzsj+zt2pyPOcnW
 IWX9ViBR3FZcbp7Aa0cMXb/XAZnVYcgh1ipvO6DJAJEuvPMJXWvU39RCyfmo6n+swaSs
 b9aOS2aAtd30pzE23KY3+Fh5AThH1oug6WgBAH3KG3+nUvk5xinjPfGr6Z/s8S9qU9zS
 4m3fcWQd+yJHID/0M7pKdIoV4+1dXb6170YyWrKlOUj8BHvbr3Urfd44kj6D0yd31JE+
 7zT5KhYnq4lTR/CYO+wkEuJJNZHUrxRK/OsTafxHy6dNZWKJtqqJfrpvJo1W6ZgU5VVq
 TDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V1ZTlVGt4iiSH8Ddu86BLRNYPa595TAeN2gP//yZH/c=;
 b=nlyCI9V15s04TKeW30rDTzTsaJ/KCEvA9SZSi3QM0chUetKBzAFAI/XUGR+N7hKZFW
 U4e2tqMJ0ivrW5lKOiN+gp/NUxquVrATY4Qb7BKqYfgrSrmSdUYdzLPib3PJ7ODcgxtk
 uQ8GcrnwcuxGE+2WFv4ZkanKlsRfyuTxU/nrTGMMq+SSUjS1hrPkA/x46L5NwNBCKMnZ
 QpPrSDfMYqVOXxb1/6jvRJRjh0NFM+J2azHBL/GZNvatZsDHOHw2esM64MvtXN5TouGT
 HUZ1sOnArwkuJdzHx4bxIQasIRZpHkkV4DPUzZ9rpWyUsVTpI3Tzx3aWUEN7OVU13wXw
 jyRw==
X-Gm-Message-State: AOAM5318cJA82A97WEYT3ME+zO+ehXSRHejCV88GT5bDBC8xiNfgZxBh
 nPeMgoJaDSoR+cOlniGjxhSb6s2lWO2mWhXidodZ6Q==
X-Google-Smtp-Source: ABdhPJwriYqY57fHh+Bynr/boS4IxvpZPnZQ+TTd3990tTQY576lUfdQxksSN7Iim68d+F+Pl0jXTgXXMLlO/3VjfNw=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24751007otk.221.1593787157642; 
 Fri, 03 Jul 2020 07:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <6AE6C8C0-3EDF-4501-AF11-0ECFBCBBB5FB@icloud.com>
In-Reply-To: <6AE6C8C0-3EDF-4501-AF11-0ECFBCBBB5FB@icloud.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 15:39:06 +0100
Message-ID: <CAFEAcA-9xQGEh_bAS4vtcsxmaXqskutCo3VOJWjGYmsktVLTkw@mail.gmail.com>
Subject: Re: How the cpu_R in DisasContext is associated with register of
 CPUArchState
To: =?UTF-8?B?5rKI5qKm5aej?= <shen.mengjiao3@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 15:15, =E6=B2=88=E6=A2=A6=E5=A7=A3 <shen.mengjiao3@ic=
loud.com> wrote:
>
> Because in translate stage when write cpu register by guest code, it oper=
ates totally on cpu_R of DisasContext, how to reflect it to register of CPU=
ArchState?

You don't say which target you're looking at, but in general
these mappings are set up when the translator is initialized.
For instance for Arm, arm_translate_init() does this:
    for (i =3D 0; i < 16; i++) {
        cpu_R[i] =3D tcg_global_mem_new_i32(cpu_env,
                                          offsetof(CPUARMState, regs[i]),
                                          regnames[i]);
    }

which creates the cpu_R[] TCGvs as TCG global variables which
live in the regs[] field of the CPUARMState structure. Whenever
TCG code is generated that accesses that global it will read
and write from the memory location corresponding to the
regs[] array entry in the CPU struct.

thanks
-- PMM

