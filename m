Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A11C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC772075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3zW10lI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC772075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZXD-00081f-Iq
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAZWL-0006yW-Ch
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:01:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22486
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAZWJ-00012z-0h
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598364109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ebP7aJVZ+3IQy7pSpxcFjrP/RdzbhDrAkBTyvoXT+6A=;
 b=E3zW10lI5adFCw3+QI62nuHEmImfp8wzXtxsHltxNKLSYGrxXEoNoGfkBXpPP8H3Knu4kY
 Z6/KO5Xo/umgDCCsbqaGarq5HTZOeVrsomleBgsHYeC1pcg3YfbYuPaBUz4XFJRTLKMz3M
 xR+YB8WuhbkH0bxlRIoL76S9XzWPmA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-L1hM0P1aP_2xOhJolDK8Sg-1; Tue, 25 Aug 2020 10:01:47 -0400
X-MC-Unique: L1hM0P1aP_2xOhJolDK8Sg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D0A580F043;
 Tue, 25 Aug 2020 14:01:46 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40CF85C1CF;
 Tue, 25 Aug 2020 14:01:46 +0000 (UTC)
Date: Tue, 25 Aug 2020 10:01:45 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 2/2] target/i386: Add missed features to Cooperlake CPU
 model
Message-ID: <20200825140145.GU642093@habkost.net>
References: <20191225063018.20038-1-xiaoyao.li@intel.com>
 <20191225063018.20038-3-xiaoyao.li@intel.com>
 <20200824220759.GS642093@habkost.net>
 <9cdaaa8d-4ce2-88c7-2400-eed62ffe779b@intel.com>
MIME-Version: 1.0
In-Reply-To: <9cdaaa8d-4ce2-88c7-2400-eed62ffe779b@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:37:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Cathy Zhang <cathy.zhang@intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 08:20:35AM +0800, Xiaoyao Li wrote:
> On 8/25/2020 6:07 AM, Eduardo Habkost wrote:
> > On Wed, Dec 25, 2019 at 02:30:18PM +0800, Xiaoyao Li wrote:
> > > It lacks VMX features and two security feature bits (disclosed recently) in
> > > MSR_IA32_ARCH_CAPABILITIES in current Cooperlake CPU model, so add them.
> > > 
> > > Fixes: 22a866b6166d ("i386: Add new CPU model Cooperlake")
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > ---
> > >   target/i386/cpu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 50 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index e1eb9f473989..c9798ac8652b 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -3198,7 +3198,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
> > >               CPUID_7_0_EDX_SPEC_CTRL_SSBD | CPUID_7_0_EDX_ARCH_CAPABILITIES,
> > >           .features[FEAT_ARCH_CAPABILITIES] =
> > >               MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
> > > -            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO,
> > > +            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
> > > +            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO,
> > 
> > This seems to break on some Cooperlake hosts, see:
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=1860743
> > 
> > Are all Cooperlake hosts supposed to have TAA_NO set?  Are there
> > hosts where this requires a microcode update to be installed?
> > 
> 
> All the production CPX in market should have IAA_NO bit. We can check it
> directly with rdmsr(0x10a).
> 
> The problem of this issue is due to commit db616173d787 ("x86/tsx: Add
> config options to set tsx=on|off|auto"), which sets the default to "off" for
> 100% safety. However, default to off may cause noticeable regressions on TSX
> safe platform, e.g., CPX.
> 
> Maybe we need to set CONFIG_X86_INTEL_TSX_MODE_AUTO=y for OSV released
> kernel?

Considering that disabling TSX is a policy decision likely to be
taken by the OS vendor or by the system administrator, we could
at least make the CPU model easier to use on those cases.

Maybe we should provide a version of Cooperlake without TSX, like
we already do for the other CPU models?

-- 
Eduardo


