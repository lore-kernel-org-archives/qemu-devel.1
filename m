Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46EFC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B23C2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRr/aeAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B23C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF4DI-0003Mf-MS
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 18:00:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4CN-00034G-WE
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4CN-0004ez-0e
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:59:03 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF4CM-0004eJ-Cc
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:59:02 -0400
Received: by mail-pg1-x541.google.com with SMTP id d31so5801992pgl.7
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=fCdLIafvCYj/CcSoYEWs+e8JEYFoMP/D8Z+dyR/F+cs=;
	b=GRr/aeAYBZYGKIeOVIEcXK919hi3+WGTi2z4vYbcua6URa8RQf7Pe94aivoXFtfbto
	hFQ9D0sNcSktEZtNks7PlR6cUezyZoAGo7QNMbBwTtHx+j3O9AGurq7UmfEx3YLeac0y
	NPw9/xYfCRi9wzK6V6tWfvNqUV0MYUZXbb1dM0avQXBDpu1OUvOp4wJ9ThF0x87qCC2c
	txl6ngsD+RV9JRXpnWBwQZce70WXVxMuDZ8OIAndJVEr9Fw3PUtpHuHrRndg96WBEN5G
	ELmH8G/N6Upt9SDQEw2303Uy0FxSeitDaGqkw6iUvKcjvRjF5oyGpL8VDfv6AkUu8TwG
	USNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fCdLIafvCYj/CcSoYEWs+e8JEYFoMP/D8Z+dyR/F+cs=;
	b=ptE2U+1izBh17K3CJIb/u1c9WD9TZVLdPGfikXwlX+RmVakCylHJQ7DFYTk0B0tYCE
	2Ay2czWhEuQjCLnEbGxFa2lq0EvduIs2qMb0RKQ7vs+7f+u4MR3drsXpRfx9Asy9BXS6
	e046CbRId0DRzjvn7RIBXqhUSydj9tKNnQwFwx8reFtOlcGju0PRUya6IEDKuJ4aFzsc
	eXS4b+Z1PtPGAI0Vh/GjqF1Ivf5leq/5ODeNR7HfNI+DZR5z1chnBJox+yWc5iFE3mHZ
	UVoiCoXQ+uSR9N1tp8dvgpgjcYYkDWCORzcWUVMyUdNw/LdVBo0g8ST6wkD3w/WL08YE
	sqQQ==
X-Gm-Message-State: APjAAAWYhr6YIQXLjG5XufW3mgAyhpDL/1IfUNeUKHIx/vJXDTEvXBuh
	ufgkBlaqo6qtUDSaXJrUqg0+iA==
X-Google-Smtp-Source: APXvYqzamiDP9i7cl1AZWoNCviEzKwD8nw2sx63GKwf4RIHziHBNy6oUu4u+jrX6yjUUE3oxeinFJA==
X-Received: by 2002:a62:69c2:: with SMTP id
	e185mr58975833pfc.119.1555106340603; 
	Fri, 12 Apr 2019 14:59:00 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	i135sm58132043pgd.41.2019.04.12.14.58.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:58:59 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fed7735f-6d51-f84d-8160-6967ffec2338@linaro.org>
Date: Fri, 12 Apr 2019 11:58:56 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-6-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v1 05/41] s390x/tcg: Implement VECTOR ADD
 WITH CARRY COMPUTE CARRY
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
Message-ID: <20190412215856.LLjDHyBTYIjfFTuxhgP3l_sWcm6oS-fwoLvFZBFjGs4@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +static DisasJumpType op_vaccc(DisasContext *s, DisasOps *o)
> +{
> +    if (get_field(s->fields, m5) != ES_128) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2),
> +                   get_field(s->fields, v3), get_field(s->fields, v4), 0,
> +                   gen_helper_gvec_vaccc128);
> +    return DISAS_NEXT;
> +}

An inline expansion could be

One possible expansion is

  tcg_gen_andi_i64(tl, cl, 1);
  tcg_gen_add2_i64(tl, th, tl, zero, al, zero);
  tcg_gen_add2_i64(tl, th, tl, th, bl, zero);
  tcg_gen_add2_i64(tl, th, th, zero, ah, zero);
  tcg_gen_add2_i64(tl, th, tl, th, bl, zero);
  /* carry out in th */

This is 8 insns for the addition vs the hw optimal 6, but we're not exactly an
optimizing compiler either.  ;-)


r~

