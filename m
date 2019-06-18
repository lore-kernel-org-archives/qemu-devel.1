Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF3C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1885220665
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1885220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdDb2-0005Lp-9N
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 08:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hdDZE-0003cO-Aa
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hdDZC-0007Ap-9b
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:50:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hdDZ5-0006z3-GQ; Tue, 18 Jun 2019 08:50:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7ED9356E7;
 Tue, 18 Jun 2019 12:50:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 030E817CE5;
 Tue, 18 Jun 2019 12:50:17 +0000 (UTC)
Date: Tue, 18 Jun 2019 14:50:15 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190618125015.ury6wbirdrqrrwdl@kamzik.brq.redhat.com>
References: <20190618083442.10407-1-drjones@redhat.com>
 <CAFEAcA9bwbev3efZ=LJPGgObBCbW-WX19fySMusLyMNC5ZExvA@mail.gmail.com>
 <20190618115558.uhygiqryxo4lbb5u@kamzik.brq.redhat.com>
 <CAFEAcA-66=jnVrdKAkY8EtY7BjoB5EscG1S15ABUd6yQij4YFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-66=jnVrdKAkY8EtY7BjoB5EscG1S15ABUd6yQij4YFw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 18 Jun 2019 12:50:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: fix direct kernel boot setup
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 12:58:30PM +0100, Peter Maydell wrote:
> On Tue, 18 Jun 2019 at 12:56, Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Tue, Jun 18, 2019 at 12:02:37PM +0100, Peter Maydell wrote:
> > > On Tue, 18 Jun 2019 at 09:34, Andrew Jones <drjones@redhat.com> wrote:
> > > >
> > > > We need to check ram_end, not ram_size.
> > > >
> > > > Fixes: 852dc64d665f ("hw/arm/boot: Diagnose layouts that put initrd or
> > > > DTB off the end of RAM")
> > > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > > ---
> > > >  hw/arm/boot.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > > > index b2f93f6beff6..8a280ab3ed49 100644
> > > > --- a/hw/arm/boot.c
> > > > +++ b/hw/arm/boot.c
> > > > @@ -1109,7 +1109,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
> > > >                               info->initrd_filename);
> > > >                  exit(1);
> > > >              }
> > > > -            if (info->initrd_start + initrd_size > info->ram_size) {
> > > > +            if (info->initrd_start + initrd_size > ram_end) {
> > > >                  error_report("could not load initrd '%s': "
> > > >                               "too big to fit into RAM after the kernel",
> > > >                               info->initrd_filename);
> > > > --
> > > > 2.20.1
> > >
> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > >
> > > I think I missed this because my test case doesn't have an
> > > initrd -- direct kernel boot works fine if all you're
> > > passing to QEMU is the kernel... I think we could clarify
> > > the commit message a little:
> >
> > I found it using kvm-unit-tests which uses a small initrd to
> > pass environment variables to the guest. All the tests started
> > to report FAIL.
> >
> > >
> > > hw/arm/boot: fix direct kernel boot with initrd
> > >
> > > Fix the condition used to check whether the initrd fits
> > > into RAM; this meant we were spuriously refusing to do
> > > a direct boot of a kernel in some cases if an initrd
> > > was also passed on the command line.
> >
> > Actually I think we need another fix for this error too. We
> > weren't actually refusing do direct boot the kernel, but we
> > should have been. We're missing the 'exit(1)' after the error
> > message.
> 
> Hmm, so we are. Do you want to send a v2 then, which fixes
> that too and fixes up the commit message?

On it's way.

Thanks,
drew

> 
> thanks
> -- PMM

