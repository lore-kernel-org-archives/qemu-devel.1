Received: from eggs.gnu.org ([2001:4830:134:3::10]:40229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8ROJ-0006J2-AL
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8ROD-0007ju-Rb
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:15:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f8ROD-0007ja-FF
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:15:21 -0400
Date: Tue, 17 Apr 2018 15:15:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180417141518.GF15421@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-FaS+HeihGmbhrLAR8e=jmz-Og+OKGakGX7MGb_KgwCw@mail.gmail.com>
	<d002e4ff-e0c9-f66e-a25a-51605a79b55f@weilnetz.de>
	<CAFEAcA_rswg=c-QWcL1VraqiOEN1+zPmGG=-AP2f2CnYUA0K+g@mail.gmail.com>
	<37db1c18-cb62-0d93-3b4c-38d2ab20c804@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37db1c18-cb62-0d93-3b4c-38d2ab20c804@weilnetz.de>
Subject: Re: [Qemu-devel] Last call for release-critical fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Apr 17, 2018 at 04:05:46PM +0200, Stefan Weil wrote:
> Am 17.04.2018 um 15:50 schrieb Peter Maydell:
> > On 17 April 2018 at 14:19, Stefan Weil <sw@weilnetz.de> wrote:
> >> Update po files? That's not a "must fix", but it would be nice to have
> >> those files synchronized with ui/gtk.c again.
> > Judging by the "POT-Creation-Date" timestamps, we haven't done
> > that for a year or so, so there doesn't seem to be a great
> > urgency to do it now.
> >
> > Overall:
> >  * I don't really understand why we need to keep doing this;
> >    I tried "make -C po update" but all it did was update the
> >    date stamp and a bunch of comments in the .po files
> >  * If we do need to do this, we need to come up with a
> >    process (preferably automatic) that ensures that we do
> >    it in a more timely manner than "somebody mentions it
> >    on the day we're thinking of tagging the final rc"
> >
> > Asking me to manually run a magic command I don't understand
> > doesn't really work, as you can see from how infrequently
> > it's happened.
> >
> > thanks
> > -- PMM
> 
> The only visible consequence if it is not done is that developers who
> run "make install" (which updates the po files) then have a local code
> modification which is in the way if they are working with git. Not many
> run "make install", and obviously those who do can handle the situation.
> I think that there would be a real problem if people tried to build with
> the source on a read only medium.
> 
> I wonder whether generating the po files without the line comments would
> improve the situation. Currently each added or removed line in ui/gtk.c
> changes the line numbers which are part of the comments. If the comments
> would not include line numbers, then only relevant changes of message
> texts would need an update of the po files. Maybe we should try that for
> the next release.

Yes, storing full po files in GIT is really awful for a number of reasons.
Stripping source location comments when storing in git is good, because
those because out of date the moment someone changes the code containging
the original msgid. You also want to sort msgids alphabetically instead
by source location so you don't get stuff moving around all in the po
file when code is refactored/moved/renamed.

I've coincidentally been tackling this same problem in libvirt just last
week

  https://www.redhat.com/archives/libvir-list/2018-April/msg01004.html

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
