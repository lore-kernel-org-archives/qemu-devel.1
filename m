Received: from eggs.gnu.org ([2001:4830:134:3::10]:46186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMZTa-00047O-SN
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMZTR-0000xf-EC
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:15:32 -0500
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
	<b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
	<20181113121836.GC4830@localhost.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <cab511df-cba6-b900-98c0-9fff6e323654@redhat.com>
Date: Tue, 13 Nov 2018 09:15:05 -0500
MIME-Version: 1.0
In-Reply-To: <20181113121836.GC4830@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


On 11/13/18 7:18 AM, Kevin Wolf wrote:
> Am 12.11.2018 um 18:36 hat Cleber Rosa geschrieben:
>> I hope you don't blame me for trying to have the advantage of the
>> counter answer. :)
> 
> Thanks for being so honest, but do you actually need this advantage when
> you have good technical arguments in favour of your proposal?
> 

The smile should have given away that I was joking.  An advantage point
over others is not needed when those are hoping to work together, and
not trying to win an argument.

>>>> And run all tests related to snapshot.  This is one of the reasons for
>>>> maybe allowing the type of test proposed here to live under
>>>> "tests/acceptance".  Others include:
>>>>
>>>>  * No numbering conflicts when naming tests
>>>>  * More descriptive tests names and metadata
>>>
>>> Test numbering and metadata - sure, we can change that in qemu-iotests.
>>> Should be a lot easier than adding a whole new second infrastructure for
>>> block tests.
>>>
>>
>> My impression is that the "infrastructure for block tests" is not that
>> different from the infrastructure needed by other tests, specially other
>> QEMU tests.  The point I'm trying to make here is that, adding a feature
>> such as metadata parsing/selection to tests looks much more like a *test
>> infrastructure* issue than a "block test" issue, right?
> 
> It depends on what you include in "infrastructure". qemu-iotests
> has some functionality that is probably common to all test frameworks.
> But it also has some functionality that is very specific to QEMU and the
> block layer.
> 
> As a rough guideline, anything that ./check does outside the actual test
> case is probably mostly generic; anything that is included in the test
> case files (such as most common.* files and iotests.py) are domain
> specific.
> 
> So yes, there are parts of qemu-iotests that could be covered by another
> tool, and probably better, but there are also parts worth of keeping.
> 

Agreed.

>>>>  * No "context switch" for people also writing acceptance tests
>>>
>>> There are no people writing "acceptance tests" for the block layer yet.
>>> The context switch comes only with your patches, since you are
>>> introducing a second competing framework for the same task, without even
>>> giving a clear path of how to integrate or convert the existing tests so
>>> we could get back to a unified world.
>>>
>>
>> You're absolutely right, and it's quite obvious that there's no one
>> writing "acceptance tests" for the block layer yet.  There's a subtle
>> but important difference here though: this initiative is trying to allow
>> people to write tests generic enough, for various QEMU subsystems
>> (that's why maybe it's badly named as "acceptance").  It's really about
>> trying to avoid context switches that may occur when developers and
>> maintainers from those various subsystems (hopefully) start to write and
>> review tests.
>>
>> So no, this is not an attempt to cause disruption, fragmentation and
>> separate worlds.  It's quite the contrary.  And please excuse me from
>> not writing a "how to migrate qemu-iotests" --  I don't even want to
>> think about that if the block layer maintainers do not see any value in
>> that.
> 
> [ Insert that "how standards proliferate" xkcd here ]
> 
> I see value in having a unified test infrastructure. However, I don't
> think committing a new Hello World grade qemu-img test case using
> different tooling than the rest of the qemu-img test cases is
> contributing much to this goal.
> 

There are a few ways I take this response.  First one is that my attempt
to make this *RFC* an attempt to discuss and eventually collaborate, is
more a miss than a hit.  Second, it makes me wonder whether you'd prefer
to take a patch without any test, or a test using a "different tooling"
(I'm considering you do take patches without tests, if you don't, then
please disregard this point).

> We have so many unfinished conversions inside QEMU, and this looks like
> the approach you would take to add another one.
> 

Wrong, there's no conversion attempted here.

>> If you believe that handing off some of the infrastructure problems that
>> qemu-iotests have to a common tool, and that it may be a good idea to
>> have qemu-iotests become more like "qemu tests that happen to exercise
>> the block layer", then we can push such an initiative forward.
> 
> Fine with me. But let's push it forward in a different way then.
> 
> My primary concern is not being able to write new tests in a new
> environment. Consistency between block tests is more important to me
> than consistency of new block tests with tests for other parts of QEMU.
> So my primary concern is how to make the existing roughly 232 test cases
> in qemu-iotests compatible with the way the other parts use.
> 

OK.

> And in fact, as those other parts don't exist yet (other than simple
> examples), maybe it would actually be worth discussing whether they
> shouldn't use the same structure and tooling as qemu-iotests (which can
> obviously be improved at the same time, but my point is about being in

Feel free to start the discussion on why they should, and how.  I'm
really receptive to discussing any ideas.

> sync) instead of setting a new standard without considering the existing
> test cases and then trying to move qemu-iotests to it.
> 

OK, "new" having a bad connotation is quite common on your reply.  I
with I had succeeded at passing the idea that I valued qemu-iotests so
much that I was excited about hearing your thoughts about this
*possible* "new" thing.  "Without considering" is an unfair statement
when you get CC'd and when expected feedback is anticipated and valued.

