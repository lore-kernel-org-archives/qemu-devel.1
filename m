Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6030EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F2722283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvG0xb6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F2722283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUnu1-00017m-CQ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUntE-0000c7-00
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUntB-0002BM-Q6
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603185904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2l4nARG+rr8RBCb/lLQxMFzDTvSrg08y8PAug7kJdT8=;
 b=DvG0xb6g0jk+YFw8Dhi3LJIvu1t9G2IhtKrKARfII56ZSKTztVEJB18cW/Od6l2PsqM7tW
 13q1irZUPfYYOWcqFpFULMvsc/Pe5ooU8Eoap+o22MC0eO5MGU3UNdTi5D0hHm6o40lLht
 N4PcitWr/3WyrymsYb8ugi5k07oZQB8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-8VV_KFo5OZa1qly1Qe8BRw-1; Tue, 20 Oct 2020 05:25:02 -0400
X-MC-Unique: 8VV_KFo5OZa1qly1Qe8BRw-1
Received: by mail-wr1-f70.google.com with SMTP id x16so561619wrg.7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 02:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2l4nARG+rr8RBCb/lLQxMFzDTvSrg08y8PAug7kJdT8=;
 b=g71+bWzLwEApOdtK8sfaqDpo+KvelRVRrl83W0TVlcXXbfiw4xr3K8PDoG5vfFTza+
 jj+AQ7tA/XAKBhKBHzk0dwvpZ7tfhEydZwtUXaklCwkE5mIagmwpeEfWnFOJrbiHnGsN
 aAqmqi4x995rFEw/sgZTBDy9YeEpXzqA/80hndEj5X2a9ocv9DNZqnWu9OLpfoQln0Bm
 C0q3OAEG4J6mFgYQM5xSeg90dCq7m5Jr12cjl06N0GYBrIqy+vGb86f6GwVN72t0pLXP
 1aOSz0Es4P1+fy+uwLzh2T19mHwyTyFA+ck2OHuWu2TSCJtwk83EWwhdeLPalZn0zHp8
 nRSg==
X-Gm-Message-State: AOAM531t/Dz/8hTFenia3baI2Z/nx0Qn+dG0SAMJMmcSA5lWvof1X8Js
 9ZtZa832WZirSKuXiq8DjxRk7FbHoyG7alS4j4iVfD8t39yQHFhtZnxIcYdJTMjG2RbvO8ml1eD
 kcOCkmgwyX9fDdIE=
X-Received: by 2002:adf:c501:: with SMTP id q1mr2263500wrf.147.1603185900858; 
 Tue, 20 Oct 2020 02:25:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCqLb5ltOn9pNAFiYz8afywmA8atEgSbUa+eTQyAzcOJJexw8TAW5Ee/OmFJmlRZ3yGVa9bQ==
X-Received: by 2002:adf:c501:: with SMTP id q1mr2263486wrf.147.1603185900656; 
 Tue, 20 Oct 2020 02:25:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id g125sm1807373wme.33.2020.10.20.02.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 02:24:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] Skip flatview_simplify() for cpu vendor zhaoxin
To: Alex Williamson <alex.williamson@redhat.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
 <20201019130206.1d3baffc@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d2b96cb-8f7f-2598-39e6-4cf0f61d567b@redhat.com>
Date: Tue, 20 Oct 2020 11:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019130206.1d3baffc@w520.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: FelixCuioc <FelixCui-oc@zhaoxin.com>, Eduardo Habkost <ehabkost@redhat.com>,
 CobeChen-oc@zhaoxin.com, qemu-devel@nongnu.org, TonyWWang-oc@zhaoxin.com,
 RockCui-oc@zhaoxin.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/20 21:02, Alex Williamson wrote:
>> For KVM we were thinking of changing the whole
>> memory map with a single ioctl, but that's much easier because KVM
>> builds its page tables lazily. It would be possible for the IOMMU too
>> but it would require a relatively complicated comparison of the old and
>> new memory maps in the kernel.
>
> We can only build IOMMU page tables lazily if we get faults, which we
> generally don't.  We also cannot atomically update IOMMU page tables
> relative to a device,

Yeah, I didn't mean building IOMMU page tables lazily, rather replacing
the whole VFIO memory map with a single ioctl.

I don't think that requires atomic updates of the IOMMU page table root,
but it would require atomic updates of IOMMU page table entires; VFIO
would compare the old and new memory map and modify the page tables when
it sees a difference.  Is that possible?

Paolo

> so "housekeeping" updates of mappings to (I
> assume) consolidate KVM memory slots doesn't work so well when the
> device is still running.  Stopping the device via something like the
> bus-master enable bit also sounds like a whole set of problems itself.
> I assume these simplified mappings also reduce our resolution for later
> unmaps, which isn't necessarily a win for an assigned device either if
> it exposes the race again each boot.
> 
> Maybe the question is why we don't see these errors more regularly, is
> there something unique about the memory layout of this platform versus
> others that causes larger memory regions to be coalesced together only
> to be later unmapped and provide more exposure to this issue?  Thanks,


