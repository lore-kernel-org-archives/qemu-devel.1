Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B984C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3462073A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w7jKyu4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3462073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT1Qk-00020U-4z
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>) id 1kT1Ol-0001Dd-TX
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>) id 1kT1Oj-00087U-34
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:26:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 11D1720878;
 Thu, 15 Oct 2020 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602761173;
 bh=jlvWDzncWzjj0CkQc8YBItJ3auhIS7cMPtALYoadg/U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=w7jKyu4OD9gTPtmS0kFMmNIa1X+o7PA7ue8sVMq8tNWG3UK0+EWd1jFYsMxflmSfj
 Igx7UK7H8hYd9DaSNIK+A5LRvXDQz4MmXJrSvnUXPoPARkcehg6FbziOGywgGGaJ4l
 RqTycU353H/kbM4UdMDPf/lJ27JqKl7hIBkmKfpI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kT1Od-001Mt3-0U; Thu, 15 Oct 2020 12:26:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 15 Oct 2020 12:26:10 +0100
From: Marc Zyngier <maz@kernel.org>
To: xu910121@sina.com
Subject: Re: Kernel patch cases qemu live migration failed.
In-Reply-To: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: xu910121@sina.com, dave.martin@arm.com,
 kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Received-SPF: pass client-ip=198.145.29.99; envelope-from=maz@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 07:26:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "Dave.Martin" <dave.martin@arm.com>,
 kvmarm <kvmarm@lists.cs.columbia.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

Please don't use my arm.com address anymore, nobody reads it...

On 2020-10-15 05:06, 张东旭 wrote:
> I'm so sorry for disturbing you.
> 
> When I apply this kernel patch：KVM: arm64/sve: System register
> context switch and access support
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/kvm/sys_regs.c?id=73433762fcaeb9d59e84d299021c6b15466c96dd

This patch was only introduced in 5.2, and wasn't supposed to be
backported to anything else.

> qemu live migration will failed with messages：
>               ​qemu-kvm: Invalid value 233 expecting positive value
> <= 232
>               qemu-kvm: Failed to load cpu:cpreg_vmstate_array_len
> New version kernel  exclude ID_AA64ZFR0_EL1 register when host not
> support SVE feature,
> so qemu ioctl kvm(KVM_GET_REG_LIST) will not contain ID_AA64ZFR0_EL1
> register.
> 
> I'm using CentOS Linux kernel, old kernel version：4.18.0-80.11.el8
> (migration source)
>       new kernel version：4.18.0-147.5.el8 (migration destination)
> 
> CentOS linux kernel version 4.18.0-111.el8 applied this patch. So
> 4.18.0-147.5.el8 also applied this patch.
> 
> Migration source and destination hosts have the same hardware, just
> kernel version is different,
> and the hardware on either side of the migration not support SVE.
> 
> Is there some good suggestions，which can make sure old version
> kernel live migration to new version kernel with qemu?

I['m afraid you should take this with your distribution of
choice, unless you can reproduce the problem with mainline kernels.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

