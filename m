Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349B5C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097DC2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097DC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeMO-0003ce-Ah
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iDeL9-0002PE-No
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iDeL5-0008Kt-D7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iDeL5-0008IH-4T
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE2DD18CB8FA;
 Fri, 27 Sep 2019 00:42:24 +0000 (UTC)
Received: from localhost (ovpn-116-45.gru2.redhat.com [10.97.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC41A60BE2;
 Fri, 27 Sep 2019 00:42:21 +0000 (UTC)
Date: Thu, 26 Sep 2019 21:42:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] i386: Re-add "pconfig" CPUID flag name
Message-ID: <20190927004220.GV8144@habkost.net>
References: <20190926212326.4092-1-ehabkost@redhat.com>
 <CABgObfa-PHfeNVVYCuEFJ4_=KADJEddJS1k0Au+sOgtxgundDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfa-PHfeNVVYCuEFJ4_=KADJEddJS1k0Au+sOgtxgundDQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 27 Sep 2019 00:42:24 +0000 (UTC)
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
Cc: thomas.lendacky@amd.com, "Kang, Luwei" <luwei.kang@intel.com>,
 libvir-list@redhat.com, qemu-devel <qemu-devel@nongnu.org>,
 Robert Hoo <robert.hu@linux.intel.com>, kai.huang@intel.com,
 berrange@redhat.com, robert.hu@intel.com, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(CCing libvir-list)

On Thu, Sep 26, 2019 at 11:58:30PM +0200, Paolo Bonzini wrote:
> Is this really needed? QEMU's value of pconfig=on vs. off should be
> provided by QMP CPU model queries, if a property is not available then
> Libvirt should not try to set it to off.
> 

Libvirt can easily work around it for new VMs, and it should.

The issue are VMs that were created with QEMU 3.1.0.  QEMU 3.1.0
was telling libvirt "Icelake-Server can't be used unless
pconfig=off is used", and libvirt was adding pconfig=off to the
domain XML as expected.

It would be wrong for libvirt to remove a device option when
migrating an existing VM to another QEMU version.  We can change
the rules (and document that), but do we want to?


> Paolo
> 
> Il gio 26 set 2019, 23:23 Eduardo Habkost <ehabkost@redhat.com> ha scritto:
> 
> > QEMU 3.1.0 was shipped with the "pconfig" CPU property available,
> > added by commit 5131dc433df5 ("i386: Add CPUID bit for PCONFIG").
> >
> > Then the feature was removed in QEMU 4.0.0 (and 3.1.1), by commit
> > 712f807e1965 ("Revert 'i386: Add CPUID bit for PCONFIG'").
> >
> > In theory this would be OK, but we do have a problem: existing
> > software (like libvirt) was already using "pconfig=off" since
> > QEMU 3.1.0 on some cases.  This means software that worked with
> > QEMU 3.1.0 doesn't work with QEMU 3.1.1 and newer.
> >
> > One symptom is the following error being generated by
> > virt-install while trying to use the 'host-model' CPU model, on a
> > host that's identified as Icelake-Server:
> >
> >   ERROR    internal error: qemu unexpectedly closed the monitor: \
> >       2019-09-24T22:57:42.550032Z qemu-kvm: \
> >       can't apply global Icelake-Server-x86_64-cpu.pconfig=off: Property
> > '.pconfig' not found
> >
> > Re-add "pconfig" to feature_word_info[FEAT_7_0_EDX].feat_names so
> > "pconfig=off" will work again.
> >
> > This change still won't let users set "monitor=on" because all
> > accelerators currently report the feature as unsupported.  But to
> > make sure PCONFIG won't be enabled by accident in the future
> > before we implement the necessary migration code, also add the
> > feature to .unmigratable_flags.
> >
> > Fixes: 712f807e1965 ("Revert 'i386: Add CPUID bit for PCONFIG'")
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  target/i386/cpu.h | 2 ++
> >  target/i386/cpu.c | 8 +++++++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 8e090acd74..b728bd22f1 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -731,6 +731,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
> >  #define CPUID_7_0_EDX_AVX512_4VNNIW     (1U << 2)
> >  /* AVX512 Multiply Accumulation Single Precision */
> >  #define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
> > +/* PCONFIG Instruction */
> > +#define CPUID_7_0_EDX_PCONFIG           (1U << 18)
> >  /* Speculation Control */
> >  #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
> >  /* Arch Capabilities */
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 71034aeb5a..3e25505bd3 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1084,7 +1084,7 @@ static FeatureWordInfo
> > feature_word_info[FEATURE_WORDS] = {
> >              NULL, NULL, NULL, NULL,
> >              NULL, NULL, "md-clear", NULL,
> >              NULL, NULL, NULL, NULL,
> > -            NULL, NULL, NULL /* pconfig */, NULL,
> > +            NULL, NULL, "pconfig", NULL,
> >              NULL, NULL, NULL, NULL,
> >              NULL, NULL, "spec-ctrl", "stibp",
> >              NULL, "arch-capabilities", "core-capability", "ssbd",
> > @@ -1095,6 +1095,12 @@ static FeatureWordInfo
> > feature_word_info[FEATURE_WORDS] = {
> >              .reg = R_EDX,
> >          },
> >          .tcg_features = TCG_7_0_EDX_FEATURES,
> > +        /*
> > +         * CPU state altered by the PCONFIG instruction (e.g. MKTME key
> > table)
> > +         * is not migrated by QEMU yet, so PCONFIG is unmigratable until
> > +         * this is implemented.
> > +         */
> > +        .unmigratable_flags = CPUID_7_0_EDX_PCONFIG,
> >      },
> >      [FEAT_7_1_EAX] = {
> >          .type = CPUID_FEATURE_WORD,
> > --
> > 2.21.0
> >
> >

-- 
Eduardo

