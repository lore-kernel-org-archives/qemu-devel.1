Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD736C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955BB208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955BB208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hflTS-0006Rr-49
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hflEK-0003cv-Nm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hflEG-0002J1-LW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:11:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hflEE-0002E7-KK
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:11:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C184788305;
 Tue, 25 Jun 2019 13:11:08 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 438215D9D3;
 Tue, 25 Jun 2019 13:11:07 +0000 (UTC)
Date: Tue, 25 Jun 2019 10:11:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190625131105.GO1862@habkost.net>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-7-ehabkost@redhat.com>
 <ace5bfc8-7b05-d1ab-bada-271cf82ec4ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace5bfc8-7b05-d1ab-bada-271cf82ec4ae@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 25 Jun 2019 13:11:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/6] i386: Add Cascadelake-Server-4.1.1 CPU
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, jingqi.liu@intel.com, "Lai,
 Paul C" <paul.c.lai@intel.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Hu,
 Robert" <robert.hu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 01:35:17PM +0800, Tao Xu wrote:
> On 6/25/2019 1:00 PM, Eduardo Habkost wrote:
> > Add new version of Cascadelake-Server CPU model, setting
> > stepping=5 and enabling the IA32_ARCH_CAPABILITIES MSR.
> > 
> > The new feature will introduce a new host software requirement,
> > breaking our CPU model runnability promises.  This means we can't
> > enable the new CPU model version by default in QEMU 4.1, because
> > management software isn't ready yet to resolve CPU model aliases.
> > This is why the feature is being enabled in a
> > Cascadelake-Server-4.1.1 CPU model instead of
> > Cascadelake-Server-4.1.
> > 
> > Includes a test case to ensure the right combinations of
> > machine-type + CPU model + command-line feature flags will work
> > as expected.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Cc: "Hu, Robert" <robert.hu@intel.com>
> > Cc: Tao Xu <tao3.xu@intel.com>
> > Cc: jingqi.liu@intel.com,
> > Cc: "Lai, Paul C" <paul.c.lai@intel.com>
> > ---
> >   target/i386/cpu.c                          | 15 +++++
> >   tests/acceptance/x86_cpu_model_versions.py | 71 ++++++++++++++++++++++
> >   2 files changed, 86 insertions(+)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 121f568954..8edae04161 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2607,6 +2607,21 @@ static X86CPUDefinition builtin_x86_defs[] = {
> ...
> > +        # versioned CPU model overrides machine-type:
> > +        vm = self.get_vm()
> > +        vm.add_args('-S')
> > +        vm.set_machine('pc-i440fx-4.0')
> > +        vm.add_args('-cpu', 'Cascadelake-Server-4.1,x-force-features=on,check=off,enforce=off')
> > +        vm.launch()
> > +        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> > +                         'pc-i440fx-4.1 + Cascadelake-Server-4.1 should not have arch-capabilities')
> > +
> > +        vm = self.get_vm()
> > +        vm.add_args('-S')
> > +        vm.set_machine('pc-i440fx-4.0')
> > +        vm.add_args('-cpu', 'Cascadelake-Server-4.1.1,x-force-features=on,check=off,enforce=off')
> > +        vm.launch()
> > +        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
> > +                         'pc-i440fx-4.1 + Cascadelake-Server-4.1 should have arch-capabilities')
> Hi Eduardo
> 
> Could me ask why here the error show "Cascadelake-Server-4.1" instead of
> "Cascadelake-Server-4.1.1"?

My mistake.  Will fix it.

> 
> And will you add the MSR_ARCH_CAP_RDCL_NO, MSR_ARCH_CAP_IBRS_ALL, and
> MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY into .features[FEAT_ARCH_CAPABILITIES]?

I will do it.  I don't know why I didn't notice them in the "Add
some MSR based features on Cascadelake-Server CPU model" patches
you sent.

-- 
Eduardo

