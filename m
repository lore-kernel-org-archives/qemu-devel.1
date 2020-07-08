Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836A7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3D120772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEU31dyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3D120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIcP-0007IJ-IO
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtILL-0004zM-58
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:15:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtILH-0008R3-Tm
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVuFmlGqpgLXtjBnNvJskw8oViYwTN4UkYXuQury5W8=;
 b=dEU31dyyfd8UpDJRJjXgsKYxFVe/A9hbGYE2b3ivb+RdGLgip15dP3FNAY+/G6JJD2/vgB
 NRKX7hILAvsm6sd7Jaq8NRo/HFumA9S8hdSvKa5Z3p6ekkFCXtt8uLjwEGeSXoKV74pACQ
 VKN2i5nn5uj9E28zvH7xExxJrE4hk8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-9BFeZVqLMmS0CyjUX4UB5g-1; Wed, 08 Jul 2020 13:13:40 -0400
X-MC-Unique: 9BFeZVqLMmS0CyjUX4UB5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDB3619057A0;
 Wed,  8 Jul 2020 17:13:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-206.ams2.redhat.com [10.36.114.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACC6D724A0;
 Wed,  8 Jul 2020 17:13:38 +0000 (UTC)
Date: Wed, 8 Jul 2020 19:13:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update nvme entry
Message-ID: <20200708171337.GG4902@linux.fritz.box>
References: <20200706194342.1996219-1-kbusch@kernel.org>
 <20200707152613.GD7002@linux.fritz.box>
 <20200708170330.GA2288218@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
In-Reply-To: <20200708170330.GA2288218@dhcp-10-100-145-180.wdl.wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.07.2020 um 19:03 hat Keith Busch geschrieben:
> On Tue, Jul 07, 2020 at 05:26:13PM +0200, Kevin Wolf wrote:
> > Am 06.07.2020 um 21:43 hat Keith Busch geschrieben:
> > > The nvme emulated device development pace has increased recently.  Klaus
> > > has offered to co-maintain, and since we have many new contributions
> > > coming through, we're adding a repository to accumulate and test new
> > > features.
> > > 
> > > Cc: Klaus Jensen <its@irrelevant.dk>
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > 
> > I assume that you'll merge this as the first thing through your new
> > tree, so instead of applying, I'll just add:
> 
> Thanks, I've started the new branch with this as the first commit. We'll
> wait at least a few more days to see if we've agreement on new patches
> before sending our pull request.

We're now in the freeze for 5.1 anyway, so everything except fixes (and
I guess the MAINTAINERS update if you do send something) will have to
wait until after the release.

Kevin


