Received: from eggs.gnu.org ([2001:4830:134:3::10]:45553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clZiC-00069Z-1m
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clZi8-0003fy-3t
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:24:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1clZi7-0003fr-Ta
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 06:24:52 -0500
Date: Wed, 8 Mar 2017 11:24:41 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170308112441.GI7470@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>

On Wed, Mar 08, 2017 at 12:22:24PM +0100, Thomas Huth wrote:
> On 08.03.2017 11:03, Peter Maydell wrote:
> > On 8 March 2017 at 09:26, Thomas Huth <thuth@redhat.com> wrote:
> >> But anyway, the more important thing that keeps me concerned is: Someone
> >>  once told me that we should get rid of old parameters and interfaces
> >> (like HMP commands) primarily only when we're changing to a new major
> >> version number. As you all know, QEMU has a lot of legacy options, which
> >> are likely rather confusing than helpful for the new users nowadays,
> >> e.g. things like the "-net channel" option (which is fortunately even
> >> hardly documented), but maybe also even the whole vlan/hub concept in
> >> the net code, or legacy parameters like "-usbdevice". If we switch to
> >> version 3.0, could we agree to remove at least some of them?
> > 
> > I think if we are going to deprecate and remove options we need
> > a clear transition plan for doing so, which means at least one
> > release where options are "still works, but warn that they
> > are going away with pointer to documentation or similar info
> > about their replacement syntax", before actually dropping them.
> 
> Yes, that's certainly a good idea. But as Daniel suggested in his mail,
> I think we should also have the rule that the option should be marked as
> deprecated in multiple releases first - so that the users have a chance
> to speak up before something gets really removed (otherwise the option
> could be removed right on the first day after the initial release with
> the deprecation message, so there is no time for the user to notice this
> and complain). Not sure whether we need three releases, as Daniel
> suggested, though, but if that's common sense, that's fine for me, too.

FYI, I didn't put any thought into my 3 releases / 12 months numbers. I
just arbitrarily picked them out of the hat, so don't consider it my
endorsement of that particular length of time :-) I think 2 is the minimum
number of releases we should deprecate for, beyond that, I'm open minded

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
