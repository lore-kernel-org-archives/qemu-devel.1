Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2276C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD3620663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD3620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg5Gn-0002a9-VV
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52881)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hg5F5-0001YP-DP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hg5F4-0004Zb-6k
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:33:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hg5F4-0004FZ-0b
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:33:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id f15so2140389wrp.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 03:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6FEoyIJFmiCe378e7DrgdHINSy2kAjijN6BA1YKUcwo=;
 b=rYYRcQVfrufh18sdimE3T8eNfh81w81QihLUouSR66XTSGyd57Nt0DNXOK74AW0G+Y
 TgVA+ODaGX0YuohxH23EDUcpu6MSe3anEH9GcFXoSfJwe3lthfqUYF5sX3YpTotFg5/J
 mYylZ4rmrxUGA2C6mpg6NVTA2pE6vpDgb/N82wQo2emkGJg+Y5hd8Er0+KX8kntnYibn
 HfPftterwnBRo8z99R3tNzvhRU2/wHwI+PbzdZij/3sPXB2/fftCxEg8tU0XW4edaIDu
 QHfOraxeia79Ktz5r0Ws6HERroPF3cjwey7/uQahj5k8hGQQjmmoSF/O3PCyTdeeeNn7
 xsEA==
X-Gm-Message-State: APjAAAVzSqJMLGJdlm5YrTL9JRugKY/y2NrIMcCXmVe2UcypIYmBVzZd
 WGq2dtE9JeX5udrU53Y0XYGxzA==
X-Google-Smtp-Source: APXvYqwR0q7AIoAas6DS7DsDBWWi6X7UPuKVDlPim9PeIn3ZyQjPhdZ8u/UtElTf5zoZEdCIswAnbA==
X-Received: by 2002:adf:e88e:: with SMTP id d14mr2900767wrm.189.1561545189282; 
 Wed, 26 Jun 2019 03:33:09 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id h21sm2254743wmb.47.2019.06.26.03.33.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 03:33:08 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190626074228.11558-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d027ccd8-cf75-a44a-e818-4fff859baf2c@redhat.com>
Date: Wed, 26 Jun 2019 12:33:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626074228.11558-1-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3] deprecate -mem-path fallback to
 anonymous RAM
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
Cc: armbru@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/19 9:42 AM, Igor Mammedov wrote:
> Fallback might affect guest or worse whole host performance
> or functionality if backing file were used to share guest RAM
> with another process.
> 
> Patch deprecates fallback so that we could remove it in future
> and ensure that QEMU will provide expected behavior and fail if
> it can't use user provided backing file.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2:
>  * improve text language
>     (Markus Armbruster <armbru@redhat.com>)
> v3:
>  * drop confusing 'or QEMU will fail to start' in error message
>  * fix up grammar error
>      (Markus Armbruster <armbru@redhat.com>)
> 
>  numa.c               | 6 ++++--
>  qemu-deprecated.texi | 9 +++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 91a29138a2..1994ab0655 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -494,8 +494,10 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>              if (mem_prealloc) {
>                  exit(1);
>              }
> -            error_report("falling back to regular RAM allocation.");
> -
> +            warn_report("falling back to regular RAM allocation");
> +            error_printf("This is deprecated. Make sure that -mem-path "
> +                         " specified path has sufficient resources to allocate"
> +                         " -m specified RAM amount");
>              /* Legacy behavior: if allocation failed, fall back to
>               * regular RAM allocation.
>               */
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 2fe9b72121..9cba82d5ec 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -112,6 +112,15 @@ QEMU using implicit generic or board specific splitting rule.
>  Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} (if
>  it's supported by used machine type) to define mapping explictly instead.
>  
> +@subsection -mem-path fallback to RAM (since 4.1)
> +Currently if guest RAM allocation from file pointed by @option{mem-path}
> +fails, QEMU falls back to allocating from RAM, which might result
> +in unpredictable behavior since the backing file specified by the user
> +is ignored. In the future, users will be responsible for making sure
> +the backing storage specified with @option{-mem-path} can actually provide
> +the guest RAM configured with @option{-m} and QEMU will fail to start up if
> +RAM allocation is unsuccessful.
> +
>  @section QEMU Machine Protocol (QMP) commands
>  
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
> 

