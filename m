Received: from eggs.gnu.org ([209.51.188.92]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDmSo-0003ES-KX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDmSn-0001st-NJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:50:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
	<9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
	<87mukzei52.fsf@dusky.pond.sub.org>
	<b294fe82-69e8-e4a3-9491-11445cdca15f@redhat.com>
	<87tvf7d1a6.fsf@dusky.pond.sub.org>
	<17e16697-2f36-cdf3-4067-a04f5de6b66c@redhat.com>
Date: Tue, 09 Apr 2019 10:50:36 +0200
In-Reply-To: <17e16697-2f36-cdf3-4067-a04f5de6b66c@redhat.com> (Thomas Huth's
	message of "Tue, 9 Apr 2019 10:40:14 +0200")
Message-ID: <87zhozbm03.fsf@dusky.pond.sub.org>
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

> On 09/04/2019 10.35, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> On 09/04/2019 09.45, Markus Armbruster wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>> We'd like to get rid of global_qtest in the long run (since it is
>>>>> causing trouble for tests that run multiple instances of QEMU in
>>>>> parallel, e.g. migration tests)... so if it is feasible, please don't
>>>>> use it in new code anymore. Try to use a local variable in the function
>>>>> that call qtest_initf() and pass the test state around via a parameter
>>>>> to the functions that need it.
>>>>
>>>> Twenty tests still use @global_qtest
>>>>
>>>> Either we're serious about getting rid of @global_qtest.  Then we should
>>>> just do it.
>>>
>>> Ha ha, "just do it" ... that's quite a bit of work, actually. It's not
>>> just about grep'ing for global_qtest, you also have to replace all the
>>> writel(), readl() etc. functions with qtest_writel(), qtest_readl() etc.
>> 
>> And that's precisely why I'm reluctant to demand this work from
>> contributors.  Asking nicely is of course fair.
>
> That's what I did, didn't I? I said "... so if it is feasible, please
> don't use it in new code anymore". I did not say "you must not use this
> in new code anymore". So where's your problem here, Markus?

You did, I don't have a problem, I just wanted to make quite sure your
asking nicely wasn't misunderstood as a polite way to demand.

[...]
