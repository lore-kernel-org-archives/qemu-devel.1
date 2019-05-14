Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09AEC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B684F20843
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B684F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46333 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVy5-0007OV-2L
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:51:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQVwm-00065q-Fy
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQVwl-0007ex-I5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:50:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQVwl-0007eY-CX
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:50:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so1028668wrr.13
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 04:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/ygqT7KrCoK9YbHKlqHPpcHm8RguaqiHpt4jM8ES73c=;
	b=a9VbZfBSWRkWH355bRVMBsLkqbbqbF5Rdm2hTyZ5+smk4nfbUipwOL7x1eRzC8Mfeb
	FKiXg74yI31PV8OfGFOpLG4k30de4rqFkdP6gU+FEYc2wPgfUqnjhdfgoYzgZiPUfQoQ
	GLQC/0tsGmKbkF+MTW3/pXEAS54hTRvBvSqE6yDxDgv+yY+zQNNilTh+eAa7/qBHGw+d
	w5Xn2D+Psx0rKcsZCNquDDXLoBLCiN1lzqHxwMUgjTUQvBQX972+3JB95VSpKk0XzY9X
	5FtHGsoh1BY9W28sbdQlUYiGeHDL8g0XaXE2gvRXAkdrm64Gt5C0J8k/R43VuA2618pE
	dm3Q==
X-Gm-Message-State: APjAAAVFvBSUrhNypqSPnDM9FxZTIOxtaagQGAjlpTKeaQ+NN42f4o0e
	+PSGyEiefkCUba0b2VXWGAQpjQ==
X-Google-Smtp-Source: APXvYqyS0Zzm9wOEsEMdnN6PnY9+8ir5islZw+k2isbpkcmzNJNxdfTYPeHmQ0qCAywn1Zf1vDCK3g==
X-Received: by 2002:adf:f487:: with SMTP id l7mr22103494wro.127.1557834614263; 
	Tue, 14 May 2019 04:50:14 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id z74sm3937572wmc.2.2019.05.14.04.50.13
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 04:50:13 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
References: <20190514104126.6294-1-marcandre.lureau@redhat.com>
	<20190514104126.6294-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d495e630-df57-85f6-d38a-5d844af52202@redhat.com>
Date: Tue, 14 May 2019 13:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514104126.6294-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v4 1/3] libvhost-user: fix cast warnings on
 32 bits
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

On 5/14/19 12:41 PM, Marc-André Lureau wrote:
> Fixes warnings:
>  warning: cast to pointer from integer of different size
>  [-Wint-to-pointer-cast]
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 74d42177c5..40443a3daa 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -621,7 +621,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
>           * data that's already arrived in the shared process.
>           * TODO: How to do hugepage
>           */
> -        ret = madvise((void *)dev_region->mmap_addr,
> +        ret = madvise((void *)(uintptr_t)dev_region->mmap_addr,
>                        dev_region->size + dev_region->mmap_offset,
>                        MADV_DONTNEED);
>          if (ret) {
> @@ -633,7 +633,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
>           * in neighbouring pages.
>           * TODO: Turn this backon later.
>           */
> -        ret = madvise((void *)dev_region->mmap_addr,
> +        ret = madvise((void *)(uintptr_t)dev_region->mmap_addr,
>                        dev_region->size + dev_region->mmap_offset,
>                        MADV_NOHUGEPAGE);
>          if (ret) {
> @@ -666,7 +666,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
>          DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
>                  __func__, i, reg_struct.range.start, reg_struct.range.len);
>          /* Now it's registered we can let the client at it */
> -        if (mprotect((void *)dev_region->mmap_addr,
> +        if (mprotect((void *)(uintptr_t)dev_region->mmap_addr,
>                       dev_region->size + dev_region->mmap_offset,
>                       PROT_READ | PROT_WRITE)) {
>              vu_panic(dev, "failed to mprotect region %d for postcopy (%s)",
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

