Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5B2C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D232084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOFZc2q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D232084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43885 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5O8-0005Nn-Mk
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:15:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5NL-00053j-Nv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5NK-0000zw-U9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:14:27 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:38554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5NK-0000zV-Am
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:14:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id 10so5828231pfo.5
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=YrJdTXredF/8RifWp1j1k4VYGitaqZetvqiWzpn20EA=;
	b=aOFZc2q0nn+tGhRD6/NFeS67YH4EEcQ5XIQoRenOw8moGCgnlDsgv+FCkM70b7XK2F
	lRPRiZnkb8ml/UmIvSJdoGKGuzK2pW0HpszSoLuVG9a5r5UWXnZ7dTBDSSWyMAWJ67Po
	r69a/DKETkLA4NzdLGD/7KgUyUqCADIMa/LoFwVeIBhWczsiuEWdgeUX2JaJVLC7s8hu
	OnISUygowbYzTUvus0ZlfTwsBrHSYinBtKmJF7EItRuJHL+IIy98+kalRnOQO9WH5+fF
	XwiZUd+t8Bu9fA2OkEVi2VpMDDqW/PJ80QJncbLu52z3PbVq1N34xP3gKSgX+YVak2a2
	mGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YrJdTXredF/8RifWp1j1k4VYGitaqZetvqiWzpn20EA=;
	b=hoNmi9rM//4fLNoLGAqS5Rd4W1Byv613jGEA/VYEijF68lYKMjAoOSOjNvkDwE8nWB
	lqVp7Euyz5eN6x3V+4H9V8rdSNtX5cynnXTNZ83BfwlMKCijVPVnYpfeQdbUI8xGd23Q
	5+FEPp5j+21nG1e/soTO2G0u/cju2o+N8BDtlqIzcSAdnkZqhm74/4VXsxR0ZxNK9CHI
	Yjz7/bgjfbUha2vnKMA4TrXj9YNsKddb2xOmZw+co8aXzTeykV2Rj1h+zCkjiXxB1Q0N
	C8pVEj7F9DowAHX6ykkvBht+xVGSfA/XghYaNz9dAioEQaaiJtsRx0rF/N7AAX5C/J+D
	fBOg==
X-Gm-Message-State: APjAAAVNxJbZo/uqoAZX3VbLnEG0OH4LZAetfLiPW69+1Io9fFClnevt
	CrI75KQzQXZ4h9QzSqyBhcMLnQ==
X-Google-Smtp-Source: APXvYqz2GZklFDBVV+p2DtuueLEANlyuqPkppQsptE/JfzVo4xLbbmTX0pBn1lrCBHu5ydZ/rble0A==
X-Received: by 2002:a63:d250:: with SMTP id t16mr55020515pgi.288.1555110864835;
	Fri, 12 Apr 2019 16:14:24 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	l26sm64664804pfb.20.2019.04.12.16.14.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:14:23 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-11-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <59b43a53-8c25-53ea-c5a8-1cd33b4011e5@linaro.org>
Date: Fri, 12 Apr 2019 13:14:19 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-11-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Subject: Re: [Qemu-devel] [PATCH v1 10/41] s390x/tcg: Implement VECTOR
 ELEMENT COMPARE *
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412231419.M1Li1V9_XfAUWVkN7xUg3iAIvD7DHHwkOktnOc_HcN8@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +                         es | logical ? 0 : MO_SIGN);

Incorrect operator precedence.  You need:

  es | (logical ? 0 : MO_SIGN)

or

  logical ? es : es | MO_SIGN

And perhaps cse this expression into a temporary
and not replicate it between the two reads.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

