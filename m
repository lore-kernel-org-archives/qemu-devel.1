Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6341DC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 06:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F9C2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 06:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F9C2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM5B2-0003iG-8y
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 02:26:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hM5AB-0003Kj-TT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hM5AA-0007We-75
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:25:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hM5A9-0007RA-Rk
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:25:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so746504wmi.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 23:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=70yUGOitSbX3Drm5NCoc8yqrzQOfX3tY5SDmtwPVPgw=;
	b=JJQIg3sLKxwQJERCaTxgYNtJ45XLhPv+h7BgkmuWEbfFS8iHvS3DmXOmbAnKadqjNg
	mwZYkLiwxsTWVaeGUVJoGkT+fwexAMYvJWXBLH+0gSWCHQgqXCAtCJtuo/vlOXB7JAiR
	+P+nmHC8nmtuF4hkwXpYRO2cq20TcXtIzfrDe5ftQak9cQUxhaENC1CM9/NI5trHl4js
	IiC3jkUSiYJw8e4FSE+wwjWwN2YnTf6cPu9YQIJrhnvkrrvP5MejWRH9hXXYc8M0GHLe
	DgpToBZQqyJYQEd/Ygy8ucUw4lPgl3hcUZv88OCh64u/2pznnOg2xFm4G85wh+RGsY1C
	7Hjw==
X-Gm-Message-State: APjAAAXWlaBIBG+l6HWsByFPmnXkHrKqZLLj9PUXay5bFAsYkWBDPvGK
	8t/y8DBVI2sbuql3Jgi70zSbyA==
X-Google-Smtp-Source: APXvYqzl0aOY6oJniJqoXkg7zVrYv4SO9zGwZVTLfSH5VcGgZBUallfylnjKrEkABGv2fZYbUg6SfA==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr923357wmc.131.1556778339649;
	Wed, 01 May 2019 23:25:39 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id i8sm11329110wrb.5.2019.05.01.23.25.38
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 23:25:39 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190501223819.8584-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <776e0e87-494a-1bd3-8074-09c6390d498c@redhat.com>
Date: Thu, 2 May 2019 08:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501223819.8584-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 2/2] configure: Use quotes around uses of
 $CPU_CFLAGS
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
Cc: alex.bennee@linaro.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502062538.b856MkxomcIRN7RUHQCgqvFikFA4CxlHKbOmK2Pe6fY@z>

On 5/2/19 12:38 AM, Richard Henderson wrote:
> About half of the values to which CPU_CFLAGS is set
> have multiple space separated arguments.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/configure b/configure
> index 234cb929ca..16bd4375d1 100755
> --- a/configure
> +++ b/configure
> @@ -1543,37 +1543,37 @@ case "$cpu" in
>             CPU_CFLAGS="-m64"
>             LDFLAGS="-m64 $LDFLAGS"
>             cross_cc_ppc64=$cc
> -           cross_cc_cflags_ppc64=$CPU_CFLAGS
> +           cross_cc_cflags_ppc64="$CPU_CFLAGS"
>             ;;
>      sparc)
>             CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc"
>             LDFLAGS="-m32 -mv8plus $LDFLAGS"
>             cross_cc_sparc=$cc
> -           cross_cc_cflags_sparc=$CPU_CFLAGS
> +           cross_cc_cflags_sparc="$CPU_CFLAGS"
>             ;;
>      sparc64)
>             CPU_CFLAGS="-m64 -mcpu=ultrasparc"
>             LDFLAGS="-m64 $LDFLAGS"
>             cross_cc_sparc64=$cc
> -           cross_cc_cflags_sparc64=$CPU_CFLAGS
> +           cross_cc_cflags_sparc64="$CPU_CFLAGS"
>             ;;
>      s390)
>             CPU_CFLAGS="-m31"
>             LDFLAGS="-m31 $LDFLAGS"
>             cross_cc_s390=$cc
> -           cross_cc_cflags_s390=$CPU_CFLAGS
> +           cross_cc_cflags_s390="$CPU_CFLAGS"
>             ;;
>      s390x)
>             CPU_CFLAGS="-m64"
>             LDFLAGS="-m64 $LDFLAGS"
>             cross_cc_s390x=$cc
> -           cross_cc_cflags_s390x=$CPU_CFLAGS
> +           cross_cc_cflags_s390x="$CPU_CFLAGS"
>             ;;
>      i386)
>             CPU_CFLAGS="-m32"
>             LDFLAGS="-m32 $LDFLAGS"
>             cross_cc_i386=$cc
> -           cross_cc_cflags_i386=$CPU_CFLAGS
> +           cross_cc_cflags_i386="$CPU_CFLAGS"
>             ;;
>      x86_64)
>             # ??? Only extremely old AMD cpus do not have cmpxchg16b.
> @@ -1582,13 +1582,13 @@ case "$cpu" in
>             CPU_CFLAGS="-m64 -mcx16"
>             LDFLAGS="-m64 $LDFLAGS"
>             cross_cc_x86_64=$cc
> -           cross_cc_cflags_x86_64=$CPU_CFLAGS
> +           cross_cc_cflags_x86_64="$CPU_CFLAGS"
>             ;;
>      x32)
>             CPU_CFLAGS="-mx32"
>             LDFLAGS="-mx32 $LDFLAGS"
>             cross_cc_i386=$cc
> -           cross_cc_cflags_i386=$CPU_CFLAGS
> +           cross_cc_cflags_i386="$CPU_CFLAGS"
>             ;;
>      # No special flags required for other host CPUs
>  esac
> 

