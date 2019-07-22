Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96420C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BB2218DA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BB2218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpWjJ-0005i0-IZ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 07:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53071)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpWj5-00053w-Ph
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpWj4-00063N-Db
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:43:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpWj4-00060Q-7o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:43:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so39068299wrl.7
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sz0dAVli6verdsWL1saWlZq8xZldmuRQESDr7ZOBKDU=;
 b=TaTux8XaaNrOXjN2DLBiXGq+H/rV3KYp0U2ciEEehepxgZ41MdZYD4MZ5ZblA5VdnX
 +IHOPmFkxgYvLtri2W8oICayltpREv2hXdTTxvywrfqBKl4bt8tNxBQUT4fNJ9Qvzwhu
 DQRi+a7GZhILp9ZbOau6kIoM3L+rs4YTA9+o2NBMeKu0aIbh04ccOXgqktYEuxCT0Nl9
 qz+UbtHZm6aIVe5RjjMixdZY7vEPXCcmcXCYiog1sfqYJaJDT24HmTT9qr6tKQ5ylIub
 alybAC5JM2t3Akr2u48XkI44FDEhfedc0t6eAaoNpOgmcsQ27chNRO7malGQE2werDUR
 EPBA==
X-Gm-Message-State: APjAAAXhjjeDGluyfYNPsQq0j3G2Pk2Wzw8gkULhFI0sigyzm7mZ6Rxa
 B6T2NEGb15FdGEk8t4IKQt6i7w==
X-Google-Smtp-Source: APXvYqwQhQxFsFWtNPS97Yxs21wUDBL4H877bFYerPHUsuBuaMioq+IGS7Xa8Y6Uy1GJYDG0Irl0xA==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr4010037wrm.117.1563795807088; 
 Mon, 22 Jul 2019 04:43:27 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o126sm35233401wmo.1.2019.07.22.04.43.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 04:43:26 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190719131425.10835-1-philmd@redhat.com>
 <20190719131425.10835-4-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6ff431d9-36bd-27a1-077b-b2cb1331750d@redhat.com>
Date: Mon, 22 Jul 2019 13:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719131425.10835-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH-for-4.1 3/7] hw/block/pflash_cfi02: Rewrite
 a fall through comment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/19/19 3:14 PM, Philippe Mathieu-Daudé wrote:
> GCC9 is confused by this comment when building with CFLAG
> -Wimplicit-fallthrough=2:
> 
>   hw/block/pflash_cfi02.c: In function ‘pflash_write’:
>   hw/block/pflash_cfi02.c:574:16: error: this statement may fall through [-Werror=implicit-fallthrough=]
>     574 |             if (boff == 0x55 && cmd == 0x98) {
>         |                ^
>   hw/block/pflash_cfi02.c:581:9: note: here
>     581 |         default:
>         |         ^~~~~~~
>   cc1: all warnings being treated as errors
> 
> Rewrite the comment using 'fall through' which is recognized by
> GCC and static analyzers.
> 
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index f68837a449..42886f6af5 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -577,7 +577,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
>                  pfl->cmd = 0x98;
>                  return;
>              }
> -            /* No break here */
> +            /* fall through */
>          default:
>              DPRINTF("%s: invalid write for command %02x\n",
>                      __func__, pfl->cmd);
> 

Queued to pflash/next, thanks.

