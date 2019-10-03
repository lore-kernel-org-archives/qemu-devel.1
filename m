Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC06C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D1A222C2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D1A222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFy8B-0002EB-IZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFy7J-0001Zr-8V
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFy7H-0004w5-DV
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:13:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFy7H-0004vW-4a
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:13:47 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DAEC369CA
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:13:46 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id c188so494214wmd.9
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 03:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Idv59k3ks8keb9H5Qtp1k/hVlx1fmHmEQ0grMs3eUc=;
 b=JJnU6+6kNVt3JgYCVDHGpW+WhY5j2xl9q+4PPwtBtTegbS7PSe/B01z3IExMFHsWuW
 fzHF+i4Iu8PRCZEma782IzKdGV4WU8yI9TKlLAy3+YDPglsWhQDSI7kAYvYypxLKXM7f
 6SCY4xVgqzqw8C+Ur12r6CAx4OzX80PzDwWR3RjRLM3Zh9waVJPMvsr3CdCjVpPJE9/B
 uPdlsLIDj6Ife8tw3aWc9TrjgTyKCEhWE17YRhSZ27IlLdZno+gNmExtVgUOhx5Y2nw+
 sVIsLOzKReTOTrPSe+6ndT5zGZr3O7N2zLqcdnhuzxdlY1n89Ta738uHxmxZa1cmlfjQ
 iBzQ==
X-Gm-Message-State: APjAAAXioca+OCJODYJnHsvOgR07baQwscRDj74FVMeMSYDDZCht1qJW
 W4kKNsZsSykYA/VakTQ+wCngMolqEkLb96xo+mUxAluSAndmp9GDKUqskH1gD2GfXuoRaxMGyvN
 QLTHoaXAcW2Bh6dQ=
X-Received: by 2002:adf:ee92:: with SMTP id b18mr6011752wro.217.1570097624713; 
 Thu, 03 Oct 2019 03:13:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLxPmYwdxrCRKJrL0xKedumnnmguZ9+3DJ8+sWuH8asImxJoHZoRDg1uAobGOT2iskrMi+zg==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr6011730wro.217.1570097624401; 
 Thu, 03 Oct 2019 03:13:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id h14sm1797764wro.44.2019.10.03.03.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 03:13:43 -0700 (PDT)
Subject: Re: [PATCH] test-bdrv-drain: fix iothread_join() hang
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191003100103.331-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ed42e887-42b2-249c-186a-8798bd19b662@redhat.com>
Date: Thu, 3 Oct 2019 12:13:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003100103.331-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/19 12:01, Stefan Hajnoczi wrote:
> tests/test-bdrv-drain can hang in tests/iothread.c:iothread_run():
> 
>   while (!atomic_read(&iothread->stopping)) {
>       aio_poll(iothread->ctx, true);
>   }
> 
> The iothread_join() function works as follows:
> 
>   void iothread_join(IOThread *iothread)
>   {
>       iothread->stopping = true;
>       aio_notify(iothread->ctx);
>       qemu_thread_join(&iothread->thread);
> 
> If iothread_run() checks iothread->stopping before the iothread_join()
> thread sets stopping to true, then aio_notify() may be optimized away
> and iothread_run() hangs forever in aio_poll().
> 
> The correct way to change iothread->stopping is from a BH that executes
> within iothread_run().  This ensures that iothread->stopping is checked
> after we set it to true.
> 
> This was already fixed for ./iothread.c (note this is a different source
> file!) by commit 2362a28ea11c145e1a13ae79342d76dc118a72a6 ("iothread:
> fix iothread_stop() race condition"), but not for tests/iothread.c.
> 
> Fixes: 0c330a734b51c177ab8488932ac3b0c4d63a718a
>        ("aio: introduce aio_co_schedule and aio_co_wake")
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/iothread.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/iothread.c b/tests/iothread.c
> index 777d9eea46..13c9fdcd8d 100644
> --- a/tests/iothread.c
> +++ b/tests/iothread.c
> @@ -55,10 +55,16 @@ static void *iothread_run(void *opaque)
>      return NULL;
>  }
>  
> -void iothread_join(IOThread *iothread)
> +static void iothread_stop_bh(void *opaque)
>  {
> +    IOThread *iothread = opaque;
> +
>      iothread->stopping = true;
> -    aio_notify(iothread->ctx);
> +}
> +
> +void iothread_join(IOThread *iothread)
> +{
> +    aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
>      qemu_thread_join(&iothread->thread);
>      qemu_cond_destroy(&iothread->init_done_cond);
>      qemu_mutex_destroy(&iothread->init_done_lock);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

Paolo

