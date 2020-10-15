Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE95FC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C7620663
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYovgX3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C7620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3tt-0000Ly-Oc
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>) id 1kT3gO-0003nC-Nn
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maz@kernel.org>) id 1kT3gM-00023i-Js
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:52:40 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C4B422222B;
 Thu, 15 Oct 2020 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602769956;
 bh=xarXKYZ8s+xHzOaOdBDdrKmal0xGW3EEb9e3ttVwQAg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aYovgX3/go3eG/ZbCmpQGRKnh9z5m7oWFIjx02kMEtmPXNzYE1JjO31kXpusbaeuU
 Rf2KrjwgM5OFSnhgQbmMevkh9IJM6bEp3jvhorN7Twx8caRis8VNIlFS2v5KmPH2vR
 8Gzar2oZW80L6/oh0qW1Crk98JSJAYlz9/aCGkdE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1kT3gI-001OiW-M4; Thu, 15 Oct 2020 14:52:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 15 Oct 2020 14:52:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: Kernel patch cases qemu live migration failed.
In-Reply-To: <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
 <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: drjones@redhat.com, xu910121@sina.com, qemu-devel@nongnu.org,
 dave.martin@arm.com, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Received-SPF: pass client-ip=198.145.29.99; envelope-from=maz@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:52:37
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
Cc: kvmarm <kvmarm@lists.cs.columbia.edu>, xu910121@sina.com,
 qemu-devel <qemu-devel@nongnu.org>, "Dave.Martin" <dave.martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-10-15 14:35, Andrew Jones wrote:
> On Thu, Oct 15, 2020 at 12:26:10PM +0100, Marc Zyngier wrote:
>> Hi
>> 
>> Please don't use my arm.com address anymore, nobody reads it...
>> 
>> On 2020-10-15 05:06, 张东旭 wrote:
>> > I'm so sorry for disturbing you.
>> >
>> > When I apply this kernel patch：KVM: arm64/sve: System register
>> > context switch and access support
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/kvm/sys_regs.c?id=73433762fcaeb9d59e84d299021c6b15466c96dd
>> 
>> This patch was only introduced in 5.2, and wasn't supposed to be
>> backported to anything else.
> 
> All upstream patches are backport candidates. Welcome to RHEL :-)

Great! RHEL gets to keep the pieces! ;-)

> 
>> 
>> > qemu live migration will failed with messages：
>> >               ​qemu-kvm: Invalid value 233 expecting positive value
>> > <= 232
>> >               qemu-kvm: Failed to load cpu:cpreg_vmstate_array_len
>> > New version kernel  exclude ID_AA64ZFR0_EL1 register when host not
>> > support SVE feature,
>> > so qemu ioctl kvm(KVM_GET_REG_LIST) will not contain ID_AA64ZFR0_EL1
>> > register.
>> >
>> > I'm using CentOS Linux kernel, old kernel version：4.18.0-80.11.el8
>> > (migration source)
>> >       new kernel version：4.18.0-147.5.el8 (migration destination)
>> >
>> > CentOS linux kernel version 4.18.0-111.el8 applied this patch. So
>> > 4.18.0-147.5.el8 also applied this patch.
>> >
>> > Migration source and destination hosts have the same hardware, just
>> > kernel version is different,
>> > and the hardware on either side of the migration not support SVE.
>> >
>> > Is there some good suggestions，which can make sure old version
>> > kernel live migration to new version kernel with qemu?
>> 
>> I['m afraid you should take this with your distribution of
>> choice, unless you can reproduce the problem with mainline kernels.
> 
> I'll bet this reproduces when migrating from a mainline pre SVE 
> register
> filtering kernel to a mainline that does the filtering. I don't have
> time to test that though.

Probably. I'm not really sure where to find SVE HW though, other
than emulation...

         M.
-- 
Jazz is not dead. It just smells funny...

