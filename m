Received: from eggs.gnu.org ([209.51.188.92]:35642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDlS3-0005ek-DP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDlS2-00012H-JA
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 03:45:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
	<9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
Date: Tue, 09 Apr 2019 09:45:45 +0200
In-Reply-To: <9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com> (Thomas Huth's
	message of "Tue, 9 Apr 2019 08:13:33 +0200")
Message-ID: <87mukzei52.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 01/10] block/pflash_cfi02: Add test for
 supported commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stephen Checkoway <s@pahtak.org>, qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> We'd like to get rid of global_qtest in the long run (since it is
> causing trouble for tests that run multiple instances of QEMU in
> parallel, e.g. migration tests)... so if it is feasible, please don't
> use it in new code anymore. Try to use a local variable in the function
> that call qtest_initf() and pass the test state around via a parameter
> to the functions that need it.

Twenty tests still use @global_qtest

Either we're serious about getting rid of @global_qtest.  Then we should
just do it.

Or we're not.  Then we shouldn't ask contributors to do extra work.
