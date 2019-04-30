Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1E7C46460
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E1521670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTeXm5lX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E1521670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50693 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWXQ-0005EZ-AV
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:27:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2y-0005AD-7X
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW2x-0002Y4-CN
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:56:00 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLW2x-0002Xb-5e
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id e92so7004783plb.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=gtSzyrc9FwCBM3XuNqgnihWYnGoBFu5mnZsyEfppXik=;
	b=eTeXm5lXvK5yQHmbzZvnJCh280ws0NP3vCIKluixOjK17YvZidFWF5r3qZi72U42FF
	WHJdJdG01tZJxlo0vuUawiagDKL8pzb5pRxwFLeQjJ9YBsJpcy3VnuXnHl5Lxz0oOUj1
	/sBUsZP+1P9a6XGHqLdmepzXDdesCIPiFGMSCpIsx+3ovJaQe9CeAeV/W1LcYd+1e2uo
	hnKSb/xm8fU6i2zQd5iQVvE9DMAbbM+pkGiYTYgjbCwIwhTbSVSobGIsYLp8pQvAYTXU
	ch4bYfxCrYIhuHO3cNOldaKOse3ZJ5o2Si9rnDX9Hh2pPqz6mD2QnTneyoTqb485BWip
	ubZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=gtSzyrc9FwCBM3XuNqgnihWYnGoBFu5mnZsyEfppXik=;
	b=NJp53UJF4E8001NlB7Kxi7lKQy0hakUhUTV8D8V1M/3vqOIIeKDs5OJP0XNNkRmaYj
	5HU3ZsmvLrrE35pgwcNkELky91+IE3dt/AJ0rSmX1RVhYVjLRIgysgijg0fPcKY1QKbx
	z+BPkafN40JS/DanpMp5oj3gtoivWc6VSpv1IsuSVzwInlgFiP49hRnN2KfUNCDUn+eI
	At8YgXhtUhwY8UO/GUndol7bLjXOWDqNTpWQGz8PcM5EH1t7X6HcXJu7g6h8mDnCj1qr
	opzdtEGDK9JITRug261vUqocagaZAfHt7oraNYywFhNo8kNILkAoWv4X3DpKmWjR5kx2
	S0Yg==
X-Gm-Message-State: APjAAAXGSdYjmE08+gvVAqXJ7/gPJ48fjOrsVPyMkSlM5yBbD7TzR9+s
	frE4kQFqwSvBNLkIhLAWxIiEMA==
X-Google-Smtp-Source: APXvYqzpSPZWR6lzcWhIeaCNpAZGS/f40cTuUSl3+g16qhjafNAmUpNCaaYkdT4EYFYYO9gf4EE2ZA==
X-Received: by 2002:a17:902:5910:: with SMTP id
	o16mr16246543pli.289.1556643358250; 
	Tue, 30 Apr 2019 09:55:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	b2sm38570363pff.63.2019.04.30.09.55.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:55:57 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-14-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <28efda41-0002-c357-7329-55b3ce82d1d4@linaro.org>
Date: Tue, 30 Apr 2019 09:55:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-14-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH 13/14] target/ppc: improve VSX_TEST_DC with
 new generator macros
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165548.1FGGDWrp6Osw953eAgLEz-At-RhgRTRivbkDiv8pRNo@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> The source and destination registers can now be decoded in the generator
> function using the new GEN_VSX_HELPER_X2 and GEN_VSX_HELPER_R2 macros.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             | 16 +++++++---------
>  target/ppc/helper.h                 |  8 ++++----
>  target/ppc/translate/vsx-impl.inc.c |  8 ++++----
>  3 files changed, 15 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


