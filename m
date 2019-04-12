Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703E2C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7182086D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtwOpjK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7182086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5CO-0002ta-7s
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:03:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5BK-0002Hz-Se
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5BI-00014W-TC
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:02:02 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5BH-00013D-05
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:01:59 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so5817795plt.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=y6xglqBzl3ykR+IauwBTmLxunY4B4fvOLG5aGqjuhwg=;
	b=GtwOpjK7YgGOimCIFy8gprDiCrv1TvVi67ckPSiFbtja8UhLdIyVCc52XxLfxK08JW
	XuK5yFzV2M+qrJyAzVkDm+cOYnefv3w7U84Q73gYtFL5Y5Pg6k6y8FCPXSRezn2cXYZc
	Yn5wIBP9iju3TGipZp5aF7eKHoADxYjkH0c7TMVhPAZqawyqaL1uDXXWyT6s2glgI2nI
	AXLsGbqeE/rby+LJpQoOBQWyuq9UDR24LF77iSmtbvTep/atDjHqBr4gOSP24uc4jieD
	DRwEE6HcVT/YDxXszsPZGMaH/1C+oWby1HPGQ6jDF7Vgl7SG4UwloGF9zC2ua0F/h+77
	J97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=y6xglqBzl3ykR+IauwBTmLxunY4B4fvOLG5aGqjuhwg=;
	b=fxcq5gcG5HATUesFBNTJdWWFBYEn4HjAYchu7CpS1IDC+utRk6SbP+MWtg0pcsuC8o
	LDcCdiOj0+2HUH3SVX5pXZ+rgvrupRgo7KDbo88XaYbykym59OssrywZnZcJ9sKCRCBK
	OGuTJpWCooaVYhgWfeSjdSWcUuIk1snX/ZqeozYvCFrHBiK/wO4q0ZF/sph7htj2DCVx
	NqliQSheeC5L0n5Q2U5Ht/yRdmsVMH9UrYtQ1R1YtTikevVybVdMKOQBnyxW63Pc+EhY
	BcQ446jpVohBmZiadadxwzs3ptZtoTQX43dxE5kWtGgcm+49Jd6goqeWdZWvxrMf6GFR
	kLGg==
X-Gm-Message-State: APjAAAXIVtUw8L89VqhMNF+F5Y+sKQQscPyMgDS56C1/xnB5tKHAXO6h
	0zds0w8yF22z+gJ45T3zlwUhOw==
X-Google-Smtp-Source: APXvYqzXDhsTzSJlgagKFPzeeJBJ7W8fSDhFLcvftAkfXLTxSfJUjjAreVTVr1KNzsley8Ovf+PrrQ==
X-Received: by 2002:a17:902:e091:: with SMTP id
	cb17mr61292188plb.222.1555110116297; 
	Fri, 12 Apr 2019 16:01:56 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	p66sm61982454pfb.4.2019.04.12.16.01.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:01:55 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <71ce854d-da00-565e-0b36-9458a7bc9183@linaro.org>
Date: Fri, 12 Apr 2019 13:01:51 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-10-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v1 09/41] s390x/tcg: Implement VECTOR
 CHECKSUM
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
Message-ID: <20190412230151.VlAL3-D9IHln605A4oq0QucsI0aea5sbP2AMFfz5rW0@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +    read_vec_element_i32(sum, get_field(s->fields, v3), 1, ES_32);
> +    for (i = 0; i < 4; i++) {
> +        read_vec_element_i32(tmp, get_field(s->fields, v2), i, ES_32);
> +        tcg_gen_add_i32(sum, sum, tmp);
> +        tcg_gen_setcond_i32(TCG_COND_LTU, tmp, sum, tmp);
> +        tcg_gen_add_i32(sum, sum, tmp);
> +    }
> +    zero_vec(get_field(s->fields, v1));
> +    write_vec_element_i32(sum, get_field(s->fields, v1), 1, ES_32);

It seems like it should be possible to implement this with i64, and fold the
carry around at the end -- 2 insns instead of 12 for managing carry.  But I
can't quite tell if that produces the same results.

You could use

  tcg_gen_add2_i32(sum, tmp, sum, zero, tmp, zero);
  tcg_gen_add_i32(sum, sum, tmp);

instead of computing carry manually with setcond.

That said, your code exactly matches the language in the manual, so

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

