Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C860AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0629F2076B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RH7MHpwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0629F2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4Sg-0008EF-Vz
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kT4RV-0007NM-Jb
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kT4RP-0000Zz-Rf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602772874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5RTNCrw0RODvdauKSr4JiAfyx2/X/h6Lfcvw2l0Yu4=;
 b=RH7MHpwTvlAyd9sypnrzv8Y1G3utLEMMEVt3IYn4j/YUVxPVz4X/E4dUZHCZEWEDQ2zbWU
 eP+RlzruIt+W26RWic5n8FPCzYM3WNSIdiBBdS8bTId5/bhN2G9u6Ks4UOLa2vje8Rt29X
 mi47gND0qf4ZLvZvO+87+6/zaEcCDQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-6QZb6IlfNneyBb4Ko5Ho8Q-1; Thu, 15 Oct 2020 10:41:10 -0400
X-MC-Unique: 6QZb6IlfNneyBb4Ko5Ho8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02CC780363D;
 Thu, 15 Oct 2020 14:41:09 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01E2455798;
 Thu, 15 Oct 2020 14:41:06 +0000 (UTC)
Date: Thu, 15 Oct 2020 16:41:04 +0200
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
 <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
MIME-Version: 1.0
In-Reply-To: <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Dave.Martin" <dave.martin@arm.com>, xu910121@sina.com,
 kvmarm <kvmarm@lists.cs.columbia.edu>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 02:52:34PM +0100, Marc Zyngier wrote:
> On 2020-10-15 14:35, Andrew Jones wrote:
> > On Thu, Oct 15, 2020 at 12:26:10PM +0100, Marc Zyngier wrote:
> > > Hi
> > > 
> > > Please don't use my arm.com address anymore, nobody reads it...
> > > 
> > > On 2020-10-15 05:06, 张东旭 wrote:
> > > > I'm so sorry for disturbing you.
> > > >
> > > > When I apply this kernel patch：KVM: arm64/sve: System register
> > > > context switch and access support
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/kvm/sys_regs.c?id=73433762fcaeb9d59e84d299021c6b15466c96dd
> > > 
> > > This patch was only introduced in 5.2, and wasn't supposed to be
> > > backported to anything else.
> > 
> > All upstream patches are backport candidates. Welcome to RHEL :-)
> 
> Great! RHEL gets to keep the pieces! ;-)
> 
> > 
> > > 
> > > > qemu live migration will failed with messages：
> > > >               ​qemu-kvm: Invalid value 233 expecting positive value
> > > > <= 232
> > > >               qemu-kvm: Failed to load cpu:cpreg_vmstate_array_len
> > > > New version kernel  exclude ID_AA64ZFR0_EL1 register when host not
> > > > support SVE feature,
> > > > so qemu ioctl kvm(KVM_GET_REG_LIST) will not contain ID_AA64ZFR0_EL1
> > > > register.
> > > >
> > > > I'm using CentOS Linux kernel, old kernel version：4.18.0-80.11.el8
> > > > (migration source)
> > > >       new kernel version：4.18.0-147.5.el8 (migration destination)
> > > >
> > > > CentOS linux kernel version 4.18.0-111.el8 applied this patch. So
> > > > 4.18.0-147.5.el8 also applied this patch.
> > > >
> > > > Migration source and destination hosts have the same hardware, just
> > > > kernel version is different,
> > > > and the hardware on either side of the migration not support SVE.
> > > >
> > > > Is there some good suggestions，which can make sure old version
> > > > kernel live migration to new version kernel with qemu?
> > > 
> > > I['m afraid you should take this with your distribution of
> > > choice, unless you can reproduce the problem with mainline kernels.
> > 
> > I'll bet this reproduces when migrating from a mainline pre SVE register
> > filtering kernel to a mainline that does the filtering. I don't have
> > time to test that though.
> 
> Probably. I'm not really sure where to find SVE HW though, other
> than emulation...
>

The reporter states neither the source nor destination hardware supports
SVE. My guess is that what's happening is the reserved ID register
ID_UNALLOCATED(4,4) was showing up in the KVM_GET_REG_LIST count on
the old kernel, but the new kernel filters it out. Maybe it is a
bug to filter it out of the count, as it's a reserved ID register and
I suppose the other reserved ID registers are still showing up?

Thanks,
drew 


