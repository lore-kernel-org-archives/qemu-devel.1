Received: from eggs.gnu.org ([2001:4830:134:3::10]:53284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ceJux-0002wM-EE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ceJuu-00082p-A1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:08:07 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:57140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ceJut-000825-Uq
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:08:04 -0500
Date: Thu, 16 Feb 2017 06:08:01 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1904899621.22778187.1487243281219.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170216102042.GB494@stefanha-x1.localdomain>
References: <20170215144246.17756-1-stefanha@redhat.com>
	<faa63719-e836-d15d-8f00-07b2d795da99@redhat.com>
	<20170216102042.GB494@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu-web] Add Andrea's virtual memory
 FOSDEM presentation to blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>



----- Original Message -----
> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: qemu-devel@nongnu.org, "Stefan Hajnoczi" <stefanha@gmail.com>, "Thomas Huth" <thuth@redhat.com>
> Sent: Thursday, February 16, 2017 11:20:42 AM
> Subject: Re: [PATCH qemu-web] Add Andrea's virtual memory FOSDEM presentation to blog post
> 
> On Wed, Feb 15, 2017 at 04:00:44PM +0100, Paolo Bonzini wrote:
> > On 15/02/2017 15:42, Stefan Hajnoczi wrote:
> > > From: Stefan Hajnoczi <stefanha@gmail.com>
> > > 
> > > Andrea's presentation touches on Transparent Huge Pages and post-copy
> > > live migration using userfaultfd for virtualization use cases.
> > > 
> > > Cc: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> > > ---
> > > I don't know jekyll or how the blog is set up.  Perhaps timestamps need
> > > to be updated in the post file.  Please fix up when applying.
> > 
> > Right, I only had to add
> > 
> > last_modified_at: 2017-02-15 15:49:00 +0100
> > 
> > to the header.  So this will be also a nice example of how to update a
> > post after the fact!
> 
> Thanks for looking into it.
> 
> Weird that the blog engine relies on manual metadata rather than using
> file timestamps.

I think the reason is that the file timestamps can change for unrelated reasons:
adding a new permalink or fixing a typo may not be worth of adding the
"updated Feb 16, 2017" note on the page.  Wordpress and the like probably
have a similar behavior, you just don't see it because it's hidden in a
database rather than part of a text file. :)

Paolo
