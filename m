Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B45BC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A3522268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX4ojNCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A3522268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVQq-0005Bt-DO
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kUVPR-0003pi-Dd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:41:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kUVPH-00077a-VN
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 09:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603114857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sNWBV7BLvG0+SkFKmi7DuKB8loiT1Sr1513NgBfdFUs=;
 b=ZX4ojNChoAhsnglBDbXrNwcBConUF7P9T3MGWB+B1EJlvWnqKX/Gm0sHpIrQhSr6p/hvq5
 ssa78746est8QDreJFI93qoGInrmRQ9oi+iivHRo9o12WPSZSVaGYJXmHPk5umhT51sHY0
 rRI8SYBV+oqp33aOzN2e0WgS6pmQ314=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-Xg-WiyYnPbuoOdNeSt-X_w-1; Mon, 19 Oct 2020 09:40:50 -0400
X-MC-Unique: Xg-WiyYnPbuoOdNeSt-X_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41F2B803F41;
 Mon, 19 Oct 2020 13:40:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70C175D9D2;
 Mon, 19 Oct 2020 13:40:46 +0000 (UTC)
Date: Mon, 19 Oct 2020 15:40:43 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201019134043.vqusmzhqp7owjt6x@kamzik.brq.redhat.com>
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
 <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
 <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
 <20201019113157.GN32292@arm.com>
 <CAFEAcA8oncKmGxKGEZBg9Pnm4hjSO8u9KSv4YxFWxX0+LJ5E2g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8oncKmGxKGEZBg9Pnm4hjSO8u9KSv4YxFWxX0+LJ5E2g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Marc Zyngier <maz@kernel.org>, xu910121@sina.com,
 Dave Martin <Dave.Martin@arm.com>, kvmarm <kvmarm@lists.cs.columbia.edu>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 12:43:33PM +0100, Peter Maydell wrote:
> On Mon, 19 Oct 2020 at 12:32, Dave Martin <Dave.Martin@arm.com> wrote:
> > I'm not quite sure about Peter's assessment here.
> >
> > I agree with the inconsistency identified here: we always enumerate all
> > unallocated ID regs, but we enumerate ID_AA64ZFR0_EL1 conditionally.
> > This doesn't feel right: on a non-SVE guest, ID_AA64ZFR0_EL1 should
> > behave exactly as an unallocated ID register.
> >
> > I'm not sure about the proposed fix.
> >
> > For one thing, I'm not sure that old hosts will accept writing of 0 to
> > arbitrary ID regs.  This may require some digging, but commit
> > 93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features from guests")
> > may be the place to start.
> 
> Well, ID regs are special in the architecture -- they always exist
> and must RAZ/WI, even if they're not actually given any fields yet.
> This is different from other "unused" parts of the system register
> encoding space, which UNDEF.

Table D12-2 confirms the register should be RAZ, as it says the register
is "RO, but RAZ if SVE is not implemented". Does "RO" imply "WI", though?
For the guest we inject an exception on writes, and for userspace we
require the value to be preserved on write.

> 
> Older hosts didn't permit writing 0 to all parts of the ID
> register space (and didn't list all ID registers in the KVM_GET_REG_LIST
> list), but that was a kernel bug which we've since fixed.
> (QEMU has workaround code for pre-4.15 kernels for this.)
> Across that older bugfix, migration works from an old kernel to
> a newer one, but wouldn't have worked from a post-bugfix kernel
> to a pre-4.15 one.
> 
> > My original idea was that at the source end we should be conservative:
> > enumerate and dump the minimum set of registers relevant to the
> > target -- for compatibility with old hosts that don't handle the
> > unallocated ID regs at all.  At the destination end, modern hosts
> > should be permissive, i.e., allow any ID reg to be set to 0, but don't
> > require the setting of any reg that older source hosts might not send.
> 
> The problem is that you've actually removed registers from
> the list that were previously in it (because pre-SVE
> kernels put this ID register in the list as a RAZ/WI register,
> and now it's not in the list if SVE isn't supported).
> 
> > So, I think that instead of changing the ID_AA64ZFR0_EL1 behaviour,
> > parhaps we should move all ID_UNALLOCATED() regs (and possibly
> > ID_HIDDEN(), not sure about that) to have REG_HIDDEN_USER visibility.
> 
> What does this do as far as the user-facing list-of-registers
> is concerned? All these registers need to remain in the
> KVM_GET_REG_LIST list, or you break migration from an old
> kernel to a new one.

I think we should follow the spec, even for userspace access, and be RAZ
for when the feature isn't implemented. As for writes, assuming the
exception injection is what we want for the guest (not WI), then that's
correct. For userspace, I think we should continue forcing preservation
(which will force preservation of zero when it's RAZ).

Thanks,
drew


