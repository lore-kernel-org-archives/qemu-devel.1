Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE522C2D0C6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 11:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2A320838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 11:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2A320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilABc-0001OY-Pe
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 06:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1ilAAu-0000yj-KL
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 06:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1ilAAs-0006XM-HZ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 06:22:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:38219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1ilAAs-0006Fa-7p
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 06:22:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Dec 2019 03:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,366,1571727600"; d="scan'208";a="269270033"
Received: from lxy-dell.sh.intel.com ([10.239.159.46])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Dec 2019 03:22:21 -0800
Message-ID: <1d1650f9d963eca4307832505a7986d7bf33aaae.camel@intel.com>
Subject: Re: [PATCH] accel/kvm: Make "kernel_irqchip" default on
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 28 Dec 2019 19:14:19 +0800
In-Reply-To: <CABgObfbiCrLtUoDnGZBVW+5hhfs2YYLs0nrcMeFgAPAir_R2mA@mail.gmail.com>
References: <CABgObfbKM_QNXJaAk7m2JYOoZgAAa+98d2x3==eYUkTi_CGw6Q@mail.gmail.com>
 <20191228093222.18431-1-xiaoyao.li@intel.com>
 <CABgObfZRjFVrUdWV81h6K7U+Jq=60uQR-uNvu5bLY=xs90FA8Q@mail.gmail.com>
 <1d4592b74493c637d4b897c771d8613d93462ec1.camel@intel.com>
 <CABgObfbiCrLtUoDnGZBVW+5hhfs2YYLs0nrcMeFgAPAir_R2mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 2019-12-28 at 10:57 +0000, Paolo Bonzini wrote:
> 
> 
> Il sab 28 dic 2019, 10:24 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:
> > BTW, it seems that this patch makes kernel_irqchip default on to workaround
> > the
> > bug. 
> > However, when explicitly configuring kernel_irqchip=off, guest still fails
> > booting due to "KVM: failed to send PV IPI: -95" with a latest upstream
> > kernel
> > ubuntu guest. Any idea about this? 
> 
> We need to clear the PV IPI feature for userspace irqchip. Are you using -cpu
> host by chance?

Yes, I used -cpu host.

After using "-cpu host,-kvm-pv-ipi" with kernel_irqchip=off, it can boot
successfully.

> Paolo
> 
> > > Paolo
> > > >  }
> > > > 
> > > >  static void kvm_accel_class_init(ObjectClass *oc, void *data)
> > > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > > index 61f8bb8e5a42..fb1b43d5b972 100644
> > > > --- a/include/hw/boards.h
> > > > +++ b/include/hw/boards.h
> > > > @@ -271,9 +271,6 @@ struct MachineState {
> > > > 
> > > >      /*< public >*/
> > > > 
> > > > -    bool kernel_irqchip_allowed;
> > > > -    bool kernel_irqchip_required;
> > > > -    bool kernel_irqchip_split;
> > > >      char *dtb;
> > > >      char *dumpdtb;
> > > >      int phandle_start;
> > 


