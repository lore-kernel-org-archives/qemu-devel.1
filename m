Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595A0C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3324121773
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3324121773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs89G-0006x8-Kl
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hs88f-00061P-7w
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hs88e-0007lY-5a
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:04:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hs88d-0007jP-Ek
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:04:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 592D6C055673;
 Mon, 29 Jul 2019 16:04:38 +0000 (UTC)
Received: from localhost (ovpn-116-93.gru2.redhat.com [10.97.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E4BA60856;
 Mon, 29 Jul 2019 16:04:37 +0000 (UTC)
Date: Mon, 29 Jul 2019 13:04:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190729160434.GC4313@habkost.net>
References: <20190716155808.25010-1-paul.c.lai@intel.com>
 <1a33ae335f396d49689425e0137213efd9f28a7c.camel@suse.com>
 <CAFEAcA9Rmw6L7O9=r_H3fv=1kFdthC+s0W5q=6UCkrPF-oWcZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Rmw6L7O9=r_H3fv=1kFdthC+s0W5q=6UCkrPF-oWcZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 29 Jul 2019 16:04:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Fixing Snowridge CPU model name and features
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
Cc: "luwei.kang@intel.com" <luwei.kang@intel.com>,
 "paul.c.lai@intel.com" <paul.c.lai@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bruce Rogers <BROGERS@suse.com>, "wei.w.wang@intel.com" <wei.w.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "tao3.xu@intel.com" <tao3.xu@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 29, 2019 at 04:46:01PM +0100, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 16:42, Bruce Rogers <BROGERS@suse.com> wrote:
> >
> > On Tue, 2019-07-16 at 08:58 -0700, Paul Lai wrote:
> > > Changing the name to Snowridge from SnowRidge-Server.
> > > There is no client model of Snowridge, so "-Server" is unnecessary.
> > >
> > > Removing CPUID_EXT_VMX from Snowridge cpu feature list.
> > >
> > > Signed-off-by: Paul Lai <paul.c.lai@intel.com>
> > > Tested-by: Tao3 Xu <tao3.xu@intel.com>
> > > ---
> > >  target/i386/cpu.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 63d89276fe..7f56e887ae 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -2688,7 +2688,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
> > >          .model_id = "Intel Xeon Processor (Icelake)",
> > >      },
> > >      {
> > > -        .name = "SnowRidge-Server",
> > > +        .name = "Snowridge",
> > >          .level = 27,
> > >          .vendor = CPUID_VENDOR_INTEL,
> > >          .family = 6,
> > > @@ -2706,7 +2706,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
> > >              CPUID_FXSR | CPUID_SSE | CPUID_SSE2,
> > >          .features[FEAT_1_ECX] =
> > >              CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_MONITOR
> > > |
> > > -            CPUID_EXT_VMX |
> > >              CPUID_EXT_SSSE3 |
> > >              CPUID_EXT_CX16 |
> > >              CPUID_EXT_SSE41 |
> >
> > What is the status of this patch with respect to the v4.1.0 release?
> > It would seem to me that it was targeted for this release, to get the
> > name and features right before codified in a released version, but
> > Intel would know better.
> 
> If nobody picks it up this afternoon then it has (probably) missed the boat.
> Not ccing any of the target/i386 maintainers or putting "for-4.1"
> in the subject line is probably why it got missed. Eduardo/Paolo/Richard ?

I'll pick it and send a pull request ASAP.

-- 
Eduardo

