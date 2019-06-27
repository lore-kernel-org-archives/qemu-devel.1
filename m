Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F31C48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A12B208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vf9qtRCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A12B208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXUB-0004OF-My
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgX8D-0007C0-CI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgX89-0004KE-Ci
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:20:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgX84-0003yq-Cl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:20:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so3295584wru.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FAwBUk3G5Bj2CQarLPtJt2WX0hbF8QWcnx2JtkNbuJw=;
 b=vf9qtRChBWvudlQuif0zapRi6RV5OpzO+5w5V4NPZgvOb4ArNBOedHwGhWCQqE0szu
 2SOb9sMaG6xrMEGie7ZnQXXmGwduu87J1b0nEyJASl/b08F79EEhHncJp81U9W4C0EG4
 r9DbVdK9xLHUVAhLLdrEPoYxTrZNF/VL/dDbwuIuL1mGFWES6Pz7V/mXg6B5mKPlr+T1
 H6mDhuepd0rM1s9Iuzng8qbeuLG1LlNBYRbwnXt5nWg8cOgIU8+mLelUy0x1KG2/jNt8
 LGB1EB/fFFN18snvi5moF2h52npxGTu1uFoAKDRh3Jh6yigG5He6ZfOYYPsPLFhXIbUe
 +NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FAwBUk3G5Bj2CQarLPtJt2WX0hbF8QWcnx2JtkNbuJw=;
 b=nyLWvcT0nlPJ/qV9nFS4u2nUYdaI4kCFViPW7EAtVA5UN6bTtw4GDl+cwxCPl3N0jy
 TVCgemwbZVEfVQJDufGxI84wElV+vkheK5tHvOHz1j664dVDN+DIMVuYBlA2MSQ50NqJ
 IaQaPl6anUtGlGGBZ9suWDKVtcUS90FGZH7ToQDRg+Z3EgW9OL81XaQ+J1IHQn0PiWAy
 TmfoA+FNpqQKuFbjbpBNf4d8LxW4nQDmMhDA5Xt4qZgtfcJEtjlyJUwj97UXt9F6tKlM
 uN14LHHWPGlBF2RDAQBu2Zbw5gqJOqTzDvf84ILG/nVa1ocUMwcocJnSO9PBohJBRptQ
 nW4w==
X-Gm-Message-State: APjAAAXaXKrdU4q/lMikGdCWc11/XUumcTFZqdBY9xLj2dLj/V/IECQZ
 g3xs5tqUvjn31FJTKhxFdKaa1A==
X-Google-Smtp-Source: APXvYqzRvmfcuD/TooS0//8nWZLBxVvzdp9XwvwyUlcH49bPmOKokAlqMl6xofm8+uW6Dag5Wc2Ztw==
X-Received: by 2002:adf:9d81:: with SMTP id p1mr4080077wre.294.1561652400048; 
 Thu, 27 Jun 2019 09:20:00 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id l8sm5098420wrg.40.2019.06.27.09.19.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 09:19:59 -0700 (PDT)
To: Dave Martin <Dave.Martin@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-8-drjones@redhat.com>
 <ee8ce4a6-09fd-47ab-ef7e-a231df1e9c1b@redhat.com>
 <20190627104638.x4gxsmv7vpww3mra@kamzik.brq.redhat.com>
 <ae98bf94-6826-1f2b-2f2e-a11a3f75cb92@redhat.com>
 <20190627114701.n7tjgmljeribk7to@kamzik.brq.redhat.com>
 <20190627151628.GI2790@e103592.cambridge.arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d0f5ee56-1e10-6c27-40f1-69b87a43fdca@linaro.org>
Date: Thu, 27 Jun 2019 18:19:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627151628.GI2790@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 07/14] target/arm/cpu64: max cpu:
 Introduce sve<vl-bits> properties
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/27/19 5:16 PM, Dave Martin wrote:
> The architecture says:
> 
> "For all purposes other than returning the result of a direct read of
> ZCR_EL1 then this field behaves as if it is set to the minimum of the
> stored value and the constrained length inherited from more privileged
> Exception levels in the current Security state, rounded down to the
> nearest implemented vector length."
> 
> I think the behaviour of a direct read is implied: the LEN bits yielded
> by an MRS should contain exactly what was last written to them via MSR.

I agree.

Moreover, the value written to ZCR_ELx.LEN should not be directly adjusted
because the effective value also depends on ZCR_EL(x+1).LEN, and if the
higher-level EL register changes, the lower-level EL must see the effect.

The function that should be modified instead is sve_zcr_len_for_el().


r~

