Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA27C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0637A20989
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0637A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35523 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOLB0-0008Sf-49
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:55:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOLAF-0007U7-BB
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOLAE-0001c6-4F
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:55:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOLAD-0001bd-Ub
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:55:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so16721700wrn.4
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DlCDrDcwoBQNAiyVPci4BoxtcAtoc6jtlBBeXoXjECM=;
	b=r1tk7FjhBF2hxP9G0+bPbYy9PS71tDbCodzPrtVNHLiOfM1zB5AiUT3SNuiYFvw9ld
	SLsBmhpUoEPWkH+NnPzwwzKzyLB0raVkEzgoLlAOsGl72LZGopMufq3+13nd3LvADkCB
	AG0dPqUyFGFxzLJ3XAeG/2R97A6ATjV2LbO0GeCbVik02qyXxMv+b1X5iOYIUpAtZCzE
	b/Zk3XKIrX1Zpp+Rn05UhBQl3wWXd6qrWlKzMfmRN9om2Onw2ON4CQTHvEaYeoTnMB80
	n2oQIxXeyzZsgQPMr2Zb4HseKZFPj3sKbqclMKf8v4RAZD6hk926ERBivilzUF/NHtsD
	J8Og==
X-Gm-Message-State: APjAAAUdOKJdhnwvnGUJuGXsH9jC0PPikMyEqt71efvI/Y7TblpFlg3m
	lR2f0mO8tYeDoGLIHFfc7Y2fwg==
X-Google-Smtp-Source: APXvYqyy4+R7+kwkoK4QrBZmDOz2HwCx1eeMvxpKQ8KH2+VBQF9YeMzFL87ADG1g9vBWWURMEsUF9w==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr28286564wrn.9.1557316508907;
	Wed, 08 May 2019 04:55:08 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	v189sm4186985wma.3.2019.05.08.04.55.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:55:08 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>
References: <20190508061523.17666-1-peterx@redhat.com>
	<4df1963e-5b76-4990-6c2f-a66ecd172869@redhat.com>
	<20190508113929.GE18465@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a32b877c-1303-f378-316b-c564a8ccc419@redhat.com>
Date: Wed, 8 May 2019 13:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508113929.GE18465@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 00/11] kvm/migration: support
 KVM_CLEAR_DIRTY_LOG
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/19 06:39, Peter Xu wrote:
>> The disadvantage of this is that you won't clear in the kernel those
>> dirty bits that come from other sources (e.g. vhost or
>> address_space_map).  This can lead to double-copying of pages.
>>
>> Migration already makes a local copy in rb->bmap, and
>> memory_region_snapshot_and_clear_dirty can also do the clear.  Would it
>> be possible to invoke the clear using rb->bmap instead of the KVMSlot's
>> new bitmap?
>
> Actually that's what I did in the first version before I post the work
> but I noticed that there seems to have a race condition with the
> design.  The problem is we have multiple copies of the same dirty
> bitmap from KVM and the race can happen with those multiple users
> (bitmaps of the users can be a merged version containing KVM and other
> sources like vhost, address_space_map, etc. but let's just make it
> simpler to not have them yet).

I see now.  And in fact the same double-copying inefficiency happens
already without this series, so you are improving the situation anyway.

Have you done any kind of benchmarking already?

Thanks,

Paolo

>   (1) page P is written by the guest (let's version its data as P1),
>       its dirty bit D is set in KVM
> 
>   (2) QEMU sync dirty log, fetch D for page P (which is set).  D is
>       not cleared in KVM due to MANUAL_PROTECT cap.
> 
>   (3) QEMU copies the D bit to all users of dirty bmap (MIGRATION and
>       VGA as example).
> 
>   (4) MIGRATION code collects bit D in migration bitmap, clear it,
>       send CLEAR to KVM to clear the bit on remote (then D in KVM is
>       cleared too), send the page P with content P1 to destination.
>       CAUTION: when reach here VGA bitmap still has the D bit set.
> 
>   (5) page P is written by the guest again (let's version its data as
>       P2), bit D set again in KVM.
> 
>   (6) VGA code collectes bit D (note! we haven't synced the log again
>       so this is the _old_ dirty bit came from step 3 above) in VGA
>       bitmap, clear it, send CLEAR to KVM to clear the bit on remote.
>       Then D bit in KVM is cleared again.  Until here, D bit in all
>       bitmaps are cleared (MIGRATION, VGA, KVM).
> 
>   (7) page P is never written again until migration completes (no
>       matter whether we sync again D bit will be cleared).
> 
>   (8) On destination VM page P will contain content P1 rather than P2,
>       this is data loss...

