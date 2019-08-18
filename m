Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A606FC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 12:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA432087E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 12:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vH3nKXkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA432087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzKUH-00086z-Kz
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 08:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzKRq-0007AH-RQ
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 08:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzKRp-0007Bp-LI
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 08:38:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzKRm-00078d-AI
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 08:38:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id t16so5881224wra.6
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q2CECf3Z0VZS2vsykoHMilxYJWnJFnixOycIv/0VdAc=;
 b=vH3nKXklQ3D6J2/DUV/Muhm5EQqjnOi1dOFDnoYkoWbFdHGdCTt0Q8H/PEx3US8HVr
 BvUvT45unuUHziXG9CABuehFsnGiy92O9yPs6EM1DOjtOQOUOf5aNmusmYAtenEpKhZU
 Pu6WIhMrgQs6oTjcv5/b9mcugffLmrQy+Ga3LvHGe4Cbic6u7Zp2AlmUwB1zher+kYK6
 3yBCSezj6lVnUja0g2Vxd3RILIf1CcZ6VnwhbaSkueQsZrX7Limpesb3ZKhlOXNae2KW
 7sCJeCoUVb6HYQGT38JuljsiR4FUcloY4PuupNMx8KAHk526GfDKtMT4X6DaoSdbTrHc
 yG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q2CECf3Z0VZS2vsykoHMilxYJWnJFnixOycIv/0VdAc=;
 b=r9zvs62BErD0J3EOulLK+70TKQgDzKBBYOhd+wJ+KfFMrTDitIaEi3+q7Aq05+eAJ/
 /H6GYoddzVxc4xYHLRYUU7K7KlyjKVZKnPzk8nN0Xn/S39xfOEoBTVXE0WMZ5zQuDpy+
 in3i10qLbNiwqETYbVZ2GFE4wR61P3+HoPtRhjDi63sJFAOIWhy3GvvjBQ9yLZa31vVi
 NWPcK7udL649nwEdWDY8x24zQFsMHKJbUuiO2D89rKF8GfUAxzICgxM6CfPRNkDCP96f
 gcs0XMbN3T7Xyr6oOLWDB9KPgSSPOJI5IG3+uIlMowEZR/dVTTsfwrISO5wBE7JT2T3Q
 SvZA==
X-Gm-Message-State: APjAAAVBnuZRAA7gS3QEEt/bobU1h2TBwoXTRV9EUeNMOn24TV8KeS1u
 kH2FqkqDS2akfkqHptLMXRtj6Q==
X-Google-Smtp-Source: APXvYqy8+V4wmFtUbhYj8pIGMMLehGXowLZiVAQJJkcV7DuCTxUQaFYSL+0IQlwYdqSdVJrbjHii/Q==
X-Received: by 2002:adf:f710:: with SMTP id r16mr22248357wrp.81.1566131885195; 
 Sun, 18 Aug 2019 05:38:05 -0700 (PDT)
Received: from [172.16.53.135] ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id r190sm12495818wmf.0.2019.08.18.05.37.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 05:38:04 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <1565941103483.3364@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <078b4e19-2b1e-bc21-f419-1064e45e5173@linaro.org>
Date: Sun, 18 Aug 2019 13:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565941103483.3364@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v7 37/42] cputlb: Replace size and endian
 operands for MemOp
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 cohuck@redhat.com, sagark@eecs.berkeley.edu, david@redhat.com,
 jasowang@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 i.mitsyanko@gmail.com, keith.busch@intel.com, jcmvbkbc@gmail.com,
 frederic.konrad@adacore.com, dmitry.fleytman@gmail.com, kraxel@redhat.com,
 edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn, pburton@wavecomp.com,
 xiaoguangrong.eric@gmail.com, peter.chubb@nicta.com.au, philmd@redhat.com,
 robh@kernel.org, hare@suse.com, sstabellini@kernel.org, berto@igalia.com,
 chouteau@adacore.com, qemu-block@nongnu.org, arikalo@wavecomp.com,
 jslaby@suse.cz, deller@gmx.de, mst@redhat.com, magnus.damm@gmail.com,
 jcd@tribudubois.net, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 mreitz@redhat.com, hpoussin@reactos.org, joel@jms.id.au,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org,
 david@gibson.dropbear.id.au, lersek@redhat.com, green@moxielogic.com,
 atar4qemu@gmail.com, antonynpavlov@gmail.com, marex@denx.de, jiri@resnulli.us,
 ehabkost@redhat.com, minyard@acm.org, qemu-s390x@nongnu.org, sw@weilnetz.de,
 alistair@alistair23.me, yuval.shaia@oracle.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, shorne@gmail.com, jsnow@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, qemu-riscv@nongnu.org, proljc@gmail.com,
 pbonzini@redhat.com, andrew@aj.id.au, claudio.fontana@suse.com,
 crwulff@gmail.com, laurent@vivier.eu, Andrew.Baumann@microsoft.com,
 sundeep.lkml@gmail.com, andrew.smirnov@gmail.com, michael@walle.cc,
 paul.durrant@citrix.com, qemu-ppc@nongnu.org, huth@tuxfamily.org,
 amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 aurelien@aurel32.net, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/19 8:38 AM, tony.nguyen@bt.com wrote:
>  static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
>                                TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    return load_helper(env, addr, oi, retaddr, 1, false, false,
> -                       full_ldub_mmu);
> +    return load_helper(env, addr, oi, retaddr, MO_8, false, full_ldub_mmu);
...
>  void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
>                          TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> -    store_helper(env, addr, val, oi, retaddr, 1, false);
> +    store_helper(env, addr, val, oi, retaddr, MO_8);
>  }

MO_UB.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

