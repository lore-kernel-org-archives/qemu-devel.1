Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CEEC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C9F20896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peRDQv9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C9F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb9br-0004LH-HD
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 16:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46041)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9Tv-0005PS-Ci
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9Tt-0003U4-2l
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:04:26 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hb9Tm-0003Li-6B
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:04:20 -0400
Received: by mail-pl1-x643.google.com with SMTP id i2so7077929plt.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jfESZEoV5+cjvts3KTLrrg5O/EhzjBEUJXY10czzknY=;
 b=peRDQv9CIBFdVloimZQOx0X1uz+e3d+c6izzprRAcBNGuDNk9pWPwlpqWZ6bojjrN6
 +XzXW4gABq7NJ9Kj1kxtSf4nuoTVYJ/+iPVOsRNQ9phU1swW3IUgi7a2NltFuKKBmTPD
 mPNNYjz8WrnJJPRVvrFMJCdvhOIBuJItGPuXSaCUw5F8Tyk99adbd+yHkPu/asLqdT47
 DBgIyyp1c2/LNxoEMgxFkKfadr915RpIcfwT7+I8lRGd9hJiX8ZLLY2LfUp42F6ZZxSU
 oDYGlgBciBu8x6itg1EQRTcQAXhz/EgeP7Fv+YYPObrwssR+td6RbvkuUjn+3OYb8v9N
 maPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jfESZEoV5+cjvts3KTLrrg5O/EhzjBEUJXY10czzknY=;
 b=dUhQxaRamIUNFkC159OP4x9D8ZzANictue/rEL7RZ3+/EzwAfTiJ5RppaUmsWfdhPj
 sdhoXdpCI+Xl6yMJQL8K0Qmqo2Q22Q1KaIkH55k26E7CoB6U+IR31F2k/P+DnXpbU+N2
 KaMSVYl9onkHtOe2AG9OKuZOji62A+R9ogVL0AMSyGuu0lKgRzRJ2U6NEZGxmEdh4jE1
 0GUdf3eCDoB/9RDI2IXLNNhc+h+WdOtX0eYGXgxISHn1tX3hnRXTSCP0ULogdVetAmXx
 FXfIf/oAS/adbLpyf+6DJNIg0TD77jORFfn5kB1+fdCq4zqOpYFP+0BXKLiKOn1PEEXD
 3mXQ==
X-Gm-Message-State: APjAAAWSkSFNHwr8G9xYeK7Ga9zua1PT4tWDmxBYMwYIzEv7IEgT4ZX1
 hNMJka/WEeyQoQL0c9lH6Mi8FhRwE+g=
X-Google-Smtp-Source: APXvYqw41u46G4YrhU9M6N5B4JHUgJJ9NjEwuZ/MgaCdWiHRhLKMuCrSMIjaYgadUTyyRnDDH6qaTA==
X-Received: by 2002:a17:902:28c9:: with SMTP id
 f67mr84158047plb.19.1560369852732; 
 Wed, 12 Jun 2019 13:04:12 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 p27sm413095pfq.136.2019.06.12.13.04.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 13:04:11 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-7-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4941fff7-e259-ecff-1e56-ab6900f8a1bd@linaro.org>
Date: Wed, 12 Jun 2019 13:04:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602110903.3431-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v2 06/15] target/ppc: introduce separate
 generator and helper for xscvqpdp
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
> introduce a new generator and helper function which perform the decode based
> upon xT and xB at translation time.
> 
> The xscvqpdp helper is the only 2 parameter xT/xB implementation that requires
> the opcode to be passed as an additional parameter, so handling this separately
> allows us to optimise the conversion in the next commit.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/fpu_helper.c             |  5 ++---
>  target/ppc/helper.h                 |  2 +-
>  target/ppc/translate/vsx-impl.inc.c | 18 +++++++++++++++++-
>  3 files changed, 20 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

