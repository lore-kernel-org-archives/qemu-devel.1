Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E9C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908FA20896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908FA20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hafKs-0000v8-Rr
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hafA8-0006ts-8V
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1haf6x-0000y1-68
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:38:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1haf6w-0000sW-SS
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:38:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so12628760wrm.8
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 04:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UW7KqeFIZo20/Ics+NGbprY8f4g/Ej93BpVBKmIp37Q=;
 b=f9LM+ZzKlvvAhXhkc+pqI5pzCrwIYmDhHlENPECCL7wQqVkGcjmZci3g1ymI++2Zre
 Icrg/7puX7/Nbx0QcE2+QPyhfJbXMHKsHfxwyqqFBEdQK1roPZgVus+ZEYVZ2aZhxpcr
 s9rV36TwTdz6rfIy8yHcdSw5DO4aeUiiWbgFDWf2aJNu+kcd8+qrWxG+yin1qWvTESFE
 bi/Qk4C55jflasQvl/PM7OSFite7T45zKPRQw4E3JOa+OB0QWQb43lMUnk2wfguPxqFO
 aG+aqNcEunZB+cVZRMQc6kGHSZZbkXfNqr61eCCKhU/HMdjATY/hu9xlF/d4CfXxpfLd
 nGmg==
X-Gm-Message-State: APjAAAU2W8YlXwcUlhR/S3Ax9H6Mkfc1fymEcdC5kxWU+9jj5CuxtKKu
 ji+bIrHTDcMX/HbCN4WBmsei7w==
X-Google-Smtp-Source: APXvYqwpksOOzWvV/gd2pzGSNGGjqvYozv+OKqDUt8jIMMWpRfUfNs/ep+m0+w1GbIxe8x7nzQY3hg==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr24409524wre.93.1560253117141; 
 Tue, 11 Jun 2019 04:38:37 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2eec:b420:d26b:a0d4:f86e:1389?
 ([2a01:e35:2eec:b420:d26b:a0d4:f86e:1389])
 by smtp.gmail.com with ESMTPSA id x6sm14546867wrr.11.2019.06.11.04.38.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 04:38:36 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190604154225.26992-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5d8ab3e9-5a55-fa0c-c4a8-883498f95a32@redhat.com>
Date: Tue, 11 Jun 2019 13:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604154225.26992-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] decodetree: Fix comparison of Field
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/19 5:42 PM, Richard Henderson wrote:
> Typo comparing the sign of the field, twice, instead of also comparing
> the mask of the field (which itself encodes both position and length).
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 81874e22cc..d7a59d63ac 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -184,7 +184,7 @@ class Field:
>          return '{0}(insn, {1}, {2})'.format(extr, self.pos, self.len)
>  
>      def __eq__(self, other):
> -        return self.sign == other.sign and self.sign == other.sign
> +        return self.sign == other.sign and self.mask == other.mask

Argh

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>      def __ne__(self, other):
>          return not self.__eq__(other)
> 

