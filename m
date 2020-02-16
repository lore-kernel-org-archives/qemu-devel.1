Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039E8C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F9120857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPCQPIEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F9120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3GHn-0005tV-0y
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 04:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GGy-0004nM-PR
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GGx-00072F-Ov
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:31:32 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3GGx-000722-JS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:31:31 -0500
Received: by mail-pl1-x642.google.com with SMTP id b22so5527929pls.12
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 01:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=eD6JxPzrp70iwRscS4laop00ZH88x6VUvhHM/TtObHI=;
 b=WPCQPIEKe1oQYtZ2NE3Vh6yPuASFrmCGjz4zuhw7x40yXBVCEy7UjJ8tvGwpfmLYdy
 gFNlF2ylxtMPOgQI/yC46IGNpSwANomOUwhKwn7E+/Zm+ZNdh3otSMeYwCDZrvKdQeXF
 NIz2kJN1ntvDvsikCPZAws4g0w1J748hvU/17GyLIup5qcQtsX7X+emUooQli6sYUAXi
 VUN2pAby2O1Kna/XOO8iUk4jaT74m+NaKJX0ngt9nPyv0ecfflIJ8cUZuhYwHoYfHr5e
 R2/WXu7eZ1ZCGvDPyDT0kbZRuK2uh8rqRmVtZCxaTITgwbA9tEIJP480eqEkyCJWlH/X
 mYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eD6JxPzrp70iwRscS4laop00ZH88x6VUvhHM/TtObHI=;
 b=HxwaATN9gKzQrGEvsceKkgL9VbMmMi4urw5N3UxIy88s4K3gGIAgL91ymJaeObKied
 09BqMmrQ+TNBFmbMeTUlbP62Mq9JL0BQFDw8FHlcZdxZnZwQpAc6d/PMKlfKqHZ7q3Vn
 AS1hyeqWJsAU8YFx/RIoNhaPzGJq/E085DbWfk8XY/MgJSiAkkWobCVvveVhLfw2raCP
 9jlOt/V2PmlC4MMw2/tYQ41H36qzJSXC3G7HAXtj+81R8QanGqH94fczc3pG8HHcC1W7
 PxYs12c98Zgo/CBG1Kg6PavrLXkyUOLgBLAwRGIQrDXzEKH9YbpPxZ6aF2MiR0lhp3S2
 ShBA==
X-Gm-Message-State: APjAAAXMHD9Ywc2k7FCFUKJATWf8lQCLM2LKmpxzpeBtrULlYp79Klbk
 C7KzuTl80R3AB1XQD30dXJi8LA==
X-Google-Smtp-Source: APXvYqxhowTRQZzFE3bI/6RNuJ3ev6Tw/9pWw9++Qj8gzjYoVQxj+c9HsGmonAu37EE82hitffi5MA==
X-Received: by 2002:a17:90a:9285:: with SMTP id
 n5mr14270061pjo.58.1581845490490; 
 Sun, 16 Feb 2020 01:31:30 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z10sm8817897pgf.35.2020.02.16.01.31.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 01:31:29 -0800 (PST)
Subject: Re: [PATCH 1/2] dp264: use pci_create() to initialise the cmd646
 device
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 rth@twiddle.net, jsnow@redhat.com
References: <20200214084607.20471-1-mark.cave-ayland@ilande.co.uk>
 <20200214084607.20471-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7594fea4-9447-50f0-85df-bd172cae7e9d@linaro.org>
Date: Sun, 16 Feb 2020 01:31:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214084607.20471-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

On 2/14/20 12:46 AM, Mark Cave-Ayland wrote:
> Remove the call to pci_cmd646_ide_init() since global device init functions
> are deprecated in preference of using qdev directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/alpha/dp264.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

