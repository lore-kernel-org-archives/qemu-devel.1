Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68EFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E78A208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVjwojl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E78A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKiD-0007lJ-Ok
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jmKYE-0002Hu-E4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:11:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jmKY7-0005Ak-4s
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592586689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKYFM+/tQxX39GcmpjlnxHPU0YXm7LXJUbikwu5r220=;
 b=FVjwojl59/5UmR+UrWUMTjfus0UY6GoMrbVWe+BSvk7N4Wq3u4L4UwaHt/DzF+PVIOs6zM
 Y7Br+8eF+ygzZSeSm9FpWoKk2J83Ci69wMu+U6a1OvQWvwkUze5gNzBNH196LqYIDnnzAp
 YclScMgz0ZKFj++ijsCPaYbwSHTwmlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-HARNiHXpNDyxHd7RKeSPZA-1; Fri, 19 Jun 2020 13:11:25 -0400
X-MC-Unique: HARNiHXpNDyxHd7RKeSPZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6084081EDDE;
 Fri, 19 Jun 2020 17:11:23 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-35.rdu2.redhat.com [10.10.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3409560BE1;
 Fri, 19 Jun 2020 17:11:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 800D3220390; Fri, 19 Jun 2020 13:11:21 -0400 (EDT)
Date: Fri, 19 Jun 2020 13:11:21 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200619171121.GE3154@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com> <20200618191655.GI2769@work-vm>
 <20200618192717.GE3814@redhat.com> <20200619082746.GA2690@work-vm>
 <20200619160923.GD3154@redhat.com> <20200619161648.GJ2690@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200619161648.GJ2690@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 05:16:48PM +0100, Dr. David Alan Gilbert wrote:

[..]
> > > > >   b) If something nasty was to write junk into the trusted attributes,
> > > > >     what would happen?
> > > > 
> > > > This directory is owned by guest. So it should be able to write
> > > > anything it wants, as long as process in guest has CAP_SYS_ADMIN, right?
> > > 
> > > Well, we shouldn't be able to break/crash/escape into the host; how
> > > much does overlayfs validate trusted.* it uses?
> > 
> > I thought qemu and kvm are the one who should ensure we should not be
> > able to break out of sandbox. Kernel implementation could be as 
> > buggy as it wanted to be. We are working with this security model
> > that kernel is completely untrusted.
> 
> But with virtiofs we allow the guest to do a lot of filesystem
> operations on the host.  It's the virtiofsd that has to ensure that
> these are safe and contained within the fs it's exposed; the qemu/kvm
> can't protect us from that.

Fair enough. I should have added virtiofsd to list. Its an attack
vector and is of concern.

> 
> That's why we sandbox the virtiofsd like we do - if we allow a
> priviliged guest to perform calls to an unconstrained virtiofsd it would
> be able to escape.  That's what I want to check.

Sure. So does giving CAP_SYS_ADMIN to virtiofsd allow daemon to escape
the jail. If it does we need to implement what crossvm folks did,
remapping of trusted xattr. That will also allow us to run inside
user namespace and still be able to support trusted xattr emulation
for guest.

Vivek


