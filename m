Received: from eggs.gnu.org ([2001:4830:134:3::10]:56517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtqcE-0005jj-8O
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtqcB-0006Kp-6i
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dtqcB-0006Jx-07
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:37:11 -0400
Date: Mon, 18 Sep 2017 15:36:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170918073657.GA3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-15-git-send-email-peterx@redhat.com>
	<20170914153334.GC7370@stefanha-x1.localdomain>
	<20170915025947.GL3617@pxdev.xzpeter.org>
	<a43ad04c-77f8-928c-949e-48129711154c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a43ad04c-77f8-928c-949e-48129711154c@redhat.com>
Subject: Re: [Qemu-devel] [RFC 14/15] qmp: support out-of-band (oob)
 execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Sep 15, 2017 at 01:34:24PM -0500, Eric Blake wrote:
> On 09/14/2017 09:59 PM, Peter Xu wrote:
> > On Thu, Sep 14, 2017 at 04:33:34PM +0100, Stefan Hajnoczi wrote:
> >> On Thu, Sep 14, 2017 at 03:50:35PM +0800, Peter Xu wrote:
> >>> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> >>> index 61fa167..47d16bb 100644
> >>> --- a/docs/devel/qapi-code-gen.txt
> >>> +++ b/docs/devel/qapi-code-gen.txt
> 
> >>
> >> Is there a more relevant place to document QMP run-oob behavior than the
> >> "How to use the QAPI code generator document"?
> > 
> > I agree, but I don't really know it. :(
> > 
> > Markus, could you provide a hint?
> 
> I'm not Markus, but I suggest docs/interop/qmp-spec.txt

Sorry I should have noticed it before (I am always not sensitive on
the word "interop").  Thanks Eric!

-- 
Peter Xu
