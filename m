Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E53C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 23:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7D620578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 23:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yegAvp02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7D620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd1RY-00033J-P0
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 19:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51870)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd1R4-0002aP-12
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 19:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd1R3-0002Rn-31
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 19:53:13 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd1R2-0002Qw-RB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 19:53:13 -0400
Received: by mail-pl1-x644.google.com with SMTP id t7so4867117plr.11
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3g8pvPHolz0Gk1ulPnQrys06815XnZv3bWSjWLJcUl8=;
 b=yegAvp02oYXPpTrY3JmyIMZswNcifeFxyWjr3jKxxxSM9W5qI9wmHEweQ2NTAmfpBo
 nuerGmsgpH+heFkmHr+OsyCnrwdOyhClM1z6KZ2NsNklRvcT+Fe261UG9exlMi/gbYTS
 rr7CcL3slStuRtr007Ot5QxxZzPGmd4g2xWIkkP/ArwlOpbWys5ecC9uj4fY4vvp1N2M
 mFPkX1L7G+b30sHz6oOEcf/tslTF1YEKfHX295Vm0+1W9oW0JHRiE+CRKHO9yRLH0P7E
 2AIRYBum3fAWtej5vcqq4aQfbG75EzidLIMhTfQgfIYdMdom68pI3E322SZ/x241QK7U
 B7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3g8pvPHolz0Gk1ulPnQrys06815XnZv3bWSjWLJcUl8=;
 b=lmDQow+BatA8F2OhdLc1pO2aax6qRNLkdCzkDb0xN2lEdeNrV/WGj+u1GLLzbj0DzS
 5lC9OFuddhwVPN8H8EDgTsR/q9u0qHPq5yy94JhMbuNvlbGpsbq76kfWrlmeRJ9zMR8R
 dyWRrZlHXQfby06yW2dvUMrGfi8wNvav7D/zzrUhHzWYucO+vEsnWsm935jVfpqrSMB1
 Xm/mqp5xOBu3+PAVs54QnUy0g5qThzK7MXTQfhjc56IxL1ZWJpA7RAp+mug1R7UtRclZ
 yZL5pfNDAxAJb3E3sAWD3uXFO3MkzrAVHhqFp34AssT/NBAfKqYqyDHuTITz8aFXqDKv
 Iq5Q==
X-Gm-Message-State: APjAAAUQOP9/7lSwLL3A5jLwyu4rYreTpE0mKov6IUVhAMKPuJeg9/i3
 Vf8XNs/mh175ko2w8DJEb2/vDw==
X-Google-Smtp-Source: APXvYqzYBgEm0DlhXI1zV9rjEEXAEKSl6pGqFWr4vhZghUZOPEVCYnd4xvgcS6Z7rocbonTPe6L9dw==
X-Received: by 2002:a17:902:7246:: with SMTP id
 c6mr50743677pll.248.1560815591586; 
 Mon, 17 Jun 2019 16:53:11 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id b37sm399803pjc.15.2019.06.17.16.52.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 16:53:10 -0700 (PDT)
To: Joel Sing <joel@sing.id.au>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20190616191900.GH61734@hippo.sing.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <41ef5fbf-f438-e60a-2fba-a72e3ad422f9@linaro.org>
Date: Mon, 17 Jun 2019 16:52:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616191900.GH61734@hippo.sing.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, palmer@sifive.com, Alistair.Francis@wdc.com,
 marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/19 12:19 PM, Joel Sing wrote:
> +    /*
> +     * Clear the load reservation, since an SC must fail if there is
> +     * an SC to any address, in between an LR and SC pair.
> +     */
> +    tcg_gen_movi_tl(load_res, 0);
> +
>      gen_set_label(l2);

This clear needs to be moved down below label l2.
Otherwise, with lr / sc / sc, the second sc could succeed in error.

FWIW, other targets have used -1 as the "invalid" load reservation, since the
architecture does not require address 0 to be unmapped.  This should be quite
visible in M-mode with paging disabled and ram at offset 0.  Often, other
targets require alignment for the lr/sc address, though I don't see that for riscv.


r~

