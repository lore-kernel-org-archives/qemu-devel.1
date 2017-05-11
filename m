Received: from eggs.gnu.org ([2001:4830:134:3::10]:45598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8iPE-0003z8-9K
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8iPB-0002iA-2I
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:21:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8iPA-0002h1-TB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:20:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com>
	<e8f7410f-98d9-2e0e-b75d-0ff38fd81b35@redhat.com>
	<87tw4su3iw.fsf@dusky.pond.sub.org> <20170510190459.GD3941@work-vm>
Date: Thu, 11 May 2017 09:20:50 +0200
In-Reply-To: <20170510190459.GD3941@work-vm> (David Alan Gilbert's message of
	"Wed, 10 May 2017 20:04:59 +0100")
Message-ID: <87lgq3luzx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>> > On 10.05.2017 11:08, Daniel P. Berrange wrote:
>> >> On Wed, May 10, 2017 at 08:48:53AM +0200, Thomas Huth wrote:
>> [...]
>> >> Also unless we're going to get more serious about automated testing to
>> >> validate machine type compatibility between *all* previously releases,
>> >> I think that 6 years / 18 releases is too long a time to have any
>> >> confidence in migration compatibility between versions.
>> 
>> Seconded.
>> 
>> > Distro vendors often offer 5 - 10 years support for certain versions of
>> > their Linux distros, so I think we should at least support 5 years, too.
>> 
>> Non sequitur.
>> 
>> Distro vendors put in serious work to keep versions working for 5 - 10
>> years.  We can't, and we don't.  All we do is try not to break things,
>> which is nice, and helps the distro vendors some, but a far cry from
>> anything I'd dare call "support".
>> 
>> Perhaps an argument could be made that us keeping to try for at least 5
>> years would help distro vendors enough to be worthwhile.  Maybe, but
>> color me skeptic.
>
> Since I'm often the one having to fix the breakages when we find they've
> diverged, I would prefer us to try to keep them working upstream.
> Every time something slips through upstream it's more work for me.

I figure when downstream rebases from upstream version V to V+3, then
upstream having tried not to break things for three versions back helps,
but from that fork on, the value of upstream trying diminishes sharply.

That makes me doubt the idea that upstream should try for as long as any
downstream version exists ("at least 5 years").  Until downstreams
rebase makes more sense to me.
