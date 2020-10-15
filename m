Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B356C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6881B22210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIeXKXbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6881B22210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3Hw-0001B5-D8
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kT3HI-0000Yv-3B
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kT3HE-00078j-Qt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602768399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+++Y27GlKLWEVEq2S9REbyh2iJra991JQ1AQaWmzEM=;
 b=DIeXKXbjDAbvPOq5zxf45Z50x4Hg5BuQZASzchn4HvDDJLJlwJaTIiLZtARzgSG30RFHAx
 cxLrqeFLjQMAbkfBvBO5USml9RUcorMN4KBJQgJCJ4DA6lh1Nx5yUONGnX4QE3HSszf640
 GarXQ83X7Z7Pxvtz2/y/eYY+HxQVnKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-55PDe9xzPA6jCYTWpz_o8A-1; Thu, 15 Oct 2020 09:26:37 -0400
X-MC-Unique: 55PDe9xzPA6jCYTWpz_o8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 815F710AC943;
 Thu, 15 Oct 2020 13:26:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9642B76674;
 Thu, 15 Oct 2020 13:26:32 +0000 (UTC)
Date: Thu, 15 Oct 2020 15:26:29 +0200
From: Andrew Jones <drjones@redhat.com>
To: =?utf-8?B?5byg5Lic5pet?= <xu910121@sina.com>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201015132629.n4k5k7wdruclcrev@kamzik.brq.redhat.com>
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
MIME-Version: 1.0
In-Reply-To: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
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
Cc: "marc.zyngier" <marc.zyngier@arm.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dave.Martin" <dave.martin@arm.com>, kvmarm <kvmarm@lists.cs.columbia.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 12:06:39PM +0800, 张东旭 wrote:
> I'm so sorry for disturbing you.When I apply this kernel patch：KVM: arm64/sve: System register context switch and access supporthttps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/kvm/sys_regs.c?id=73433762fcaeb9d59e84d299021c6b15466c96ddqemu live migration will failed with messages：              ​qemu-kvm: Invalid value 233 expecting positive value <= 232              qemu-kvm: Failed to load cpu:cpreg_vmstate_array_lenNew version kernel  exclude ID_AA64ZFR0_EL1 register when host not support SVE feature, so qemu ioctl kvm(KVM_GET_REG_LIST) will not contain ID_AA64ZFR0_EL1 register.
> I'm using CentOS Linux kernel, old kernel version：4.18.0-80.11.el8 (migration source)					     new kernel version：4.18.0-147.5.el8 (migration destination)
> CentOS linux kernel version 4.18.0-111.el8 applied this patch. So 4.18.0-147.5.el8 also applied this patch.
> Migration source and destination hosts have the same hardware, just kernel version is different, and the hardware on either side of the migration not support SVE.
>  Is there some good suggestions，which can make sure old version kernel live migration to new version kernel with qemu?Thanks a lot.

ARM KVM guests must be run with CPU host passthrough. This means the
host hardware and host kernel versions must be identical in order
to guarantee successful migrations.

That said, upgrading the host kernel without shutting down the guests
is a reasonable thing to try. Unfortunately, in this case, the only
way to do it would be to hack QEMU on the destination to allow this
extra register in KVM_GET_REG_LIST. It should be harmless, as it's
not used. Allowing it is similar to allowing the destination to have
a larger number of registers than the source in KVM_GET_REG_LIST (which
is why the failing test is <=, not ==).

I wouldn't post a real patch to resolve this issue, though, as everything
is working as expected. The failing test is failing because it detected
a risky migration. And, KVM's filtering of registers from KVM_GET_REG_LIST
is also correct, even if previous KVM versions didn't do that. With CPU
models you could request the reg list for a particular model and expect
it to be the same across all kernel versions that support it, but we
don't have those.

Thanks,
drew


