Received: from eggs.gnu.org ([2001:4830:134:3::10]:60211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dS0At-0007qu-T9
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dS0Aq-0000rX-LT
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:09:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dS0Aq-0000r4-F7
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:09:52 -0400
Date: Mon, 3 Jul 2017 13:09:45 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170703120945.GG5663@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-2-git-send-email-yang.zhong@intel.com>
	<20170703102043.GE5663@redhat.com>
	<68cbc479-3707-cdab-4dcd-d055b02ede7d@redhat.com>
	<20170703103340.GF5663@redhat.com>
	<650bf1e9-ba8c-c7a5-9e48-94dc970523d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <650bf1e9-ba8c-c7a5-9e48-94dc970523d6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/15] configure: add the disable-tcg
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On Mon, Jul 03, 2017 at 12:55:04PM +0200, Paolo Bonzini wrote:
> 
> 
> On 03/07/2017 12:33, Daniel P. Berrange wrote:
> >> i386-softmmu and x86_64-softmmu are singled out here, because they're
> >> the only targets where --disable-tcg compiles.  For the others, more
> >> work is needed (see patches 6-15 in Yang Zhong's series).
> >
> > Even with that, you still can't disable TCG if building on a non-x86
> > host, since that'd leave you with no available CPU at all. So the
> > code still needs refactoring to check architectures properly.
> 
> It would leave you with a tools-only build; whether that's a good idea,
> it's another story.  I think it's acceptable, but others may disagree.

If you do 'configure --target-list=x86_64-softmmu --disable-tcg' on a
non-x86 host I would be surprised to find  x86_64-softmmu not built.
IMHO if you explicitly request system emulators and its not posisble
to build then, an error should be report, rather than silently ignoring
the request.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
