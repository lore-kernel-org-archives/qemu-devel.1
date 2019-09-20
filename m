Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A547C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6F92080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6F92080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEYM-00019M-48
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iBEVu-0008BH-Ah
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iBEVt-00057G-DA
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iBEVr-000561-Ad; Fri, 20 Sep 2019 04:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A417A7FD6C;
 Fri, 20 Sep 2019 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-81.ams2.redhat.com
 [10.36.117.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C8A360BF1;
 Fri, 20 Sep 2019 08:43:28 +0000 (UTC)
Date: Fri, 20 Sep 2019 10:43:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [RFC 4/4] ahci media error reporting
Message-ID: <20190920084327.GB5458@localhost.localdomain>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190919194847.18518-5-tasleson@redhat.com>
 <df07a621-8515-2414-2f59-a7eb7eebd75b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df07a621-8515-2414-2f59-a7eb7eebd75b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 20 Sep 2019 08:43:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Tony Asleson <tasleson@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.09.2019 um 22:43 hat John Snow geschrieben:
> I'd have to check -- because I can't say the AHCI emulator was designed
> so much as congealed -- but you might need calls to ncq_finish.
> 
> usually, ncq_cb handles the return from any NCQ command and will call
> ncq_err and ncq_finish as appropriate to tidy up the command.
> 
> It might be a mistake that execute_ncq_command issues ncq_err in the
> `default` arm of the switch statement without a call to finish.
> 
> If we do call ncq_finish from this context I'm not sure if we want
> block_acct_done here unconditionally. We may not have started a block
> accounting operation if we never started a backend operation. Everything
> else looks about right to me.

With that much uncertainty, the one thing I'm pretty certain of is that
someone (TM) should write some qtests - if only to figure out what
really happens.

Kevin

