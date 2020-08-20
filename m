Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C884C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC5920724
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3HieiU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC5920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8iDU-0006B0-C8
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 06:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8iCy-0005ky-LN
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8iCw-0006PC-69
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597920847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+RmeOygfRXzTIXay00NgVRx94fIPGWJ+N+7pKsM3AA=;
 b=h3HieiU1uPJLJNhSDiiH/xDl8QW8FI1ssrnJXHVlN6KjYz6giJjl6HXl/XqyFGXfzVjMQ9
 nhc5P1Jm5tuFcT6qd0z90QqDYsg2o3FzXCiw5bCHnA+BcG4e/DIdySXiFqvnbep1ZYxwFr
 1kPotLpEjtGe4wXjEX9uTGQtS3dqZaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-tsVzp6NwORKCRNBVXyRR1g-1; Thu, 20 Aug 2020 06:54:06 -0400
X-MC-Unique: tsVzp6NwORKCRNBVXyRR1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEAA51DE1B;
 Thu, 20 Aug 2020 10:54:04 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D54B660C87;
 Thu, 20 Aug 2020 10:54:02 +0000 (UTC)
Date: Thu, 20 Aug 2020 12:54:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200820105401.GA99531@linux.fritz.box>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
 <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.08.2020 um 21:14 hat Peter Maydell geschrieben:
> On Mon, 23 Mar 2020 at 13:32, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Sat, Mar 21, 2020 at 11:50:23PM +0100, BALATON Zoltan wrote:
> > > This was discussed before. I think instead of annoying people with a
> > > warning, rather configure should be changed to create a build dir if run
> > > from source and have a Makefile in top dir that runs make -C builddir so
> > > people don't have to care about this or change their ways and can continue
> > > to run configure && make from source dir but you don't have to support
> > > in-tree build. Then you can deprecate in-tree builds but supporting only
> > > out-of-tree without this convenience would not just unnecessarily annoy
> > > those who prefer working in a single tree but people (and apparently some
> > > tools) expect sources to build with usual configure; make; make install so
> > > that should be the minimum to support.
> >
> > Yes, please!  I use in-tree builds and find it tedious to cd into a
> > build dir manually.
> >
> > Also, many build scripts (packaging, etc) we'll break if we simply
> > remove in-tree builds.  I think make && make install should continue to
> > work.
> 
> Paolo's conversion-to-Meson patchseries is about to land, so now
> is the time for people who would like this "automatically create
> a build directory and use it" behaviour to write the necessary
> patches. Any volunteers ?
> 
> My current plan is to land the Meson series first, because it is
> really painful for Paolo to try to keep rebasing it as other
> changes to the old build system occur. This would break
> in-tree builds temporarily until the "automatic creation and
> use of a builddir" patches go in on top of it.

Usually, our requirement is that patch series don't break anything. And
if something slips through, whoever broke it is supposed to fix it, not
whoever is affected.

Kevin


