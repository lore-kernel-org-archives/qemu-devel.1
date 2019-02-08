Received: from eggs.gnu.org ([209.51.188.92]:58601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gs8Zd-0004qJ-Mv
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gs8Zd-0006cF-3T
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:00:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gs8Zc-0006aJ-Tn
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:00:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87399811DD
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 16:00:15 +0000 (UTC)
Date: Fri, 8 Feb 2019 17:00:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190208160013.GA4441@dhcp-200-176.str.redhat.com>
References: <20181206215026.7716-1-pbonzini@redhat.com>
	<20181206215026.7716-3-pbonzini@redhat.com>
	<20190208124844.GE4494@dhcp-200-176.str.redhat.com>
	<d9b84d67-dfb8-6dd7-dc77-9ea442bc9c5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b84d67-dfb8-6dd7-dc77-9ea442bc9c5c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

Am 08.02.2019 um 14:46 hat Paolo Bonzini geschrieben:
> On 08/02/19 13:48, Kevin Wolf wrote:
> > I just wanted to work on a unit test and found that a simple 'make
> > check-tests/test-bdrv-drain' (which used to build and run the test with
> > a single command) doesn't work any more.
> > 
> > git bisect points to this commit.
> 
> What's wrong with "tests/test-bdrv-drain"?  (Before there were some
> differences in test environment, but not now).

It runs the old version without building the source I just modified.

Kevin
