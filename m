Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB12C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC65A214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kscA1f0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC65A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtwg-0005K2-FS
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtft-0001tU-Ld
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCtfs-0003f5-K4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:52:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCtfs-0003eO-Er
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:52:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id w10so1573461plq.5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yHt544kKMLTAzXmG0QrhjlZ7h59m1K6L+Zarp5LpcJg=;
 b=kscA1f0L6uoL1sMKfbO0+Q4nVf0JdEYjVH3wf3h72tv+CfVXeht+jgysi+ffD60bP3
 JeBgd4LdnyuZMph60kTwhPesUnQ9ZgfztJF4Z9UtR6Ven1q73C+egAI1/Ehs+nJ/1Xbp
 9xGt8yEBbdXz12oTSiOAnU+aMaF4xcbwg1KBWJEOG8leq0SaIMzn5tRoXtDVYTX3oeE4
 pA2UoEBuFdbHi2NBgm9KdypVxspW692WaQHzli00haJYkqa62F5ipsY94XkpP6Unsj4I
 1NP8JpWsqRTCPZ0MHhhFNxvYFuVAAM7hykw9vXbEKZMxqv/gNPLFMB1s1X//Tu4OTVdi
 bh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yHt544kKMLTAzXmG0QrhjlZ7h59m1K6L+Zarp5LpcJg=;
 b=pXdjInZgaUatnAbGlKrW/XM1jB3hb2GoFa+ZcvRE4dga0sTh88MtIMAHcOtsAfvYEG
 Xc3aFZQPs0hApyQQZ7O56WoN5sTop8hdsJnErzY8X91/HUwvuFhgY+Ut8eMkyWOKClG6
 ZzQiKbd20PI+wyLgv9XOHIUp6vM50oFKjwAEibmu281iNK7nBMa9fBStHr6LMclF9KZk
 QLJgNODmiBiNkZNGpwSEnOpdm2H1mpga1jtFJwmYiWVTkxdsPCMLQ8fQ3PIkHbIvpppT
 KJNOe51chVC1//MLCC27Yxg8XDECI+aTmmPik/sIoIfXnPNdEBpfepvvCbfktYrI9fS9
 ufDA==
X-Gm-Message-State: APjAAAWNhYcpMQ3tzwCdW0N4c+QVswNRT2kRCmO1lbzjlG2rDDXuspGT
 lJfQFYcwNznFnTwqlVgjw2Qrvg==
X-Google-Smtp-Source: APXvYqzySPwdlwkuHB5V8VGPQ0mMYuk+AZcsoAPoKnTbz/yNMcnNXbiBiSC25n2odXgg+iXvlfiHTw==
X-Received: by 2002:a17:902:b7c3:: with SMTP id
 v3mr5033181plz.139.1569361586558; 
 Tue, 24 Sep 2019 14:46:26 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id b5sm3730404pfp.38.2019.09.24.14.46.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 14:46:25 -0700 (PDT)
Subject: Re: [PATCH 5/7] target/ppc: change struct PPC_DFP decimal storage
 from uint64[2] to ppc_vsr_t
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-6-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a79cc85b-66b2-0ac2-c4bb-1e8d0a63e3ee@linaro.org>
Date: Tue, 24 Sep 2019 14:46:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924153556.27575-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.194
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

On 9/24/19 8:35 AM, Mark Cave-Ayland wrote:
> There are several places in dfp_helper.c that access the decimal number
> representations in struct PPC_DFP via HI_IDX and LO_IDX defines which are set
> at the top of dfp_helper.c according to the host endian.
> 
> However we can instead switch to using ppc_vsr_t for decimal numbers and then
> make subsequent use of the existing VsrD() macros to access the correct
> element regardless of host endian. Note that 64-bit decimals are stored in the
> LSB of ppc_vsr_t (equivalent to VsrD(1)).
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/dfp_helper.c | 210 +++++++++++++++++++++-------------------
>  1 file changed, 108 insertions(+), 102 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

