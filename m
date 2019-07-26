Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D1C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397F222C7E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397F222C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwdQ-0005Ym-FF
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45188)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqwdA-00056r-D4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqwd5-0001iF-Jn
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:35:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hqwcz-0000x7-2Y; Fri, 26 Jul 2019 05:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B34A9C04959E;
 Fri, 26 Jul 2019 09:35:02 +0000 (UTC)
Received: from work-vm (ovpn-117-185.ams2.redhat.com [10.36.117.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BE55600C4;
 Fri, 26 Jul 2019 09:35:01 +0000 (UTC)
Date: Fri, 26 Jul 2019 10:34:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190726093459.GD2657@work-vm>
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-3-peter.maydell@linaro.org>
 <20190725172712.GM2656@work-vm>
 <CAFEAcA-jGvNS4N4qobLekHYdV82qSUWVQOvTRQbrpcCRF0Yvwg@mail.gmail.com>
 <20190725180007.GN2656@work-vm>
 <CAFEAcA8T25Fq5wj8a-K9KAyXdfj3+HtW=kTJ13zr+-iHFz4-GA@mail.gmail.com>
 <20190726093208.GC2657@work-vm>
 <CAFEAcA9G1RmT-Ot4rYfqTa-xHfTPVq+RJ2A_EB9ufNrEhzyBCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9G1RmT-Ot4rYfqTa-xHfTPVq+RJ2A_EB9ufNrEhzyBCw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 26 Jul 2019 09:35:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1? 2/2] vmstate.h: Type check
 VMSTATE_STRUCT_VARRAY macros
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Fri, 26 Jul 2019 at 10:32, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > Would
> > >
> > > /*
> > >  * Check that type t2 is an array of type t1 of size n,
> > >  * eg if t1 is 'foo' and n is 32 then t2 must be 'foo[32]'
> > >  */
> > >
> > > be clearer ?
> >
> > Yep.
> 
> OK, I'll fold that in. Are you happy for me to take this
> via the target-arm tree for 4.1, given the two dependent
> patches are both for arm devices?

Yep

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

