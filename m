Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA52C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257E22087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6qMvaD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257E22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRfZk-00008Q-4A
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 12:19:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRfXK-0007Jq-79
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRfXI-0004GA-U2
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:16:46 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRfXI-0004Et-KN
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:16:44 -0400
Received: by mail-pg1-x543.google.com with SMTP id w22so3515762pgi.6
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Zfvv0Z8g1QhQQH4cyWttMwoja9M/0120x03BLmpxy9A=;
	b=N6qMvaD6dTxPmDp0XkBKij3PgrBc3cv9GGsGa74Y+Qo2UOe42yIc3oxhHx69hOko+L
	CPdOKEI6V4nW4L7GNFPLJcc9H5ULqicx/Wr4D9VimXL6QGZFtaVuizzPhv+6CoPLcFbl
	o1GFqmwGRAA+S00WSAtYcfDTtaItfhLZlINQi+sJpEgvd+67D5z7FPMEuHypnPv+fHUh
	RSPlryleMoxVNzzcTMGOq0KkbvKaK4XXuX/FG6ksZUnAy5HBPkvHA4RWPVekPUwwGhgm
	b0f7Mix65RNuj4i5o3XU/VHBe2dDs1iZxeO/BNpnQ9mbRzyxxwe7A+xowURZqsTeZLNV
	wH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Zfvv0Z8g1QhQQH4cyWttMwoja9M/0120x03BLmpxy9A=;
	b=GUALeVP1wV+DAIqRoSExYC6eLwaqSZGtAaSwsuTvL5KJdJ238ukR8RHL4THUK1Uwhs
	gXCq1zf43fL/SyTwFGh4rCpGyaWo7m5kvuhVyQFttOqdLwLTTUaGLFo3/1lN/Nzb7J9O
	HvogY0xhX0w1GJbNWgx8CFIEC49ggbWi4lWtxeA2RVb6YhbvoIHkVnpQ72fl2DqaQkJv
	0J4P/ayLHWDFYpUtOfHVi90UNXbLOTswXhKzdQW5pBxd0R8++NJ5U1T2xQS7P4LBfNaE
	Yg1JR/Y8/Z7baESjMQ5uNaDmZ7ZKf8ZFaPkoQHM42N7uGba7vPvFLKfW7YeeYFr5DLLv
	dETA==
X-Gm-Message-State: APjAAAWdot+PF7JdvcGPvkq/evfY2CXPmyVwBcDEusrezsaZqdXfi9y9
	o5el+LD5nI75DhpynT2FK4IghQ==
X-Google-Smtp-Source: APXvYqx4a7vIv9DFhpUYVRR2hRGqt+7PXpbwdsneVd35g8a6os68iWJ9MRJ7ZM97gWCScj+P6p+WvQ==
X-Received: by 2002:a62:2506:: with SMTP id l6mr60889590pfl.250.1558109803330; 
	Fri, 17 May 2019 09:16:43 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	2sm11575197pgc.49.2019.05.17.09.16.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 09:16:42 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b3611279-15c4-f9b7-2a91-051ac6431b2c@linaro.org>
Date: Fri, 17 May 2019 09:16:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515203112.506-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v1 1/5] s390x/tcg: Implement VECTOR FIND
 ANY ELEMENT EQUAL
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
> +#define DEF_VFAE(BITS)                                                         \
> +static int vfae##BITS(void *v1, const void *v2, const void *v3, uint8_t m5)    


First, because this *is* complicated stuff, can we find a way to use inline
functions instead of an undebuggable macro for this?  Perhaps a different set
of wrappers than s390_vec_read_element##BITS, which always return uint32_t, so
that they have a constant signature?

> +        if (zs && !data) {
> +            if (cc == 3) {
> +                first_byte = i * (BITS / 8);
> +                cc = 0; /* match for zero */
> +            } else if (cc != 0) {
> +                cc = 2; /* matching elements before match for zero */
> +            }
> +            if (!rt) {
> +                break;
> +            }
> +        }    

So here we are computing the second intermediate result.

> +        /* try to match with any other element from the other vector */
> +        for (j = 0; j < (128 / BITS); j++) {
> +            if (data == s390_vec_read_element##BITS(v3, j)) {
> +                any_equal = true;
> +                break;
> +            }
> +        }

And here the first intermediate result,

> +        /* invert the result if requested */
> +        any_equal = in ^ any_equal;

... inverted, if requested,

> +        if (cc == 3 && any_equal) {
> +            first_byte = i * (BITS / 8);
> +            cc = 1; /* matching elements, no match for zero */
> +            if (!zs && !rt) {
> +                break;
> +            }
> +        }

> +        /* indicate bit vector if requested */
> +        if (rt && any_equal) {
> +            s390_vec_write_element##BITS(&tmp, i, (uint##BITS##_t)-1ull);
> +        }

... writing out (some of) the results of the first intermediate result.

> +    }
> +    if (!rt) {
> +        s390_vec_write_element8(&tmp, 7, first_byte);
> +    }

... writing out the rest of the first intermediate result.

I wonder if it wouldn't be clearer, within the loop, to do

	if (any_equal) {
	    if (cc == 3) {
		first_byte = ...;
		cc = 1;
	    }
	    if (rt) {
		write element -1;
	    } else if (!zs) {
		break;
	    }
	}

I also think that, if we create a bunch more of these wrappers:

> +DEF_VFAE_HELPER(8)
> +DEF_VFAE_HELPER(16)
> +DEF_VFAE_HELPER(32)

then RT and ZS can be passed in as constant parameters to the above, and then
the compiler will fold away all of the stuff that's not needed for each
different case.  Which, I think, is significant.  These are practically
different instructions with the different modifiers.


r~

