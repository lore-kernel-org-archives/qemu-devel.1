Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE3C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63ED121882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ED121882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibUS-0000wx-Lq
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58066)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hibC8-0002Y6-BF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hibC5-0007cL-8g
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:04:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hibBq-0006wY-6J
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:04:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so1488030wmm.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 02:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZS5/2cf/icmS19boYz8m743AZWGi4w6tVSomu4+4+Tc=;
 b=ddURh+JVduOY0UyTrkbyvGbDeqUma7BY5VHyYwoaVrbvVyJYzZ+xc5EzIZucWZ1Jg8
 xRu8mg5/JDDUOYqcWeJ2ma9nWnP493NhQAM8W2VmJqelyjxHU3Gv190Ha25H2seYl9Fe
 XTk/3x5iB9Fbd+jaJU7PagUcc3IT+culwAITDgTFatD1mAMDC56qfqYcdYoHCotmgqW1
 C4pGeD5aLZex2125ZGw/Q9jUvDNs4YuZcXe/aRhlREztBCsokw/ASJzoaNMOwHPPvf5b
 J+296y3koNQdXMctqYGBm7vSvj5Y7ZVFvw8+J9dZ6aV7u+t40N75EzyHCYA48WRA6g0b
 cf2A==
X-Gm-Message-State: APjAAAU5NZsmt7beWbl2uwgA2Ziny2HwMnOcuidrp7wMEPFLkD6b9974
 CFqPDh2EX8v6GRy/k0zoZ3+a2Q==
X-Google-Smtp-Source: APXvYqxe4VU2E9ze8ovdg8mZETW439ayN7YRKaXJvN9wvZZB85qHEqDFPow3WJ8kWcebPF9N77TUhw==
X-Received: by 2002:a7b:cae9:: with SMTP id t9mr7101205wml.126.1562144667926; 
 Wed, 03 Jul 2019 02:04:27 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id m24sm1788504wmi.39.2019.07.03.02.04.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 02:04:27 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190703011234.20517-1-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d6934c75-f428-f4ed-6f6e-fb47a2b674cf@redhat.com>
Date: Wed, 3 Jul 2019 11:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703011234.20517-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] migration/postcopy: fix document of
 postcopy_send_discard_bm_ram()
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
Cc: dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 3:12 AM, Wei Yang wrote:
> Commit 6b6712efccd3 ('ram: Split dirty bitmap by RAMBlock') changes the
> parameter of postcopy_send_discard_bm_ram(), while left the document
> part untouched.
> 
> This patch correct the document and fix one typo by hand.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/ram.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 246efe6939..410e0f89fe 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2763,8 +2763,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
>   *
>   * @ms: current migration state
>   * @pds: state for postcopy
> - * @start: RAMBlock starting page
> - * @length: RAMBlock size
> + * @block: RAMBlock to discard
>   */
>  static int postcopy_send_discard_bm_ram(MigrationState *ms,
>                                          PostcopyDiscardState *pds,
> @@ -2961,7 +2960,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>  }
>  
>  /**
> - * postcopy_chuck_hostpages: discrad any partially sent host page
> + * postcopy_chuck_hostpages: discard any partially sent host page
>   *
>   * Utility for the outgoing postcopy code.
>   *
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

