Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFAAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6379020759
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVkA75D4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6379020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybag-0000vg-Nj
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jybZb-0008ST-DZ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:47:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jybZZ-0000Vw-6S
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595512064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aD2ns/g2HFcfvGi7MvtSIQqFu/4k+cl9M8W7+6o8WQs=;
 b=EVkA75D4JzbWaoxGHh8sOUzFj9kbV39XjYaNkWbv3hBkCiRz9eJantc+Q6LtKzjq7d4Hwc
 P1KZWBJjZb0RZNuCL2RkogVDAzV9aMGllAD7OdCusEmPXaY/1PJ9ZdIYznJjgEYNl0HXzZ
 6qVEwmx/1bDT3qZFqxtSQki81iUximU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-7vQn_JpXNKGsM9GC_OjFCQ-1; Thu, 23 Jul 2020 09:47:42 -0400
X-MC-Unique: 7vQn_JpXNKGsM9GC_OjFCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9984218C63C2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 13:47:41 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-146.rdu2.redhat.com [10.10.118.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8674774F44;
 Thu, 23 Jul 2020 13:47:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 768B82204C7; Thu, 23 Jul 2020 09:47:33 -0400 (EDT)
Date: Thu, 23 Jul 2020 09:47:33 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH for-5.1 2/3] virtiofsd: add
 container-friendly -o chroot sandboxing option
Message-ID: <20200723134733.GA5885@redhat.com>
References: <20200722130206.224898-1-stefanha@redhat.com>
 <20200722130206.224898-3-stefanha@redhat.com>
 <20200722175820.GL2660@work-vm>
 <20200723122850.GI186372@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200723122850.GI186372@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, vromanso@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, rmohr@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 01:28:50PM +0100, Stefan Hajnoczi wrote:
> On Wed, Jul 22, 2020 at 06:58:20PM +0100, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > virtiofsd cannot run in an unprivileged container because CAP_SYS_ADMIN
> > > is required to create namespaces.
> > > 
> > > Introduce a weaker sandbox that is sufficient in container environments
> > > because the container runtime already sets up namespaces. Use chroot to
> > > restrict path traversal to the shared directory.
> > > 
> > > virtiofsd loses the following:
> > > 
> > > 1. Mount namespace. The process chroots to the shared directory but
> > >    leaves the mounts in place. Seccomp rejects mount(2)/umount(2)
> > >    syscalls.
> > 
> > OK, I'm guessing the behaviour of what happens if the host adds another
> > mount afterwards might be different?
> 
> Running inside a container with -o chroot:
>  - The container has its own mount namespace and it is therefore not
>    affected, modulo shared subtrees (see mount(8)).

How does virtiofsd inside container gets the directory it wants to
export to guest? I am assuming that its probably a volume mount
inside container. If yes, volume mounts can set propagation
properties say "slave" and that means mounts done later will
propagate inside container in that volume (and hopefully be
visible inside guest once submount patches are upstream).

Thanks
Vivek


