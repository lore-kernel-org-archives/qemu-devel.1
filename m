Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55FAC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3073020EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF29f0Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3073020EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHohr-0007dV-9C
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kHoh8-0006tH-Rf
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kHoh5-0002J0-UH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600090733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6n1IMRR+b8sORZZVRNGBMDobQJpWdxljMS02jcGBgNw=;
 b=TF29f0ThTWuJNKtS+j120y233lKnNv8DMOuk95gs3VKJzFiUF7Q9HG0ZUmXUN+F0Q2EZlb
 XNYC8E6VsBfElEZPFYR6WNW3w5IfQJu6aVEs9QxBtxgcS8Y90zo8YGA/FBjoFB1FuqrmRs
 YtqBoQlZJosjCMEOH83VTiuQUD7owV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-NdT_HIWsMt-Tjy7u2RxrlA-1; Mon, 14 Sep 2020 09:38:51 -0400
X-MC-Unique: NdT_HIWsMt-Tjy7u2RxrlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 763F856C20;
 Mon, 14 Sep 2020 13:38:50 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28BAB7513A;
 Mon, 14 Sep 2020 13:38:50 +0000 (UTC)
Date: Mon, 14 Sep 2020 09:38:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v2 1/2] Introduce (x86) CPU model deprecation API
Message-ID: <20200914133849.GY1618070@habkost.net>
References: <1591843676-102054-1-git-send-email-robert.hu@linux.intel.com>
 <20200909181506.GM1618070@habkost.net>
 <e3a289f5db0064dd363cb3481d152e20df14b35d.camel@linux.intel.com>
 <20200911140013.GS1618070@habkost.net>
 <b3d7de0e900c199e28702584a90a08987862e655.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <b3d7de0e900c199e28702584a90a08987862e655.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: xiaoyao.li@intel.com, qemu-devel@nongnu.org, armbru@redhat.com,
 robert.hu@intel.com, chenyi.qiang@intel.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 06:50:09PM +0800, Robert Hoo wrote:
> On Fri, 2020-09-11 at 10:00 -0400, Eduardo Habkost wrote:
> > On Fri, Sep 11, 2020 at 02:22:51PM +0800, Robert Hoo wrote:
> > > On Wed, 2020-09-09 at 14:15 -0400, Eduardo Habkost wrote:
[...]
> > > > > +static void x86_cpu_deprecation_check(ObjectClass *oc)
> > > > > +{
> > > > > +    X86CPUClass *xcc = X86_CPU_CLASS(oc);
> > > > > +    X86CPUVersion effective_version;
> > > > > +    const X86CPUVersionDefinition *vdef;
> > > > > +
> > > > > +    if (xcc->model == NULL) {
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    if (xcc->model->version == CPU_VERSION_LEGACY) {
> > > > > +        /* Treat legacy version as v1 */
> > > > > +        effective_version = 1;
> > > > > +    } else {
> > > > > +        effective_version = x86_cpu_model_resolve_version(xcc-
> > > > > > model);
> > > > > 
> > > > > +    }
> > > > > +
> > > > > +    vdef = xcc->model->cpudef->versions;
> > > > > +
> > > > > +    if (vdef == NULL) {
> > > > > +        return;
> > > > > +    } else {
> > > > > +        if (vdef[effective_version - 1].deprecated) {
> > > > > +            warn_report("Effective CPU model '%s' -- %s",
> > > > > +                    x86_cpu_versioned_model_name(xcc->model-
> > > > > > cpudef,\
> > > > > 
> > > > > +                                                effective_vers
> > > > > ion)
> > > > > ,
> > > > > +                    vdef[effective_version - 1].note);
> > > > > +        }
> > > > > +    }
> > > > 
> > > > Why do we need this extra logic?  Isn't it simpler to just add a
> > > > bool CPUClass::deprecated field, and set:
> > > > 
> > > >    cpu->deprecated = model->deprecated;
> > > > 
> > > > inside x86_cpu_cpudef_class_init()?
> > > > 
> > > 
> > > All these are to fulfill the target you expected earlier:
> > > 
> > > "We need a proper CPU model deprecation API.  Deprecation info
> > > should appear on query-cpu-definitions and should trigger a
> > > warning when using the CPU model."
> > > 
> > > So I think each deprecated model shall have its own deprecation
> > > message, e.g. by which version it's going to be deprecation, etc.
> > 
> > There's nothing x86-specific about having deprecated CPU models,
> > so I don't understand the reason for the x86-specific hook.
> > 
> > If the .note field is the reason you added the arch-specific
> > hook, you can just add a CPUClass::deprecation_note field and
> > make the feature generic.
> > 
> I tend to agree with you on this generalization requirement.
> 
> But then I find it still has some tricky thing, perhaps that's why I
> defined this x86 target specific hook:
> 
> 1) The versioned CPU model is x86 specific (at least at present)

I don't see why this would be an obstacle.  You just need to set
CPUClass::deprecated and/or CPUClass::deprecation_note in the
x86-specific class_init code.

> 
> 2) Each x86 cpudef CPU model has 1 unversioned cpu_model_type then its
> versioned cpu_model_types. Refer to code in
> x86_register_cpudef_types(). The unversioned model won't be marked
> deprecated as it is unkown when registered. In
> machine_run_board_init(), the cpu_model being checked is the
> unversioned one, if I set -cpu to its general unversioned model.
> In short, the unversioned cpudef CPU model would escape the deprecation
> check.

Why is that a problem?  If, for example, Model-v1 is deprecated
and Model-v2 is not deprecated, we must never tell the user that
"-cpu Model" is deprecated.  Even if some machine types resolve
"-cpu Model" to Model-v1.

-- 
Eduardo


