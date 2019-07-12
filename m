Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A4CC742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B237204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B237204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzfK-00022c-MT
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlzf9-0001e7-0H
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlzf7-0000BT-Mo
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:48:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlzf7-0000AH-Eb
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:48:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so10777771wru.10
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nXk2mUU/x5GlfSZ73WsyZgaEyDeZ11NKBYfrMLSQzIY=;
 b=ZgTOWLXlObDsL9lLcgELwaX598cbFaqXg2MY1KPEZGOfoUC2ajFhpOLoCLe8C5oTwY
 f/WaojESMfbi42ZQ5MiRhE/JeEFBe8OdAs+VIe402t+XIMrXP9ptcfj9wtXEijrPxQEX
 sy3bnC/1edlKKcKzmhjK20+si1zA78uqh1ctWHAK/inm5AajEwkkSc2YJEgmbEG8wuqG
 SbFzM02ABvIGY5wveIRD6UB6rXgJjRXoRT8WWtmdoFDDJduslSeszqsJ4XaE4GkLMH0s
 4iQpqq0rbPFygIsIJ2NOtHuWiyYtuVUieQGL1GmWtn0zXcuJgLUGMWlb4GffIoCCGcVm
 7pjg==
X-Gm-Message-State: APjAAAUvXhknFlAf0qenyRjF3+SbuaTOTt5hnf8r14R0jJ3b5Th5NQL1
 l0fWqOu99s4wNbwLZVyDkpdfGw==
X-Google-Smtp-Source: APXvYqxU/J9zUwYVdlMpoFpxp3UiVqPUosXVI8ACbufjUu/DCwV9SXcg5gWW1aYuSKBJ5+n/pZokSQ==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr13566458wrv.30.1562953728072; 
 Fri, 12 Jul 2019 10:48:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id f70sm9747008wme.22.2019.07.12.10.48.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:48:47 -0700 (PDT)
To: Wang King <king.wang@huawei.com>
References: <20190712065241.11784-1-king.wang@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bfa98a9e-bd10-8376-2eb9-61a508d52ad4@redhat.com>
Date: Fri, 12 Jul 2019 19:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712065241.11784-1-king.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] memory: unref the memory region in
 simplify flatview
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
Cc: weidong.huang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/07/19 08:52, Wang King wrote:
> From: King Wang<king.wang@huawei.com>
> 
> The memory region reference is increased when insert a range
> into flatview range array, then decreased by destroy flatview.
> If some flat range merged by flatview_simplify, the memory region
> reference can not be decreased by destroy flatview any more.
> 
> In this case, start virtual machine by the command line:
> qemu-system-x86_64
> -name guest=ubuntu,debug-threads=on
> -machine pc,accel=kvm,usb=off,dump-guest-core=off
> -cpu host
> -m 16384
> -realtime mlock=off
> -smp 8,sockets=2,cores=4,threads=1
> -object memory-backend-file,id=ram-node0,prealloc=yes,mem-path=/dev/hugepages,share=yes,size=8589934592
> -numa node,nodeid=0,cpus=0-3,memdev=ram-node0
> -object memory-backend-file,id=ram-node1,prealloc=yes,mem-path=/dev/hugepages,share=yes,size=8589934592
> -numa node,nodeid=1,cpus=4-7,memdev=ram-node1
> -no-user-config
> -nodefaults
> -rtc base=utc
> -no-shutdown
> -boot strict=on
> -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2
> -device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x2
> -device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x3
> -drive file=ubuntu.qcow2,format=qcow2,if=none,id=drive-virtio-disk0,cache=none,aio=native
> -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
> -chardev pty,id=charserial0
> -device isa-serial,chardev=charserial0,id=serial0
> -device usb-tablet,id=input0,bus=usb.0,port=1
> -vnc 0.0.0.0:0
> -device VGA,id=video0,vgamem_mb=16,bus=pci.0,addr=0x5
> -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x6
> -msg timestamp=on
> 
> And run the script in guest OS:
> while true
> do
>     setpci -s 00:06.0 04.b=03
> 	setpci -s 00:06.0 04.b=07
> done
> 
> I found the reference of node0 HostMemoryBackendFile is a big one.
> (gdb) p numa_info[0]->node_memdev->parent.ref
> $6 = 1636278
> (gdb)
> 
> Signed-off-by: King Wang<king.wang@huawei.com>
> ---
>  memory.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/memory.c b/memory.c
> index 480f3d989b..d8d42bdff8 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -321,7 +321,7 @@ static bool can_merge(FlatRange *r1, FlatRange *r2)
>  /* Attempt to simplify a view by merging adjacent ranges */
>  static void flatview_simplify(FlatView *view)
>  {
> -    unsigned i, j;
> +    unsigned i, j, k;
>  
>      i = 0;
>      while (i < view->nr) {
> @@ -332,6 +332,9 @@ static void flatview_simplify(FlatView *view)
>              ++j;
>          }
>          ++i;
> +        for (k = i; k < j; k++) {
> +            memory_region_unref(view->ranges[k].mr);
> +        }
>          memmove(&view->ranges[i], &view->ranges[j],
>                  (view->nr - j) * sizeof(view->ranges[j]));
>          view->nr -= j - i;
> 

Good catch.  Queued, thanks.

Paolo

