Received: from eggs.gnu.org ([2001:4830:134:3::10]:35054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daff6-00061s-J7
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daff2-0004ws-Ox
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:04:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1daff2-0004uv-GB
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:04:52 -0400
Date: Thu, 27 Jul 2017 11:04:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170727100442.GF2555@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
	<20170717103308.GI7163@stefanha-x1.localdomain>
	<8760epr9vw.fsf@dusky.pond.sub.org>
	<20170721153331.GL18014@stefanha-x1.localdomain>
	<026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
	<8760eiuxu5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8760eiuxu5.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <cleber@redhat.com>

On Mon, Jul 24, 2017 at 08:56:50AM +0200, Markus Armbruster wrote:
> Cleber Rosa <crosa@redhat.com> writes:
> 
> > On 07/21/2017 11:33 AM, Stefan Hajnoczi wrote:
> >>> Output testing style delegates checking ouput to diff.  I rather like it
> >>> when text output is readily available.  It is when testing QMP.  A
> >>> non-trivial example using this style could be useful, as discussing
> >>> ideas tends to be more productive when they come with patches.
> >> 
> >> Yes, I was considering how many of the Python iotests could be rewritten
> >> comfortably in shell.  It is nice when the test simply executes commands
> >> and the output file shows the entire history of what happened.  Great
> >> for debugging.
> >> 
> >> Stefan
> >> 
> > I'd like to have a better understanding of the major pain points here.
> >
> > Although this can be seen as a matter of taste, style preferences and
> > even religion, I guess it's safe to say that Python can scale better
> > than shell.  The upside of shell based tests is the "automatic" and
> > complete logging, right?  Running "bash -x /path/to/test.sh" will give
> > much more *useful* information than "python -v /path/to/test.py" will, fact.
> >
> > I believe this has to do with how *generic* Python code is written, and
> > how builtin functions and most of the standard Python libraries work as
> > they do.  Now, when writing code aimed at testing, making use of testing
> > oriented libraries and tools, one would expect much more useful and
> > readily available debug information.
> >
> > I'm biased, for sure, but that's what you get when you write basic tests
> > using the Avocado libraries.  For instance, when using process.run()[1]
> > within a test, you can choose to see its command output quite easily
> > with a command such as "avocado --show=avocado.test.stdout run test.py".
> >
> > Using other custom logging channels is also trivial (for instance for
> > specific QMP communication)[2][3].
> >
> > I wonder if such logging capabilities fill in the gap of what you
> > describe as "[when the] output file shows the entire history of what
> > happened".
> 
> Test code language is orthogonal to verification method (with code
> vs. with diff).  Except verifying with shell code would be obviously
> nuts[*].
> 
> The existing iotests written in Python verify with code, and the ones
> written in shell verify with diff.  Doesn't mean that we have to port
> from Python to shell to gain "verify with diff".

Nb, not all the python tests verify with code. The LUKS test 149 that
I wrote in python verifies  with diff. I chose python because shell is
an awful programming language if the code needs conditionals, non-scalar
data structures, or is more than 10 lines long in total :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
