Received: from eggs.gnu.org ([2001:4830:134:3::10]:41469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHbsW-0000kT-7r
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHbsS-0007Vn-8J
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:39:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHbsS-0007VN-26
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:39:40 -0500
Date: Thu, 15 Dec 2016 19:39:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161215193932.GB16467@work-vm>
References: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
	<20161215175533-mutt-send-email-mst@kernel.org>
	<20161215160740.GN2509@work-vm>
	<20161215205122-mutt-send-email-mst@kernel.org>
	<20161215190355.GA16467@work-vm>
	<CAFEAcA8XtikQ54QN1dgCFjwntc==FxRnUH17Hh+NWdJc0aNWMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8XtikQ54QN1dgCFjwntc==FxRnUH17Hh+NWdJc0aNWMg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Introduce a new --only-migratable
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, John Snow <jsnow@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 15 December 2016 at 19:03, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > One thing we'd have to do if we did that would be to
> > add another flag to devices to declare that they might
> > sometime in the future call the migrate_add_blocker.
> 
> ...do you have a third-party library to suggest for
> the "foretell the future" functionality necessary
> for devices to implement this correctly? :-)

No, but it'll be available shortly.....

No, what I mean is there are actually three classes of devices:

    a) Devices that are always migratable
    b) Devices that are never migratable (i.e. set the flag in their
       device structure)
    c) Devices that dont have the flag set but sometimes
       based on the action of the guest call migrate_add_blocker.

If you wanted to make it introspectable in this way then you'd
have to add another flag to the device state so that (c) type
devices could be spotted in the introsepction - although
there's no good way to describe well if it's going to be unmigratable
most of the time (e.g. a 9pfs device that's mounted) or only
doing something odd.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
