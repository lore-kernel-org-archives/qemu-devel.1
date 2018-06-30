Received: from eggs.gnu.org ([2001:4830:134:3::10]:42993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fZ5Bg-0001pu-9F
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 22:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fZ5Be-0007lp-NE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 22:00:32 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:55508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fZ5Bd-0007k8-Sz
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 22:00:30 -0400
Received: by mail-wm0-x234.google.com with SMTP id v16-v6so3832244wmv.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 19:00:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629091438.GC2568@work-vm>
References: <20180627204136.4177-1-zhangckid@gmail.com>
	<20180627204136.4177-12-zhangckid@gmail.com>
	<3464fd15-6b1c-b524-0445-58fb352c1b42@redhat.com>
	<20180629091438.GC2568@work-vm>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sat, 30 Jun 2018 10:00:27 +0800
Message-ID: <CAK3tnvLF6Hqk6oLurcop7ngQkWLy5FHmJODwGH4sKYTjn2QfKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V9 11/20] qapi/migration.json: Rename COLO
 unknown mode to none mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

On Fri, Jun 29, 2018 at 5:14 PM, Dr. David Alan Gilbert <dgilbert@redhat.com
> wrote:

> * Eric Blake (eblake@redhat.com) wrote:
> > On 06/27/2018 03:41 PM, Zhang Chen wrote:
> > > From: Zhang Chen <chen.zhang@intel.com>
> > >
> > > Suggested by Markus Armbruster rename COLO unknown mode to none mode.
> > >
> > > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > > ---
> > >   migration/colo-failover.c |  2 +-
> > >   migration/colo.c          |  2 +-
> > >   qapi/migration.json       | 10 +++++-----
> > >   3 files changed, 7 insertions(+), 7 deletions(-)
> >
> > >   # Since: 2.8
> > >   ##
> > >   { 'enum': 'COLOMode',
> > > -  'data': [ 'unknown', 'primary', 'secondary'] }
> > > +  'data': [ 'none', 'primary', 'secondary'] }
> >
> > The deletion of 'unknown' could potentially be a user-visible regression
> > visible if COLOMode were in a QMP command; but thankfully the generated
> > qapi/qapi-introspect.c does not seem to cover this enum, so it just
> affects
> > internal code for now.
>
> Note that the migration capability to enable colo is still x-colo;
> so I take that to mean we've still got a free hand to change any part of
> the COLO interface until we're happy it's right.
>
> Dave
>
>
Thanks Eric and Dave.

Zhang Chen



> > Reviewed-by: Eric Blake <eblake@redhat.com>
> >
> > --
> > Eric Blake, Principal Software Engineer
> > Red Hat, Inc.           +1-919-301-3266
> > Virtualization:  qemu.org | libvirt.org
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
