Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CF6C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787582054F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787582054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsYq-0005lP-Ck
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hxsXs-0004sX-0l
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxsXr-00030I-2s
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:38:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxsXq-0002zz-Sg
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:38:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so4995950wrn.10
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 05:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OQxTb15dBEop0iMkCR5umznP40ZPRML73cIH76GB6q0=;
 b=sfXH7Gx0c65fNzaP466eIU1EvfaYYwHAGSDCjA2jEEYyjaL3lMycNhlp6YgTvoixVa
 SUPbaxKKbb6ykWlp1DvZlONOOlaC5XMYJUfzcx5Wk7XDrCQppSyCEjkfWikMEAadJA04
 ewYEcgMkaLQ1G09VV2/MU+8h7ZNRfGKG5xyHEAkgoS9uWqmnS/lrZNvj7LqTH7DrwxnJ
 ec7vdfst89S5PVIKJRp1oHPv2bC+ecdndmATpUU75DoMFyPkFdiz1Qg53BPw9uscZAyr
 wUKBmlMzPNm2BRhrKv1TmJfFdBpk5IvNW0JeS30I1hhSqqwFCHcLKNlmP9GpvkHv2Ik6
 nihg==
X-Gm-Message-State: APjAAAVpUkTVViowaHeQPIChnfR1SYWSHxNbbXqX5nQaI+2IXvEvkXru
 Lhs70opExDzXCX+gGnwCnTUK2w==
X-Google-Smtp-Source: APXvYqzHXi0LTLrU+veUZEXYj8kaZqp+KV0b9firhcIoUqUVu5kp2k5HZ5tYlk4cZ7IY+Gir9fDIOA==
X-Received: by 2002:adf:f386:: with SMTP id m6mr49490872wro.313.1565786305896; 
 Wed, 14 Aug 2019 05:38:25 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g8sm6442475wmf.17.2019.08.14.05.38.24
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 05:38:25 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190814002723.5140-1-richardw.yang@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2ff8a0a8-f665-1bb4-5073-1697bee22bfc@redhat.com>
Date: Wed, 14 Aug 2019 14:38:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814002723.5140-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] test-bitmap: test set 1 bit case for
 bitmap_set
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
Cc: corentincj@iksaif.net, pl@kamp.de, kraxel@redhat.com, peterx@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/08/19 02:27, Wei Yang wrote:
> All current bitmap_set test cases set range across word, while the
> handle of a range within one word is different from that.
> 
> Add case to set 1 bit as a represent for set range within one word.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> ---
> Thanks for Paolo's finding.
> 
> ---
>  tests/test-bitmap.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> index 18aa584591..087e02a26c 100644
> --- a/tests/test-bitmap.c
> +++ b/tests/test-bitmap.c
> @@ -67,6 +67,18 @@ static void bitmap_set_case(bmap_set_func set_func)
>  
>      bmap = bitmap_new(BMAP_SIZE);
>  
> +    /* Set one bit at offset in second word */
> +    for (offset = 0; offset <= BITS_PER_LONG; offset++) {
> +        bitmap_clear(bmap, 0, BMAP_SIZE);
> +        set_func(bmap, BITS_PER_LONG + offset, 1);
> +        g_assert_cmpint(find_first_bit(bmap, 2 * BITS_PER_LONG),
> +                        ==, BITS_PER_LONG + offset);
> +        g_assert_cmpint(find_next_zero_bit(bmap,
> +                                           3 * BITS_PER_LONG,
> +                                           BITS_PER_LONG + offset),
> +                        ==, BITS_PER_LONG + offset + 1);
> +    }
> +
>      /* Both Aligned, set bits [BITS_PER_LONG, 3*BITS_PER_LONG] */
>      set_func(bmap, BITS_PER_LONG, 2 * BITS_PER_LONG);
>      g_assert_cmpuint(bmap[1], ==, -1ul);
> 

Queued, thanks for writing the testcase without no one asking! :)

Paolo

