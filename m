Received: from eggs.gnu.org ([2001:4830:134:3::10]:55426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drp7t-00037y-Vp
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drp7p-0003cu-2Z
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:37:34 -0400
Date: Tue, 12 Sep 2017 14:37:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170912173723.GA7570@localhost.localdomain>
References: <1504605227-5124-1-git-send-email-thuth@redhat.com>
	<871snlwev0.fsf@dusky.pond.sub.org> <20170905164835.GF2112@work-vm>
	<6e03aa82-3663-c251-c8e1-ac2e7eb0e7e7@redhat.com>
	<87mv68e2i3.fsf@dusky.pond.sub.org>
	<20170909204133.GH7570@localhost.localdomain>
	<825b29f3-7857-558e-9092-855c9f75463e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825b29f3-7857-558e-9092-855c9f75463e@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH] tests: Add a device_add/del
 HMP test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Mon, Sep 11, 2017 at 08:13:21AM +0200, Thomas Huth wrote:
> On 09.09.2017 22:41, Eduardo Habkost wrote:
> > On Wed, Sep 06, 2017 at 08:59:32AM +0200, Markus Armbruster wrote:
> >> Thomas Huth <thuth@redhat.com> writes:
> >>
> >>> On 05.09.2017 18:48, Dr. David Alan Gilbert wrote:
> >>>> * Markus Armbruster (armbru@redhat.com) wrote:
> >>>>> Thomas Huth <thuth@redhat.com> writes:
> >>>>>
> >>>>>> People tend to forget to mark internal devices with "user_creatable = false
> >>>>>> or hotpluggable = false, and these devices can crash QEMU if added via the
> >>>>>> HMP monitor. So let's add a test to run through all devices and that tries
> >>>>>> to add them blindly (without arguments) to see whether this could crash the
> >>>>>> QEMU instance.
> [...]
> >>>>> * The device supports only cold plug with -device, not hot plug with
> >>>>>   device_add.
> >>>
> >>> We've got Eduardo's scripts/device-crash-test script for that already,
> >>> so no need to cover that here.
> >>
> >> Point taken.  So this test is really about hot plug / unplug.  Suggest
> >> to clarify the commit message: s/add them blindly/hotplug and unplug
> >> them blindly/.
> > 
> > We could extend device-crash-test to test device_add too, as it
> > already has extra code to deal with known crashes and testing
> > multiple machine-types.  Also, any additional code we write to
> > ensure we add mandatory arguments or plug only to valid buses
> > would apply to both -device and device_add.  I also think Python
> > test code is easier to maintain and extend, but that's just my
> > personal preference.
> 
> Adding device_add/del support to device-crash-test is certainly an
> option. The problem is that nobody runs it by default, so this won't
> help to avoid that new problems are being committed to the repository.
> 
> I think we really should have a test for "make check", too. So would my
> test be acceptable if I'd rewrite it to use QMP instead (I don't think I
> could do the full list that Markus mentioned, but at least a basic test
> via QMP as a start)?

We can run device-crash-test on "make check", we just need to
choose what's the subset of tests we want to run (because testing
all machine+device+target combinations would take too long).

But while device-crash-test doesn't support hotplug, I think your
test code would be good too.

-- 
Eduardo
