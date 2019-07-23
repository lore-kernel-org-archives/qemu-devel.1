Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EE9C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF13B2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF13B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpuMV-00051R-4k
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpuMK-0004Oa-6I
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpuMJ-0003nZ-2K
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:57:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpuMI-0003mx-Rz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:57:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so43038173wrt.6
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 05:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z6Av3HlmhRRhxe5BapJLLEaMBENj0QEZJ3URj6hvyy0=;
 b=ONq87HapUc/eTrfcMfPMFhbaxkbb/reCi5t7YT04Wliau0PLjn1BVxV7ZPDORPUAdV
 WFgGeZJ+BWdD15ZI06zicwS7irupFuxvAQnk0H0WExuo9vIWZuoVPUnfviTy0ZuQZYRL
 WnbkDqY7ioLCsM4N4ddXCtVh5OKASvXx0M46QBM693quZF3/49++Aoh65BgJF5fvz09f
 lzfVp3+YAAqcSKZRSPOgJRHH4amNhsz8QQZj6Hihd1P2vummpeOiaVEY9DzsJR+xho3n
 s/kvQZvJKlEyVSmvtp8J1ZYGiPxzftDdkeLFLOIa08RdeETZXRlLcPtv09GzVvBRWGkL
 iMFg==
X-Gm-Message-State: APjAAAWXBztZIjmuh45CpTOmBowAPRuqYhj8eCx2qb8/jQ1Am1I5j5zr
 hwRoBkkRuqpEz2q+WGArz+YGVQ==
X-Google-Smtp-Source: APXvYqwxaHatTZLct+oZjVxZyXYH9e4S45iQFrmYj9MshOuLU2uaAzQRLFAUu1lMUJRqDhWHKXDkiQ==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr2215728wrn.129.1563886653883; 
 Tue, 23 Jul 2019 05:57:33 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id w24sm33656228wmc.30.2019.07.23.05.57.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 05:57:33 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190723121605.491-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f7ff8fd9-162e-da72-09e7-1fd70ebf9fe1@redhat.com>
Date: Tue, 23 Jul 2019 14:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190723121605.491-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] configure: remove AUTOCONF_HOST
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/19 2:16 PM, Marc-André Lureau wrote:
> This is a left-over from commit
> c12b6d70e384c769ca372e15ffd19b3e9f563662 ("pixman: drop submodule")
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  configure | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/configure b/configure
> index ad0b8582bf..82c65ab46a 100755
> --- a/configure
> +++ b/configure
> @@ -7351,11 +7351,6 @@ if test "$sparse" = "yes" ; then
>    echo "HOST_CC      := REAL_CC=\"\$(HOST_CC)\" cgcc"  >> $config_host_mak
>    echo "QEMU_CFLAGS  += -Wbitwise -Wno-transparent-union -Wno-old-initializer -Wno-non-pointer-null" >> $config_host_mak
>  fi
> -if test "$cross_prefix" != ""; then
> -  echo "AUTOCONF_HOST := --host=${cross_prefix%-}"     >> $config_host_mak
> -else
> -  echo "AUTOCONF_HOST := "                             >> $config_host_mak
> -fi
>  echo "LDFLAGS=$LDFLAGS" >> $config_host_mak
>  echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
>  echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

