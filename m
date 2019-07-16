Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4068C76197
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7EC217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7EC217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPIQ-0005XK-PV
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnPIG-00058L-3K
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnPIF-0001Te-0u
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:23:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnPIE-0001TB-Ol
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:23:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so19111914wme.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 08:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RYQ1dBThSk8JJ858ZnZHSH/umzI8P+MPP72jS8oW5Pg=;
 b=JZNBb7XWrUquMRNz+4kbhyTLsHtlS3m5jr3cTZdXhfCx1Vy4N+N4VmaQeAdTF/tD+Q
 Z9oQJ7dFg2fB0Ignx2ALYzhsgeN+WYh+OJAIZNoFlC0KeYDF0qFXcur3WHDsWuaSyAmE
 6682slaLM0Qo9GG4u477TKquEK5uvw+uPk4tYEbnEhdb9BhG8eoGRjnlaUFGlIrLnBXk
 P2sK4Biddo0e1mMp9SsqzVWpXuoKW889+Ak31bscKMM8GZBwixuhvk3Vv4tGSwNrYeYL
 QB6MbSQ+amSbgvxE05Np74aL9BKVP93ZKBgdMz7m91bh5TVUi6/a4EI2TVlk3gr2CmcB
 GjdA==
X-Gm-Message-State: APjAAAUjHJvyoZcrKUU2PD9Wbsf8u7wUF4bMqZLe72YDZgb1c/VTtf2f
 tHPQfN1hZI/s5rTsLpWnatDWqIydelM=
X-Google-Smtp-Source: APXvYqwro0QEHN+JSabrEO/AdGCyYUf54H+3ZTZ/PidinJmiwf9U9x8w4NFqqQ+zGvnoCBSRwb/fRw==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr32946869wmi.80.1563290581454; 
 Tue, 16 Jul 2019 08:23:01 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id u1sm20144983wml.14.2019.07.16.08.23.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 08:23:00 -0700 (PDT)
To: Cornelia Huck <cohuck@redhat.com>, Collin Walling
 <walling@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>
References: <20190708125433.16927-1-cohuck@redhat.com>
 <20190708125433.16927-3-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cfce6fc7-8459-7c04-0b57-500f3d143931@redhat.com>
Date: Tue, 16 Jul 2019 17:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708125433.16927-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] s390x/tcg: move fallthrough
 annotation
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/19 2:54 PM, Cornelia Huck wrote:
> ...so that the compiler properly recognizes it.
> 
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Fixes: f180da83c039 ("s390x/tcg: Implement VECTOR LOAD LOGICAL ELEMENT AND ZERO")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/translate_vx.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
> index 7b1d31cba5cf..41d5cf869f94 100644
> --- a/target/s390x/translate_vx.inc.c
> +++ b/target/s390x/translate_vx.inc.c
> @@ -577,8 +577,8 @@ static DisasJumpType op_vllez(DisasContext *s, DisasOps *o)
>              enr = 0;
>              break;
>          }
> -    default:
>          /* fallthrough */
> +    default:

Haha :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>          gen_program_exception(s, PGM_SPECIFICATION);
>          return DISAS_NORETURN;
>      }
> 

