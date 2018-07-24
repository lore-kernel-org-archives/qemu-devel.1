Received: from eggs.gnu.org ([2001:4830:134:3::10]:58665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhyhy-0004ai-J9
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhyhv-0005FK-9e
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:54:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fhyhv-0005F5-27
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:54:35 -0400
Date: Tue, 24 Jul 2018 15:54:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180724145429.GD2374@work-vm>
References: <20180722193350.6028-1-zhangckid@gmail.com>
	<20180722193350.6028-11-zhangckid@gmail.com>
	<0f358f05-46c7-cb77-c9fd-1d6673493df4@redhat.com>
	<CAK3tnvJ1OnLBkFH3wD7GdT3pEK7_Wb5pw=8ig_9Ytv4=3fmX7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3tnvJ1OnLBkFH3wD7GdT3pEK7_Wb5pw=8ig_9Ytv4=3fmX7A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH V10 10/20] qmp event: Add COLO_EXIT event
 to notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

* Zhang Chen (zhangckid@gmail.com) wrote:
> On Tue, Jul 24, 2018 at 2:41 AM, Eric Blake <eblake@redhat.com> wrote:
> 
> > On 07/22/2018 02:33 PM, Zhang Chen wrote:
> >
> >> From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> >>
> >> If some errors happen during VM's COLO FT stage, it's important to
> >> notify the users of this event. Together with 'x-colo-lost-heartbeat',
> >> Users can intervene in COLO's failover work immediately.
> >> If users don't want to get involved in COLO's failover verdict,
> >> it is still necessary to notify users that we exited COLO mode.
> >>
> >> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> >> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>   migration/colo.c    | 31 +++++++++++++++++++++++++++++++
> >>   qapi/migration.json | 38 ++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 69 insertions(+)
> >>
> >
> > At this point in the release cycle, this series feels like enough of a new
> > feature (rather than a bug fix) that it is probably not appropriate for
> > 3.0, which means...
> >
> >
> > +++ b/qapi/migration.json
> >> @@ -900,6 +900,44 @@
> >>   { 'enum': 'FailoverStatus',
> >>     'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
> >>   +##
> >> +# @COLO_EXIT:
> >> +#
> >> +# Emitted when VM finishes COLO mode due to some errors happening or
> >> +# at the request of users.
> >> +#
> >> +# @mode: report COLO mode when COLO exited.
> >> +#
> >> +# @reason: describes the reason for the COLO exit.
> >> +#
> >> +# Since: 3.0
> >>
> >
> > ...this and other references should be updated to 3.1.
> 
> 
> OK, I will fix it and resend this series.

No need to resend now; resend after the review of the other bits in the
series; I'm sure there will be other minor things; anyway we can always
fix up version nunmbers in merge.

Dave

> Thanks
> Zhang Chen
> 
> 
> >
> >
> > --
> > Eric Blake, Principal Software Engineer
> > Red Hat, Inc.           +1-919-301-3266
> > Virtualization:  qemu.org | libvirt.org
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
