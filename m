Received: from eggs.gnu.org ([2001:4830:134:3::10]:44975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eAb6Q-0004Ym-7Y
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eAb6N-0004we-2f
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eAb6M-0004wT-SU
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:29:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3950C04AC59
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 12:29:33 +0000 (UTC)
Date: Fri, 3 Nov 2017 20:29:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171103122931.GC10939@lemon>
References: <150970267983.273.1055338257816616711@bafd83ae6430>
	<9066062f-b01e-0e37-8d0d-0982429d546a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9066062f-b01e-0e37-8d0d-0982429d546a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Run the test-crypto-block only if
 encryption is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 11/03 11:03, Thomas Huth wrote:
> > make: *** [check-tests/test-aio-multithread] Error 1
> > make: *** Waiting for unfinished jobs....
> > Could not access KVM kernel module: No such file or directory
> > qemu-system-x86_64: failed to initialize KVM: No such file or directory
> > qemu-system-x86_64: Back to tcg accelerator
> 
> ... but this test-aio-multithread error is certainly not related to my
> patch, I think. Is this already a known issue?

Indeed doesn't look like yours. I remember seeing test-aio-multithread failures
but we've not investigated yet AFAICT.

Fam
