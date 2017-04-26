Received: from eggs.gnu.org ([2001:4830:134:3::10]:40232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Mio-000733-2m
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Mij-0004E3-Ui
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:11:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3Mij-0004Dm-OW
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:11:01 -0400
Date: Wed, 26 Apr 2017 14:10:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426131056.GX18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1493161481-29595-9-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170426110202.GF18933@redhat.com>
	<8760694f-6e70-4f0f-9482-9eb7075eb6c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8760694f-6e70-4f0f-9482-9eb7075eb6c7@redhat.com>
Subject: Re: [Qemu-devel] [PULL 8/8] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, Vinzenz Feenstra <vfeenstr@redhat.com>

On Wed, Apr 26, 2017 at 08:08:25AM -0500, Eric Blake wrote:
> On 04/26/2017 06:02 AM, Daniel P. Berrange wrote:
> > On Tue, Apr 25, 2017 at 06:04:41PM -0500, Michael Roth wrote:
> >> From: Vinzenz Feenstra <vfeenstr@redhat.com>
> >>
> >> Adds a new command `guest-get-timezone` reporting the currently
> >> configured timezone on the system. The information on what timezone is
> >> currently is configured is useful in case of Windows VMs where the
> >> offset of the hardware clock is required to have the same offset. This
> >> can be used for management systems like `oVirt` to detect the timezone
> >> difference and warn administrators of the misconfiguration.
> > 
> >> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> >> +{
> > 
> >> +    name = g_time_zone_get_abbreviation(tz, intv);
> > 
> > [snip]
> > 
> >> +##
> >> +# @GuestTimezone:
> >> +#
> >> +# @zone:    Timezone name
> > 
> > This isn't clearly documented in glib, but it looks like the time zone
> > names are *different* when glib is run on POSIX vs Win32 platforms.
> > 
> > Do we really want to expose something in QAPI that is going to have
> > different semantics depending on the guest OS the agent runs in ?
> > 
> 
> Maybe it's just a matter of proper documentation.  The 'offset' field is
> the important one, with unambiguous machine-parseable semantics; the
> 'zone' field is an optional, informative, human-readable format
> according to the guest OS's whims, and should not be relied on for
> scripting purposes.

Yeah, if it is only intended for informative purposes this should be
explicitly documented that it is not standardized across guests.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
