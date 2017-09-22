Received: from eggs.gnu.org ([2001:4830:134:3::10]:37498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNYT-0005QR-Uc
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNYQ-0005L6-06
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:59:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvNYP-0005Jk-QF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:59:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BEEB7F3F3
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 12:59:36 +0000 (UTC)
Date: Fri, 22 Sep 2017 20:59:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922125932.GD32000@lemon>
References: <1506070572-7549-1-git-send-email-peterx@redhat.com>
	<1506070572-7549-2-git-send-email-peterx@redhat.com>
	<20170922090433.GC12725@redhat.com>
	<20170922091430.GJ30661@pxdev.xzpeter.org>
	<20170922093631.GG12725@redhat.com>
	<4760b1a1-446d-fc2c-8794-8860bededc56@redhat.com>
	<20170922094325.GH12725@redhat.com>
	<d0992b81-d5d0-6957-d292-52be50a21ec7@redhat.com>
	<20170922101728.GJ12725@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922101728.GJ12725@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] iothread: provide helpers for internal
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, 09/22 11:17, Daniel P. Berrange wrote:
> Sorry yes, my bad - its the iothread behind the monitor. I still think that
> is a detail worth keeping private in case we want to refactor how the
> monitor threading works later.

I agree. I convinced Peter to reuse IOThread just because we can, but we don't
need to expose it to user just because we can. Like Daniel, I also see no reason
to do that at this point, and I think we can always do it later when necesssary.

Fam
