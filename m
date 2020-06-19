Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062DCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DC721707
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IW5MiVjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DC721707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJbP-0003nl-1S
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jmJaD-0001ur-0s
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:09:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46464
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jmJaA-0002Lm-Mv
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592582973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I312RrnGPjHwdsnBELG74IdqjvGt+9W8gL4g09O+1ko=;
 b=IW5MiVjEL0cXiifbXJ33lHkJ7IThR8PA8cRdMsVTYsVJrifSRgpoPWJisF3dv/NMUWQXbZ
 IUiH5264I0fP7MLrV6sJkafbqCc6THRl/vxBnkz7ZiDjwtNcJzoCz3msR+PJmpc9nCG5II
 V/ismbEo+KsYG2PTTCRftV/YQ+roF+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-4nqdKz90Nca_MbOgQBn6Ww-1; Fri, 19 Jun 2020 12:09:30 -0400
X-MC-Unique: 4nqdKz90Nca_MbOgQBn6Ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C53B918C6EC4;
 Fri, 19 Jun 2020 16:09:29 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-35.rdu2.redhat.com [10.10.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CE7A5D9CA;
 Fri, 19 Jun 2020 16:09:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id AF7BD220390; Fri, 19 Jun 2020 12:09:23 -0400 (EDT)
Date: Fri, 19 Jun 2020 12:09:23 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200619160923.GD3154@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com> <20200618191655.GI2769@work-vm>
 <20200618192717.GE3814@redhat.com> <20200619082746.GA2690@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200619082746.GA2690@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Fri, Jun 19, 2020 at 09:27:46AM +0100, Dr. David Alan Gilbert wrote:
> * Vivek Goyal (vgoyal@redhat.com) wrote:
> > On Thu, Jun 18, 2020 at 08:16:55PM +0100, Dr. David Alan Gilbert wrote:
> > > * Vivek Goyal (vgoyal@redhat.com) wrote:
> > > > On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> > > > > virtiofsd doesn't need of all Linux capabilities(7) available to root.  Keep a
> > > > > whitelisted set of capabilities that we require.  This improves security in
> > > > > case virtiofsd is compromised by making it hard for an attacker to gain further
> > > > > access to the system.
> > > > 
> > > > Hi Stefan,
> > > > 
> > > > I just noticed that this patch set breaks overlayfs on top of virtiofs.
> > > > 
> > > > overlayfs sets "trusted.overlay.*" and xattrs in trusted domain
> > > > need CAP_SYS_ADMIN.
> > > > 
> > > > man xattr says.
> > > > 
> > > >    Trusted extended attributes
> > > >        Trusted  extended  attributes  are  visible and accessible only to pro‐
> > > >        cesses that have the  CAP_SYS_ADMIN  capability.   Attributes  in  this
> > > >        class are used to implement mechanisms in user space (i.e., outside the
> > > >        kernel) which keep information in extended attributes to which ordinary
> > > >        processes should not have access.
> > > > 
> > > > There is a chance that overlay moves away from trusted xattr in future.
> > > > But for now we need to make it work. This is an important use case for
> > > > kata docker in docker build.
> > > > 
> > > > May be we can add an option to virtiofsd say "--add-cap <capability>" and
> > > > ask user to pass in "--add-cap cap_sys_admin" if they need to run daemon
> > > > with this capaibility.
> > > 
> > > I'll admit I don't like the idea of giving it cap_sys_admin.
> > > Can you explain:
> > >   a) What overlayfs uses trusted for?
> > 
> > overlayfs stores bunch of metadata and uses "trusted" xattrs for it.
> 
> Tell me more about this metadata.
> Taking a juicy looking one, what does OVL_XATTR_REDIRECT do?

It contains path information which is used for lookup into lower layer.

> Or what happens if I was to write random numbers into OVL_XATTR_NLINK?

Overlay is storing its metadata in trusted.* xattrs. If a user modifies
metadata, then various kind of bad things can happen. I think one can
do some kind of checks on metadata to make sure it does not crash
atleast.

And that's true for any filesystem. Isn't. If user manages to modify
metadata outside of filesystem, then lot of bad things can happen. I
thought that's the reason that people are not comfortable with the
idea of allowing mounting filesystem from inside user namespace because
it makes it easy to mount a hand crafted filesystem.

Anyway, I think overlayfs is just one use case of trusted xattr. Even
if overlayfs moves away from trusted xattr, what about other users.
We need to have a story around how will we support trusted xattrs
safely.


> 
> > >   b) If something nasty was to write junk into the trusted attributes,
> > >     what would happen?
> > 
> > This directory is owned by guest. So it should be able to write
> > anything it wants, as long as process in guest has CAP_SYS_ADMIN, right?
> 
> Well, we shouldn't be able to break/crash/escape into the host; how
> much does overlayfs validate trusted.* it uses?

I thought qemu and kvm are the one who should ensure we should not be
able to break out of sandbox. Kernel implementation could be as 
buggy as it wanted to be. We are working with this security model
that kernel is completely untrusted.

> 
> > >   c) I see overlayfs has a fallback check if xattr isn't supported at
> > > all - what is the consequence?
> > 
> > It falls back to I think read only mode. 
> 
> It looks like the fallback is more subtle to me:
>         /*
>          * Check if upper/work fs supports trusted.overlay.* xattr
>          */
>         err = ovl_do_setxattr(ofs->workdir, OVL_XATTR_OPAQUE, "0", 1, 0);
>         if (err) {
>                 ofs->noxattr = true;
>                 ofs->config.index = false;
>                 ofs->config.metacopy = false;
>                 pr_warn("upper fs does not support xattr, falling back to index=off and metacopy=off.\n");
> 
> but I don't know what index and metacopy are.

They enable certain features in overlayfs. In fact, we fall back to
lesser capability on if we are running on ext4/xfs. For virtiofs, 
we deny the mount completely.

        /*
         * We allowed sub-optimal upper fs configuration and don't want to break
         * users over kernel upgrade, but we never allowed remote upper fs, so
         * we can enforce strict requirements for remote upper fs.
         */
        if (ovl_dentry_remote(ofs->workdir) &&
            (!d_type || !rename_whiteout || ofs->noxattr)) {
                pr_err("upper fs missing required features.\n");
                err = -EINVAL;
                goto out;
        }

> 
> > For a moment forget about overlayfs. Say a user process in guest with
> > CAP_SYS_ADMIN is writing trusted.foo. Should that succeed? Is a
> > passthrough filesystem, so it should go through. But currently it
> > wont.
> 
> As long as any effects of what it writes are contained to the area of
> the filesystem exposed to the guest, yes - however it worries me what
> the consequences of broken trusted metadata is.  If it's delicate enough
> that it's guarded by CAP_SYS_ADMIN someone must have worried about it.

Agreed that we need to look into whether having CAP_SYS_ADMIN allow
virtiofsd to break out of jail. 

May be we need to provide that remapping trusted xattr feature so
that we don't have to have CAP_SYS_ADMIN in init_user_ns and can
provide this emulation even when running in user namespace.

Vivek


