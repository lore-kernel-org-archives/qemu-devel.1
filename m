Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0149AC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD8720717
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD8720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ1ao-0008E9-PH
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZ1UL-0001u0-Eq
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZ1UK-0000Kv-7s
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:08:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZ1UK-0000JD-1s
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:08:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so242095wre.12
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 16:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XwNruKAKjm05H2ALIZCkR5Z22tanni0lql/0mWzk61s=;
 b=dZqA3VlXBy57QvDweuFzJghNgKfAr3v5Xh3RKaj/mDwheqBkO8/uDCosRsgYkbCp8q
 NcKTbZNQKmjJds8kjaH4h+Jb7gbT9CDwh5rkh0f4t9BoCiSdMA0VvficQCSMGRRXsplo
 NHmnQIGg9AKHPwjjmthVUobdj74Qeujzt8ZQXIDXOyBQpErTsrkHapc7+Eo2Nd6wdHCU
 oDIilgNz+FxhBikrtUp20FDHNwQakaT35qH8Y8fog2A3a9wIFE8s37Y7n2mQcXkcfarL
 kn27tXleDvyQyeuN9TAiQEEDCja2qRHc8DYTPSVOzaUEKQTFeAN41Z85t18z/4TeMVy3
 lJCw==
X-Gm-Message-State: APjAAAXVy1sU19cKmkBJ0w7nLJlRw/dbmb3snoiGqyMOLzYucqzKAC9p
 H9m9NNA3JUAWY2pp6Irw6ABT5g==
X-Google-Smtp-Source: APXvYqzJe6e63NU6WQKMgebgm2j7WrTyQL8MPSrE84ILTB3Uv3UlSgtqdiMnigM1dqhddLfUxH2GHg==
X-Received: by 2002:a5d:624c:: with SMTP id m12mr15968235wrv.354.1559862482784; 
 Thu, 06 Jun 2019 16:08:02 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id j82sm266263wmj.40.2019.06.06.16.08.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Jun 2019 16:08:02 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190606154310.15830-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <699f599d-86b1-ea6b-376f-2ea6ce1acd60@redhat.com>
Date: Fri, 7 Jun 2019 01:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606154310.15830-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] cputlb: cast size_t to target_ulong before
 using for address masks
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Randrianasulu <randrianasulu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 5:43 PM, Alex Bennée wrote:
> While size_t is defined to happily access the biggest host object this
> isn't the case when generating masks for 64 bit guests on 32 bit
> hosts. Otherwise we end up truncating the address when we fall back to
> our unaligned helper.
> 
> Cc: Andrew Randrianasulu <randrianasulu@gmail.com>

Fixes: https://bugs.launchpad.net/qemu/+bug/1831545

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index b796ab1cbe..8f814a1a2c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1306,7 +1306,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>          uint64_t r1, r2;
>          unsigned shift;
>      do_unaligned_access:
> -        addr1 = addr & ~(size - 1);
> +        addr1 = addr & ~((target_ulong)size - 1);

Tricky...
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


>          addr2 = addr1 + size;
>          r1 = full_load(env, addr1, oi, retaddr);
>          r2 = full_load(env, addr2, oi, retaddr);
> 

