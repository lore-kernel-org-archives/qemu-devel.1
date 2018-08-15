Received: from eggs.gnu.org ([2001:4830:134:3::10]:46509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpkhA-0003kL-0e
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 21:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpkh6-0005Zf-NF
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 21:33:55 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpkh5-0005YD-Lz
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 21:33:51 -0400
Date: Tue, 14 Aug 2018 21:33:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180815013347.GD17669@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9e5rl4b.fsf@dusky.pond.sub.org>
	<20180814094347.GE2580@work-vm>
Subject: Re: [Qemu-devel] [PATCH 2/3] monitor: show sync profiling info with
 'info sync'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>

On Tue, Aug 14, 2018 at 10:43:47 +0100, Dr. David Alan Gilbert wrote:
> * Emilio G. Cota (cota@braap.org) wrote:
> > +@item info sync
> 
> As long as this is just for devs I'm OK with this from the HMP side;
> however, if you want to automate the display or wire it to other
> tools then you should probably wire it up via QMP.

On Tue, Aug 14, 2018 at 18:03:32 +0200, Markus Armbruster wrote:
> "Emilio G. Cota" <cota@braap.org> writes:
> > +@item info sync
> 
> Please explain briefly why you think this command is not going to be
> useful in QMP.  Recommend to do that right in your commit message.  For
> instance, you could argue that the information provided is useful only
> to developers, and developers are just fine with getting it from HMP
> "info sync".
> 
> However, if we expect developers to further process the data, providing
> it as JSON (via QMP) makes sense, because is saves them the trouble of
> parsing your (undocumented) HMP output format.
> 
> If we decide we want to provide the functionality in QMP, I can help you
> with the necessary code changes.

Thanks Dave and Markus for taking a look.

This is just for developers. This means (1) the info displayed and the
output format could change in the future, and (2) it is only meant
to be used from HMP "info sync-profile".

I'll include the above in the commit log, as Markus suggested.

> > +        .name       = "sync",
> 
> I think "info sync-profile" would be clearer.

Done.

Thanks,

		Emilio
