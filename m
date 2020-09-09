Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF6DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B832087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4gRlTNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B832087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwVk-0006ge-1O
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFwV5-00068K-58
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:34:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFwV2-0005yo-Mw
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599644083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uy7ouSRZrCqIK2d64Twf7tkOpwiPj82LipvPt9O1uDA=;
 b=M4gRlTNJxOjPnHiwIZ9UZ8KJqKAfVamNly7TL17tBbd3w8ozlhwX8fzSVBfU95wwGIVDgi
 GRLtFyujneKTnJUcCfKdSda7cqZA7SGsHgAVuMqO5PCdY8EsPeF7ntLsgpO2+VFG91q8kL
 Q3/3MxN4ezw2o0UAf/ot1sRl+tjtdb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-wiTG1aiVMMqwcGvJqqEBYg-1; Wed, 09 Sep 2020 05:34:41 -0400
X-MC-Unique: wiTG1aiVMMqwcGvJqqEBYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1417B80EF8A;
 Wed,  9 Sep 2020 09:34:40 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89B6E3A40;
 Wed,  9 Sep 2020 09:34:38 +0000 (UTC)
Date: Wed, 9 Sep 2020 11:34:35 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v2 09/12] hw/arm/virt: spe: Add SPE fdt binding for virt
 machine
Message-ID: <20200909093435.txd7bkt6n3z7tm4u@kamzik.brq.redhat.com>
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <c6ac607d2cd253de6a990538edfde7f86066f04f.1599549462.git.haibo.xu@linaro.org>
 <20200908111625.2wzzn7jh5wt4nnmu@kamzik.brq.redhat.com>
 <CAJc+Z1GCmf5fEjifa84O6jmfd6WCih1jT07AXb7vWFC7=sXfrA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJc+Z1GCmf5fEjifa84O6jmfd6WCih1jT07AXb7vWFC7=sXfrA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 03:51:14PM +0800, Haibo Xu wrote:
> > > +
> > > +            if (spe) {
> > > +                assert(ARM_CPU(cpu)->has_spe == ON_OFF_AUTO_ON);
> > > +                if (kvm_irqchip_in_kernel()) {
> > > +                    kvm_arm_spe_set_irq(cpu, PPI(VIRTUAL_SPE_IRQ));
> > > +                }
> > > +                kvm_arm_spe_init(cpu);
> >
> > A later patch introduces userspace irqchip support. Should we avoid
> > allowing it until then to avoid breaking bisection?
> >
> 
> Yes, it's possible to break the bisection. To avoid it I think we can
> move the above codes
> block to a separate patch after adding the userspace irqchip support,
> Or, just put the userspace
> irqchip support patch before this patch. What's your opinion?
>

This patch ca forbid SPE without kernel irqchip. Then the patch that adds
userspace irqchip support would also remove the restriction.

Thanks,
drew 


