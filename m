Received: from eggs.gnu.org ([2001:4830:134:3::10]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gNg85-0001sV-T2
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gNg82-0007TI-Ka
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:33:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gNg82-0007T6-EK
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:33:54 -0500
Date: Fri, 16 Nov 2018 16:33:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181116163350.40fcd163.cohuck@redhat.com>
In-Reply-To: <20654e1b-38a0-7f70-df97-7ccd5bf17197@redhat.com>
References: <20181026105711.29605-1-cohuck@redhat.com>
	<20181115172032.53945f5e.cohuck@redhat.com>
	<1c020087-acd7-302a-d5be-dcdbf7b7084d@redhat.com>
	<20181116161400.1e3c2669.cohuck@redhat.com>
	<20654e1b-38a0-7f70-df97-7ccd5bf17197@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] MAINTAINERS: clarify some of the tags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On Fri, 16 Nov 2018 09:23:27 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 11/16/18 9:14 AM, Cornelia Huck wrote:

> >>>> +++ b/MAINTAINERS
> >>>> @@ -12,9 +12,14 @@ consult qemu-devel and not any specific individual privately.
> >>>>    Descriptions of section entries:
> >>>>    
> >>>>    	M: Mail patches to: FullName <address@domain>
> >>>> +	   Maintainers are looking after a certain area and must be CCed on
> >>>> +	   patches. They are considered the main contact point.  
> >>
> >> Maybe add something along the lines of "However, a maintainer may accept
> >> code that has been reviewed by others without explicitly reviewing it
> >> themselves"?  
> > 
> > I'm not sure whether that adds vital information. If a maintainer picks
> > a patch that has been reviewed by others, they may or may not do a
> > proper review themselves; but the end result is basically the same
> > (patch makes its way into the tree.)  
> 
> Okay. There's also the counter argument that too much text makes it 
> something that no one will want to spend time reading, so leaving things 
> concise is desirable.

We could also write up a more verbose "patch handling and
maintainership guide" or so; but I'd prefer short comments in
MAINTAINERS covering the basics only.

> 
> >> At any rate, I like the idea of adding the additional descriptions for
> >> the categories, even if we still bike-shed on the wording or even the
> >> set of categories to use.  
> > 
> > What about going with this as a starting point?  
> 
> Yes, works for me. We can always add more patches later if desired.

OK, great!

Peter, would you consider picking up this one for 3.1? At the very
least, it has a R-b from Markus already :)
