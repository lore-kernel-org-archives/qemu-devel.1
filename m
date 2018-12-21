Received: from eggs.gnu.org ([2001:4830:134:3::10]:34145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaI0z-00054n-QU
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 05:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaI0v-0003GT-Pt
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 05:26:45 -0500
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:52437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gaI0v-0003FA-I1
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 05:26:41 -0500
Received: from player762.ha.ovh.net (unknown [10.109.160.232])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 15A1F1EF072
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 11:26:39 +0100 (CET)
Date: Fri, 21 Dec 2018 11:26:34 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181221112634.4abd9d02@bahia.lan>
In-Reply-To: <20181221093623.738b71e9@bahia.lan>
References: <beec7ae9-f9ce-52f0-7e55-cb25d70c51f4@ozlabs.ru>
	<d5247b86-4c9c-0eff-7900-66443041f63e@redhat.com>
	<20181221093623.738b71e9@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] travis failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>

On Fri, 21 Dec 2018 09:36:23 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 21 Dec 2018 07:47:07 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
> > On 2018-12-21 04:06, Alexey Kardashevskiy wrote:  
> > > Hi
> > > 
> > > I am trying https://travis-ci.org/aik/qemu/ and that thing fails every
> > > time I am not so sure why.
> > > 
> > > One example:
> > > https://travis-ci.org/aik/qemu/jobs/470796318
> > > 
> > > The errors are like this:
> > > 
> > >   GTESTER check-qtest-unicore32
> > >   GTESTER check-qtest-x86_64
> > > Could not access KVM kernel module: No such file or directory
> > > qemu-system-x86_64: failed to initialize KVM: No such file or directory
> > > qemu-system-x86_64: Back to tcg accelerator
> > > 
> > > 
> > > Does anyone else see those? How do we fix them? Thanks.    
> > 
> > Some test are explicitly requesting "-M accel=kvm:tcg" and this is
> > causing this message if KVM is not available. We could maybe silence
> > them if qtest_enabled() ?
> > 
> >  Thomas
> > 
> >   
> 
> I've also experienced a bunch of similar failures with travis, like:
> 
> https://travis-ci.org/gkurz/qemu/jobs/466994463
> 

Today with tests/test-qht-par again:

https://travis-ci.org/gkurz/qemu/jobs/470871251#L4455

Cc'ing Emilio for suggestions on how to go forward with this.

> The KVM error messages aren't directly related to the failure IMHO.
> 
> In both cases, the cause of the failure seems to be:
> 
> No output has been received in the last XXm0s, this potentially indicates a
> stalled build or something wrong with the build itself.
> Check the details on how to adjust your build configuration on:
> https://docs.travis-ci.com/user/common-build-problems/#Build-times-out-because-no-output-was-received
> The build has been terminated
> 
> and the last GTESTER line is for tests/test-qht-par:
> 
> https://travis-ci.org/aik/qemu/jobs/470796318#L8219
> 
> https://travis-ci.org/gkurz/qemu/jobs/466994463#L4454
> 
> This has been recently discussed on qemu-devel:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01638.html
> 
> But I haven't seen anything come out that yet.
> 
> 
