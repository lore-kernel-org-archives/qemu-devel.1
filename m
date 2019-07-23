Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74430C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498AA2182B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 14:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498AA2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpvoH-0003D8-DH
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 10:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50861)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpvo6-0002kC-1m
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpvo4-0005Di-Vb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:30:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40375)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpvo4-0005CI-Mz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 10:30:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so43424199wrl.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 07:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xMRcspNyYL1JDYf7vVxucuzKzYEENd3mTztSpRIT/rI=;
 b=AiIfTDy5moleVFTwH39oY6/7F69at7dwS/wOyKMNrLhYedFKEGsd8puPCDFQXudFXM
 H56KnzRWsYODKoJ/f732CQLcSWw8DZW6UFpOHkr/l6yf5NjDIaKqmiT8AOxS563qMf6p
 opqnh3UvP9mjk8dQZxKXBRX6VgHp1xxt0oOgU55ZIWPKRytZJ2sEvr23pD1NKYDzzSgj
 /RwznTbZ08nY66zoLp5416So8/BRkFPoQ9xFwYJoyq4i/YYpdSrLPpWcdbIB9H3BP8o2
 Bi0+xSUsrkyB+BTobhqCfLfVsabju6yqs/V86LbM6Vf1Eqr/0dYUNLhvDRyi1+OZML9y
 H6jQ==
X-Gm-Message-State: APjAAAULe8C5Zp5n+laRdBMKXEKTq4Zy+4HkreaU2bQilLlWy6et9DRr
 tVRxcxeuz6PFVodxOsaGP4VCFg==
X-Google-Smtp-Source: APXvYqwYnx3fY1BCIABMh+jou68fZHsRIfY+DcK8W/MgaXB3kcy0FajvOq0LFAhYrNh1JVjrM7RnIw==
X-Received: by 2002:a5d:4f01:: with SMTP id c1mr916805wru.43.1563892219366;
 Tue, 23 Jul 2019 07:30:19 -0700 (PDT)
Received: from [10.201.49.73] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id z1sm45683738wrv.90.2019.07.23.07.30.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 07:30:18 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190723140445.12748-1-sgarzare@redhat.com>
 <20190723140445.12748-3-sgarzare@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a19c6de9-654e-f57f-987f-bae41d9050d2@redhat.com>
Date: Tue, 23 Jul 2019 16:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723140445.12748-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/i386/pc: Map into memory the
 initrd
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/07/19 16:04, Stefano Garzarella wrote:
> In order to reduce the memory footprint we map into memory
> the initrd using g_mapped_file_new() instead of reading it.
> In this way we can share the initrd pages between multiple
> instances of QEMU.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Coverity is going to complain about the leaks.  Should we instead store
the initrd GMappedFile in PCMachineState, even if it is just for reference?

Paolo

> ---
>  hw/i386/pc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 549c437050..b139589777 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1241,17 +1241,20 @@ static void load_linux(PCMachineState *pcms,
>  
>              /* load initrd */
>              if (initrd_filename) {
> +                GMappedFile *gmf;
>                  gsize initrd_size;
>                  gchar *initrd_data;
>                  GError *gerr = NULL;
>  
> -                if (!g_file_get_contents(initrd_filename, &initrd_data,
> -                            &initrd_size, &gerr)) {
> +                gmf = g_mapped_file_new(initrd_filename, false, &gerr);
> +                if (!gmf) {
>                      fprintf(stderr, "qemu: error reading initrd %s: %s\n",
>                              initrd_filename, gerr->message);
>                      exit(1);
>                  }
>  
> +                initrd_data = g_mapped_file_get_contents(gmf);
> +                initrd_size = g_mapped_file_get_length(gmf);
>                  initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
>                  if (initrd_size >= initrd_max) {
>                      fprintf(stderr, "qemu: initrd is too large, cannot support."
> @@ -1378,6 +1381,7 @@ static void load_linux(PCMachineState *pcms,
>  
>      /* load initrd */
>      if (initrd_filename) {
> +        GMappedFile *gmf;
>          gsize initrd_size;
>          gchar *initrd_data;
>          GError *gerr = NULL;
> @@ -1387,12 +1391,15 @@ static void load_linux(PCMachineState *pcms,
>              exit(1);
>          }
>  
> -        if (!g_file_get_contents(initrd_filename, &initrd_data,
> -                                 &initrd_size, &gerr)) {
> +        gmf = g_mapped_file_new(initrd_filename, false, &gerr);
> +        if (!gmf) {
>              fprintf(stderr, "qemu: error reading initrd %s: %s\n",
>                      initrd_filename, gerr->message);
>              exit(1);
>          }
> +
> +        initrd_data = g_mapped_file_get_contents(gmf);
> +        initrd_size = g_mapped_file_get_length(gmf);
>          if (initrd_size >= initrd_max) {
>              fprintf(stderr, "qemu: initrd is too large, cannot support."
>                      "(max: %"PRIu32", need %"PRId64")\n",
> 



