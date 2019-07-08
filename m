Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE61C606CF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 21:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B72216C4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 21:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B72216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44995 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkbSx-0005v9-EC
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 17:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hkbRp-0005Sc-SK
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 17:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hkbRo-0005rC-RI
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 17:45:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hkbRo-0005mX-Lf
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 17:45:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A100308621B;
 Mon,  8 Jul 2019 21:45:15 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B4705B083;
 Mon,  8 Jul 2019 21:45:13 +0000 (UTC)
Date: Mon, 8 Jul 2019 18:45:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190708214512.GU5198@habkost.net>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-3-git-send-email-pbonzini@redhat.com>
 <20190705205228.GF5198@habkost.net>
 <2015601d-8979-e5d6-fb14-ed74dc420813@redhat.com>
 <20190705214129.GH5198@habkost.net>
 <90631bfa-80a6-db32-15fe-82a6765b5f1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90631bfa-80a6-db32-15fe-82a6765b5f1e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 08 Jul 2019 21:45:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/7] target/i386: introduce generic feature
 dependency mechanism
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 06, 2019 at 12:07:50AM +0200, Paolo Bonzini wrote:
> On 05/07/19 23:41, Eduardo Habkost wrote:
> >>>> +    for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
> >>>> +        FeatureDep *d = &feature_dependencies[i];
> >>>> +        if ((env->user_features[d->from] & d->from_flag) &&
> >>>> +            !(env->features[d->from] & d->from_flag)) {
> >>> Why does it matter if the feature was cleared explicitly by the
> >>> user?
> >> Because the feature set of named CPU models should be internally
> >> consistent.  I thought of this mechanism as a quick "clean up user's
> >> choices" pass to avoid having to remember a multitude of VMX features,
> >> for example it makes "-cpu host,-rdtscp" just work.
> > If named CPU models are already consistent, ignoring
> > user_features shouldn't make a difference, right?  It would also
> > be a useful mechanism to detect inconsistencies in internal CPU
> > model definitions.
> 
> Ok, I can drop that check.
> 
> >> It has to be done before expansion, so that env->user_features is set
> >> properly before -cpu host is expanded.
> > 
> > I don't get it.  It looks like you only need env->user_features
> > to be set above because you are handling dependencies before
> > cpu->max_features is handled.
> > 
> > If you handle dependencies at x86_cpu_filter_features() instead
> > (after cpu->max_features was already handled), you don't even
> > need to worry about setting user_features.
> 
> I think you're right, but on the other hand setting user_features is
> cleaner.  Effectively the dependent features have been disabled because
> of something the user told QEMU.  So on one hand I can move the loop to
> x86_cpu_filter_features, on the other hand I'd prefer to set
> user_features and then it feels more like expansion (e.g. of vmx-ept=off
> to vmx-ept=off,vmx-unrestricted-guest=off) than filtering.

I don't disagree if you really want to set user_features for
consistency.  Considering it part of expansion and not filtering
makes sense, too.

The only point I disagree with is the handling feature dependency
before the "if (cpu->max_features)" block.  e.g. if a feature is
being disabled by x86_cpu_get_supported_feature_word(), we also
need to disable features that depend on it.

-- 
Eduardo

