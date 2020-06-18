Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50332C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AB4208C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzWNCcGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AB4208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0Cq-0007Ft-BX
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jm0CC-0006ZY-SC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:27:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jm0C9-0002KT-Ul
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592508448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZitNEfCO8tRQF/K15DCfx0q0lYVaz7ly6Li2zme+H1g=;
 b=OzWNCcGBwu0J91ztnoaljvzvwW3JoVL3NvdtSCpuwvOF2Q/lY6dgphUTkhyqmci1z2vN7e
 Hf05P0IAGkdm0lxIsWKvfPdVCa/thMYw+0TFxBzLRahp2aj5hSrxONjxpUqjzYzO6wnLgd
 EMLFTmSo6vyY34Qf1SxzfraFzI1bXsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-uu81TS37PIOm45csfNGEQQ-1; Thu, 18 Jun 2020 15:27:25 -0400
X-MC-Unique: uu81TS37PIOm45csfNGEQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31617107ACCA;
 Thu, 18 Jun 2020 19:27:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-20.rdu2.redhat.com [10.10.115.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18A561001901;
 Thu, 18 Jun 2020 19:27:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 52882222D7B; Thu, 18 Jun 2020 15:27:17 -0400 (EDT)
Date: Thu, 18 Jun 2020 15:27:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200618192717.GE3814@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com> <20200618191655.GI2769@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200618191655.GI2769@work-vm>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
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

On Thu, Jun 18, 2020 at 08:16:55PM +0100, Dr. David Alan Gilbert wrote:
> * Vivek Goyal (vgoyal@redhat.com) wrote:
> > On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> > > virtiofsd doesn't need of all Linux capabilities(7) available to root.  Keep a
> > > whitelisted set of capabilities that we require.  This improves security in
> > > case virtiofsd is compromised by making it hard for an attacker to gain further
> > > access to the system.
> > 
> > Hi Stefan,
> > 
> > I just noticed that this patch set breaks overlayfs on top of virtiofs.
> > 
> > overlayfs sets "trusted.overlay.*" and xattrs in trusted domain
> > need CAP_SYS_ADMIN.
> > 
> > man xattr says.
> > 
> >    Trusted extended attributes
> >        Trusted  extended  attributes  are  visible and accessible only to pro‐
> >        cesses that have the  CAP_SYS_ADMIN  capability.   Attributes  in  this
> >        class are used to implement mechanisms in user space (i.e., outside the
> >        kernel) which keep information in extended attributes to which ordinary
> >        processes should not have access.
> > 
> > There is a chance that overlay moves away from trusted xattr in future.
> > But for now we need to make it work. This is an important use case for
> > kata docker in docker build.
> > 
> > May be we can add an option to virtiofsd say "--add-cap <capability>" and
> > ask user to pass in "--add-cap cap_sys_admin" if they need to run daemon
> > with this capaibility.
> 
> I'll admit I don't like the idea of giving it cap_sys_admin.
> Can you explain:
>   a) What overlayfs uses trusted for?

overlayfs stores bunch of metadata and uses "trusted" xattrs for it.

>   b) If something nasty was to write junk into the trusted attributes,
>     what would happen?

This directory is owned by guest. So it should be able to write
anything it wants, as long as process in guest has CAP_SYS_ADMIN, right?

>   c) I see overlayfs has a fallback check if xattr isn't supported at
> all - what is the consequence?

It falls back to I think read only mode. 

For a moment forget about overlayfs. Say a user process in guest with
CAP_SYS_ADMIN is writing trusted.foo. Should that succeed? Is a
passthrough filesystem, so it should go through. But currently it
wont.

Thanks
Vivek


