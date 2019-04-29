Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B977C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 11:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8662087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 11:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8662087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL4IU-0006oq-Ur
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 07:18:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL4HP-0006Im-Ec
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL4HO-0005Rn-Gj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:17:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL4HO-0005Pr-Av
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:17:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so15498015wrp.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 04:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EZ/ZPjDElQp3m4rft9gqMh4FXrIs9TtJim2N6VsVzXc=;
	b=p7GysH66k+ag3G7U6gXuft1kSsdIt9GTZk/YKrmTjKOpZT9xAewYHHdkaQDShjhREa
	WdftAwKqQwtvEDTfaF9KmGFPO82yptWsazkQiwsKLYJxcPyEbung/avZoZ1SfO9gaCvw
	1SqoVJuhRt4frVMOoSD0W0Ed6GMuSrugsvu9wRANF/bWucA7hDKZo+yrr/bjsavDy/8V
	+xNMkF84CfxRtoDJNmAz4zL8c7RIvSxML+MMQOR1+pl4YuYuWp7CUZoOo7Lb2rGi4xne
	U1y82RMaS4RIVyRAW5dFciE1mdGjeghk1eXyr+mKEqGm7xPB/P32A59KKWVt/vZtvmEL
	lrFA==
X-Gm-Message-State: APjAAAX22CZN0YySLkOjAfM1nonnSxn4/JP8fh7TPzPTwLUdldCifQsj
	KLygO0h13Y80bgGtDlxuudIXVzfSo3U=
X-Google-Smtp-Source: APXvYqzsvA5vREVnsZQBuiZfNqmCDCrnhy7Q0eDVTs+6jEYxjlH8vq3kmfbFZeqwa4D4il82ebshAg==
X-Received: by 2002:a5d:4fc1:: with SMTP id h1mr12538868wrw.303.1556536619628; 
	Mon, 29 Apr 2019 04:16:59 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	e10sm18926098wra.52.2019.04.29.04.16.58
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 04:16:58 -0700 (PDT)
To: "Longpeng(Mike)" <longpeng2@huawei.com>, kraxel@redhat.com
References: <1556523569-44480-1-git-send-email-longpeng2@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7e19e93d-9ad4-51a8-3c1e-ed4d1672a47f@redhat.com>
Date: Mon, 29 Apr 2019 13:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556523569-44480-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] usb/xchi: avoid trigger assertion if guest
 write wrong epid
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
Message-ID: <20190429111657.Lv7uJSNd4OJD77Yp6exalvnNX4CEclZlbprdgDtHwCQ@z>

Hi Mike,

On 4/29/19 9:39 AM, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> we found the following core in our environment:
> 0  0x00007fc6b06c2237 in raise ()
> 1  0x00007fc6b06c3928 in abort ()
> 2  0x00007fc6b06bb056 in __assert_fail_base ()
> 3  0x00007fc6b06bb102 in __assert_fail ()
> 4  0x0000000000702e36 in xhci_kick_ep (...)

  5 xhci_doorbell_write?

> 6  0x000000000047767f in access_with_adjusted_size (...)
> 7  0x000000000047944d in memory_region_dispatch_write (...)
> 8  0x000000000042df17 in address_space_write_continue (...)
> 10 0x000000000043084d in address_space_rw (...)
> 11 0x000000000047451b in kvm_cpu_exec (cpu=cpu@entry=0x1ab11b0)
> 12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=0x1ab11b0)
> 13 0x0000000000870631 in qemu_thread_start (args=args@entry=0x1acfb50)
> 14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=<optimized out>)
> 15 0x00007fc6b0a60dd5 in start_thread ()
> 16 0x00007fc6b078a59d in clone ()
> (gdb) bt
> (gdb) f 5

This is the frame you removed...

> (gdb) p /x tmp
> $9 = 0x62481a00 <-- last byte 0x00 is @epid

I don't see 'tmp' in xhci_doorbell_write().

Can you use trace events?

There we have trace_usb_xhci_doorbell_write().

> 
> xhci_doorbell_write() already check the upper bound of @slotid an @epid,
> it also need to check the lower bound.
> 
> Cc: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
>  hw/usb/hcd-xhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index ec28bee..b4e6bfc 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3135,9 +3135,9 @@ static void xhci_doorbell_write(void *ptr, hwaddr reg,

Expanding the diff:

       if (reg == 0) {
           if (val == 0) {
               xhci_process_commands(xhci);
           } else {
               DPRINTF("xhci: bad doorbell 0 write: 0x%x\n",
                       (uint32_t)val);
           }
>      } else {
>          epid = val & 0xff;
>          streamid = (val >> 16) & 0xffff;
> -        if (reg > xhci->numslots) {
> +        if (reg == 0 || reg > xhci->numslots) {

So 'reg' can not be zero here...

>              DPRINTF("xhci: bad doorbell %d\n", (int)reg);
> -        } else if (epid > 31) {
> +        } else if (epid == 0 || epid > 31) {

Here neither.

>              DPRINTF("xhci: bad doorbell %d write: 0x%x\n",
>                      (int)reg, (uint32_t)val);
>          } else {
> 

Isn't it the other line that triggered the assertion?

static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
                         unsigned int epid, unsigned int streamid)
{
    XHCIEPContext *epctx;

    assert(slotid >= 1 && slotid <= xhci->numslots); // <===
    assert(epid >= 1 && epid <= 31);

Regards,

Phil.

