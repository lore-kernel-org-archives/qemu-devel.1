Received: from eggs.gnu.org ([2001:4830:134:3::10]:56387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f3jZB-0004tn-Ix
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f3jZ7-0002TK-Tm
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:39:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f3jZ7-0002Sx-Og
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:39:09 -0400
Date: Wed, 4 Apr 2018 15:38:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180404143859.GI3186@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
	<57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Apr 04, 2018 at 10:24:48AM -0400, Programmingkid wrote:
> 
> > On Apr 4, 2018, at 7:15 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > On 02/04/2018 16:13, Programmingkid wrote:
> >> 
> >>> On Apr 2, 2018, at 10:07 AM, qemu-devel-request@nongnu.org wrote:
> >>> 
> >>> Message: 2
> >>> Date: Mon, 2 Apr 2018 04:22:52 +0200
> >>> From: Paolo Bonzini <pbonzini@redhat.com>
> >>> To: Rainer M?ller <raimue@macports.org>, qemu-devel@nongnu.org
> >>> Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions
> >>> 	for MacPorts
> >>> Message-ID: <357029f4-71c0-a9f9-7bda-a5a44f609b27@redhat.com>
> >>> Content-Type: text/plain; charset=utf-8
> >>> 
> >>> On 01/04/2018 18:22, Rainer M?ller wrote:
> >>>> Signed-off-by: Rainer M?ller <raimue@macports.org>
> >>>> ---
> >>>> _download/macos.md | 6 +++++-
> >>>> 1 file changed, 5 insertions(+), 1 deletion(-)
> >>>> 
> >>>> diff --git a/_download/macos.md b/_download/macos.md
> >>>> index dbb312c..06aa811 100644
> >>>> --- a/_download/macos.md
> >>>> +++ b/_download/macos.md
> >>>> @@ -1,6 +1,10 @@
> >>>> -QEMU can be installed from Homebrew:
> >>>> +QEMU can be installed from <strong>Homebrew</strong>:
> >>>> 
> >>>> <pre>brew install qemu</pre>
> >>>> 
> >>>> +QEMU can be installed from <strong>MacPorts</strong>:
> >>>> +
> >>>> +<pre>sudo port install qemu</pre>
> >>>> +
> >>>> QEMU requires Mac OS X 10.5 or later, but it is recommended
> >>>> to use Mac OS X 10.7 or later.
> >>>> 
> >>> 
> >>> Thanks for the patch!  I'm travelling but I will apply it as soon as I can.
> >>> 
> >>> Paolo
> >> 
> >> I was wondering if a link to the Mac OS X host wiki page could be added to this page.
> >> It does have prebuilt binaries ready for use.
> >> 
> >> https://wiki.qemu.org/Hosts/Mac
> > 
> > Actually I believe we should remove those links.  I don't think hosting
> > QEMU binaries on mediafire is a good idea.
> > 
> > Paolo
> 
> Why not?

The source/quality of those binaries is completely opaque. We've no idea who
built them, nor what build options were used, nor what/where the corresponding
source is (required for GPL compliance), nor any checksum / signature to
validate the binary isn't compromised since build, etc, etc.

Pointing users to those binaries makes it appear QEMU project is blessing
them, and so any issues with them directly reflect on QEMU's reputation.

If we're going to link to binaries telling users to download them, we need
to be hosting them on qemu.org and have a clearly documented formal process
around building & distributing them.

Since both Homebrew & Macports are providing formal bulds though, it looks
simpler to just entirely delegate the problem to them, as we do for Linux
where we delegate to distro vendors to build & distribute binaries.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
