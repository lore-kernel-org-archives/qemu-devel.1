Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F377AC31E48
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1BE20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrKT1rxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1BE20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb9SZ-00037N-Qf
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 16:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44669)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9QA-0001FE-Di
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9Ov-0007tc-55
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:59:17 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hb9Ov-0007sd-01
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:59:17 -0400
Received: by mail-pf1-x441.google.com with SMTP id q10so10284344pff.9
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Myb4EDe5G8psjlQi9qyQpwxFCeY3PhtQ1P8nfNrlgRE=;
 b=XrKT1rxtxAM5GXfpFN2u6JLo+qTxzJNEDunzXrwDh0Wwy7YY5ZECEVoHo2tA6Pjpdp
 cid789F8WaTslZVsgzke+pwH80kkZ3SSlztz9gUnhA3qm4uj5sh2V5ecmXR7EVvgJtW4
 8daYWrhX7YpQHAJY7B3f27ZbXL7MCOGXDiTQmB5ziEyRq3jb31ZTS5plnPk2P+Uf59E+
 c4B/PPhPFxljOWvI9bDCrzHNmnK7sU9vKmQLMuX+sBI+ww+15EtregEdY18gnOEWEHQq
 IiX3TUjCTyWG0rpbaEkUoo3znHeU1hegICUJBTukXI/7VRCZLah9egmWIplY1Q5ct5Ox
 VOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Myb4EDe5G8psjlQi9qyQpwxFCeY3PhtQ1P8nfNrlgRE=;
 b=gMGQWeIixJvsKS/H9bpXu2e65xoyGW8ZRqKBaQcpW0H8A88E3O6oF6IGEd3DLinytZ
 xjnpfF/pI3OXQySW+E6fsse2/GM6rmk4UmIyEG3vb3inI06rKhNd50k/2wAaJewIRIXm
 fCGXWjl4dsZMyXJ9OsAAboTJaLZHZL16M1+1SZBdyXTrFPOhGz8u7bh/xLyivw3K/nT/
 aB6Y3w+fHOW9iL7CuOMhwakUfD/WzSXPHHItpXFNazYIfWYHGZzWIUaKJHzj0ydc3MQT
 PjqR+e6+kIMMuBXNwDFQh4V4xzypaMhwK1FzHSpeRRgOeRJF7cBcHjPKTmNVtC8731/C
 AFmA==
X-Gm-Message-State: APjAAAXSipt2T1wivQUF/zWna3ZRphRq7FGLnZNBnxG0ie1gQmkMa4D6
 44q30iEai54qy951CAkz+zdZrA==
X-Google-Smtp-Source: APXvYqw6IX3SOZJUCkzCt4PwrvYQqyOcVWDaEL3R5W+4lPucA1dn8g8HeGPGngB2kpBm9Mkow4sz2g==
X-Received: by 2002:a17:90a:a790:: with SMTP id
 f16mr913071pjq.27.1560369555643; 
 Wed, 12 Jun 2019 12:59:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 z3sm228477pjn.16.2019.06.12.12.59.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 12:59:14 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-5-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <97dd42d2-edd5-5eb1-cfa0-5b23cee807f9@linaro.org>
Date: Wed, 12 Jun 2019 12:59:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602110903.3431-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 04/15] target/ppc: introduce separate
 VSX_CMP macro for xvcmp* instructions
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
> introduce a new VSX_CMP macro which performs the decode based upon xT, xA
> and xB at translation time.
> 
> Subsequent commits will make the same changes for other instructions however
> the xvcmp* instructions are different in that they return a set of flags to be
> optionally written back to the crf[6] register. Move this logic from the
> helper function to the generator function, along with the float_status update.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 15 +++++-------
>  target/ppc/helper.h                 | 20 +++++++++------
>  target/ppc/translate/vsx-impl.inc.c | 49 +++++++++++++++++++++++++++++++------
>  3 files changed, 59 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

