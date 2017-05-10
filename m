Received: from eggs.gnu.org ([2001:4830:134:3::10]:43733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8WvC-0004Hu-Hl
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8Wv8-0003fy-JB
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:05:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8Wv8-0003fO-EI
	for qemu-devel@nongnu.org; Wed, 10 May 2017 15:05:10 -0400
Date: Wed, 10 May 2017 20:04:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170510190459.GD3941@work-vm>
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com>
	<e8f7410f-98d9-2e0e-b75d-0ff38fd81b35@redhat.com>
	<87tw4su3iw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tw4su3iw.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machines pc-0.10 to
 pc-0.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

* Markus Armbruster (armbru@redhat.com) wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 10.05.2017 11:08, Daniel P. Berrange wrote:
> >> On Wed, May 10, 2017 at 08:48:53AM +0200, Thomas Huth wrote:
> [...]
> >> Also unless we're going to get more serious about automated testing to
> >> validate machine type compatibility between *all* previously releases,
> >> I think that 6 years / 18 releases is too long a time to have any
> >> confidence in migration compatibility between versions.
> 
> Seconded.
> 
> > Distro vendors often offer 5 - 10 years support for certain versions of
> > their Linux distros, so I think we should at least support 5 years, too.
> 
> Non sequitur.
> 
> Distro vendors put in serious work to keep versions working for 5 - 10
> years.  We can't, and we don't.  All we do is try not to break things,
> which is nice, and helps the distro vendors some, but a far cry from
> anything I'd dare call "support".
> 
> Perhaps an argument could be made that us keeping to try for at least 5
> years would help distro vendors enough to be worthwhile.  Maybe, but
> color me skeptic.

Since I'm often the one having to fix the breakages when we find they've
diverged, I would prefer us to try to keep them working upstream.
Every time something slips through upstream it's more work for me.

Dave

> >> IOW, I think you should be more aggressive in culling old machine types
> >> that this patch is...
> >
> > Actually, I like the idea of using the major release versions for
> > defining the set of removal - hoping that we will do a v3.0 next year
> > which then would support the previous two major release versions 1.x and
> > 2.x, but drops support for the 0.xx versions completely ...
> 
> I wouldn't put *that* much weight into our past version numbers.  If I
> remember correctly, there was no more to 1.0 than a feeling of "this 0.x
> thing is getting ridiculous".
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
