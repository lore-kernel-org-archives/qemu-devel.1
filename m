Received: from eggs.gnu.org ([2001:4830:134:3::10]:58386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cO65c-0005FV-Nj
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 12:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cO65X-0003MZ-PJ
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 12:08:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cO65X-0003MG-JB
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 12:07:59 -0500
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <38d74124-eb01-c381-8dd9-2a6334c71fa3@redhat.com>
Date: Mon, 2 Jan 2017 18:07:56 +0100
MIME-Version: 1.0
In-Reply-To: <1483266886-25050-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH 0/2] run_tests: support
 concurrent test execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>



On 01/01/2017 11:34, Peter Xu wrote:
> run_tests.sh is getting slower. Maybe it's time to let it run faster.
> An obvious issue is that, we were running the tests sequentially in
> the past.
> 
> This series provides another new "-j" parameter. "-j 8" means we run
> the tests on 8 task queues. That'll fasten the script a lot. A very
> quick test of mine shows 3x speed boost with 8 task queues.
> 
> Most of the changes are in scripts/tash.bash of patch 2, which
> implemented the main logic for task managements. Please see commit
> message for more information.
> 
> I did a quick "make standalone" test to make sure this series won't
> break it. However I am not sure whether it'll break other thing that I
> don't know...

Would it work if run_tests.sh wrote a Makefile for all the tests (with
phony targets only), and then simply ran "make -f Makefile.tmp -jN"?

Thanks,

Paolo
