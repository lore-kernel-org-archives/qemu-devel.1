Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F79C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8AE20809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSX6t5qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8AE20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJQ3-0004tB-Vz
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jmJOp-0003V8-0d
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:57:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44112
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jmJOn-0008Lq-DG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592582268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkgDIxv8D3xhyi/e4NmXeN+LwFijSaMWMkE43XFbtrw=;
 b=eSX6t5qu81/j4/+1yN5OqTRuZBZ3xdpBQeVNPY+pONia9OrLx3L+DqVBpNZL0wR89+fP4Z
 9svVdnQ5EZ9pjVeeHJmX75r2Ug7OSK8YG69RE8YnH8FQZzO0vKRXohbsvz7Jb5Irt3vaPq
 6vs53VnJ7ltRgOkVd+6H+1aBCmkZ1dM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-D6pqPzbjNwWTEKVVqKryAA-1; Fri, 19 Jun 2020 11:57:46 -0400
X-MC-Unique: D6pqPzbjNwWTEKVVqKryAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF248106B242;
 Fri, 19 Jun 2020 15:57:45 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-35.rdu2.redhat.com [10.10.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6CBC5BAEE;
 Fri, 19 Jun 2020 15:57:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 328B6220390; Fri, 19 Jun 2020 11:57:37 -0400 (EDT)
Date: Fri, 19 Jun 2020 11:57:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200619155737.GA12225@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com>
 <CAJfpegsfqADmK6foDyuQQnvMDh_jE0rNUCBRuxPchSSirrb04Q@mail.gmail.com>
 <20200619142508.GB3154@redhat.com>
 <CAJfpeguhS3w-AZTpyzO2QqcX_7F1qDm__5C8r3pBnCgPoxTKmQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJfpeguhS3w-AZTpyzO2QqcX_7F1qDm__5C8r3pBnCgPoxTKmQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 05:26:37PM +0200, Miklos Szeredi wrote:
> On Fri, Jun 19, 2020 at 4:25 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Fri, Jun 19, 2020 at 04:16:30PM +0200, Miklos Szeredi wrote:
> > > On Thu, Jun 18, 2020 at 9:08 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> > > > > virtiofsd doesn't need of all Linux capabilities(7) available to root.  Keep a
> > > > > whitelisted set of capabilities that we require.  This improves security in
> > > > > case virtiofsd is compromised by making it hard for an attacker to gain further
> > > > > access to the system.
> > > >
> > > > Hi Stefan,
> > > >
> > > > I just noticed that this patch set breaks overlayfs on top of virtiofs.
> > >
> > > How so?  Virtiofs isn't mounting overlayfs, is it?  Only the mounter
> > > requires CAP_SYS_ADMIN, not the accessor.
> >
> > virtiofsd needs CAP_SYS_ADMIN, otherwise fsetxattr(trusted.overlay.opaque)
> > fails in lo_setxattr().
> >
> > This is triggered when we mount overlayfs on top of virtiofs and overlayfs
> > tries to set OVL_XATTR_OPAQUE on upper to check if trusted xattrs are
> > supported or not.
> 
> Ah, right.
> 
> Plan is to use "user.*" xattr for unprivileged overlay.  This would be
> a good way to eliminate this attack surface in the overlay on virtiofs
> case as well.

So unpriviliged overlay is one which is mounted from inside a user
namespace. But in this case we might be mounting it from init_user_ns
of guest. So from overlayfs perspective this will still be treated
as priviliged overlay instance and it will use trusted xattrs, IIUC?

Thanks
Vivek

> 
> Other ways to minimize risk is to separate operations requiring
> CAP_SYS_ADMIN into a separate process, preferably a separate
> executable, that communicates with virtiofsd using a pipe and contains
> the minimum amount of code.

> 
> Thanks,
> Miklos
> 


