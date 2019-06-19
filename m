Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EF7C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 23:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF8D20851
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 23:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF8D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdkNK-0000dQ-4N
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 19:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hdkJL-00052u-6C
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hdk7o-0004kL-Qu
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hdk7o-0004jF-LO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 19:36:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B504759454;
 Wed, 19 Jun 2019 23:36:16 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28CFA5D71D;
 Wed, 19 Jun 2019 23:36:14 +0000 (UTC)
Date: Wed, 19 Jun 2019 20:36:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190619233613.GG26409@habkost.net>
References: <20190612084104.34984-1-like.xu@linux.intel.com>
 <20190612084104.34984-8-like.xu@linux.intel.com>
 <20190619191546.GD26409@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619191546.GD26409@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 19 Jun 2019 23:36:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 7/9] target/i386: Support multi-dies
 when host doesn't support CPUID.1F
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 04:15:46PM -0300, Eduardo Habkost wrote:
> On Wed, Jun 12, 2019 at 04:41:02PM +0800, Like Xu wrote:
> > In guest CPUID generation process, the cpuid_min_level would be adjusted to
> > the maximum passed value for basic CPUID configuration and it should not be
> > restricted by the limited value returned from cpu_x86_cpuid(). After the basic
> > cpu_x86_cpuid() loop is finished, the cpuid_0_entry.eax needs to be configured
> > again by the last adjusted cpuid_min_level value.
> > 
> > If a user wants to expose CPUID.1F by passing dies > 1 for any reason without
> > host support, a per-cpu smp topology warning will appear but it's not blocked.
> > 
> > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> 
> This code doesn't look at host CPUID at all, as far as I can see.
> Isn't it simpler to just make cpuid_x86_cpuid() return the
> correct data?

I suggest the following change instead.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6db38e145b..d05a224092 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5152,6 +5152,10 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
         }
 
+        if (env->nr_dies > 1) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
+        }
+
         /* SVM requires CPUID[0x8000000A] */
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
-- 
2.18.0.rc1.1.g3f1ff2140

