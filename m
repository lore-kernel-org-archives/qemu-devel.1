Received: from eggs.gnu.org ([2001:4830:134:3::10]:42111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1csulh-0006Gx-Ei
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1csulg-0001hI-84
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:18:53 -0400
Date: Tue, 28 Mar 2017 19:18:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170328171842.GE11725@noname.redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
Subject: [Qemu-devel] Deprecating the -drive option is a good point in time
 to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org

Am 27.03.2017 um 10:06 hat Thomas Huth geschrieben:
> On 24.03.2017 23:10, John Snow wrote:
> > On 03/08/2017 03:26 AM, Thomas Huth wrote:
> >>
> >>  Hi everybody,
> >>
> >> what will be the next version of QEMU after 2.9? Will we go for a 2.10
> >> (as I've seen it mentioned a couple of times on the mailing list
> >> already), or do we dare to switch to 3.0 instead?
> >>
> >> I personally dislike two-digit minor version numbers like 2.10 since the
> >> non-experienced users sometimes mix it up with 2.1 ... and there have
> >> been a couple of new cool features in the past releases that would
> >> justify a 3.0 now, too, I think.
> >>
> >> But anyway, the more important thing that keeps me concerned is: Someone
> >>  once told me that we should get rid of old parameters and interfaces
> >> (like HMP commands) primarily only when we're changing to a new major
> >> version number. As you all know, QEMU has a lot of legacy options, which
> >> are likely rather confusing than helpful for the new users nowadays,
> >> e.g. things like the "-net channel" option (which is fortunately even
> >> hardly documented), but maybe also even the whole vlan/hub concept in
> >> the net code, or legacy parameters like "-usbdevice". If we switch to
> >> version 3.0, could we agree to remove at least some of them?
> >>
> >>  Thomas
> >>
> > 
> > As others have stated, we need a few releases to deprecate things first.
> > 
> > Maybe we should develop a serious plan to develop some of our legacy
> > interfaces first.
> > 
> > Maybe 2.10 can introduce a list of things we want to deprecate,
> > 2.11 can be the transition release,
> > and then 3.0 can cut the cord and free of us our terrible burden?
> > 
> > I have a list of things I want to axe...
> 
> I've started a Wiki page with such a list here:
> 
> http://wiki.qemu-project.org/Features/LegacyRemoval
> 
> Feel free to amend!

I propose deprecating -drive (in favour of -blockdev/-device) and added
it to the list.

Similar to -net, we still need to check that all block devices created
internally by individual machines can still be configured. As far as I
know, this is already true for the PC, not sure about other machines.

But maybe we really should treat that as a problem of qdev/QOM, which
should provide a mechanism to set options for automatically created
devices rather than relying on subsystem-specific ways (like -net or
-drive) to bypass the normal qdev configuration.

Kevin
