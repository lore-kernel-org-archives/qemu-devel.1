Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513D5C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A08D2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A08D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMVDO-0005Zy-7h
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 06:14:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMVCd-0005FO-Ig
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMVCc-0002Ty-Me
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:14:03 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMVCc-0002Rs-2e
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:14:02 -0400
Received: by mail-wr1-f46.google.com with SMTP id a9so7137784wrp.6
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 03:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1/z9WSN5XyxeogLJh5HwhsFPqKka9SHeCJF6z36Eqic=;
	b=Z6NrocE1cQwQVYhWCtbj95iSrlCVhV0M3NkDqj5hRdSPduMZHEGSEJvtH14pihBg5Z
	cPBBZurGkdyaZIg78dFfDU7ZtZVCHeNiP/gjZGgGzAhSAV8HvKO+1bHsAd18On9sSSkS
	Dw7UDTG2bnRyaYJvi+5rmfX7Of86Ust4IIPbDSmqkgM+FMQfr6i+bYXy4gJUnjArGIxi
	dfe4eqgxR9aN4Dn1SBI9lNYHdf4ob1Xn6QhAAK4oRaGGGgW/ZEc7dWnmmuND0hPpJwyJ
	RqeFskYiQOo44MKpr9ABgM1MEEUfhzOFpGRsRpqoWeStQJijS2oJ+krsAUg8TYE6ArfI
	skug==
X-Gm-Message-State: APjAAAVorK0C5m7KlwzPoIvckFvLZX5BOf9DvrnFsfGiNyyn1l+gJu2l
	n7bdzUp5ayVxAhAOCzyGphktzAFdUdk=
X-Google-Smtp-Source: APXvYqyRQcRQcseCxus7dic6Z3KpH7yfaN2IS166Jo7u6mwyidhy6dbgpX4TJCKaGEQFDvtPk+oCPQ==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr6185213wrw.315.1556878440457; 
	Fri, 03 May 2019 03:14:00 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id l21sm1623309wme.4.2019.05.03.03.13.59
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 03:13:59 -0700 (PDT)
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
References: <20190503002258.9799-1-driver1998@foxmail.com>
	<20190503003102.10042-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <853d213b-f3e7-350b-3714-bb0c98401414@redhat.com>
Date: Fri, 3 May 2019 12:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503003102.10042-1-driver1998@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.46
Subject: Re: [Qemu-devel] [PATCH v3 4/4] osdep: Fix mingw compilation
 regarding stdio formats
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503101358.GSzoukBh96gp-RmJNIkHTCsD2WLWqUux8Jh2-xjTW_g@z>

On 5/3/19 2:31 AM, Cao Jiaxi wrote:
> I encountered the following compilation error on mingw:
> 
> /mnt/d/qemu/include/qemu/osdep.h:97:9: error: '__USE_MINGW_ANSI_STDIO' macro redefined [-Werror,-Wmacro-redefined]
>  #define __USE_MINGW_ANSI_STDIO 1
>         ^
> /mnt/d/llvm-mingw/aarch64-w64-mingw32/include/_mingw.h:433:9: note: previous definition is here
>  #define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it should be 0 */
> 
> It turns out that __USE_MINGW_ANSI_STDIO must be set before any
> system headers are included, not just before stdio.h.
> 
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  include/qemu/osdep.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 303d315c5d..af2b91f0b8 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -85,17 +85,17 @@ extern int daemon(int, int);
>  #endif
>  #endif
>  
> +/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
> +#ifdef __MINGW32__
> +#define __USE_MINGW_ANSI_STDIO 1
> +#endif
> +
>  #include <stdarg.h>
>  #include <stddef.h>
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <sys/types.h>
>  #include <stdlib.h>
> -
> -/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
> -#ifdef __MINGW32__
> -#define __USE_MINGW_ANSI_STDIO 1
> -#endif
>  #include <stdio.h>
>  
>  #include <string.h>
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

