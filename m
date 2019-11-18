Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA9C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB05220740
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oBadPYev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB05220740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWcdH-0001DX-Ti
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcbf-0008KL-8H
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcbe-0007e1-3a
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:41:59 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWcbd-0007dI-OZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:41:58 -0500
Received: by mail-wr1-x441.google.com with SMTP id f2so18336569wrs.11
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 00:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CzM2VI0idBWgtiGfAq6Zv0yTI6qF2bsxDrGTUD/vAro=;
 b=oBadPYevT8fKQqJiBXlA+INjxrVybiuIDrugYv/ONDJ+JbfoICu4QeTyRCgK+GCF7T
 lshDcOitjr3ztkHPv2Ea45wHG1/WUVS2YGppovKprk+76ESftDM+pYSPS7EUzdwOAuGd
 oDdyjeiA8yf2c4Vpbin6n4ivAK8A+IcflRkftt0Bt3+n0zgQOFPiSSVjjOWIjqJQaP55
 8DIJZ5gOp+6lHyk1QzmmzflzgkaSAFSRm+kGIAizd6qkM6w0m+OMIKlpFCblYyKtWuuX
 JtMclux1vjxw/F0htyFiTdpvhTf4w3wR+WGd5eejNJkJTMUeY5vwZJ2PWpvCSV+ZxccY
 Z7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CzM2VI0idBWgtiGfAq6Zv0yTI6qF2bsxDrGTUD/vAro=;
 b=Qb/+g0qLyCeh2wms4nlqcoeS7RimuNjxAUZ3jwmvFLWxTqtjeBXogk9u/buG774oUh
 VdD2pKs4r4J+PdObyYDPZFE0rnu3GYT2dMtdlwDWU2MGVeAEn64uWf1EU97OgnN90nK2
 Qcveq38cwZGPqTnjaxF12LT0uQ5PL6Pg19hks2zmRRNrKnggfbQWmwiw4x0LZLgfruIh
 vS12qj75dq8UjyKi8D3hP5kaKkPsduyCGwOOjNSeZ56qY/QyPedD2jGBm+QaSqwXETvX
 y5eBgm6y6eFtw8z7Wq+PyMarEbQ8XRZAlqQqGb4jnElPakm3qEfaL83qv2PCIT4D7bwh
 XS0w==
X-Gm-Message-State: APjAAAWlnxpgCueXD2QMyKYRSz45LY3OeDDXeLjvNCYfx5LsOd2QW7Qn
 8GVbU0WwyB9LuFtv2al/2LlfBQ==
X-Google-Smtp-Source: APXvYqwfuXWhOQ/+Ftbt4HEkYyX+Qk+RemfsHItJbleagb0H94bb64znOuJRgW3bPyWYv9uDdUlKyw==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr30535284wrm.199.1574066516544; 
 Mon, 18 Nov 2019 00:41:56 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id n23sm19237841wmc.18.2019.11.18.00.41.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 00:41:55 -0800 (PST)
Subject: Re: [RFC PATCH 08/11] gdbstub: extend GByteArray to read register
 helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <026f7fc7-082c-c277-bbfa-f51eb0c058c4@linaro.org>
Date: Mon, 18 Nov 2019 09:41:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 luis.machado@linaro.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 alan.hayward@arm.com, "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 damien.hedde@greensocs.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 6:29 PM, Alex Bennée wrote:
> +++ b/target/arm/helper.c
> @@ -47,30 +47,27 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>  
>  static void switch_mode(CPUARMState *env, int mode);
>  
> -static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
> +static int vfp_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
>  {
>      int nregs;
>  
>      /* VFP data registers are always little-endian.  */
>      nregs = arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
>      if (reg < nregs) {
> -        stq_le_p(buf, *aa32_vfp_dreg(env, reg));
> -        return 8;
> +        return gdb_get_reg64(buf, *aa32_vfp_dreg(env, reg));
>      }
>      if (arm_feature(env, ARM_FEATURE_NEON)) {
>          /* Aliases for Q regs.  */
>          nregs += 16;
>          if (reg < nregs) {
>              uint64_t *q = aa32_vfp_qreg(env, reg - 32);
> -            stq_le_p(buf, q[0]);
> -            stq_le_p(buf + 8, q[1]);
> -            return 16;
> +            return gdb_get_reg128(buf, q[0], q[1]);
>          }

Mostly ok, except for this change, which has the same endianness problem that
the other ARM change did.  Why is this not done in patch 6 with the other?


r~

