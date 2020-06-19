Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCED2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0612206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQa4G5xO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0612206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmCaB-0000Vp-Tr
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 04:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmCZE-0008Q0-Cv
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 04:40:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmCZC-0005MK-8m
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 04:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592556004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0UjCRqNrbTF8bbBEyh61OzSeE5ji2wrgpidr+AIpVSc=;
 b=aQa4G5xO+h5HtvTyJtLfxZQg1VGF2mnHPss3BCoLaCHrgGJW+DMUKh0TOjSOJEpn2tTzZ+
 f9FUUFomKAIbrQvOuhT+Om1a4ugLbme0PHuElxXgqVda3sm9LP27OCuqSCieYhgbT7XA5a
 4IevUP9tFsVxj3VRdOlrtplrBmYgifE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-QfTCAFwEMQyohGWFv9iFOg-1; Fri, 19 Jun 2020 04:40:01 -0400
X-MC-Unique: QfTCAFwEMQyohGWFv9iFOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35F96184D141;
 Fri, 19 Jun 2020 08:40:00 +0000 (UTC)
Received: from work-vm (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4865E1010403;
 Fri, 19 Jun 2020 08:39:56 +0000 (UTC)
Date: Fri, 19 Jun 2020 09:39:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200619083953.GB2690@work-vm>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com> <20200618191655.GI2769@work-vm>
 <20200618192717.GE3814@redhat.com>
 <CAJFHJrrJzPLatNvw2xC3WYLbzCW0+DB+4UczQHGPBF9p+WGYQA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJFHJrrJzPLatNvw2xC3WYLbzCW0+DB+4UczQHGPBF9p+WGYQA@mail.gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chirantan Ekbote (chirantan@chromium.org) wrote:
> On Fri, Jun 19, 2020 at 4:27 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
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
> 
> Not just that but it needs CAP_SYS_ADMIN in the init namespace[1].  We
> have the same problem.  Our virtiofs process has CAP_SYS_ADMIN in a
> user namespace and it cannot set any trusted or security xattrs.  The
> security xattrs check is at least namespace aware so you only need
> CAP_SYS_ADMIN in the namespace that mounted the fs but that doesn't
> help us much.

It would have been good if you'd mentioned that; it would have saved
Vivek some confusion!

> We ended up working around it by prefixing "user.virtiofs." to the
> xattr name[2], which has its own problems but there was pretty much no
> chance that we would be able to give the fs device CAP_SYS_ADMIN in
> the init namespace.


What problems did you hit with that?  We should standardise the renaming
so we make an on-disc format that's compatible.

Dave

> 
> [1]: https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/5e857ce6eae7ca21b2055cca4885545e29228fe2/fs/xattr.c#116
> [2]: https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/2243111
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


