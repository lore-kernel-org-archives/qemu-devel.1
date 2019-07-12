Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A79AC742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E082084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E082084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlsVk-0008NW-87
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 06:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54646)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlsVY-0007yu-SE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlsVX-0002BN-H4
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:10:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlsVX-00029U-AH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:10:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so9378813wrs.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 03:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=it2XLFX1+uAwag6a6GECLdDCE9gHPXdebVm/KwytyEw=;
 b=PlKB4evTSDuIEfhvObqI1ScZZDsvnC4RDYL9R+FpxfwHXed4rrhDEasITTow94z2sl
 iFBMjwy5vdxdrKNsttzYXNOBF06Ra0RvdJKIp0ZN7LMzOZoLrHt6lYqF4SF7vwffbnD4
 GMe+1t3PeQXk3HX7qtxWE0lLCnqlUE2Y6y5dw7YTn5DyTo31TpOFgk0oFIfENBvqnDlV
 5SLOl6LpqwtSm00OsgfJwEiIAMkGwtIuasmVDCDxPptt94qGoNEoAQcgmffntSDOzKVA
 aoG0kWONq04mDaduHwEPuycXNXcffF+NKv280mo267524Pv+J7AKr3ZrYknSHho+Qv99
 7niA==
X-Gm-Message-State: APjAAAWYxKxXykO3fC31G5b082T+Pke3meScBqXmWdTORA0HInUxpFbt
 zWdtOdGPei46x9jB8jdoVuhhUg==
X-Google-Smtp-Source: APXvYqzfsiViU1kYuP1+hut6DLlR4je5iJnLMJoc/YKp/HZMHHyBhhDkWlEBD3KEp3gn8T5CAYKgyg==
X-Received: by 2002:adf:f38a:: with SMTP id m10mr10635320wro.268.1562926226110; 
 Fri, 12 Jul 2019 03:10:26 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id e3sm8062889wrt.93.2019.07.12.03.10.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 03:10:25 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
References: <20190712081910.29085-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3f2411a5-1d60-7543-87c8-96672fcb7488@redhat.com>
Date: Fri, 12 Jul 2019 12:10:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712081910.29085-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Add missing GCC_FMT_ATTR
 and fix three format errors
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/19 10:19 AM, Stefan Weil wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  contrib/libvhost-user/libvhost-user.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 4b36e35a82..59b3202979 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -142,7 +142,7 @@ vu_request_to_string(unsigned int req)
>      }
>  }
>  
> -static void
> +static void GCC_FMT_ATTR(2, 3)
>  vu_panic(VuDev *dev, const char *msg, ...)
>  {
>      char *buf = NULL;
> @@ -661,7 +661,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
>  
>          if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
>              vu_panic(dev, "%s: Failed to userfault region %d "
> -                          "@%p + size:%zx offset: %zx: (ufd=%d)%s\n",
> +                          "@%" PRIx64 " + size:%zx offset: %zx: (ufd=%d)%s\n",
>                       __func__, i,
>                       dev_region->mmap_addr,
>                       dev_region->size, dev_region->mmap_offset,
> @@ -1753,7 +1753,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
>  
>      /* If their number is silly, that's a fatal mistake. */
>      if (*head >= vq->vring.num) {
> -        vu_panic(dev, "Guest says index %u is available", head);
> +        vu_panic(dev, "Guest says index %u is available", idx);
>          return false;
>      }
>  
> @@ -1812,7 +1812,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
>      smp_wmb();
>  
>      if (*next >= max) {
> -        vu_panic(dev, "Desc next is %u", next);
> +        vu_panic(dev, "Desc next is %u", *next);
>          return VIRTQUEUE_READ_DESC_ERROR;
>      }
>  
> 

This fixes:

      CC      contrib/libvhost-user/libvhost-user.o
    contrib/libvhost-user/libvhost-user.c: In function
'vu_set_mem_table_exec_postcopy':
    contrib/libvhost-user/libvhost-user.c:663:27: error: format '%p'
expects argument of type 'void *', but argument 5 has type 'uint64_t
{aka long long unsigned int}' [-Werror=format=]
                 vu_panic(dev, "%s: Failed to userfault region %d "
                               ^
    contrib/libvhost-user/libvhost-user.c: In function 'virtqueue_get_head':
    contrib/libvhost-user/libvhost-user.c:1756:42: error: format '%u'
expects argument of type 'unsigned int', but argument 3 has type
'unsigned int *' [-Werror=format=]
             vu_panic(dev, "Guest says index %u is available", head);
                                              ^
    contrib/libvhost-user/libvhost-user.c: In function
'virtqueue_read_next_desc':
    contrib/libvhost-user/libvhost-user.c:1815:38: error: format '%u'
expects argument of type 'unsigned int', but argument 3 has type
'unsigned int *' [-Werror=format=]
             vu_panic(dev, "Desc next is %u", next);
                                          ^

However with your patch applied I still have:

    contrib/libvhost-user/libvhost-user.c: In function
'vu_set_mem_table_exec_postcopy':
    contrib/libvhost-user/libvhost-user.c:663:27: error: format '%zx'
expects argument of type 'size_t', but argument 6 has type 'uint64_t
{aka long long unsigned int}' [-Werror=format=]
                 vu_panic(dev, "%s: Failed to userfault region %d "
                               ^
    contrib/libvhost-user/libvhost-user.c:663:27: error: format '%zx'
expects argument of type 'size_t', but argument 7 has type 'uint64_t
{aka long long unsigned int}' [-Werror=format=]
    cc1: all warnings being treated as errors

Which is right:

typedef struct VuDevRegion {
    /* Guest Physical address. */
    uint64_t gpa;
    /* Memory region size. */
    uint64_t size;
    /* QEMU virtual address (userspace). */
    uint64_t qva;
    /* Starting offset in our mmaped space. */
    uint64_t mmap_offset;
    /* Start address of mmaped space. */
    uint64_t mmap_addr;
} VuDevRegion;

Build succeed applying this on top of your patch:

-- >8 --
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -661,7 +661,8 @@ vu_set_mem_table_exec_postcopy(VuDev *dev,
VhostUserMsg *vmsg)

         if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
             vu_panic(dev, "%s: Failed to userfault region %d "
-                          "@%" PRIx64 " + size:%zx offset: %zx:
(ufd=%d)%s\n",
+                          "@%" PRIx64 " + size:%" PRIx64 " offset: %"
PRIx64
+                          ": (ufd=%d)%s\n",
                      __func__, i,
                      dev_region->mmap_addr,
                      dev_region->size, dev_region->mmap_offset,
---

With this snippet amended:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.

