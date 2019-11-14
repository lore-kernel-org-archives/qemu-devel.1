Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AB4C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 20:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828FB20715
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 20:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X2cRNhFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828FB20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVM7d-0003Tn-Nf
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 15:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iVM6g-00030R-1P
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 15:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iVM6c-0000Kc-0A
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 15:52:45 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iVM6b-0000Jg-Lk
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 15:52:41 -0500
Received: by mail-wr1-x442.google.com with SMTP id z10so8274310wrs.12
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G8WNVahWv/LvqUP+pc1VBdTRja74wJ9fG/jTdsO2AhA=;
 b=X2cRNhFI+07pdy2xCXaqk/VLoTbLuUjdYYi1ySkDaI/8NkcZATmU7XjcKz4xe2ldig
 YwZd1AqTP7WQliKPe8PwKYv3XBpTyRI+ThQvu471rU3tTlmva/ce80/D3VNO2jVR9x/5
 WVREnpKmpKFNF4SvKe/bd7eMoDvePf+tWPpbC1XqKepqvd06nCb6Iokto36XzIx/ba/X
 haBh+BfqBOQQ2tXtkafDVh5rRZecuvzz90x841zB3kV5+7mRqxy9ZocLmzVwmKZcddJ1
 y28Ql/RX/Wil2Fu8bt07LL6kixTNkSDFnumaS758bIPaQc6kH4uvQ4stwdebtEZJATfl
 EzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G8WNVahWv/LvqUP+pc1VBdTRja74wJ9fG/jTdsO2AhA=;
 b=EiS5lduZ19VCnTwKbK9flzXHd1liUTp89fKSFPSa8c/IwjTRW+FDIpzFJBEbk5r2I0
 QgJctdfahN9BiFRjrDjPDmkrnnnrYwW/0brr4hNo/sKpYb1Qew05MbycnrwMNnOU3+54
 U6kGJmuCatjyiEerFRh/9stGzXZoVy3GBqVJvGvg9mazhibYwage3hPpqC7ks2pCBDBh
 RSk0cE3cH+C8k8fjFLA/cpgSg1AiySwMy4QtOkUMaltazlkYJTHyArCJkKPSP2fKkqju
 YnVGOHK69QcHZ6sJQ0quEPmODrRG+6Zqy9dCYWa6jnOfviAbAb66XhK4pBn68//ilTK9
 5QqA==
X-Gm-Message-State: APjAAAVrDQdgQtADAXW/HUxRAigQt/Hh1Ts9pTyrUlyuparkLvNTcZ5/
 MxggZ7f5faBjpZ7OyjfM4PP7Z9Cs0HAr2A==
X-Google-Smtp-Source: APXvYqyITZ9G+Fax9KYXgoxTvkm8k6E52yBAeYgo0Db7DyXzLEaYdFnP5DW/xbUSI6ZgdLzMKZy6DQ==
X-Received: by 2002:a5d:460b:: with SMTP id t11mr11172276wrq.185.1573764759548; 
 Thu, 14 Nov 2019 12:52:39 -0800 (PST)
Received: from [192.168.8.102] (184.red-37-158-56.dynamicip.rima-tde.net.
 [37.158.56.184])
 by smtp.gmail.com with ESMTPSA id q15sm8769530wrs.91.2019.11.14.12.52.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Nov 2019 12:52:38 -0800 (PST)
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Peter Maydell <peter.maydell@linaro.org>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
 <d4baa0c3-694a-293a-385a-b3eba7d52d0d@linaro.org>
 <CAFEAcA-yc9oBfsj1uvbYVCc8kivOE9k2QBGdKs8HZ-vj2iv-pw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <79acf595-5cc3-b795-24c9-e4511071c6c8@linaro.org>
Date: Thu, 14 Nov 2019 21:52:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-yc9oBfsj1uvbYVCc8kivOE9k2QBGdKs8HZ-vj2iv-pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Keith Packard <keithp@keithp.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/14/19 8:29 PM, Peter Maydell wrote:
> On Thu, 14 Nov 2019 at 19:18, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>   - If the sequence crosses a page, then so be it.  Because of
>>     step 1, this only happens when we *must* cross a page, and
>>     will have recognized any paging exception anyway.
>>     The generic parts of qemu will handle proper invalidation of
>>     a TB that crosses a page boundary.
> 
> I'm not sure this would work. If you have
>   insn1 insn2 || other-insn
> (where || is the page boundary and page 2 is non-executable)
> then the required behaviour is "execute insn1 and insn2 with
> normal behaviour, then fault trying to read other-insn, with
> the fault address being that of other-insn".
> Whereas for
>   insn1 insn2 || insn3
> you want to treat it as a semihosting sequence. But you can't distinguish
> the two because trying to read the word in page 2 will cause us to
> generate a fault with the fault address being that of insn1. Or
> have I forgotten how the page-crossing handling works ?

Yet another reason why I prefer any semi-hosting call to use an encoding that
is otherwise reserved illegal.

For this, you have to make up your mind: is it important to execute the
instructions as specified by the ISA, or as specified by the semi-hosting spec?

In this case, semi-hosting defines an "entry nop" that begins the sequence, and
I think that we are well within our rights to ignore the validity of "insn1
insn2 || other-insn".


r~

