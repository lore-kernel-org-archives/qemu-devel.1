Received: from eggs.gnu.org ([2001:4830:134:3::10]:47926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOLR6-0003KR-Mt
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cOLR2-0008Bu-Rk
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cOLR2-0008Bi-Ld
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 04:31:12 -0500
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
	<38d74124-eb01-c381-8dd9-2a6334c71fa3@redhat.com>
	<20170103030326.GC22664@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6a8bdb5-537b-2239-bd64-62172a992f06@redhat.com>
Date: Tue, 3 Jan 2017 10:31:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170103030326.GC22664@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>



On 03/01/2017 04:03, Peter Xu wrote:
>> Would it work if run_tests.sh wrote a Makefile for all the tests (with
>> phony targets only), and then simply ran "make -f Makefile.tmp -jN"?
> Would this be a little bit tricky? This version 1 is kind-of overkill
> (hundreds of lines of codes), I can make it much shorter if you like
> in v2 according to Radim's suggestion.

Yes, that's a nice suggestion!

Paolo
