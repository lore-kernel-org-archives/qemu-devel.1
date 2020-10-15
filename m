Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8AFC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3051B2223F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cvk4qSEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3051B2223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3Ri-0002g6-7c
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kT3Q0-0000gt-4d
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kT3Px-0008JB-TH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602768941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KO6fi08NfGByxXZfKo9I5VP3nl/DbBwbTw76hSITJQ=;
 b=Cvk4qSEdOcz93FHN/d4KDLHwVPPNo3VF4x1rrieGsYrdPXA9fAestyjaXkE/CGMJyYK0F+
 j23RvMBVSlzf8kofi+kkp7vxMgItDquD6Gs/NSLV7Wo5ESe+sZju4MFJZQp+SweFc3qRW6
 2R6ifkLj8kQOomXGrELivvpy5tCPZJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-t3pzo8Y2PzSqLcRVUCrWHg-1; Thu, 15 Oct 2020 09:35:31 -0400
X-MC-Unique: t3pzo8Y2PzSqLcRVUCrWHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 762AA5705E;
 Thu, 15 Oct 2020 13:35:09 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D088A76663;
 Thu, 15 Oct 2020 13:35:07 +0000 (UTC)
Date: Thu, 15 Oct 2020 15:35:05 +0200
From: Andrew Jones <drjones@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
MIME-Version: 1.0
In-Reply-To: <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: kvmarm <kvmarm@lists.cs.columbia.edu>, xu910121@sina.com,
 qemu-devel <qemu-devel@nongnu.org>, "Dave.Martin" <dave.martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 12:26:10PM +0100, Marc Zyngier wrote:
> Hi
> 
> Please don't use my arm.com address anymore, nobody reads it...
> 
> On 2020-10-15 05:06, 张东旭 wrote:
> > I'm so sorry for disturbing you.
> > 
> > When I apply this kernel patch：KVM: arm64/sve: System register
> > context switch and access support
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/kvm/sys_regs.c?id=73433762fcaeb9d59e84d299021c6b15466c96dd
> 
> This patch was only introduced in 5.2, and wasn't supposed to be
> backported to anything else.

All upstream patches are backport candidates. Welcome to RHEL :-)

> 
> > qemu live migration will failed with messages：
> >               ​qemu-kvm: Invalid value 233 expecting positive value
> > <= 232
> >               qemu-kvm: Failed to load cpu:cpreg_vmstate_array_len
> > New version kernel  exclude ID_AA64ZFR0_EL1 register when host not
> > support SVE feature,
> > so qemu ioctl kvm(KVM_GET_REG_LIST) will not contain ID_AA64ZFR0_EL1
> > register.
> > 
> > I'm using CentOS Linux kernel, old kernel version：4.18.0-80.11.el8
> > (migration source)
> >       new kernel version：4.18.0-147.5.el8 (migration destination)
> > 
> > CentOS linux kernel version 4.18.0-111.el8 applied this patch. So
> > 4.18.0-147.5.el8 also applied this patch.
> > 
> > Migration source and destination hosts have the same hardware, just
> > kernel version is different,
> > and the hardware on either side of the migration not support SVE.
> > 
> > Is there some good suggestions，which can make sure old version
> > kernel live migration to new version kernel with qemu?
> 
> I['m afraid you should take this with your distribution of
> choice, unless you can reproduce the problem with mainline kernels.

I'll bet this reproduces when migrating from a mainline pre SVE register
filtering kernel to a mainline that does the filtering. I don't have
time to test that though.

Thanks,
drew


