Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDFCC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9C1216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z79I33qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9C1216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40925 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQWT-0007cT-64
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:38:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQVb-0007JW-Bv
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQVa-000701-GD
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:37:35 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQVa-0006zM-AP
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:37:34 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so10258424plp.10
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=SD0HWQb5tUQvClxC4NCgDLBrG8LmitLUi05QmwopyQA=;
	b=z79I33qjI4qqUhIlQLRv1aQOnNG0e/ev3JZLpI6D7zxV2k9qs7WUvKzBwXsxOURfS+
	ukwprh9ZfiXyrZtCmhyCLY/Kk90UA/8qCAB3U4CUZhoBeUWTUrC+WHloxRC0i0Vn9BwK
	yAOpjQunBphu8hOo48RPMCiWN/p1H2D46Gm3wWuTY/wTT0lMVdzFgSahre6U2S+flXLb
	iYZOSrDBUAeVRfxbDSCNqdBnIFZFwJqHpgMheJ23eHcS80/2hCous6IJ5c5yYzxXauE6
	tIRa7aIQn9z0JP5SmaF1gZh3o8eNAR88x81W0sv7aTBu1l5dKU54EfP0wLPlGtM/5baJ
	b9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=SD0HWQb5tUQvClxC4NCgDLBrG8LmitLUi05QmwopyQA=;
	b=hrAPrhCoXhn8U/rhkgxkj0fHDE+4/FZ6YnROYlDVXfEhj4uOcBAeNUQDH5rExAhvmX
	BWvuY7OCiUA0oQA/LER6NK7iJ9K6H81KUDe1mK7Jd3QAoLNFfv7oLRjRK+uBLK05GSc0
	eSifLXnixVlDbLis83W00HeSq4stwARQf3OnUNi6bvSazorwOvOgZs0Cws6+n+Jh7hFa
	rfXE1P1MOPkFy3FknqUC+NLjJOsHA2SooRJi6HKZGIuMc97n2qzKT4R2pjibSSs8feMu
	l51WY878ORc/iumaKTerM1p7lkr74T80ssv+HbyZF46DxmUSf7m3Bk3+gnTDN+xkVhJN
	NxGw==
X-Gm-Message-State: APjAAAVqllnuA9TVVgOyYCChJ9v4Tq4P55Qw4oqubp9Snb6IPjWE+uZ/
	AdDNj2qocRFdVWmiqwvbcMDaNQ==
X-Google-Smtp-Source: APXvYqyfdTasEyNYo5y/wmiQlAzFtR2Yul2OGoS6921Wn1N6TrQt+5HwS0xeQnpKjq/bssBaTqM5Fw==
X-Received: by 2002:a17:902:2702:: with SMTP id
	c2mr48607684plb.277.1557337053156; 
	Wed, 08 May 2019 10:37:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	m11sm23113855pgd.12.2019.05.08.10.37.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 10:37:32 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-14-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <931c9caf-f305-3a09-cbd9-7a11e781fb2e@linaro.org>
Date: Wed, 8 May 2019 10:37:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-14-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v10 13/13] qemu/bitops.h: Add extract8 and
 extract16
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

On 5/8/19 7:56 AM, Yoshinori Sato wrote:
> +static inline uint16_t extract16(uint32_t value, int start, int length)

s/uint32_t/uint16_t/

Aside from the possible value of the more restrictive asserts, I'm not sure
what advantage you see in these routines.  All arithmetic in C is promoted to
type "int", which for all supported hosts is 32-bits.

This suggests an implementation for these functions as

    assert(...);
    return extract32(value, start, length);

because otherwise the (32 - length) subexpression might at first glance appear
to be a cut-and-paste bug.  Whereas it's really required by the larger
subexpression.


r~

