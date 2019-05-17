Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0E1C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7AE20815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJfpbGcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7AE20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52246 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRhd4-0002go-RO
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 14:30:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRhYA-0006d9-86
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRhSg-0003D5-K3
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:20:07 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRhSg-0003Ae-CA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:20:06 -0400
Received: by mail-pg1-x544.google.com with SMTP id z16so3650942pgv.11
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qNnmv261yOj3OhLx4yhO/zlMgNmWD/pODlnvKhjfp7A=;
	b=eJfpbGcZSqw+xHFGBkpsU7HTAet5xnsr9ztpqrAj6cq+NFtGOvsDgxcmFw3dKQseiK
	QRgbpz2M7ykHCpga4/AypJA+ZlUTd/HoSbmsE2ze3FiDZW+4VGgY2TUBuYNej+2ciiym
	YbqjTn4arzWQSBArjoLZ7pnTGjKk0GHnslHK+UXjgeDiQWN2jDDKhVc7Rzdq2QjtYxw3
	EncOWkIm+kMMmLp1C8SEKwm+cBv9ZhIEMn0GLi8QUZaLP44g+JDTTBIUG9A4vZmszTIC
	dDWJ8ZbeVYiV3sdpeX6R7aPhEH5v39U2sVjNlbOTwAgGyNQPFvth9rlx2nuZH5bgl0hu
	9+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qNnmv261yOj3OhLx4yhO/zlMgNmWD/pODlnvKhjfp7A=;
	b=dFSc/1tVt47JcHUjwhUZxw0K5mn+kaGW/wT4suHJAYrt+3/8e20EDgfS4xRVxYd73A
	CBE/Yh/t1QxD3A6LayWowdITYSfskLOWDHwUYbxSAp0WCsCTSoui7AJG3gZyL3Bgzy5K
	wE+Pbe3I8A4GxBydDp1S+Xmn+KmukaF+pzbNdTHdzY0434A/DSrmnvTFJHBhfgMvKZ7E
	qV6bFMly1b4mX7IyYyFVLvQ8wmmLFA+wbqr1AGLSlzh99S2RypwDR+75b2dSoAIr03U5
	yCPVebaAWb391FqQGTOkH6p+eGLo5vcSOSausX4Q2zvoYCtqqHmlIe5bvB4MlLFAaL7+
	vNSw==
X-Gm-Message-State: APjAAAV/jVbpRDWuzEr3JnXX10U5aWOUwPR27CbqfwGfOIpu9ZW432zL
	SemzJfkvHeJmb9GoErwDgOy/HA==
X-Google-Smtp-Source: APXvYqz5TmXpGBqPSMviILY9MC7D5TV/LR2/EH4Z3RpLjT607a1PosKBJnVhw7hkUsgG/VAb+SNRLg==
X-Received: by 2002:a62:e117:: with SMTP id q23mr62687857pfh.60.1558117204886; 
	Fri, 17 May 2019 11:20:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	h11sm10788508pfn.170.2019.05.17.11.20.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 11:20:04 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f2659286-a445-cfcb-56d6-3afa61757773@linaro.org>
Date: Fri, 17 May 2019 11:20:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515203112.506-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v1 4/5] s390x/tcg: Implement VECTOR ISOLATE
 STRING
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
> +#define DEF_VISTR(BITS)                                                        \
> +static int vistr##BITS(void *v1, const void *v2)
> +{
> +    S390Vector tmp = {};
> +    int i, cc = 3;
> +
> +    for (i = 0; i < (128 / BITS); i++) {
> +        const uint##BITS##_t data = s390_vec_read_element##BITS(v2, i);
> +
> +        if (!data) {
> +            cc = 0;
> +            break;
> +        }
> +        s390_vec_write_element##BITS(&tmp, i, data);
> +    }
> +    *(S390Vector *)v1 = tmp;
> +    return cc;
> +}
> +DEF_VISTR(8)
> +DEF_VISTR(16)
> +DEF_VISTR(32)

Based on previous, this becomes

    cc = 3;
    a0 = s390_vec_read_element64(v2, 0);
    a1 = s390_vec_read_element64(v2, 1);

    z0 = zero_search(a0, m);
    if (z0) {
        i = clz64(z0);
        a0 &= ~(UINT64_MAX >> i);
        a1 = 0;
        cc = 0;
    } else {
        z1 = zero_search(a1, m);
        if (z1) {
            i = clz64(z1);
            a1 &= ~(UINT64_MAX >> i);
            cc = 0;
        }
    }

    s390_vec_write_element64(v1, 0, a0);
    s390_vec_write_element64(v1, 1, a1);
    return cc;


r~

