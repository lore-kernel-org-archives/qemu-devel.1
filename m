Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBB2C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830372083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830372083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKll-00026c-N1
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1hyKjC-0007fD-1w
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hyKj5-0000Tf-Gb
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:44:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hyKj5-0000NS-7M
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:43:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 081233001D30;
 Thu, 15 Aug 2019 18:43:54 +0000 (UTC)
Received: from localhost (ovpn-116-32.gru2.redhat.com [10.97.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B3E917CFB;
 Thu, 15 Aug 2019 18:43:53 +0000 (UTC)
Date: Thu, 15 Aug 2019 15:43:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Bruce Rogers <BROGERS@suse.com>
Message-ID: <20190815184351.GX3908@habkost.net>
References: <89368c9df9e960ead712227ac8dd3e1793c164b0.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89368c9df9e960ead712227ac8dd3e1793c164b0.camel@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 15 Aug 2019 18:43:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] current QEMU can't start pc-q35-2.12  SEV guest
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
Cc: Liang Yan <LYan@suse.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 12:49:58AM +0000, Bruce Rogers wrote:
> Hi,
> 
> I ran into a case where a guest on a SEV capable host, which was
> enabled to use SEV and using an older machine type was no longer able
> to run when the QEMU version had been updated.
> 
> Specifically, when the guest was installed and running under a v2.12
> QEMU, set up for SEV (ok it was v2.11 with SEV support backported, but
> the details still apply), using a command line such as follows:
> 
> qemu-system-x86_64 -cpu EPYC-IBRS \
> -machine pc-q35-2.12,accel=kvm,memory-encryption=sev0 \
> -object sev-guest,id=sev0,...
> 
> The guest ran fine, using SEV memory enryption.
> 
> Later the version of QEMU was updated to v3.1.0, and the same guest now
> hung at boot, when using the exact same command line. (Current QEMU
> still has the same problem.)
> 
> Upon investigation, I find that the handling of xlevel in
> target/i386/cpu.c relies includes an explicit detection of SEV being
> enabled and sets the cpuid_min_xlevel in the CPUX86State structure to
> 0x8000001F as the required minimum for SEV support. This normally is
> used to set the xlevel the guest sees, allowing it to use SEV.
> 
> The compat settings for the v2.12 machine type include an xlevel value
> associated with it (0x8000000A). Unfortunately the processing of the
> compat settings gets conflated with the logic of handling a user
> explicitly specifying an xlevel on the command line, which is treated
> as an "override" condition, overriding the other xlevel selections
> which would otherwise be done in the QEMU cpu code.
> 
> So, in the scenario I describe above, the original, working case would
> provide an cpuid xlevel value of 0x8000001F to the guest (correct), and
> the failing case ends up providing the value 0x8000000A (incorrect).
> 
> It seems to me that the handling of the compat settings and the
> explicit xlevel setting by the user should be processed separately, but
> I don't see how to do that easily.
> 
> How should this problem be resolved?
> 
> In my case, I've added to the code which is for checking a user
> provided xlevel value, the check again for sev_enabled(), and if that's
> the case, I still apply the cpuid_min_xlevel value. This works for the
> time being, but doesn't seem to be the right solution.
> 

I believe this is my fault.  On commit e00516475c27 ("i386:
Enable TOPOEXT feature on AMD EPYC CPU"), I had added
xlevel=0x8000000A compat entries, but they were supposed to be
min-xlevel=0x8000000A.

Does this patch solve the problem?

---

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..11d5a3cd3a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -154,8 +154,8 @@ const size_t pc_compat_3_0_len = G_N_ELEMENTS(pc_compat_3_0);
 GlobalProperty pc_compat_2_12[] = {
     { TYPE_X86_CPU, "legacy-cache", "on" },
     { TYPE_X86_CPU, "topoext", "off" },
-    { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
-    { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
+    { "EPYC-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "EPYC-IBPB-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
 };
 const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);
 

-- 
Eduardo

