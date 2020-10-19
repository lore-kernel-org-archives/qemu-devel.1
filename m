Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F49C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBE12224F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS7JCdku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBE12224F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUaVk-00057k-Fm
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kUaQG-0007XU-Ku
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kUaQB-0000ov-Pu
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603134133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hETq2MK5UNR2g0DSGewOEz7HlJgIpcZTAUMJI0/Ruc=;
 b=IS7JCdku/Jhszuzq00/Bh/8vbuTQpgy/sNless2PcKKXTsMTzVmAAW0WTw2yt9hshtmrsI
 Pu6eSmMmK1qz5A0JSPNvSMBPzeG49KBukUFbuUQkngP67zxuJ8Z4npWacZ+zf5QPjCoR1M
 ayRcyhluO9mqc9TuHafKEIanDrBJm10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-QE4CU-zvNfq_MNPftRHjGQ-1; Mon, 19 Oct 2020 15:02:10 -0400
X-MC-Unique: QE4CU-zvNfq_MNPftRHjGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C9BA425DE;
 Mon, 19 Oct 2020 19:02:08 +0000 (UTC)
Received: from w520.home (ovpn-112-77.phx2.redhat.com [10.3.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6132260DA0;
 Mon, 19 Oct 2020 19:02:07 +0000 (UTC)
Date: Mon, 19 Oct 2020 13:02:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] Skip flatview_simplify() for cpu vendor zhaoxin
Message-ID: <20201019130206.1d3baffc@w520.home>
In-Reply-To: <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
References: <20201016112933.14856-1-FelixCui-oc@zhaoxin.com>
 <20201016112933.14856-2-FelixCui-oc@zhaoxin.com>
 <a971c9db-469f-ddc0-1a27-3e21958f6ff7@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: FelixCuioc <FelixCui-oc@zhaoxin.com>, Eduardo Habkost <ehabkost@redhat.com>,
 CobeChen-oc@zhaoxin.com, qemu-devel@nongnu.org, TonyWWang-oc@zhaoxin.com,
 RockCui-oc@zhaoxin.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Oct 2020 13:42:29 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 16/10/20 13:29, FelixCuioc wrote:
> > The issue here is that an assinged EHCI device accesses
> > an adjacent mapping between the delete and add phases
> > of the VFIO MemoryListener.
> > We want to skip flatview_simplify() is to prevent EHCI
> > device IOVA mappings from being unmapped.  
> 
> Hi,
> 
> there is indeed a bug, but I have already explained last month
> (https://mail.gnu.org/archive/html/qemu-devel/2020-09/msg01279.html)
> that this patch is conceptually wrong:
> 
> 1) you're adding host_get_vendor conditioned on compiling the x86
> emulator, so you are breaking compilation on non-x86 machines.
> 
> 2) you're adding a check for the host, but the bug applies to all hosts.
>  If there is a bug on x86 hardware emulation, it should be fixed even
> when emulating x86 from ARM.  It should also apply to all CPU vendors.
> 
> Alex, the issue here is that the delete+add passes are racing against an
> assigned device's DMA. For KVM we were thinking of changing the whole
> memory map with a single ioctl, but that's much easier because KVM
> builds its page tables lazily. It would be possible for the IOMMU too
> but it would require a relatively complicated comparison of the old and
> new memory maps in the kernel.

We can only build IOMMU page tables lazily if we get faults, which we
generally don't.  We also cannot atomically update IOMMU page tables
relative to a device, so "housekeeping" updates of mappings to (I
assume) consolidate KVM memory slots doesn't work so well when the
device is still running.  Stopping the device via something like the
bus-master enable bit also sounds like a whole set of problems itself.
I assume these simplified mappings also reduce our resolution for later
unmaps, which isn't necessarily a win for an assigned device either if
it exposes the race again each boot.

Maybe the question is why we don't see these errors more regularly, is
there something unique about the memory layout of this platform versus
others that causes larger memory regions to be coalesced together only
to be later unmapped and provide more exposure to this issue?  Thanks,

Alex


