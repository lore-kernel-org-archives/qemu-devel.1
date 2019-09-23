Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0C8C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDD320B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x02xI+Ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDD320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCSnX-0008LI-QN
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCSmY-0007JF-TA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCSmX-0008FT-SD
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:09:54 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:39539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCSmX-0008Eh-CA
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:09:53 -0400
Received: by mail-pg1-x535.google.com with SMTP id u17so8426659pgi.6
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/qNyo7wCuq1YanO9qRM1s7ZJkKgLvI4Opx8LD5QjWq8=;
 b=x02xI+IgQ5zKPZ7zU5CkmiuVVDbYNMTqc+3N29i6AzhJspFnCvBIyHL1WERD/UotWI
 g+CyxywIgMXGL8f3MUz31gTLhQjfqJe/7zrx66tn7tkyG0937ex6vDZPcoX5sVBbdQgF
 1LX95cN85YnVEgwdu2L4xnWC0GfQnI80o0I0XGqOXZ+AWRZogzUCTGF7um027hytqW0E
 psFw/AtMx1veD3zY+F/7qpJMvJY3NThfnT28Y4RfKO2k+eIVCNwLnahDmKdNnhEE8wEq
 ZTqsjWkvHvwCMgG5dj9w23ADvM/3rs4dkOPfWM2QcdXuSr8USTcA5tiR8iGuIGbLNusS
 tZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/qNyo7wCuq1YanO9qRM1s7ZJkKgLvI4Opx8LD5QjWq8=;
 b=OotSAgJUhd64ClVan4jHBZjxXcil9ScAXM1VPAVAE6b9P2TtYHUsMEGfOUDXssYl6R
 YWNm6usirnPEOFhsXxvTOLlVPRY24PexoWI4YYEYPnrIucDP8oLero51RZupUy7XJrow
 qtlXY8BO/OEQu2/VH9yB0iufUtQ8ZuDzL7YLa3403AKmuULSBSsz1xdDXyFW1r6Kt/r9
 xen3DD5/xC3NvgSVMc1uly2y36MJW7DKgcKLvbp++fwtrmUhBLEM3BdKSkQUylWewNiL
 0gdZrdBGYxm3L/MEyv5cwKYo/Cm4xivUPsKStvxwRXqDc516fWAt/aXyFL3vxKYN34WI
 wPDw==
X-Gm-Message-State: APjAAAWNbY9UBZAfX6Fcqb4//JMxB5USn4R1Y6t1NmkgbTj2hvdPUZAl
 72b5lNvHy8Yaflkfei8M2MxQ+w==
X-Google-Smtp-Source: APXvYqwMGJJHTu/ewyceHsxbdSu/lh0751RdaX2fX4CC1iwgreNJQm6TpJOcsw5wY/oJqeiIMLsWrg==
X-Received: by 2002:a62:cf82:: with SMTP id b124mr889263pfg.159.1569262192035; 
 Mon, 23 Sep 2019 11:09:52 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id g24sm20419643pgn.90.2019.09.23.11.09.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Sep 2019 11:09:50 -0700 (PDT)
Subject: Re: [PATCH v3 08/20] cputlb: Disable __always_inline__ without
 optimization
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-9-richard.henderson@linaro.org>
 <4c505d4b-751e-911d-4b2e-fe90a9d5ab02@redhat.com>
 <ce2f8cc3-a97a-b15f-2816-b85d66bc7c17@linaro.org>
 <73c01ed0-607e-9412-b287-1aa30d8f081d@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a4c0e7d4-56a7-0b98-e26c-5eefc1050c0a@linaro.org>
Date: Mon, 23 Sep 2019 11:09:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <73c01ed0-607e-9412-b287-1aa30d8f081d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::535
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
Cc: alex.bennee@linaro.org, stefanha@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 9:49 AM, Paolo Bonzini wrote:
> Hmm, still we support 4.8 and always_inline is much older than that.  So
> I'm not sure it's useful to test it.

Fair enough.


r~

