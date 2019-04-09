Received: from eggs.gnu.org ([209.51.188.92]:45360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDmEm-0007OQ-HE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDmEi-00032V-K8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:36:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
	<9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
	<87mukzei52.fsf@dusky.pond.sub.org>
	<b294fe82-69e8-e4a3-9491-11445cdca15f@redhat.com>
Date: Tue, 09 Apr 2019 10:35:13 +0200
In-Reply-To: <b294fe82-69e8-e4a3-9491-11445cdca15f@redhat.com> (Thomas Huth's
	message of "Tue, 9 Apr 2019 10:16:33 +0200")
Message-ID: <87tvf7d1a6.fsf@dusky.pond.sub.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stephen Checkoway <s@pahtak.org>, Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 09/04/2019 09.45, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> We'd like to get rid of global_qtest in the long run (since it is
>>> causing trouble for tests that run multiple instances of QEMU in
>>> parallel, e.g. migration tests)... so if it is feasible, please don't
>>> use it in new code anymore. Try to use a local variable in the function
>>> that call qtest_initf() and pass the test state around via a parameter
>>> to the functions that need it.
>> 
>> Twenty tests still use @global_qtest
>> 
>> Either we're serious about getting rid of @global_qtest.  Then we should
>> just do it.
>
> Ha ha, "just do it" ... that's quite a bit of work, actually. It's not
> just about grep'ing for global_qtest, you also have to replace all the
> writel(), readl() etc. functions with qtest_writel(), qtest_readl() etc.

And that's precisely why I'm reluctant to demand this work from
contributors.  Asking nicely is of course fair.

> If you feel like this is a "just do it" quick task, you're welcome to help!
>
>> Or we're not.  Then we shouldn't ask contributors to do extra work.
>
> We are:
>
>  git log --oneline -- tests | grep global_qtest
>
> ... it just takes time.
>
>  Thomas
