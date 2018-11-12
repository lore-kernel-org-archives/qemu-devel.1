Received: from eggs.gnu.org ([2001:4830:134:3::10]:49587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMDtC-0007pb-Li
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMDt2-0007vB-NN
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:12:32 -0500
Date: Mon, 12 Nov 2018 15:11:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181112151129.GR3602@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Mon, Nov 12, 2018 at 09:59:56AM -0500, Cleber Rosa wrote:
> 
> On 11/12/18 5:49 AM, Kevin Wolf wrote:
> > Am 09.11.2018 um 23:12 hat Cleber Rosa geschrieben:
> >> The initial goal of this RFC is to get feedback on tests not specific
> >> to the QEMU main binary, but specific to other components such as
> >> qemu-img.
> >>
> >> For this experiment, a small issue with the zero and negative number
> >> of I/O operations given to the bench command was chosen.
> > 
> > Any reason why this shouldn't be in qemu-iotests?
> > 
> > Kevin
> > 
> 
> Hi Kevin,
> 
> This is indeed one of the comments I was expecting to receive.  AFAIK,
> there's nothing that prevents such a *simple* test to be written as a
> qemu-iotest.
> 
> Having said that, one of the things we're trying to achieve with
> "tests/acceptance" is that a individual developer or maintainer, should
> be able to run a subset of tests that he/she cares about.
> 
> Suppose that this developer is working on a "snapshot" related feature,
> and wants to run tests that cover both "qemu-img snapshot" and then
> tests interacting with a guest running on a snapshotted image.  By using
> the tags mechanism, one could run:
> 
>  $ avocado run -t snapshot tests/acceptance
> 
> And run all tests related to snapshot.  This is one of the reasons for
> maybe allowing the type of test proposed here to live under
> "tests/acceptance".  Others include:
> 
>  * No numbering conflicts when naming tests
>  * More descriptive tests names and metadata

I've long thought we should change the naming for tests/qemu-iotests to
have descriptive names instead just forever clashing 3-digit numbers
that generate needless merge conflits

We also already have a tagging concept for iotests in the "groups"
file. Thus far we've only used a few generic names, but we could
expand that at will, so no reason why we couldn't have a "snapshot"
group listed there.

Personally I'd get rid of the groups file though, and just use magic
comments at the top of each test. This would again reduce needless
merge conflicts.

If people are doing work on the block layer I think they'll already
be used to runnng qemu-iotests as their acceptance test check. There
are already many there which only focus on qemu-img/qemu-io, and not
the QEMU system emulators

>  * No "context switch" for people also writing acceptance tests
>  * The various utility APIs available in both the Test class and on
> avocado.utils
> 
> BTW, since most tests Today exist outside of "tests/acceptance", that
> may be also be solved in a great part by adding support in the (Avocado)
> test runner about some metadata in tests such qemu-iotests.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
