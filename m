Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D4EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03D520658
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdrCfLrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03D520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XKZ-0002kO-6s
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5XJr-00023T-Vh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:40:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5XJn-00023t-Hs
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597164005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUKWicgDbR+X+BhAVZGE26I5tIGZe1Qz8U4lzrU4fuY=;
 b=WdrCfLrwU5PQigb3rRqJAyxLeFu7kk8qvNibUWRdVMrTxTFUxkz9gyp6IjhZ6sJ3SY4fL5
 Nx1zCsOFYnwCu63loWFhT9Neu1JjEH7WEN+oV27dCp9TRXclaleJzKLbO9CtczzscEdqnF
 /BXqutlSrh6+c5+Ig0ZrJ5tS10pc784=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-qWWe4mjzNiag5uFp_1EbEw-1; Tue, 11 Aug 2020 12:40:03 -0400
X-MC-Unique: qWWe4mjzNiag5uFp_1EbEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F5048B78A5;
 Tue, 11 Aug 2020 16:38:37 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8753960E1C;
 Tue, 11 Aug 2020 16:38:35 +0000 (UTC)
Date: Tue, 11 Aug 2020 18:38:32 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH 6/7] hw/arm/virt: spe: Add SPE fdt binding for virt machine
Message-ID: <20200811163832.roxay4uafcyp3sed@kamzik.brq.redhat.com>
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <1663d06172cffa723e00893837ba04634f061fc8.1596768588.git.haibo.xu@linaro.org>
 <20200810110521.4hodliv4tl64v463@kamzik.brq.redhat.com>
 <CAJc+Z1HDokOuTA4=hzS5KHPU9w3Hm0UV=nJbjnvHEbtTpDY0Ag@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJc+Z1HDokOuTA4=hzS5KHPU9w3Hm0UV=nJbjnvHEbtTpDY0Ag@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 10:38:02AM +0800, Haibo Xu wrote:
> On Mon, 10 Aug 2020 at 19:05, Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Fri, Aug 07, 2020 at 08:10:36AM +0000, Haibo Xu wrote:
> > > Add a virtual SPE device for virt machine while using PPI
> > > 5 for SPE overflow interrupt number.
> >
> > Any reason PPI 5 was selected?
> >
> 
> No special reason to choose PPI 5. Just re-use the setting in kvmtool.

Please write in the commit message that kvmtool has already selected PPI 5
for this purpose.

> > > +    fdt_add_spe_nodes(vms);
> > > +
> >
> > You didn't add any compat code, which means all virt machine types are now
> > getting an SPE FDT node, ACPI table change, and, most importantly, PPI 5
> > has gone from unallocated to allocated. We definitely need compat code.
> >
> 
> So the 'compat code' here means to only add the SPE node in KVM mode?

No, it means only add it for the 5.2 and later machine types. You'll see
what I mean when you study the patchset I pointed out, which is also only
for 5.2 and later machine types.

> > > +        if (switched_level & KVM_ARM_DEV_SPE) {
> > > +            qemu_set_irq(cpu->spe_interrupt,
> > > +                         !!(run->s.regs.device_irq_level & KVM_ARM_DEV_SPE));
> > > +            switched_level &= ~KVM_ARM_DEV_SPE;
> > > +        }
> > > +
> >
> > Did you test with a userspace irqchip?
> 
> No, I just tested with an in-kernel irqchip.
> Actually, the current kernel vSPE patch doesn't support a userspace irqchip.
> AFAIK, the userspace irqchip support should be ready in the next
> kernel patch series
> which will be sent out for review in the middle of September.

It probably doesn't hurt to do the above hunk already, hoping it will just
work when it's possible to test, but I generally prefer only adding tested
code. Maybe this hunk should be a separate patch with a commit message
explaining that it's untested?

Thanks,
drew


