Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B824C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDFC20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDFC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLNWa-0001B9-9S
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 03:50:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLNQz-0005ni-Od
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLNQw-0002Ag-Oj
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:44:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLNQt-00025a-A7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:44:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so19759899wrt.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 00:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=X9C5r2Cb2NdxOC/IU7nlWZnzuAvqHThmcaXNN/nQSBs=;
	b=Y/2qkTvQwuwnU/onxuSJfN8kaudriTH7bQ9Mg5tOYBZNeKIXjYc/4FQRygKp7QXcSJ
	qQnaiTxvBaj7NyHyrHMQxmcOs3HF9hopkwFWwPN9VUl0Q4qsMc1j43M1whqHNakEAHoU
	1Tr0x0EKJoH+K7sO5ftuLFJpgkscXI7kKlT95u8yV7mRqUAvFVGOWGij+olPfMFG58ME
	7PaoRyYm+PFXKLkB0Vp4i9tW7FZO7CcHHd4G9vMDksiQwHno1LJLbcqf7ineXTSt4JvP
	mcXCzIl/NKfKqYBTzDFTjWvFRtrnted90GgPJY1wpidRTCWkyTyzBwPrO9SfjegyUTVj
	8Ang==
X-Gm-Message-State: APjAAAWw+jR62Gf1ewkYebac9WS+ssA7ODT5ySIDyj/VisgcRUCRAfBd
	UV72NQdh5yW5LEdP2vVS2lfsJi1rldE=
X-Google-Smtp-Source: APXvYqxUy3eC7Meake3mWkTijWrc/kd2t0Pq5oewQRHB2A2I+U7L5RpJ+R4DHN9uVhFFVUY2ERqZHA==
X-Received: by 2002:a5d:5447:: with SMTP id w7mr3042494wrv.325.1556610240224; 
	Tue, 30 Apr 2019 00:44:00 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	d16sm28334971wra.54.2019.04.30.00.43.59
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 00:43:59 -0700 (PDT)
To: "Longpeng(Mike)" <longpeng2@huawei.com>, kraxel@redhat.com
References: <1556605301-44112-1-git-send-email-longpeng2@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2faba88e-19a3-2674-afa8-f9cfe8241da9@redhat.com>
Date: Tue, 30 Apr 2019 09:43:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556605301-44112-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2] usb/xchi: avoid trigger assertion if
 guest write wrong epid
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
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430074358.XLxeVfnhxK9gEZjFrZDTxjJ4FmcjWJO2EOSJssiqBw0@z>

On 4/30/19 8:21 AM, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> we found the following core in our environment:
> 0  0x00007fc6b06c2237 in raise ()
> 1  0x00007fc6b06c3928 in abort ()
> 2  0x00007fc6b06bb056 in __assert_fail_base ()
> 3  0x00007fc6b06bb102 in __assert_fail ()
> 4  0x0000000000702e36 in xhci_kick_ep (...)
> 5  0x000000000047897a in memory_region_write_accessor (...)
> 6  0x000000000047767f in access_with_adjusted_size (...)
> 7  0x000000000047944d in memory_region_dispatch_write (...)
> (mr=mr@entry=0x7fc6a0138df0, addr=addr@entry=156, data=1648892416,
> size=size@entry=4, attrs=attrs@entry=...)
> 8  0x000000000042df17 in address_space_write_continue (...)
> 10 0x000000000043084d in address_space_rw (...)
> 11 0x000000000047451b in kvm_cpu_exec (cpu=cpu@entry=0x1ab11b0)
> 12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=0x1ab11b0)
> 13 0x0000000000870631 in qemu_thread_start (args=args@entry=0x1acfb50)
> 14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=<optimized out>)
> 15 0x00007fc6b0a60dd5 in start_thread ()
> 16 0x00007fc6b078a59d in clone ()
> 
> (gdb) f 5
> 5  0x000000000047897a in memory_region_write_accessor (...)
> 529	    mr->ops->write(mr->opaque, addr, tmp, size);
> (gdb) p /x tmp
> $9 = 0x62481a00 <-- last byte 0x00 is @epid
> 
> xhci_doorbell_write() already check the upper bound of @slotid an @epid,
> it also need to check the lower bound.
> 
> Cc: Gonglei <arei.gonglei@huawei.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Longpeng <longpeng2@huawei.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v1 -> v2:
>   1) update the description, include the full backtrace
>   2) remove unnecessary check: 'reg == 0'
> 
> ---
>  hw/usb/hcd-xhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index ec28bee..d8472b4 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3137,7 +3137,7 @@ static void xhci_doorbell_write(void *ptr, hwaddr reg,
>          streamid = (val >> 16) & 0xffff;
>          if (reg > xhci->numslots) {
>              DPRINTF("xhci: bad doorbell %d\n", (int)reg);
> -        } else if (epid > 31) {
> +        } else if (epid == 0 || epid > 31) {
>              DPRINTF("xhci: bad doorbell %d write: 0x%x\n",
>                      (int)reg, (uint32_t)val);
>          } else {
> 