>>> Are those utility APIs actually worth losing the existing iotests.py
>>> functions that provide stuff that is pretty specific to the QEMU and the
>>> block layer?
>>
>> There's no reason to lose iotests.py.  Even the current acceptance tests
>> are based on the principle of reusing the code that a lot of the iotests
>> use (scripts/qemu.py and scripts/qmp/*).
>>
>> What I'm aiming for is that QEMU developers can write *tests*, and have
>> a simple (and hopefully a common) way of running them.
> 
> We already do write tests. It's not like you're starting from zero, even
> if your approach is as if you did.
> 

I'm really disappointed that I have to explain this, because I'm either
failing miserably at communicating, or there's some other worse issues
going on here.

Anyway, when I used *tests* without a qualifier, I'm really talking
about lowering the specialization factors on the test infrastructure.
The giveaway is in adjectives such as "simple" and "common".  Please,
pretty please, assume positive intentions: I never intended or claimed
to be the pioneer of tests in QEMU.

> Anyway, one specific concern about the "simple way" I have is that we're
> adding a hard dependency on an external package (Avocado) that isn't
> usually installed anyway on developer machines. Maintainers will of
> course just install it. But will this reduce the amount of tests that
> contributors run, and increase the amount of untested patches on the
> mailing list?
> 

We've opted for a "opt-in" approach.  If you want to run tests that
depend on this external package, you go ahead and pay the data costs
associated with that download.  We did pack all those steps in a single
"make check-acceptance" command for everyone's convenience, though.

> Maybe we can keep a simple in-tree runner like ./check that doesn't have
> any external dependencies and runs all of those tests that don't make
> use of Avocado utility functions etc.? And you'd use Avocado when you
> want to run all tests or use advanced test harness options.
> 

Sure, this is the current state of affairs.  And yes, one way of
integrating the execution of test from different "silos" is by adding
support on the runner, as mentioned before.  I hope to work on this some
time soon.

>>> 1. Why is a change to something completely new useful and worth the
>>>    effort? We don't generally rewrite QEMU or the kernel if some parts
>>>    of it are ugly. We incrementally improve it instead. Exceptions need
>>>    good justification because rewrites come with costs, especially if
>>>    they can't offer feature parity.
>>>
>>
>> I'll tell you a "shocking secret" (please take that with a grain of
>> salt): I have no use case myself for any of the QEMU tests.  I don't
>> rely on them.  No QEMU test make a difference in my work.  That's why I
>> may miss some of the obvious points, but at the same time, maybe I can
>> look at things from a different perspective.
>>
>> Because incrementally improving the *overall* testing of QEMU is indeed
>> one of my goals, this RFC was a "provocation" for change.  Had I written
>> a Python script with a very similar content, named it "233", we'd have
>> missed this discussion.
> 
> I would still have had input for you, which I will now put here, because
> I want to make sure that way we would write the test case will actually
> be well supported (having to care about this would be avoided if we
> started from "use the qemu-iotests test harness for everything" and then
> incrementally improved it to make it suit better for other cases and to
> make it usable from Avocado - in fact, the existing acceptance tests
> could trivially fit in there without any necessary changes to the
> harness).
> 

Would you believe that most of the tests that a QE team runs (look at
Avocado-VT tests) would require no changes to the "check" harness or no
significant amount of supporting code?  It's easy to take into account
the existing few and simple acceptance tests, and disregard the
infrastructure needed, but we do have a road map that was part of the
original series cover letter.  We do have WiP versions of tests that
configure and boot various guests and interact with them.

It's tricky to get all of them at once at the quality level for
upstream, so what you see it's just the start, not the end goal.  With
that in mind, we consciously recognized that "./check" was not enough,
and it made no sense to put all that supporting code in QEMU itself.

> So for a long time, the only Python test cases we had looked much like
> your test case: Just run some code with lots of asserts in it, and at
> the end print something like "42 test cases passed"; this or an
> exception stack trace is the only output you get. Turns out that this is
> really hard to debug when a test case starts to fail.
> 
> Our shell based test cases, on the other hand, have always printed the
> output and then we diffed it against a reference output. When it fails,
> you usually can see immediately what happens. The lesson we learned is
> that most of our newer Python test cases are much more verbose and make
> more use of diffing aginst a reference output instead of asserting. This
> is what your qemu-img test should probably do as well.
> 
> And in fact, if it doesn't involve interacting with QMP in complex ways
> that actually need some programming to deal with the return values of
> the monitor, we wouldn't even write it in Python, but just in bash.
> 

Right, you'd review this new qemu-iotest, but the overall discussion
about an eventual larger collaboration would be missed.

>>> 2. How do we migrate the existing tests to the new infrastructure to
>>>    avoid fragmentation?
>>
>> Again, I haven't even thought of proposing that.  This is so dependent
>> on so many other aspects, including this initial feeling and feedback
>> from the maintainers.
> 
> But this is the most important point if we don't want to cause
> fragmentation of the tests!
> 
> The answer to it decides whether doing any of this makes sense.
> 
> Kevin
> 

Sorry but I can't commit at this point to writing such a proposal.
Maybe at a later time, priorities and common interests will better align
and we can revisit this topic.  I appreciate your time and feedback here
though.

Thanks,
- Cleber.
