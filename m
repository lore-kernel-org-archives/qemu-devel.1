Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C7C76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D301E2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D301E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsDZ8-0002bR-Vb
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 17:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsDYb-00025R-EI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsDYa-00051h-9g
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:51:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsDYa-00051J-3C
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:51:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so13545781wrr.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 14:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xiPqrjocdpybq1vtn4jL9+UPQJ5XET6FIU2PWFLo44g=;
 b=cfIA4eQ+R3x4YgvkxCrKEf/fJKkLrd3q++CKw2pdXsKEnPQZoiUNKrrMWn07goFbW1
 Tm6lOr9aA3s/yiNIBJ1K7tHUyOhJtYCGfww5NTvzVWpazOVnFIwkda+ZgI2BclwygNwA
 +n2mVoXyvA92CRxZOQlYJjqYOxI/3idiPb3sKg5gDgox77Kf9GsyBxr3SQ+TsuL7tjID
 w6HVtMEEk0LRUisTblOJoeFVCWeWwF9CHPiSzy0HGYGKr/OyGrqvIq2lFpjmwAHn10lP
 6srQTcUA8gyvq7EBYzEUeKpf97ihbD7BbzEsQoX6EdpRCsUcBrq9NnFA47w76n+Ln5Xq
 7uQQ==
X-Gm-Message-State: APjAAAXPSLsud+tk/sVXQv7S4OhtKB7OEIPOO+KBvYxGPEaFXX/VAzmI
 /UoGE3/9gUQt3D2YjB1xnZqHYQ==
X-Google-Smtp-Source: APXvYqxk+bnDyoehjLbyMxPxf1NToqF8de78nDdPtVOQEVrjXWr/XrhUSexQaz6PYtMJ9lB2u3L0lA==
X-Received: by 2002:adf:fc8d:: with SMTP id g13mr89043998wrr.234.1564437107055; 
 Mon, 29 Jul 2019 14:51:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04?
 ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id q193sm47870309wme.8.2019.07.29.14.51.46
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 14:51:46 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190729213416.1972-1-pbonzini@redhat.com>
 <e8d53076-f5d0-ed13-110b-0cce911a07ec@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8993ddbe-0a2f-feb0-9d1c-cbb5ea83bbc5@redhat.com>
Date: Mon, 29 Jul 2019 23:51:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e8d53076-f5d0-ed13-110b-0cce911a07ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] dma-helpers: ensure AIO callback is
 invoked after cancellation
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
Cc: Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/19 23:46, John Snow wrote:
>> @@ -111,15 +112,12 @@ static void dma_complete(DMAAIOCB *dbs, int ret)
>>  {
>>      trace_dma_complete(dbs, ret, dbs->common.cb);
>>  
>> +    assert(!dbs->acb && !dbs->bh);
>>      dma_blk_unmap(dbs);
>>      if (dbs->common.cb) {
>>          dbs->common.cb(dbs->common.opaque, ret);
>>      }
>>      qemu_iovec_destroy(&dbs->iov);
>> -    if (dbs->bh) {
>> -        qemu_bh_delete(dbs->bh);
>> -        dbs->bh = NULL;
>> -    }
> 
> Now presumably handled by dma_aio_cancel,

No, it simply could never happen.  dma_complete is called here in dma_blk_cb:

    dbs->acb = NULL;
    dbs->offset += dbs->iov.size;

    if (dbs->sg_cur_index == dbs->sg->nsg || ret < 0) {
        dma_complete(dbs, ret);
        return;
    }

and the only way to reach that when dbs->bh becomes non-NULL is through 
reschedule_dma, which clears dbs->bh before invoking dma_blk_cb.

>>      if (dbs->acb) {
>> +        /* This will invoke dma_blk_cb.  */
> 
> uhh, does it?

Yes:

/* Async version of aio cancel. The caller is not blocked if the acb implements
 * cancel_async, otherwise we do nothing and let the request normally complete.
 * In either case the completion callback must be called. */

> this is maybe where I got lost reading this code.
> Isn't dbs->acb going to be what was returned from e.g.
> dma_blk_read_io_func, which ultimately uses blk_aio_em_aiocb_info, that
> has no cancel callback?

Right therefore the I/O will complete and the callback will be invoked.

> Well, here at least I am now on terra-firma that we're going to call the
> original callback with ECANCELED, which is a step towards code that
> isn't surprising my sensibilities.

Good. :)

Paolo

