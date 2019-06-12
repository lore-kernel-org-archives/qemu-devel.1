Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD299C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D2720896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4e8s3bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D2720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb9ax-0003WJ-Nt
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 16:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9Vs-00071r-Pc
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9Vq-00056F-Lg
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:06:28 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hb9Vq-00053A-Cc
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:06:26 -0400
Received: by mail-pf1-x443.google.com with SMTP id a186so10307621pfa.5
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vecIoMfhkkNeEmnVQnonJ4E0VwrBZGc3qytYyHQ+f/E=;
 b=K4e8s3bGy5x1tu8SUpI6y86TIQ/z/WWe3lOkflD7V0uSzyVG+f2pzBOsXNImpDkp8B
 /WsiaHlr063y3DyODjPfWu0iQC7wBr5llOwTv+DlR8W4uf+Qgg0vtJyZ80KxeFsiSnAs
 h9Vk1u+VZJsdZPYPO4MSij50W2t9NWEtyyTqmSRsXDq8puFdA5yuQxz86vYtrmk5q6Bc
 t/rvIqWm1ha56lMpR2ZnQm3wRnj+nSzZyiNEEOB/hFNpiBQFT4km2JwueZBVLnNcVEWJ
 NwvHxKJOF/uUp8LEBSQ+IY7trn8vspqSVrtafAZEopyxZQ5EVAnJKdnf9GX+Gkp9CHnw
 wquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vecIoMfhkkNeEmnVQnonJ4E0VwrBZGc3qytYyHQ+f/E=;
 b=cgELA+EClGPklqf2+PdvwUFuPf9BkSirDFQ8QZDoM80pAR/wLKl1MqYVXMLElG3cCM
 VpsDkei6npJezGYJbkqEIHgQnooJAKKJGsPTXuyCjickM2yuRbIKQfFLcyXwn1Ts53yZ
 RM/WoJttunHE9gSqxR/FwYHJ3mu1OUlom3vm5Di6QmWRB8PrtFddoO9wqhyAoLuSu42I
 x66rxurROTfm37BcXCF7aj1RLi3HqDEZtmcIyphb3rBljqNn9dfpkx9n7N3NDC0e9J+s
 3mPZA1+ENKIEFAxf1cTNp12MNHfTfPQhlVInFQMvtnwF/wfypKYJk7K1ANFUrozLNA8Z
 R+PA==
X-Gm-Message-State: APjAAAV/xg4VP1Mo9YBn+EXAIHSoBJ3rb/xMwKIbbfYai51LmtjcaeKq
 Mr9cx+nRfvf/KPCTDCaVDQGXZg==
X-Google-Smtp-Source: APXvYqy881+PHy3etdExDYLVNlsL5YDVhfUYHHeSJk8frPMho7c8HyvooAZHytcFs6Xm8zvVasr8xw==
X-Received: by 2002:a62:1c91:: with SMTP id c139mr81007950pfc.25.1560369984007; 
 Wed, 12 Jun 2019 13:06:24 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 t11sm306025pgp.1.2019.06.12.13.06.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 13:06:23 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-9-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <79710cd0-9005-28f0-3554-527d10b2b770@linaro.org>
Date: Wed, 12 Jun 2019 13:06:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602110903.3431-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 08/15] target/ppc: introduce
 GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
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

On 6/2/19 4:08 AM, Mark Cave-Ayland wrote:
> Rather than perform the VSR register decoding within the helper itself,
> introduce a new GEN_VSX_HELPER_X2_AB macro which performs the decode based
> upon xA and xB at translation time.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 15 ++++++---------
>  target/ppc/helper.h                 | 12 ++++++------
>  target/ppc/translate/vsx-impl.inc.c | 30 ++++++++++++++++++++++++------
>  3 files changed, 36 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

