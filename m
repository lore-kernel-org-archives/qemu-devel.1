Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD023C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFF1207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhXWZdny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFF1207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlzuL-0001Ke-Un
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jlztm-0000oI-4L
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:08:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1jlztj-0007Xu-UO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592507306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biL937nVRWE2AZIUC24vk6ZKO9vvm4VOV8K5gKjdplo=;
 b=GhXWZdnycZRssuaR+ITNUrCq2OgQouFZFXFr0aptueDE/bc5ovlLQJRIe2pMH++3BNwOBw
 S216Cj5c4Ga9rkyhGXh95C8VkU2r+TErala8m1cinDmGMFUFAIefKmQ2C9UgDGFDCCFR8d
 TZiWvnwvTgueOC/0+ewpEk9Trb2+75E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-TD5zNElmOlCmN9J_uVNaGQ-1; Thu, 18 Jun 2020 15:08:24 -0400
X-MC-Unique: TD5zNElmOlCmN9J_uVNaGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 368EB84638E;
 Thu, 18 Jun 2020 19:08:23 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-20.rdu2.redhat.com [10.10.115.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA2795C1D0;
 Thu, 18 Jun 2020 19:08:16 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 2CD83222D7B; Thu, 18 Jun 2020 15:08:16 -0400 (EDT)
Date: Thu, 18 Jun 2020 15:08:16 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200618190816.GD3814@redhat.com>
References: <20200416164907.244868-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200416164907.244868-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 15:08:26
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
 Miklos Szeredi <miklos@szeredi.hu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> virtiofsd doesn't need of all Linux capabilities(7) available to root.  Keep a
> whitelisted set of capabilities that we require.  This improves security in
> case virtiofsd is compromised by making it hard for an attacker to gain further
> access to the system.

Hi Stefan,

I just noticed that this patch set breaks overlayfs on top of virtiofs.

overlayfs sets "trusted.overlay.*" and xattrs in trusted domain
need CAP_SYS_ADMIN.

man xattr says.

   Trusted extended attributes
       Trusted  extended  attributes  are  visible and accessible only to pro‐
       cesses that have the  CAP_SYS_ADMIN  capability.   Attributes  in  this
       class are used to implement mechanisms in user space (i.e., outside the
       kernel) which keep information in extended attributes to which ordinary
       processes should not have access.

There is a chance that overlay moves away from trusted xattr in future.
But for now we need to make it work. This is an important use case for
kata docker in docker build.

May be we can add an option to virtiofsd say "--add-cap <capability>" and
ask user to pass in "--add-cap cap_sys_admin" if they need to run daemon
with this capaibility.

Thanks
Vivek

> 
> Stefan Hajnoczi (2):
>   virtiofsd: only retain file system capabilities
>   virtiofsd: drop all capabilities in the wait parent process
> 
>  tools/virtiofsd/passthrough_ll.c | 51 ++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> -- 
> 2.25.1
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs


