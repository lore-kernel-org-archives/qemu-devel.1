Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9ADC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADCC20863
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADCC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjXB8-0002TI-W0
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjWzw-0007YT-NP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjWzv-0007i5-L3
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjWzv-0007hd-Fk
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:48:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9252E8665F;
 Fri,  5 Jul 2019 22:48:06 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 238B4891CF;
 Fri,  5 Jul 2019 22:48:05 +0000 (UTC)
Date: Fri, 5 Jul 2019 19:48:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190705224804.GM5198@habkost.net>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-7-git-send-email-pbonzini@redhat.com>
 <20190705212249.GG5198@habkost.net>
 <6262c798-fc94-5100-8836-e3cbea306282@redhat.com>
 <20190705223329.GL5198@habkost.net>
 <ea52e4c3-2553-b778-2b25-6a460fd67967@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea52e4c3-2553-b778-2b25-6a460fd67967@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 05 Jul 2019 22:48:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/7] target/i386: add VMX features
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 06, 2019 at 12:42:22AM +0200, Paolo Bonzini wrote:
> On 06/07/19 00:33, Eduardo Habkost wrote:
> > Oh, that's the info I was missing.  I always expected
> > kvm_arch_get_supported_*() to be subject to change (depending on
> > KVM and hardware capabilities), and not be part of guest ABI.
> 
> For most bits that's true.  Just not for these ones, because they are
> integer values rather than bit flags.
> 
> The reason for the complex rules is that you need to know what is a
> flag, what is a fixed value that the guest uses, and what is a maximum
> supported value.  Simpler userspace than QEMU can just use the defaults
> since they don't care about maintaining the guest ABI.
> 
> > Now, if KVM is going to to implement the guest ABI guarantee at
> > KVM_GET_MSRS, that's OK.  Is this going to be obvious to people
> > touching KVM_GET_MSRS in the future?
> > 
> > What if we do want the guest ABI to change in the future?  How do
> > you expect QEMU to ask KVM to enable the new guest ABI?  How do
> > you expect the user to ask QEMU to enable the new guest ABI?
> 
> That would be with ioctl(KVM_ENABLE_CAP) for KVM, and with -cpu for QEMU.

Makes sense to me.

> 
> >> - KVM could change bits 16-24, but it always allows writing a value that
> >> is _smaller_ than the one you read.  So I'm zeroing those, ensuring no
> >> future ABI changes.
> >>
> >> - KVM could in theory change bits 25-27: here it also allows writing a
> >> value that is smaller than the one you read, so guest ABI is preserved.
> >>  Such a change is very unlikely, all Intel silicon has always had 0
> >> here.  But I can change the code to zero these three bits just like bits
> >> 16-24.
> > 
> > The complex rules above make me a bit nervous.  Can we at least
> > make QEMU validate the values returned by
> > kvm_arch_get_supported_msr_feature() to catch ABI-breaking
> > mistakes in the future?
> 
> I don't know... I'm a bit wary of adding hard-coded values in QEMU,
> userspace simply should not care.  But I can add comments to KVM to
> remind people of values that should not be changed.

Sounds good to me.  If we're worried about breaking guest ABI by
accident, we can include the MSRs in the guest ABI validation
test cases I'm working on.

-- 
Eduardo

