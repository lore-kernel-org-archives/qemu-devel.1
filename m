Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C799C32757
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06266218A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06266218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBP3-0007sw-Vx
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 04:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1hyBO7-0007Ms-De
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hyBO6-000264-Av
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:45:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hyBO3-00024h-31; Thu, 15 Aug 2019 04:45:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17F5759455;
 Thu, 15 Aug 2019 08:45:33 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-204-82.brq.redhat.com
 [10.40.204.82])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADF1B429AA;
 Thu, 15 Aug 2019 08:45:28 +0000 (UTC)
Date: Thu, 15 Aug 2019 10:45:26 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190815084526.e335iqjyvif3ecqr@kamzik.brq.redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
 <CAFEAcA_Tq-DLQuH2-+NtYOE0m4ki_CfEfWpHG+UM4rGhdK3q-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Tq-DLQuH2-+NtYOE0m4ki_CfEfWpHG+UM4rGhdK3q-w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 15 Aug 2019 08:45:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 00/15] target/arm/kvm: enable SVE in
 guests
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 09:31:35AM +0100, Peter Maydell wrote:
> On Fri, 2 Aug 2019 at 13:25, Andrew Jones <drjones@redhat.com> wrote:
> >
> > Since Linux kernel v5.2-rc1 KVM has support for enabling SVE in guests.
> > This series provides the QEMU bits for that enablement. First, we
> > select existing CPU properties representing features we want to
> > advertise in addition to the SVE vector lengths and prepare
> > them for a qmp query. Then we introduce the qmp query, applying
> > it immediately to those selected features. We also document ARM CPU
> > features at this time. We next add a qtest for the selected CPU
> > features that uses the qmp query for its tests - and we continue to
> > add tests as we add CPU features with the following patches. So then,
> > once we have the support we need for CPU feature querying and testing,
> > we add our first SVE CPU feature property, 'sve', which just allows
> > SVE to be completely enabled/disabled. Following that feature property,
> > we add all 16 vector length properties along with the input validation
> > they need and tests to prove the validation works. At this point the
> > SVE features are still only for TCG, so we provide some patches to
> > prepare for KVM and then a patch that allows the 'max' CPU type to
> > enable SVE with KVM, but at first without vector length properties.
> > After a bit more preparation we add the SVE vector length properties
> > to the KVM-enabled 'max' CPU type along with the additional input
> > validation and tests that that needs.  Finally we allow the 'host'
> > CPU type to also enjoy these properties by simply sharing them with it.
> 
> Hi -- I see there have been some review comments on these patches
> that mean there'll be a v4. In the meantime, patches 1, 2, 5, 6, 9, 10
> seem to me to be independent bugfixes/cleanups that have been reviewed.
> Would you like me to take those into target-arm.next to reduce the
> size of the patchset for v4, or is that going to make rebasing
> painful on your end?
>

Hi Peter,

Please do take the fixups. I think the rebasing should go fine, and indeed
reducing the number of patches in the patchset should reduce some of my
maintenance and also some reviewer strain for v4.

Thanks,
drew

