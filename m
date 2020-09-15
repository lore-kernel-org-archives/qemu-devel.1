Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B42DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD43B20897
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 02:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD43B20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI19r-0005ur-Um
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 22:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kI18g-0004Hp-Qg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:56:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:23493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1kI18d-0004d1-Sa
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 22:56:14 -0400
IronPort-SDR: 7ha6fUb6s3r9uT6aAFT3/gdAKUS+xAOJ842gPjYeuBx5JMWw2a4RTiPtP0799Ycy7SLM2R9aYv
 WdVniF7KQKig==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="223374985"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; d="scan'208";a="223374985"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 19:56:09 -0700
IronPort-SDR: G2u5tGjOsSPwrtWqKRWsQhgYR7DzZ7rDoF0Yi7iBegXItWYyX084w4pmutZF1Zm6K2N0jqLKYk
 eyq0pXU5FUyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; d="scan'208";a="335500312"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 19:56:07 -0700
Message-ID: <e37ad7f662256431512f2b1e0bfed7d2b0853a3e.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] Introduce (x86) CPU model deprecation API
From: Robert Hoo <robert.hu@linux.intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 15 Sep 2020 10:56:06 +0800
In-Reply-To: <20200914133849.GY1618070@habkost.net>
References: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
 <20200909181506.GM1618070@habkost.net>
 <e3a289f5db0064dd363cb3481d152e20df14b35d.camel@linux.intel.com>
 <20200911140013.GS1618070@habkost.net>
 <b3d7de0e900c199e28702584a90a08987862e655.camel@linux.intel.com>
 <20200914133849.GY1618070@habkost.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=robert.hu@linux.intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 22:56:09
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "Hu, Robert" <robert.hu@intel.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-09-14 at 13:38 +0000, Eduardo Habkost wrote:
> On Mon, Sep 14, 2020 at 06:50:09PM +0800, Robert Hoo wrote:
> > On Fri, 2020-09-11 at 10:00 -0400, Eduardo Habkost wrote:
> > > On Fri, Sep 11, 2020 at 02:22:51PM +0800, Robert Hoo wrote:
> > > > On Wed, 2020-09-09 at 14:15 -0400, Eduardo Habkost wrote:
> 
> [...]
> > > > > > +static void x86_cpu_deprecation_check(ObjectClass *oc)
> > > > > > +{
> > > > > > +    X86CPUClass *xcc = X86_CPU_CLASS(oc);
> > > > > > +    X86CPUVersion effective_version;
> > > > > > +    const X86CPUVersionDefinition *vdef;
> > > > > > +
> > > > > > +    if (xcc->model == NULL) {
> > > > > > +        return;
> > > > > > +    }
> > > > > > +
> > > > > > +    if (xcc->model->version == CPU_VERSION_LEGACY) {
> > > > > > +        /* Treat legacy version as v1 */
> > > > > > +        effective_version = 1;
> > > > > > +    } else {
> > > > > > +        effective_version =
> > > > > > x86_cpu_model_resolve_version(xcc-
> > > > > > > model);
> > > > > > 
> > > > > > +    }
> > > > > > +
> > > > > > +    vdef = xcc->model->cpudef->versions;
> > > > > > +
> > > > > > +    if (vdef == NULL) {
> > > > > > +        return;
> > > > > > +    } else {
> > > > > > +        if (vdef[effective_version - 1].deprecated) {
> > > > > > +            warn_report("Effective CPU model '%s' -- %s",
> > > > > > +                    x86_cpu_versioned_model_name(xcc-
> > > > > > >model-
> > > > > > > cpudef,\
> > > > > > 
> > > > > > +                                                effective_
> > > > > > vers
> > > > > > ion)
> > > > > > ,
> > > > > > +                    vdef[effective_version - 1].note);
> > > > > > +        }
> > > > > > +    }
> > > > > 
> > > > > Why do we need this extra logic?  Isn't it simpler to just
> > > > > add a
> > > > > bool CPUClass::deprecated field, and set:
> > > > > 
> > > > >    cpu->deprecated = model->deprecated;
> > > > > 
> > > > > inside x86_cpu_cpudef_class_init()?
> > > > > 
> > > > 
> > > > All these are to fulfill the target you expected earlier:
> > > > 
> > > > "We need a proper CPU model deprecation API.  Deprecation info
> > > > should appear on query-cpu-definitions and should trigger a
> > > > warning when using the CPU model."
> > > > 
> > > > So I think each deprecated model shall have its own deprecation
> > > > message, e.g. by which version it's going to be deprecation,
> > > > etc.
> > > 
> > > There's nothing x86-specific about having deprecated CPU models,
> > > so I don't understand the reason for the x86-specific hook.
> > > 
> > > If the .note field is the reason you added the arch-specific
> > > hook, you can just add a CPUClass::deprecation_note field and
> > > make the feature generic.
> > > 
> > 
> > I tend to agree with you on this generalization requirement.
> > 
> > But then I find it still has some tricky thing, perhaps that's why
> > I
> > defined this x86 target specific hook:
> > 
> > 1) The versioned CPU model is x86 specific (at least at present)
> 
> I don't see why this would be an obstacle.  You just need to set
> CPUClass::deprecated and/or CPUClass::deprecation_note in the
> x86-specific class_init code.
> 
> > 
> > 2) Each x86 cpudef CPU model has 1 unversioned cpu_model_type then
> > its
> > versioned cpu_model_types. Refer to code in
> > x86_register_cpudef_types(). The unversioned model won't be marked
> > deprecated as it is unkown when registered. In
> > machine_run_board_init(), the cpu_model being checked is the
> > unversioned one, if I set -cpu to its general unversioned model.
> > In short, the unversioned cpudef CPU model would escape the
> > deprecation
> > check.
> 
> Why is that a problem?  If, for example, Model-v1 is deprecated
> and Model-v2 is not deprecated, we must never tell the user that
> "-cpu Model" is deprecated.  

Yes, that's why I cannot mark the unversioned one deprecated or not in
its init.

> Even if some machine types resolve
> "-cpu Model" to Model-v1.
> 
That's what I concerned. Say, if I named "-cpu Icelake-Client" and it's
resolved to Icelake-CPU-v1 (deprecated), shouldn't we warn user?
> --
> Eduardo
> 


