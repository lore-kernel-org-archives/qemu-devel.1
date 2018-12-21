Received: from eggs.gnu.org ([2001:4830:134:3::10]:40012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaPX0-0002mg-8W
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 13:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaPWx-0000oG-04
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 13:28:18 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40371)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gaPWw-0000mt-Oj
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 13:28:14 -0500
Date: Fri, 21 Dec 2018 13:28:10 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181221182810.GA11197@flamenco>
References: <beec7ae9-f9ce-52f0-7e55-cb25d70c51f4@ozlabs.ru>
	<d5247b86-4c9c-0eff-7900-66443041f63e@redhat.com>
	<20181221093623.738b71e9@bahia.lan>
	<20181221112634.4abd9d02@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221112634.4abd9d02@bahia.lan>
Subject: Re: [Qemu-devel] travis failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Dec 21, 2018 at 11:26:34 +0100, Greg Kurz wrote:
> On Fri, 21 Dec 2018 09:36:23 +0100
> Greg Kurz <groug@kaod.org> wrote:
> 
> > On Fri, 21 Dec 2018 07:47:07 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> > 
> > > On 2018-12-21 04:06, Alexey Kardashevskiy wrote:  
> > > > Hi
> > > > 
> > > > I am trying https://travis-ci.org/aik/qemu/ and that thing fails every
> > > > time I am not so sure why.
> > > > 
> > > > One example:
> > > > https://travis-ci.org/aik/qemu/jobs/470796318
> > > > 
> > > > The errors are like this:
> > > > 
> > > >   GTESTER check-qtest-unicore32
> > > >   GTESTER check-qtest-x86_64
> > > > Could not access KVM kernel module: No such file or directory
> > > > qemu-system-x86_64: failed to initialize KVM: No such file or directory
> > > > qemu-system-x86_64: Back to tcg accelerator
> > > > 
> > > > 
> > > > Does anyone else see those? How do we fix them? Thanks.    
> > > 
> > > Some test are explicitly requesting "-M accel=kvm:tcg" and this is
> > > causing this message if KVM is not available. We could maybe silence
> > > them if qtest_enabled() ?
> > > 
> > >  Thomas
> > > 
> > >   
> > 
> > I've also experienced a bunch of similar failures with travis, like:
> > 
> > https://travis-ci.org/gkurz/qemu/jobs/466994463
> > 
> 
> Today with tests/test-qht-par again:
> 
> https://travis-ci.org/gkurz/qemu/jobs/470871251#L4455
> 
> Cc'ing Emilio for suggestions on how to go forward with this.

Yes, this was being discussed in this thread:

  https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01638.html

I haven't heard from Eduardo in a while, I guess he's off for the
holidays.

My latest suggestion was to try a branch where test-qht-par is
standalone, instead of using system(3) to call qht-bench--see
this message:
  https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02056.html

Can anyone please try that? Or at least let me know how to run
a test Travis build so that I can debug this faster.

Thanks,

		Emilio
