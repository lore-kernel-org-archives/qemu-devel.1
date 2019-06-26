Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD19C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD6A217D7
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOOxsf1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD6A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCkx-0004ah-9p
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44305)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfh-0001dC-Ny
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCff-00087D-HU
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfd-00084e-Kz
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id w9so5249659wmd.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j73IWeE9j9dPjC/uhdxa2nC+8/trzeKutNSYF5vdd6M=;
 b=GOOxsf1j8RXK/9ujd81ge09pV7HLBWlJ7sLmLUWhgD4BoLYVLzr1y6kK2Lp1NfZOv9
 Rd72a7tEg1FpfKvCMZAJUKghW9cL/Cdp07IO4vK6r8kQcjgx75MKZpoxJyb4mDSJ00JB
 NNf2EGOAj0gVIu6ce4X1ShHLE+8r5SFFtNGJ8u2gvocYOywoINmx1bN3ILY8fvcP+y5g
 swx2Ztr7yjtJ+72k63d9Glpc06pMq3z2xHQI7iS9t0QrLx/zW5m2XoEpjc6VhxgPaUeV
 Z8D2ZJRMT4RLJo45mjsecjwBi6CE3RoWY7KKu7hrkdi3Clup243C7qBtSpZaoOYo90NO
 zwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j73IWeE9j9dPjC/uhdxa2nC+8/trzeKutNSYF5vdd6M=;
 b=UmJt9WXzASRLkITFenaahihnnkgu9Qza20qzbzH5s4EoCkMcR/TZJwXgyDmZYYl++y
 JDWf3jHT5tv3fEcmv4FFiqWQWeQajvAFlpLe4fQJWYfAjIu9orPME5HwodrRikgf4sYv
 ZR0euDHvJ+7qBu6xTTYlw3y5A//RCDtROzsxi8HsJ/Cslnudo42LPog2DRB0ElsxT/hW
 DMEo+Sq6ippV0Io2D/AAGPKmkajBtOS91wC8+KIbo7H6j0PMsP7ph/rCRqyznxSRksue
 ZjVPiOoHppzrLiIMDJJcLQvxdOzQrsEWWkT8VnyBVdDIXWS9e4GA1XBqQgp1/saA5il1
 zBFw==
X-Gm-Message-State: APjAAAXkqxlpoC/qTQGoCfEHB2Isp9VOjgLxiGkJU+oVnZAeVRq+yiJm
 +c7bhmdraBP/Wwjx+YmYXOSUo3pR0m3vFQ==
X-Google-Smtp-Source: APXvYqzZ45OJHe5Oq9htjM/1hxyhGC1NCvucMGvOlJAIxDSJ5Idwax+FCoADvS0bHhsx9MMqrNNDRw==
X-Received: by 2002:a1c:7f54:: with SMTP id a81mr251141wmd.170.1561573764085; 
 Wed, 26 Jun 2019 11:29:24 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id 35sm22266536wrj.87.2019.06.26.11.29.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:23 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1560942225-24728-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1560942225-24728-5-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <763ade00-7c85-06df-909d-eac520dd6c70@linaro.org>
Date: Wed, 26 Jun 2019 17:37:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560942225-24728-5-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 4/8] target/ppc: Optimize emulation of
 vgbbd instruction
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 1:03 PM, Stefan Brankovic wrote:
> Optimize altivec instruction vgbbd (Vector Gather Bits by Bytes by Doubleword)
> All ith bits (i in range 1 to 8) of each byte of doubleword element in
> source register are concatenated and placed into ith byte of appropriate
> doubleword element in destination register.
> 
> Following solution is done for both doubleword elements of source register
> in parallel, in order to reduce the number of instructions needed(that's why
> arrays are used):
> First, both doubleword elements of source register vB are placed in
> appropriate element of array avr. Bits are gathered in 2x8 iterations(2 for
> loops). In first iteration bit 1 of byte 1, bit 2 of byte 2,... bit 8 of
> byte 8 are in their final spots so avr[i], i={0,1} can be and-ed with
> tcg_mask. For every following iteration, both avr[i] and tcg_mask variables
> have to be shifted right for 7 and 8 places, respectively, in order to get
> bit 1 of byte 2, bit 2 of byte 3.. bit 7 of byte 8 in their final spots so
> shifted avr values(saved in tmp) can be and-ed with new value of tcg_mask...
> After first 8 iteration(first loop), all the first bits are in their final
> places, all second bits but second bit from eight byte are in their places...
> only 1 eight bit from eight byte is in it's place). In second loop we do all
> operations symmetrically, in order to get other half of bits in their final
> spots. Results for first and second doubleword elements are saved in
> result[0] and result[1] respectively. In the end those results are saved in
> appropriate doubleword element of destination register vD.
> 
> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> ---
>  target/ppc/helper.h                 |   1 -
>  target/ppc/int_helper.c             | 276 ------------------------------------
>  target/ppc/translate/vmx-impl.inc.c |  77 +++++++++-
>  3 files changed, 76 insertions(+), 278 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


