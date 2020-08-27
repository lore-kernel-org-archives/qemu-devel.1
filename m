Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B109C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4705320825
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uVSTBFYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4705320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBPIw-0004GX-GS
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 17:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBPIK-0003pq-Fb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:18:52 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:50239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBPII-0006bl-R6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:18:52 -0400
Received: by mail-pj1-x1032.google.com with SMTP id i13so3311351pjv.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language;
 bh=Dt0N+ePf7hKrxt/rXK/IQVXTqKR4hijiYCr568leI9k=;
 b=uVSTBFYMtmm+2XSyr2RBOvYz9All9FAmnoeAr/XZcV06XGMqGpi1J1ht896COrw1Nt
 YCEWatugUVUE7JRHeo0n15Dy0XEudoqx3iAog72mS46G2pOStOVgnVOnvT08rskNxPBx
 pKbbJfktBusR4dxQHMAZbPe4sQ4XlUJTLcA5tDAHUdQI4nlTy5y87lypsaJcZlkWCkFc
 dEir+5BUMf3tul+q+qsqa58H2AfEtTh+U8nWqBKd0cX3aVWeRx2lT6ut6l8Yem8FVMei
 s/ya3VphWWFAz036/m72Bigx52khxHjfeseVo+CHKlGxjnri9FQ9Ynp+RVBuFYUAmZJp
 EgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language;
 bh=Dt0N+ePf7hKrxt/rXK/IQVXTqKR4hijiYCr568leI9k=;
 b=h9rSZu3SLjq5S2S0tA0dXVYpODD/ZgB/V1irMXVxry9b7bRzRanfIhgddtTpSCb22a
 ljwoVcVAKm7uFMEhvr6doqjCrSZkTtOpKm6Y6hezBo81LvWBK6eqPbzi+Y7p929rMaIc
 H2QTfnCqbFPx3W8dyUT5vof21DPyajRozB7JmeiRW1hECIzUors4P6ImPnqSZmCAGBQw
 YvIKfDNbmgtrBJztxmAh9h6TEL4FUKuvuvQpceDnjmzGlIstR8DF5X/WUQ6omQQkigyV
 0mCXo7zGmGfqEN7WbYVl9YJ/P1ilbgbBQC8xJVGeVc0+Gp/DXQloBmt1I8wqYKXBVVdv
 V/2A==
X-Gm-Message-State: AOAM5308i9AmxrbdrtpjgFxGIy7m81mnz/eveJOIAO8cQhpFpXQpNPNz
 yfYjykuoqC1D0YUofDT3ZK5dTcpOQOLLFQ==
X-Google-Smtp-Source: ABdhPJyPZ2cYQM+GdhSmkj4xWBQ6OBa4dbct5u2/p225zwAxrQIIohfc9DMJtcLesJUcnS6Nde8wWw==
X-Received: by 2002:a17:90a:384c:: with SMTP id
 l12mr635410pjf.27.1598563128947; 
 Thu, 27 Aug 2020 14:18:48 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l5sm3429899pga.43.2020.08.27.14.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 14:18:47 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: build broken with --enable-gcrypt
Message-ID: <046eb29c-9c68-1baf-846e-decd65f567e0@linaro.org>
Date: Thu, 27 Aug 2020 14:18:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------EDCCB028FFC23CF97BE90812"
Content-Language: en-US
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------EDCCB028FFC23CF97BE90812
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

The meson conversion seems to have not been properly accomplished for the
gcrypt option: we fail to link against -lgcrypt.

I tried aping the nettle bits, like the following, but it has no effect.  I
don't understand how the "nettle" token works, honestly, since it doesn't
appear to be used at all.


r~




--------------EDCCB028FFC23CF97BE90812
Content-Type: text/plain; charset=UTF-8;
 name="z.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="z.txt"

ZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZSBiL2NvbmZpZ3VyZQppbmRleCBiMWUxMTM5N2E4Li40
ZmQ1MGMwMjc1IDEwMDc1NQotLS0gYS9jb25maWd1cmUKKysrIGIvY29uZmlndXJlCkBAIC02
OTcyLDYgKzY5NzIsOCBAQCBpZiB0ZXN0ICIkZ2NyeXB0IiA9ICJ5ZXMiIDsgdGhlbgogICBp
ZiB0ZXN0ICIkZ2NyeXB0X2htYWMiID0gInllcyIgOyB0aGVuCiAgICAgZWNobyAiQ09ORklH
X0dDUllQVF9ITUFDPXkiID4+ICRjb25maWdfaG9zdF9tYWsKICAgZmkKKyAgZWNobyAiR0NS
WVBUX0NGTEFHUz0kZ2NyeXB0X2NmbGFncyIgPj4gJGNvbmZpZ19ob3N0X21haworICBlY2hv
ICJHQ1JZUFRfTElCUz0kZ2NyeXB0X2xpYnMiID4+ICRjb25maWdfaG9zdF9tYWsKIGZpCiBp
ZiB0ZXN0ICIkbmV0dGxlIiA9ICJ5ZXMiIDsgdGhlbgogICBlY2hvICJDT05GSUdfTkVUVExF
PXkiID4+ICRjb25maWdfaG9zdF9tYWsKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVz
b24uYnVpbGQKaW5kZXggZjBmZTVmODc5OS4uZDQ1YzU0ODE5MSAxMDA2NDQKLS0tIGEvbWVz
b24uYnVpbGQKKysrIGIvbWVzb24uYnVpbGQKQEAgLTEwOCw2ICsxMDgsMTEgQEAgaWYgJ0NP
TkZJR19ORVRUTEUnIGluIGNvbmZpZ19ob3N0CiAgIG5ldHRsZSA9IGRlY2xhcmVfZGVwZW5k
ZW5jeShjb21waWxlX2FyZ3M6IGNvbmZpZ19ob3N0WydORVRUTEVfQ0ZMQUdTJ10uc3BsaXQo
KSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpbmtfYXJnczogY29uZmlnX2hv
c3RbJ05FVFRMRV9MSUJTJ10uc3BsaXQoKSkKIGVuZGlmCitnY3J5cHQgPSBub3RfZm91bmQK
K2lmICdDT05GSUdfR0NSWVBUJyBpbiBjb25maWdfaG9zdAorICBnY3J5cHQgPSBkZWNsYXJl
X2RlcGVuZGVuY3koY29tcGlsZV9hcmdzOiBjb25maWdfaG9zdFsnR0NSWVBUX0NGTEFHUydd
LnNwbGl0KCksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaW5rX2FyZ3M6IGNv
bmZpZ19ob3N0WydHQ1JZUFRfTElCUyddLnNwbGl0KCkpCitlbmRpZgogZ251dGxzID0gbm90
X2ZvdW5kCiBpZiAnQ09ORklHX0dOVVRMUycgaW4gY29uZmlnX2hvc3QKICAgZ251dGxzID0g
ZGVjbGFyZV9kZXBlbmRlbmN5KGNvbXBpbGVfYXJnczogY29uZmlnX2hvc3RbJ0dOVVRMU19D
RkxBR1MnXS5zcGxpdCgpLAo=
--------------EDCCB028FFC23CF97BE90812--

