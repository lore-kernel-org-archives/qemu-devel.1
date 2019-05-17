Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304EEC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F075F20815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfBilimF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F075F20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51315 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRgHJ-0004Lg-1C
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:04:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRgCI-0001Ub-EF
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRg1f-0004JK-5p
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:48:08 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRg1d-0004B5-FH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:48:07 -0400
Received: by mail-pl1-x642.google.com with SMTP id w7so3608281plz.1
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=oZ5wyOLL+nouFfOy0/Kky2b4dgnVAmw0MOGV8k1wDNs=;
	b=AfBilimF5ecKBMUPkd9xWqdaEtkxK/pUzvKGwc1wfG4fSq2ZVhXLiBuZZB6b9/skzQ
	C0t8RpmiPoj7ZqZPjT5Hg1/u7PFkY9l82EasfbDwdy4vQgbfBka10rEsVa4g/k1p/YyO
	wZDIbqn0E3bsTqsTPXS3gjplWllo8227YolXO1KWugsjeEaukExoNSZZ9nXSWSt9Q8vi
	XuQUf5uYAmH+IACI870hWqSIepDtbP3KSnSYHinQfKZdeaalbLr+TuuBjfh7TQlmTDdH
	M+wpdQfokdBdXFE2eiJPjRmMZGhJy/DkrJtKLkb+edJaTe6VFCIDa2iOISxWsmDsnHSN
	2WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=oZ5wyOLL+nouFfOy0/Kky2b4dgnVAmw0MOGV8k1wDNs=;
	b=AiCO3vS4H5ri6olt+2L4uzppERCDz9i2SXa3k+Id0zfAUFne43hrAfIyCmt49UBmZX
	sHH1cseRfnLut+jDh7koJek5VXYX6ApV/OOyHcvh1NbejbUvcD4M/PJ5TuKehjFqmVpA
	mpB4kjwBdNKsrHbqTHKNKqwJjVjR/q1ClbpiIltFw5BjRreC/kZz4sXx8/KV+ClT8Sw1
	o9nAQYIf+5/AYLyTNe3BWx5QRBTUaZoqVkcGud0MsmJej53XstQR61kOwWPmhX/7nZaB
	MIjW19jWZj/zS68oy85/igwuyqiNSy49EIkGTosxFJyR37nXekxdhcFXfLg7y9G6Nq22
	yuaw==
X-Gm-Message-State: APjAAAUiiCX+tAwjDG4z4X1BT/PxL2OP05ZRPAA330KRsTlHXaZqaPEr
	OeLDwN3KEIJMQ4vv5H4aX6mJyQ==
X-Google-Smtp-Source: APXvYqw+PAkmfMizIHcOOp4PyQTuWz+Tzzcgz/oC3+eRnMvRA5QsrWcIYBtdASf4RrLlZcQBE/I6vg==
X-Received: by 2002:a17:902:2947:: with SMTP id
	g65mr38767627plb.115.1558111682571; 
	Fri, 17 May 2019 09:48:02 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	k63sm13989287pfb.108.2019.05.17.09.48.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 09:48:01 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fcce920c-58e3-60ef-ebc0-bcbc2e651e87@linaro.org>
Date: Fri, 17 May 2019 09:47:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515203112.506-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v1 2/5] s390x/tcg: Implement VECTOR FIND
 ELEMENT EQUAL
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

On 5/15/19 1:31 PM, David Hildenbrand wrote:
> +#define DEF_VFEE(BITS)                                                         

Same comment wrt inline functions applies.

Here, because there's one result, writing to byte 7, I wonder if it isn't
clearer to write the loop

    first_equal = n;
    first_zero = n;
    for (i = n - 1; i >= 0; --i) {
        if (data1 == data2) {
            first_equal = i;
        }
        if (data1 == 0) {
            first_zero = i;
        }
    }

// As an aside, there are bit tricks for the above,
// but let's stay simple(r) for now.

    if (zs) {
        if (first_equal < first_zero) {
            cc = (first_zero < n ? 2 : 1);
        } else {
            first_equal = first_zero;
            cc = (first_zero < n ? 0 : 3);
        }
    } else {
        cc = (first_equal < n ? 1 : 3);
    }
    s390_vec_write_element64(v1, 0, first_equal);
    s390_vec_write_element64(v1, 1, 0);

Note that you don't need S390Vector tmp, since the result is written after all
of the inputs are consumed.


r~

