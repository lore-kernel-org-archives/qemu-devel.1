Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDD4C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7D5214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7P46UkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7D5214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05vx-0002qX-BJ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1j05vJ-0002Nf-Eq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1j05vH-000489-2u
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:52:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56987
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1j05vG-00047k-Sj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581090721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4stA1o4P7qROB/SMs9ohY6biVXuPjSiStrzSGoIEYgw=;
 b=P7P46UkOnkp+u4VUymttlzXBQiWbTjSlO0NqjdeDVCcz+isDAsSXFN/I200KrB+NyI47UL
 y9xzJpWueceCSqqZbJK96pHbwehJ8fp0MDkWqe/edWunBMaN4Xx/lA08WsNdgr5zqS+OH4
 ggk4AJ/yYb4RbktC4z46LRa2vveCBh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-5G3dkFQBMCOxY_dvao50eQ-1; Fri, 07 Feb 2020 10:52:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACA07190D341
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 15:51:59 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7008C5C541;
 Fri,  7 Feb 2020 15:51:59 +0000 (UTC)
Date: Fri, 7 Feb 2020 08:51:58 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 20/59] target/i386: kvm: initialize microcode revision
 from KVM
Message-ID: <20200207085158.208e86c4@x1.home>
In-Reply-To: <f2e74bc5-b3ce-c917-d0d3-bd9a8a194c36@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
 <1579787449-27599-21-git-send-email-pbonzini@redhat.com>
 <20200206162412.11d5b9c6@w520.home>
 <f2e74bc5-b3ce-c917-d0d3-bd9a8a194c36@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 5G3dkFQBMCOxY_dvao50eQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 00:40:31 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 07/02/20 00:24, Alex Williamson wrote:
> > Hey Paolo,
> > 
> > My Windows 10 VM boot loops with this :-\  It seems to be related to
> > the CPU model.  Now fails (host-passthrough):
> > 
> > -cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-vendor-id=KeenlyKVM,kvm=off  
> 
> Can you try adding ucode-rev=0x100000000 just to double check that it's
> the microcode version? 

Yes, it boots with:

-cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=0x1fff,hv-vendor-id=KeenlyKVM,kvm=off,ucode-rev=0x100000000

> Also perhaps doing "rdmsr 0x8b" and if you have
> anything set in bits 0-31 clearing them.

How would I do that?  Thanks,

Alex


