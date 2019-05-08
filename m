Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B55C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F43221726
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hc09OhED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F43221726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQOR-0001Wz-MB
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:30:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQKA-00067o-Pz
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQKA-000744-1h
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:25:46 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQK9-00073i-RH
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:25:45 -0400
Received: by mail-pf1-x443.google.com with SMTP id t87so10262834pfa.2
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=yIcVWigt7710/0fSTSsiiQ//EMdY0psNWMKo4h4Nx9I=;
	b=Hc09OhED7sbLm+xqopx3wf0HjTQXyO+3i6dPrLkudl2eewovlS48ecLX2HaHyOkMtD
	Hvumdn9qSvL3XWYaN6GUUZzwt4FLwDUYbe4nJ5xj0I6BvAIol1wDTzk5FAAOaMzxOcv7
	wXf98ViRa7w7SvLhK9NRiT5zskwA30MKhHCvEWT6zdq5iGCOAuuofGSi3meA0uPEs40f
	5orBM/82f5fk4miJ/vL79pdKxTeq42waD+O3BTx4+zFHSONwRyCIMmh1g/MZ5tnVWJMD
	474N6KmPiGjIsD6DbPp/WXjvuY3KJuF7+Gbbtfpv0JtPsik7alr7KLCcyznK0EghERr2
	381A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yIcVWigt7710/0fSTSsiiQ//EMdY0psNWMKo4h4Nx9I=;
	b=ovz16h5QFC7t9hZNPJ77UYKN+h0BKRStrqx8i/XuATXU+4UEy1j4toQatTWSRxxOtR
	+jmoljc2kuH6NQQAyYy2bph+sjtD9HdtaDHdkCY5S+JffXhExvUA0IPyNNUoBdwzZdW2
	YJ3+PAw5WRBLbNQ+CnxKTvtLjPW11FNO5Gpz1AmjHsvVacnFI/6wh+2ZfsL0/uyZyHxH
	IeDZ+TpvTMtABb6u74QmBNxr1ZW9eVZZpz/TUnj2W+EwwDqq5kYSIpgTHrQoODV7RJm0
	so+aG7U0HgnMsnQ3+ZUE8HmhYNWEHyXnNLPKOxDBvnMI5XeCapvPBza7r3n3i7lGPGcc
	tUSw==
X-Gm-Message-State: APjAAAXt/sS65Kz2KQmimCG4encu8z+hr0ODwevc4Hae1fiNhMTEUyy2
	bmGtoM3KFCe8wWWyioRRS7CYWVNbvTE=
X-Google-Smtp-Source: APXvYqzlq2xEaUZ5qfZZaIPQ2qJ333ULM1eE6eSB4Y1Y+yv9e522/H5drtxsKdg+h9GiZzyf+SyfAA==
X-Received: by 2002:a62:62c1:: with SMTP id w184mr26143120pfb.95.1557336344742;
	Wed, 08 May 2019 10:25:44 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	l15sm27185164pfi.79.2019.05.08.10.25.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 10:25:44 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9d3f3e6f-c3ed-54d6-d2e2-9c3a1ac48945@linaro.org>
Date: Wed, 8 May 2019 10:25:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v10 00/13] Add RX archtecture support
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 7:55 AM, Yoshinori Sato wrote:
> Changes for v9.
> - Fix "mov.l dsp5[rs],rd".

You need the same change to the disassembler.


r~

