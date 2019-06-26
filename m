Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565D7C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2211420B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzSEExhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2211420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgD3D-00062O-Am
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46959)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCsD-0004x8-6q
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCsC-0003wn-A2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:42:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCsB-0003uY-9N
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:42:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id n9so3957203wru.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ryh3ozYOiTPIN0tFG8UcccVvcIN70MIi96qBj9nH9Gk=;
 b=dzSEExhuxTg3EZY/oSNRcVKl3wsjdqR88edY74z+mTYGhv0+leGHpeGBt+I18JDlDU
 D3rmn7O7SJCehAZ+2wM9EfK2tBOnQJVXKPfGeZR1uLZMGfZ6lwIcvqi52Dq41ZHBxD/a
 pk3CpbwL1vkcRBIX5bcR3dYNomQVRmshsMGKsXUxsTQHc/qHhyVi7n0Wju7ccyjVjYRN
 FqYYmBM+n0XMrQZ+hqph3eFxk7CTx0vTKPzqekXhS5xVRxidkMQVaLF1uc2sfa9iwpBX
 qMw0sd2JjNyJpPhQnArBkYJoqSS2r83QTC05S+2miHYuTX7JJ4ImC9L9mv6e5tNzV01l
 RZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ryh3ozYOiTPIN0tFG8UcccVvcIN70MIi96qBj9nH9Gk=;
 b=donjC29YmTVK+IYe0bcsMDRM74+0S6KYuSl3/+Yl5R/0jq99LoqKIYbLZ4bD5HRDjQ
 TbAm241ELyaEfJRAy7NIUTDA3wDavFvo2gvvRHP5brYQLT7i0XXLti8efz3MQ0J2L9wx
 3UcG7fWSGrgCksGK32kRbuVD9r8COo506Y7kr7rwTUwRSRxQX4ebbhWGBNFdg5Yes3Dj
 P9FN00b4n1q3MotrY8mPRKBZbWsSFiTAU1a3WoMk7Fgv3sPtV1GC1rNrYa9W+0lrnnen
 nZTFh64rxruR0Ob+Vs5hhHyoe0YIlcZesgalPLTvXElVrelxhBDY9c2SWn969dJ13cOb
 ttdQ==
X-Gm-Message-State: APjAAAWil5SHgNnVBExEjMA+jJlkRVmFK3wfCx71yDK/BPgN5iUn2H8O
 4bY4aV7tow+qUollYVhvZczKWg==
X-Google-Smtp-Source: APXvYqyOlbfxcTG1vb56GbY+Ly2OQwoCTBwxyAvmkWAOkdRqVjcxGza6ndi/27r3OtT7C3svY1R+HQ==
X-Received: by 2002:adf:f544:: with SMTP id j4mr4849178wrp.150.1561574541655; 
 Wed, 26 Jun 2019 11:42:21 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id n3sm17634818wro.59.2019.06.26.11.42.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:42:21 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
 <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
 <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
 <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
 <d2c1f979-7ff2-946e-4863-c1be19c5f003@ilande.co.uk>
 <16f26b7f-2435-aa05-66a3-073e8310d5c8@linaro.org>
 <0ceec012-fcdc-ccde-291a-121a4e475f86@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7b1699e1-28ca-a58f-787e-c0ca11666b90@linaro.org>
Date: Wed, 26 Jun 2019 20:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0ceec012-fcdc-ccde-291a-121a4e475f86@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/19 7:00 PM, Mark Cave-Ayland wrote:
> Interestingly if I set a trap and then switch the opcode to "lis r4,0" (0x3c800000)
> then we carry on as normal until the next "lis r2,0" instruction. Looking through the
> whole output of -d out_asm this is the first mention of r2 which makes me wonder if
> it is special somehow? At least a quick search indicates that for 32-bit PPC r2 is
> supposed to be dedicated as a TOC pointer.
> 
> Is there a quick way to disable r2 from the list of available registers to see if
> that gets things going?

Interesting.  I'm not sure why that's happening.

As a quick hack,


  /* For some memory operations, we need a scratch that isn't R0.  For the AIX
     calling convention, we can re-use the TOC register since we'll be reloading
     it at every call.  Otherwise R12 will do nicely as neither a call-saved
     register nor a parameter register.  */
- #ifdef _CALL_AIX
+ #if 0
  # define TCG_REG_TMP1   TCG_REG_R2
  #else
  # define TCG_REG_TMP1   TCG_REG_R12
  #endif


But I thought that _CALL_AIX was only defined for ppc64 elf version 1.  I
thought that ppc32 used _CALL_SYSV instead.  Certainly that's what is used
elsewhere...


r~

