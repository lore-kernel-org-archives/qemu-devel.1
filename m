Received: from eggs.gnu.org ([2001:4830:134:3::10]:55390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpYdx-00005y-Ee
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpYdt-0001zT-Io
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpYdt-0001zD-DO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:37:13 -0400
Date: Wed, 6 Sep 2017 13:37:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170906133709.6072a661.cohuck@redhat.com>
In-Reply-To: <24e87c3e-2674-8fc1-cd0a-94f4907ddc7d@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
	<20170831111953.242ddc28.cohuck@redhat.com>
	<e805e756-495d-3125-eaf0-262635b9c545@linux.vnet.ibm.com>
	<20170905100234.7a92128e.cohuck@redhat.com>
	<bff0fcd2-4c1d-b5da-2d11-dc479d9d7275@linux.vnet.ibm.com>
	<20170905174606.1e0c6404.cohuck@redhat.com>
	<24e87c3e-2674-8fc1-cd0a-94f4907ddc7d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] s390x: fix invalid use of cc 1 for SSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

On Tue, 5 Sep 2017 19:20:43 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/05/2017 05:46 PM, Cornelia Huck wrote:
> > On Tue, 5 Sep 2017 17:24:19 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> >> Despite of that we already had a problem of this type: see 1728cff2ab
> >> ("s390x/3270: fix instruction interception handler", 2017-06-09) by 
> >> Dong Jia. If we had some automated testing covering all the asserts
> >> I would not think twice about using an assert here. But I don't think
> >> we do and I'm reluctant (not positive that assert is superior to what
> >> we have now). Maybe we could agree on reported by again.  
> > 
> > Yes, we (as in generally 'we') are really lacking automated testing...
> > (it is somewhere on my todo list).
> > 
> > Either leave it as-is, or do an assert. -ENODEV just feels wrong.
> >   
> 
> I think I will leave this one as is and maybe try to discuss with
> the folks here about reliable test coverage. Just spoke with Marc H.,
> and according to that we have a long way to go.

Ideally, we want something that can be executed from 'make check'. We
can already cover some basic stuff via tcg (I need to look into wiring
up more stuff), people with access to hardware should be able to cover
the rest.

That's not to say that extensive in-house testing by you guys wouldn't
be helpful, quite the contrary :)
