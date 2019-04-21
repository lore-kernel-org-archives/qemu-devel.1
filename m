Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF5EC10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 10:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2BB20651
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 10:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2BB20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51514 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hI9yH-0008Ee-0C
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 06:45:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9xS-0007vB-2w
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9xR-00026B-4w
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:44:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hI9xQ-00025T-V2
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:44:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id f14so11903348wrj.5
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 03:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mjaYR4r2S3CsleAF2QHaJGLy2+KZxzv/hhAdVH+Jr5g=;
	b=ZcqKOYGMTJx86jRIAbTDRFxE6QxULI21IXB1zXRdMNE24Pqqv0w8IRvypGbeKAiMrU
	tICQQXD+JX6bLGQCPwa0c/a4vtoNFbbc+wg6hCygeibXM282W38AKoTzgzgHDeDqje1z
	6t5nyNqg8pGCEyIVihJFAgo0ZF7LKPazZjOF/cfWiBNL6cm27NTcB8QdoajB7RCk08dJ
	CsCVXOARNKsnOwbkdHJuMoR/AyFGhfKlJEBVo/wml3GA9IJ3NLXr1dYcE2ySXzIbvUhs
	tqUoeQpermfOQWz0xeH5dKs+NWf0kCrnENNY2HKmzGSL5qzH4n5a8+N0JtSX8ddAgyh4
	L/sw==
X-Gm-Message-State: APjAAAVv1SoUEF2kAAUc3T4aBHKwJkIG71FH/JRwT470M9ybnlz+5UW5
	FZl23DnWlhOnse+tOJgQba+qZqSaDkm/TA==
X-Google-Smtp-Source: APXvYqzaWnCY+agBeXYO578Rr69eZOFOK/5GAqislRbModSnciRVt8qIzlkvh3Xiu4v7mPJDwESeew==
X-Received: by 2002:a5d:654b:: with SMTP id z11mr7349345wrv.173.1555843463392; 
	Sun, 21 Apr 2019 03:44:23 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	u6sm15336148wrg.72.2019.04.21.03.44.22
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sun, 21 Apr 2019 03:44:22 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, jslaby@suse.cz, pbonzini@redhat.com
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-3-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <51d2ae28-267a-2710-8401-bad769e2d2c0@redhat.com>
Date: Sun, 21 Apr 2019 12:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420161446.2274-3-liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 2/3] edu: mmio: allow mmio read dispatch
 accept 8 bytes
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421104421.iPOTydobLxfCox3MtWHKSVaoLbKjsWYj3SDo0V95hEU@z>

Hi Li,

On 4/20/19 6:14 PM, Li Qiang wrote:
> The edu spec said when address >= 0x80, the MMIO area can

"says"

> be accessed by 8 bytes.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/misc/edu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 65fc32b928..4018dddcb8 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -189,6 +189,10 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr addr, unsigned size)

Completing the diff ...:

       if (size != 4) {

>          return val;
>      }
>  
> +    if (addr >= 0x80 && size != 4 && size != 8) {

... to show this code is unreachable for size == 8.

> +        return val;
> +    }
> +
>      switch (addr) {
>      case 0x00:
>          val = 0x010000edu;
> 

I think the change you wanted is:

-- >8 --
@@ -185,7 +185,11 @@ static uint64_t edu_mmio_read(void *opaque, hwaddr
addr, unsigned size)
     EduState *edu = opaque;
     uint64_t val = ~0ULL;

-    if (size != 4) {
+    if (addr < 0x80 && size != 4) {
+        return val;
+    }
+
+    if (addr >= 0x80 && size != 4 && size != 8) {
         return val;
     }

---

Another cleaner way to solve this is use 2 MemoryRegionOps, one for the
first 0x80 addresses and another for the rest.

Regards,

Phil.

