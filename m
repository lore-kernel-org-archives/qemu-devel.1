Received: from eggs.gnu.org ([209.51.188.92]:38334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gordN-0004RH-Pu
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gordM-0002iR-T4
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:18:37 -0500
Date: Wed, 30 Jan 2019 15:18:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190130151829.GT15904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1548769067-20792-1-git-send-email-thuth@redhat.com>
	<20190129145156.6719b8a4.cohuck@redhat.com>
	<e3dfae55-8733-bd01-1f13-422f343fb258@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3dfae55-8733-bd01-1f13-422f343fb258@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Fix LGPL version in the file
 header comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Wed, Jan 30, 2019 at 09:01:01AM -0600, Eric Blake wrote:
> On 1/29/19 7:51 AM, Cornelia Huck wrote:
> > On Tue, 29 Jan 2019 14:37:47 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> > 
> >> It's either "GNU *Library* General Public License version 2" or
> >> "GNU Lesser General Public License version *2.1*", but there was
> >> no "version 2.0" of the "Lesser" license. So assume that version
> >> 2.1 is meant here.
> > 
> > I think we can assume that.
> > 
> > Given that there have been several of these cases (and that there's a
> > lot of boilerplate in general): Should we adopt SPDX license
> > identifiers for QEMU, as the Linux kernel did? They also discovered and
> > fixed some problems/oddities while at it.
> 
> I'm also in favor of SPDX license identifiers - their brevity and
> machine-parsability favors more accurate usage and fewer copy/paste
> mistake propagation.

I'm curious if the kernel developers actually ended up removing the
current boilerplate license text from files they added SPDX tags
to ?

The original work only added SPDX tags to files which lacked any
pre-existing license text

  https://lwn.net/Articles/739183/

Although its from 2017, the LWN article indicates there was
some uncertainty about whether they'd actually go through with
removing license text, especially for files where the person
removing the text is not the exclusive copyright holder:


  "An additional goal is to eventually get rid of the other license
   texts; the consensus seems to be that the SPDX identifier is a 
   sufficient declaration of the license on its own. But removing
   license text from source files must be done with a great deal 
   of care, so it may be a long time before anybody works up the 
   courage to attempt that on any files that they do not themselves 
   own the copyright for. "

I can understand the sentiment that SPDX identifier alone should be
sufficient, but I think I'd want to see an explicit legal opinion from
a lawyer who works with open source before removing any license text.

Any one know if anything changed in this respect since that 2017
lwn article ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
