Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE7C742BA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290692080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290692080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvMp-0008C6-JP
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49808)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlvMg-0007nu-0Q
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlvMf-00053j-1P
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:13:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlvMe-0004xq-RQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:13:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so8878054wme.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sZ6jo2otzPVhD5q//dUPZO4PoowChvLG0uciIQR8r9E=;
 b=cGSK499VrrIZ8xaQ1GAAwA4CdE2oHx9Sqm/Z1ImFjJgcUj/aRxPPifD3DSLrdPMIFZ
 XWFYZErUjvVAfm5ftWaDq+P2k1R/+s+IPpFKFiGsm08syUOuunwqqkE22bZ4DPakyFji
 oB7+9eAnOsA1VrUXdfEoQq+x3dxwVqCTcqGTN8RwwAU+j+HB3p3pQZFEI7oOTxM82Nh+
 6e0nak7XjrsliTSBI7lz2Nre7exIAzqg6nFDYrVUXClYe4zLt6nrCFXaiqulthgjtuHk
 Ww+C/qLniIL8YVeIqoixWI1sloM0eRDrs9JuR9z1EQlbU2xavlhY3rHIr2xS40C+P3Ov
 D62w==
X-Gm-Message-State: APjAAAUsrFTa+pRDwJLi49PzKkhM1PVnJ1QH6Nzgwd9YX1/XhmMmUemY
 YH9Q3AZVGxflAHvG5I23CyuVZw==
X-Google-Smtp-Source: APXvYqxe2mOlBX/2WqN7rFYOg2A7uRrfGZzLiAGtZWNWFTiBKOZGsrMZaca7EJKUxRiXzFhuor3eUA==
X-Received: by 2002:a1c:18a:: with SMTP id 132mr9928476wmb.15.1562937207136;
 Fri, 12 Jul 2019 06:13:27 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id c11sm12789916wrq.45.2019.07.12.06.13.26
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 06:13:26 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
References: <20190712115024.2659-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e747b0ae-1917-5b2c-9cc1-4e54476f38a3@redhat.com>
Date: Fri, 12 Jul 2019 15:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712115024.2659-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2] libvhost-user: Add missing GCC_FMT_ATTR
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

On 7/12/19 1:50 PM, Stefan Weil wrote:
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> v2:
> - Show different value in "Guest says [...]" (suggested by Marc-André Lureau)
> - Fix more format errors for 32 bit builds (reported by Philippe Mathieu-Daudé)
> 
> Philippe, I did not get the additional errors on x86_64.

Works for me! I was testing on armhf host.

Thanks for the quick v2,

Phil.

> Regards
> Stefan
> 
> 
>  contrib/libvhost-user/libvhost-user.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 4b36e35a82..3b5520a77f 100644
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
> @@ -661,7 +661,8 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
>  
>          if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
>              vu_panic(dev, "%s: Failed to userfault region %d "
> -                          "@%p + size:%zx offset: %zx: (ufd=%d)%s\n",
> +                          "@%" PRIx64 " + size:%" PRIx64
> +                          " offset: %" PRIx64 ": (ufd=%d)%s\n",
>                       __func__, i,
>                       dev_region->mmap_addr,
>                       dev_region->size, dev_region->mmap_offset,
> @@ -1753,7 +1754,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
>  
>      /* If their number is silly, that's a fatal mistake. */
>      if (*head >= vq->vring.num) {
> -        vu_panic(dev, "Guest says index %u is available", head);
> +        vu_panic(dev, "Guest says index %u is available", *head);
>          return false;
>      }
>  
> @@ -1812,7 +1813,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
>      smp_wmb();
>  
>      if (*next >= max) {
> -        vu_panic(dev, "Desc next is %u", next);
> +        vu_panic(dev, "Desc next is %u", *next);
>          return VIRTQUEUE_READ_DESC_ERROR;
>      }
>  
> 

