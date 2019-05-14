Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C3EC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4873C208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4873C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47227 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWGX-00032N-AL
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:10:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQWEk-0001Zc-IC
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQW05-00029o-Lj
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:53:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQW05-000290-Ef
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:53:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id d12so18837755wrm.8
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 04:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=n8AvSRGkG+hrKYZK1C1jvfZTV7/jDz8xnIBV8VahpDY=;
	b=qGUAYMWgCVLuz5y2EFEb1cFBg3epnWazLbpkW/IOXAaBIDXnVoNm4GMejsyDS3AMLi
	19Ln+hkSFvtWi11fY025N4mpTTnM60Vt4gY3N7o4eF/XHIx/IrhZnDuzSvYp3Y9OA/T7
	Vd1Gox43xp9tnQelKyULIyCDEVZTEQOfoPxuiGZI028PH5rPUpx1SeN3/v6tg6cU7QNQ
	liI1VduOrDF9/MDhHBa0Xj6ULbH1ji359dHxmol54E5PjFOxblhMVhthQFnuFN/qNkpr
	u8r7nbZCyXQkrxCkW445REcmBv7vM7pLv51v/lDTW2xq7fgzGVMxbzdASpdJiwuxPPj6
	MHXg==
X-Gm-Message-State: APjAAAWB0t5PeCev1e9fAJQQi7MJdkJvJ+RZ8q0kucWszhdVCk/M2Bfz
	YBinnQMhmvu69zlxu6/n6F0zSg==
X-Google-Smtp-Source: APXvYqyRTLvnFehmsyvdaNROPgfyOcUQ+K6eSy0hDTCmafqokTsvcSMuGK/CdHOoNFdAT72JU0dGeA==
X-Received: by 2002:adf:fdc1:: with SMTP id i1mr2345940wrs.103.1557834820097; 
	Tue, 14 May 2019 04:53:40 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	b18sm10909492wrx.75.2019.05.14.04.53.39
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 04:53:39 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
References: <20190514104126.6294-1-marcandre.lureau@redhat.com>
	<20190514104126.6294-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <36d35842-d872-427b-accf-2d206a6c6b61@redhat.com>
Date: Tue, 14 May 2019 13:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514104126.6294-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v4 2/3] libvhost-user: fix -Werror=format=
 on ppc64
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc-André,

On 5/14/19 12:41 PM, Marc-André Lureau wrote:
> That should fix the following warning:
> 
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
> ‘vu_set_mem_table_exec_postcopy’:
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
> format ‘%llx’ expects argument of type ‘long long unsigned int’, but
> argument 5 has type ‘__u64’ [-Werror=format=]
>          DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
>          ^
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
> format ‘%llx’ expects argument of type ‘long long unsigned int’, but
> argument 6 has type ‘__u64’ [-Werror=format=]
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 40443a3daa..ab85166b15 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -663,8 +663,10 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
>                       __func__, i);
>              return false;
>          }
> -        DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
> -                __func__, i, reg_struct.range.start, reg_struct.range.len);
> +        DPRINT("%s: region %d: Registered userfault for %"
> +               PRIu64 " + %" PRIu64 "\n", __func__, i,

I guess you want PRIx64 in both places here.

I'd put the '%' on the next line:

           DPRINT("%s: region %d: Registered userfault for "
                  "%" PRIx64 " + %" PRIx64 "\n", __func__, i,

Using PRIx64:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +               (uint64_t)reg_struct.range.start,
> +               (uint64_t)reg_struct.range.len);
>          /* Now it's registered we can let the client at it */
>          if (mprotect((void *)(uintptr_t)dev_region->mmap_addr,
>                       dev_region->size + dev_region->mmap_offset,
> 

