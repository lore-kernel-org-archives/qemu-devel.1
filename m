Received: from eggs.gnu.org ([209.51.188.92]:49549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gs5aR-0001cF-1h
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gs5aP-0001nN-0z
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:48:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gs5aN-0001mN-JW
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 07:48:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C31D95944D
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 12:48:48 +0000 (UTC)
Date: Fri, 8 Feb 2019 13:48:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190208124844.GE4494@dhcp-200-176.str.redhat.com>
References: <20181206215026.7716-1-pbonzini@redhat.com>
	<20181206215026.7716-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206215026.7716-3-pbonzini@redhat.com>
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

Am 06.12.2018 um 22:50 hat Paolo Bonzini geschrieben:
> gtester is deprecated by upstream glib (see for example the announcement
> at https://blog.gtk.org/2018/07/11/news-from-glib-2-58/) and it does
> not support tests that call g_test_skip in some glib stable releases.
> 
> glib suggests instead using Automake's TAP support, which gtest itself
> supports since version 2.38 (QEMU's minimum requirement is 2.40).
> We do not support Automake, but we can use Automake's code to beautify
> the TAP output.  I chose to use the Perl copy rather than the shell/awk
> one, with some changes so that it can accept TAP through stdin, in order
> to reuse Perl's TAP parsing package.  This also avoids duplicating the
> parser between tap-driver.pl and tap-merge.pl.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I just wanted to work on a unit test and found that a simple 'make
check-tests/test-bdrv-drain' (which used to build and run the test with
a single command) doesn't work any more.

git bisect points to this commit.

Kevin
