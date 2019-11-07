Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CB1C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 08:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE762166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 08:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE762166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSddr-0005hb-FX
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 03:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSdbu-0004Yf-3B
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSdbr-0007pO-Qu
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:57:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSdbr-0007jp-Hz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:57:43 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B016B4E832
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 08:57:42 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id q125so1489216qka.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 00:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QncuxsSnXpZblvSAjpStc0tmPfEmXDJTLIpR6QnQ6b8=;
 b=ZdMmu0LpPhBI6cuS428n0iD/FfcXi5Nkvem0/X8HylCG5h39l3EF20wZYKaxa/H0SH
 +4KH6JGsuF0nQCjRtIcSeaKtS180ekEgXBJh7Q64bK4ELqSLVgz0eg3rw+INMRxHqjsB
 D7PzFky98/OoWdhvzofWbergZKfC+yArUEwtqzjrYVMq5sq28ss1EmxNHEQWke7nfDtC
 qNc62+JQB6m5kDK5zEq7AsxaSy8Zs4JRFFvQC42GtaMg5gt/rq6mOnAEcOGqrb7APsfK
 Tx2uT/+kRx0JPYsLrFvp5DR91bZvzhzlxr4AySJfRpkYsycu4BD4nulSTMp7+R/eJ6W5
 dS9A==
X-Gm-Message-State: APjAAAV38aazseHtVusFszH+eBf/mU4CoNoBcjA/PHnFNoCrGaZ77+7u
 SQY/T1WXH/m17Hn2mSMakapTagfLG0Khih21vqjD92AeKKrzemWoAOxm5s8WIrrVJTBsjdJc1Wn
 dGxzRptZKkkkhECw=
X-Received: by 2002:a0c:ee26:: with SMTP id l6mr2333907qvs.71.1573117061959;
 Thu, 07 Nov 2019 00:57:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUgXYKKSZMNd5/NPWOQM6gAJkjG/4u4NIVyuBsMrvkrxh0ni6n178GGcXYvrEhxqz8C5jr/g==
X-Received: by 2002:a0c:ee26:: with SMTP id l6mr2333884qvs.71.1573117061677;
 Thu, 07 Nov 2019 00:57:41 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id u4sm820380qkd.105.2019.11.07.00.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 00:57:40 -0800 (PST)
Date: Thu, 7 Nov 2019 03:57:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [RFC v2 11/14] linux-headers/kvm.h: add capability to forward
 hypercall
Message-ID: <20191107035624-mutt-send-email-mst@kernel.org>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <20191105091056.9541-12-guoheyi@huawei.com>
 <20191106185524.0fe51c50.cohuck@redhat.com>
 <4dbcbd18-0e6c-f985-c36d-96df65331d11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbcbd18-0e6c-f985-c36d-96df65331d11@huawei.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 09:44:36AM +0800, Guoheyi wrote:
> 
> 
> On 2019/11/7 1:55, Cornelia Huck wrote:
> > On Tue, 5 Nov 2019 17:10:53 +0800
> > Heyi Guo <guoheyi@huawei.com> wrote:
> > 
> > > To keep backward compatibility, we add new KVM capability
> > > "KVM_CAP_FORWARD_HYPERCALL" to probe whether KVM supports forwarding
> > > hypercall to userspace.
> > > 
> > > The capability should be enabled explicitly, for we don't want user
> > > space application to deal with unexpected hypercall exits. After
> > > enabling this cap, all HVC calls unhandled by kvm will be forwarded to
> > > user space.
> > > 
> > > Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Dave Martin <Dave.Martin@arm.com>
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: James Morse <james.morse@arm.com>
> > > ---
> > >   linux-headers/linux/kvm.h |  1 +
> > >   target/arm/sdei.c         | 16 ++++++++++++++++
> > >   target/arm/sdei.h         |  2 ++
> > >   3 files changed, 19 insertions(+)
> > > 
> > > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > > index 3d9b18f7f8..36c9b3859f 100644
> > > --- a/linux-headers/linux/kvm.h
> > > +++ b/linux-headers/linux/kvm.h
> > > @@ -1000,6 +1000,7 @@ struct kvm_ppc_resize_hpt {
> > >   #define KVM_CAP_PMU_EVENT_FILTER 173
> > >   #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
> > >   #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
> > > +#define KVM_CAP_FORWARD_HYPERCALL 176
> > >   #ifdef KVM_CAP_IRQ_ROUTING
> > Is this cap upstream already? I would have thought your header sync
> > would have brought it in, then. (Saying this, that header sync looks
> > awfully small.)
> > 
> > If it is not upstream yet, please split off this hunk into a separate
> > patch -- it's a bit annoying, but makes life easier for merging.
> No, it is not upstream yet. The whole framework and interfaces between KVM
> and qemu are still under discussion. I'll keep in mind of this when moving
> forward to next steps...
> 
> Thanks,
> HG

It's best to add it in some other place meanwhile.
Then we can drop it when it's in an upstream header.


> > 
> > 
> > .
> > 
> 

