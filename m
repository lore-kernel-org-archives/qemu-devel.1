Received: from eggs.gnu.org ([2001:4830:134:3::10]:54537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1VwY-0005nJ-9h
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1VwU-0006p6-7A
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:09:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1VwU-0006ok-0M
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 07:09:50 -0400
Date: Mon, 9 Oct 2017 13:09:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171009130945.3c58e6cb.cohuck@redhat.com>
In-Reply-To: <7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
	<d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
	<7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/8] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, 9 Oct 2017 12:54:03 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 10/09/2017 10:20 AM, Thomas Huth wrote:
> > On 04.10.2017 17:41, Halil Pasic wrote:  

> >> +/* IO instructions conclude according this */
> >> +typedef struct IOInstEnding {
> >> +        /*
> >> +         * General semantic of cc codes of IO instructions is (brief):
> >> +         * 0 -- produced expected result
> >> +         * 1 --  status conditions were present or produced alternate result
> >> +         * 2 -- ineffective, because busy with previously initiated function
> >> +         * 3 -- ineffective, not operational
> >> +         */
> >> +        int cc;
> >> +} IOInstEnding;  
> > 
> > Why do you need a struct for this? Do you plan to extend it later? If
> > so, I think you should mention that in the patch description. If not,
> > please use a named enum or a "typedef unsigned int IOInstEnding" instead.
> > 
> >  Thomas  
> 
> We may, we may not. In the previous version we also had to support
> do end a certain instruction with an addressing exception, but this
> is going away in patch #3. Honestly I don't expect this being extended.
> 
> I have other reasons for the struct. Type safety and clear semantics,
> and frankly at least for s390 and linux I don't see any downsides given
> what is written in the "zSeries ELF Application Binary Interface Supplement".
> Can you please explain to me what is the problem with using this struct, and
> what is the benefit switching to a unsigned int?

Honestly, I fail to see the benefit of using a struct here... it's just
a condition code, and while adding a comment what the various codes
mean for I/O instructions is a good idea, I think having to use a
IOInstEnding struct just renders the code less readable.

[I haven't had time to look at the rest of the patches yet.]
