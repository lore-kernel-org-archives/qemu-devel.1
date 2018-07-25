Received: from eggs.gnu.org ([2001:4830:134:3::10]:53643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fiBbA-0004A7-Ft
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 00:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fiBb7-0007Mi-G6
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 00:40:28 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fi9Bx-0007AY-RF
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 22:06:23 -0400
Received: by mail-wm0-x244.google.com with SMTP id s14-v6so4357137wmc.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 19:06:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180724145429.GD2374@work-vm>
References: <20180722193350.6028-1-zhangckid@gmail.com>
	<20180722193350.6028-11-zhangckid@gmail.com>
	<0f358f05-46c7-cb77-c9fd-1d6673493df4@redhat.com>
	<CAK3tnvJ1OnLBkFH3wD7GdT3pEK7_Wb5pw=8ig_9Ytv4=3fmX7A@mail.gmail.com>
	<20180724145429.GD2374@work-vm>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 25 Jul 2018 09:12:27 +0800
Message-ID: <CAK3tnvJjJFWXmnDdYczfswaMZLbSRHDj+r7pco=VNFrWBQM47Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On Tue, Jul 24, 2018 at 10:54 PM, Dr. David Alan Gilbert <
dgilbert@redhat.com> wrote:

> * Zhang Chen (zhangckid@gmail.com) wrote:
> > On Tue, Jul 24, 2018 at 2:41 AM, Eric Blake <eblake@redhat.com> wrote:
> >
> > > On 07/22/2018 02:33 PM, Zhang Chen wrote:
> > >
> > >> From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > >>
> > >> If some errors happen during VM's COLO FT stage, it's important to
> > >> notify the users of this event. Together with 'x-colo-lost-heartbeat',
> > >> Users can intervene in COLO's failover work immediately.
> > >> If users don't want to get involved in COLO's failover verdict,
> > >> it is still necessary to notify users that we exited COLO mode.
> > >>
> > >> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > >> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > >> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > >> Reviewed-by: Eric Blake <eblake@redhat.com>
> > >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > >> ---
> > >>   migration/colo.c    | 31 +++++++++++++++++++++++++++++++
> > >>   qapi/migration.json | 38 ++++++++++++++++++++++++++++++++++++++
> > >>   2 files changed, 69 insertions(+)
> > >>
> > >
> > > At this point in the release cycle, this series feels like enough of a
> new
> > > feature (rather than a bug fix) that it is probably not appropriate for
> > > 3.0, which means...
> > >
> > >
> > > +++ b/qapi/migration.json
> > >> @@ -900,6 +900,44 @@
> > >>   { 'enum': 'FailoverStatus',
> > >>     'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
> > >>   +##
> > >> +# @COLO_EXIT:
> > >> +#
> > >> +# Emitted when VM finishes COLO mode due to some errors happening or
> > >> +# at the request of users.
> > >> +#
> > >> +# @mode: report COLO mode when COLO exited.
> > >> +#
> > >> +# @reason: describes the reason for the COLO exit.
> > >> +#
> > >> +# Since: 3.0
> > >>
> > >
> > > ...this and other references should be updated to 3.1.
> >
> >
> > OK, I will fix it and resend this series.
>
> No need to resend now; resend after the review of the other bits in the
> series; I'm sure there will be other minor things; anyway we can always
> fix up version nunmbers in merge.
>

OK, I got it.

Thanks
Zhang Chen


>
> Dave
>
> > Thanks
> > Zhang Chen
> >
> >
> > >
> > >
> > > --
> > > Eric Blake, Principal Software Engineer
> > > Red Hat, Inc.           +1-919-301-3266
> > > Virtualization:  qemu.org | libvirt.org
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
