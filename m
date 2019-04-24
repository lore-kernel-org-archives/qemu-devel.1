Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A7C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2581218B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aI8FYFOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2581218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJLn7-0005kL-VQ
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 13:34:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLhB-00018K-St
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLSz-0002Dc-TX
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:13:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:45431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJLSz-0002CX-Lf
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:13:53 -0400
Received: by mail-pf1-x42e.google.com with SMTP id e24so9615389pfi.12
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=HGHUGGygEueyVrFtzcsR0dzEnlqBbddDkuUCZAH40Dg=;
	b=aI8FYFOoY+r8RE3QK2A1uv+3IvFC8VxIWegXWcS4sUL5NlG/FFo5jslnOcHE69WrMs
	KhrQijHBmyv/byuvzkvBz7xybjo9wih9VwaEA5qhn9+NF923rI+B9XsuIst5Ktm/zEKg
	8NicAZAGuOsP1XRQ87D8HthE0lTEkN02zS2cYinG+nrxlNriMiKnTQ6UdAPQlbyAQMaY
	5aspv9kWxcL3QoZo9XA0lofp1U5ivD8ukiYK6Y3CAfTEsSqAo8wUrKzzkZSSJzaiHkh7
	kj9cdfQxFdtEHxXyQJ0vk5vxZ44DFFcHtvp5VxNAFZtxztk6jOv5Nq+wIIwXWdIsMK+C
	NAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=HGHUGGygEueyVrFtzcsR0dzEnlqBbddDkuUCZAH40Dg=;
	b=HZrsxum9cJpWvlye/uiYuEf72hEr+pY933+RtmgacbjQu8jUeJZ1BgCIJ3yGbI92Cm
	xCKYGFUK3GBD+ZN4Dhaw0WJtJ9EB/er+JkiVxAxozvW3S5TCJpDkePCRis5fe43vQQg6
	PJ7VLqnh+kMGy+IGdYpE41mZu4lO4TGLMtJXLaZHLwXEqkhZft4XaYTFeLe2ymCERgWv
	ouNgcl0ok8gIYvpdNDIx0/5JysbYdpymBSiBCjzhBZbmtHZEzDZg1ubnzCrd8bNmHmsj
	EFnZ4IjkHsQT+4tTBygihUL5h5ySH9BE9H04p66DdidmZtYgVr+nt6QP6teqPLNyS4RR
	bZjg==
X-Gm-Message-State: APjAAAXONKvum68TcltD7RviSHF64ssMnFzYjwIXqsum3kJA3R9/mIhp
	WcYoM4aWjV07TfvL8Mo4zqdGzp6bJQw=
X-Google-Smtp-Source: APXvYqxYb/N9bQH1x9FZbKPv6XFRkMxunMFrrZPnPDSe7LS1Hhtm4AaRme7gxcdyf3KLu7GQQgxfUw==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr34093071pff.35.1556126031531; 
	Wed, 24 Apr 2019 10:13:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	y10sm28607013pfm.27.2019.04.24.10.13.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 10:13:50 -0700 (PDT)
To: arilou@gmail.com, qemu-devel@nongnu.org
References: <20190424142714.28460-1-arilou@gmail.com>
	<20190424142714.28460-2-arilou@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ef86e214-eb94-034a-16a4-30a7334c6e0e@linaro.org>
Date: Wed, 24 Apr 2019 10:13:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424142714.28460-2-arilou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42e
Subject: Re: [Qemu-devel] [PATCH v3 02/20] gdbstub: Implement deatch (D pkt)
 with new infra
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
Message-ID: <20190424171348.Q52O5i4y9JBubrNv9eI6daD6VS3jRRdb-C-ec7BrG8A@z>

On 4/24/19 7:26 AM, arilou@gmail.com wrote:
> +        {
> +            static GdbCmdParseEntry deatch_cmd_desc = {

static const.  s/deatch/detach/.

That'll require changes to patch 1, since process_string_cmd doesn't take a
const GdbCmdParseEntry pointer.

> +                .handler = handle_detach,
> +                .cmd = "D",
> +                .cmd_startswith = 1,
> +                .schema = "?.l0"
> +            };
> +            process_string_cmd(s, NULL, line_buf, &deatch_cmd_desc, 1);

process_string_cmd returns errors, which you make no attempt to handle here.
Should the errors returns in fact be asserts?


r~

