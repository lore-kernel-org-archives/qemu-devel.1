Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B35C47404
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 01:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625D320679
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 01:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625D320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ67H-0005Cm-DZ
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 21:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iJ66K-0004lb-J4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 21:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iJ66I-00033Y-4Y
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 21:21:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iJ66H-0002xl-VG
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 21:21:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0264E3086272;
 Sat, 12 Oct 2019 01:21:39 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEA005C1B2;
 Sat, 12 Oct 2019 01:21:35 +0000 (UTC)
Date: Fri, 11 Oct 2019 22:21:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2] target/i386: Add Snowridge-v2 (noMPX) CPU model
Message-ID: <20191012012134.GJ4084@habkost.net>
References: <20191011145349.123425-1-xiaoyao.li@intel.com>
 <20191011182143.GD4084@habkost.net>
 <e89e2380-8d3c-621f-6534-9ec783405b11@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89e2380-8d3c-621f-6534-9ec783405b11@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Sat, 12 Oct 2019 01:21:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 12, 2019 at 09:15:56AM +0800, Xiaoyao Li wrote:
> On 10/12/2019 2:21 AM, Eduardo Habkost wrote:
> > On Fri, Oct 11, 2019 at 10:53:49PM +0800, Xiaoyao Li wrote:
> > > Add new version of Snowridge CPU model that removes MPX feature.
> > > 
> > > MPX support is being phased out by Intel. GCC has dropped it, Linux kernel
> > > and kvm are also going to do that in the future.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > ---
> > > Changes in v2:
> > >      - Use CPU model versioning mechanism instead of machine-type compat
> > > ---
> > >   target/i386/cpu.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 44f1bbdcac76..27b0a17b46a8 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -2793,6 +2793,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
> > >               CPUID_6_EAX_ARAT,
> > >           .xlevel = 0x80000008,
> > >           .model_id = "Intel Atom Processor (SnowRidge)",
> > > +        .versions = (X86CPUVersionDefinition[]) {
> > > +            { .version = 1 },
> > > +            {
> > > +                .version = 2,
> > > +                .alias = "Snowridge-noMPX",
> > 
> > The intention is to stop creating new funny names for CPU model
> > variations, now, and stick to -v1, -v2, -v3, etc.
> > 
> > The .alias field is optional, and was added only for
> > compatibility with the existing -noTSX and -IBRS CPU models.
> 
> Got it.
> 
> > > +                .props = (PropValue[]) {
> > > +                    { "mpx", "off" },
> > > +                    { "model-id", "Intel Atom Processor (Snowridge, no MPX)" },
> > 
> > Do you think it's important to report a different model-id?
> > I would keep it the same and only add mpx=off.
> 
> I just want to let user know easily the differences between Snowridge-v1 and
> Snowridge-v2. Unfortunately, it seems ugly.
> 
> When testing with Cascadelake-Server, it puzzles every time that which one
> should I choose between Cascadelake-Server-v1 and Cascadelake-Server-v2.
> From the output of "-cpu ?", I don't know the differences between them.
> Everytime I have to go to the source code to see the difference.
> 
> Maybe there is a way to see/report the differences between different
> versions of the same CPU model that I just don't know?

Good point.  I forgot that model-id is also the model description
in "-cpu ?".

Well, it doesn't hurt to have a different model-id in v2 that's
more informative.  Feel free to keep the model-id line in v3.

Thanks!

-- 
Eduardo

