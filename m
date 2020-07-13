Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDA6C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04032067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwBZHp+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04032067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juyhE-0005NX-38
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 09:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1juygQ-0004rK-4L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:39:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1juygN-00026g-5s
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594647585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UTelTcxKTCViGLWmhCCJ+7moMIiAkxlIQONoV4b8C0g=;
 b=fwBZHp+yDK6OgF1nRMMYrbRLXJqJUaTMsZdb8ZK2bYrKfQNJ81qx+J2FRyJ2d8NUpas7ES
 55p7B4wO7ROsiS5ubTZv29nm8E21k0Z4qXugecV7p8hjmX4//FSeoLkXsWhQ6EdFu07VYF
 6aL/5gFC0lDQKwNgqKd0N3TRDSu1l2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-O0yvZTnVNquzVYkiVaYFiQ-1; Mon, 13 Jul 2020 09:39:41 -0400
X-MC-Unique: O0yvZTnVNquzVYkiVaYFiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0736801E6A;
 Mon, 13 Jul 2020 13:39:39 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-117.rdu2.redhat.com [10.10.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1092F60BEC;
 Mon, 13 Jul 2020 13:39:36 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 9767A2237D7; Mon, 13 Jul 2020 09:39:35 -0400 (EDT)
Date: Mon, 13 Jul 2020 09:39:35 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200713133935.GA271133@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com> <20200618191655.GI2769@work-vm>
 <20200618192717.GE3814@redhat.com>
 <CAJFHJrrJzPLatNvw2xC3WYLbzCW0+DB+4UczQHGPBF9p+WGYQA@mail.gmail.com>
 <20200619191540.GI3154@redhat.com>
 <CAJFHJroGNbfO-tXqrod_snCHcnN4NKjX8t9LTeroyiNEwjtVcQ@mail.gmail.com>
 <20200625125508.GB149340@redhat.com>
 <CAJFHJrpwvEMa_OkxRg3XHXp+=Wuzwwc8shhCZd3xDsmVVJG7aw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJFHJrpwvEMa_OkxRg3XHXp+=Wuzwwc8shhCZd3xDsmVVJG7aw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 05:54:19PM +0900, Chirantan Ekbote wrote:
> On Thu, Jun 25, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Thu, Jun 25, 2020 at 12:19:39PM +0900, Chirantan Ekbote wrote:
> > [..]
> > > > Chirantan,
> > > >
> > > > So you ended up renaming all "trusted", "security" and "system" xattrs?
> > > > Only "user" xattrs are complete passthrough?
> > > >
> > >
> > > No, we only rename "security" xattrs (except for selinux).
> > >
> > > >
> > > > IOW, security.selinux will be renamed to user.virtiofs.security.selinux
> > > > on host?
> > > >
> > >
> > > We don't relabel security.selinux because it only requires CAP_FOWNER
> > > in the process's user namespace and it also does its own MAC-based
> > > checks.  Also we have some tools that label files beforehand so it
> > > seemed easier to leave them unchanged.
> >
> > If we rename selinux xattr also, then we can support selinux both in
> > guest and host and they both can have their own independent policies.
> >
> 
> This works as long as you don't need to support setfscreatecon, which
> exists to guarantee that an inode is atomically created with the
> correct selinux context.  It's kind of possible for files with
> O_TMPFILE + fsetxattr + linkat but there is no equivalent for
> directories.  You're basically forced to create the directory and then
> set the xattr and while it's possible to prevent other threads in the
> server from seeing the unfinished directories with a rwlock or similar
> there is no protection against power loss.  If the machine loses power
> after the directory is created but before the selinux xattr is set
> then that directory will have the wrong selinux context and the guest
> would need to run restorecon at boot to assign the correct label.

Overlayfs has this notion of work directory where they create directory
(and file if O_TMPFILE is not supported), and then rename it to correct
place. I am wondering if we could do something similar. If server is
given a work directory where.

A. Create new directory
B. set selinux lables
C. rename directory

That way if machine crashes after step A or step B, that directory
never becomes visible to guest and no relabeling is required.

Thanks
Vivek


