Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A70C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DE720674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSo5BAvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DE720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFIm-00048G-Dc
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBFGB-0000ny-Ds
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBFG9-0007zF-08
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:03:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBFG7-0007yi-4x
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583748217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUUCXen90C2Znpu0RoandKXNGqev0sXvwOrDBiVuIXw=;
 b=JSo5BAvIzOWoIhxbR9AXpoxgjNV/kibCY/Pzl+4Hl5c/a5Y2eRqm/8G7ze9WlM8Koqyxq2
 GnVdOwIy8jm0RBBUBLiJs+CraoA8SC4u3LPCtgFe6WGmD9aVJuRjGw8XJwd9UgXB3kUnVk
 TecmxZTXWLjQC/S0blIaFC6/00H9ifQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-0iGmHh0ENdGtDfv9Mh79NQ-1; Mon, 09 Mar 2020 06:03:36 -0400
X-MC-Unique: 0iGmHh0ENdGtDfv9Mh79NQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 821728018A5;
 Mon,  9 Mar 2020 10:03:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B73260BFB;
 Mon,  9 Mar 2020 10:03:32 +0000 (UTC)
Date: Mon, 9 Mar 2020 11:03:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] mem-prealloc: initialize cond and mutex
Message-ID: <20200309110331.3ef650a9@redhat.com>
In-Reply-To: <20200306085014.120669-1-borntraeger@de.ibm.com>
References: <20200306085014.120669-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 bauerchen <bauerchen@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  6 Mar 2020 03:50:14 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Guests with mem-prealloc do fail with
> qemu-system-s390x: /home/cborntra/REPOS/qemu/util/qemu-thread-posix.c:76: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
> qemu-system-s390x: /home/cborntra/REPOS/qemu/util/qemu-thread-posix.c:161: qemu_cond_broadcast: Assertion `cond->initialized' failed.
> 
> Let us initialize cond and mutex.
> 
> Cc: bauerchen <bauerchen@tencent.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: 037fb5eb3941 ("mem-prealloc: optimize large guest startup")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  util/oslib-posix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 897e8f3ba6..52650183d3 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -470,6 +470,8 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
>      char *addr = area;
>      int i = 0;
>  
> +    qemu_cond_init(&page_cond);
> +    qemu_mutex_init(&page_mutex);

Is it possible for touch_all_pages to be called several times?
If it's then it probably needs a guard against that to make
sure it won't explode, something like:

static bool page_mutex_inited;

if(page_mutex_inited)
  page_mutex_inited = true
  qemu_mutex_init(&page_mutex) 
  ...

>      memset_thread_failed = false;
>      threads_created_flag = false;
>      memset_num_threads = get_memset_num_threads(smp_cpus);


