Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD7FC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A34821473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A34821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7WL-0001iM-BG
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43353)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hi3q6-00042C-65
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hi3pz-0007bV-V1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hi3pu-0007Yj-Gq
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 695FC356C4;
 Mon,  1 Jul 2019 21:27:33 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD70060852;
 Mon,  1 Jul 2019 21:27:32 +0000 (UTC)
Date: Mon, 1 Jul 2019 17:38:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Message-ID: <20190701203839.GG5198@habkost.net>
References: <20190628002844.24894-1-ehabkost@redhat.com>
 <20190628002844.24894-10-ehabkost@redhat.com>
 <612a3fdf-6525-a428-ebd5-b951c333bf2f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612a3fdf-6525-a428-ebd5-b951c333bf2f@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 01 Jul 2019 21:27:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 9/9] i386: Add Cascadelake-Server-v2 CPU
 model
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, jingqi.liu@intel.com,
 Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Hu, Robert" <robert.hu@intel.com>,
 Jiri Denemark <jdenemar@redhat.com>, "Lai, Paul C" <paul.c.lai@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 03:23:31PM +0800, Xiaoyao Li wrote:
> On 6/28/2019 8:28 AM, Eduardo Habkost wrote:
> > Add new version of Cascadelake-Server CPU model, setting
> > stepping=5 and enabling the IA32_ARCH_CAPABILITIES MSR
> > with some flags.
> > 
> > The new feature will introduce a new host software requirement,
> > breaking our CPU model runnability promises.  This means we can't
> > enable the new CPU model version by default in QEMU 4.1, because
> > management software isn't ready yet to resolve CPU model aliases.
> > This is why "pc-*-4.1" will keep returning Cascadelake-Server-v1
> > if "-cpu Cascadelake-Server" is specified.
> > 
> > Includes a test case to ensure the right combinations of
> > machine-type + CPU model + command-line feature flags will work
> > as expected.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * Enable rdctl-no, ibrs-all, skip-l1dfl-vmentry
> >    (Suggested by Tao Xu)
> > 
> > Cc: "Hu, Robert" <robert.hu@intel.com>
> > Cc: Tao Xu <tao3.xu@intel.com>
> > Cc: jingqi.liu@intel.com,
> > Cc: "Lai, Paul C" <paul.c.lai@intel.com>
> > ---
> >   target/i386/cpu.c                          | 14 +++++
> >   tests/acceptance/x86_cpu_model_versions.py | 73 ++++++++++++++++++++++
> >   2 files changed, 87 insertions(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 10a09c971a..570890a7dd 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2343,6 +2343,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
> >               CPUID_6_EAX_ARAT,
> >           .xlevel = 0x80000008,
> >           .model_id = "Intel Xeon Processor (Cascadelake)",
> > +        .versions = (X86CPUVersionDefinition[]) {
> > +            { .version = 1 },
> > +            { .version = 2,
> > +              .props = (PropValue[]) {
> > +                  { "stepping", "5" },
> 
> Stepping should be 6?

Yes, my mistake.

> 
> > +                  { "arch-capabilities", "on" },
> > +                  { "rdctl-no", "on" },
> > +                  { "ibrs-all", "on" },
> > +                  { "skip-l1dfl-vmentry", "on" },
> 
> rdmsr 0x10AH returns 0x2b from host Cascadelake, we'd better add feature
> "mds-no" too. Otherwise we will need another version for that feature.

Thanks for the info, I will update it in the next version.

> [...]

-- 
Eduardo

