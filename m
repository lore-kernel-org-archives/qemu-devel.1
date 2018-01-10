Received: from eggs.gnu.org ([2001:4830:134:3::10]:42449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZIoz-00068W-Qf
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZIoz-0000Uj-2f
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:01:45 -0500
Date: Wed, 10 Jan 2018 16:01:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180110160124.GC2451@work-vm>
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-3-vsementsov@virtuozzo.com>
	<20171208173321.GR2403@work-vm>
	<8711ff94-3d7a-446e-6da1-2e6e2b82899a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8711ff94-3d7a-446e-6da1-2e6e2b82899a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qapi: add name parameter to
 nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

* Eric Blake (eblake@redhat.com) wrote:
> On 12/08/2017 11:33 AM, Dr. David Alan Gilbert wrote:
> 
> >> @@ -2223,7 +2224,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
> >>      bool writable = qdict_get_try_bool(qdict, "writable", false);
> >>      Error *local_err = NULL;
> >>  
> >> -    qmp_nbd_server_add(device, true, writable, &local_err);
> >> +    qmp_nbd_server_add(device, false, NULL, true, writable, &local_err);
> > 
> > I wont insist, but it would be nice if you wired up an optional
> > parameter on HMP as well.
> 
> Can be done as a followup patch

Yes, agreed.

> I'm not sure how many people are
> setting up NBD exports via HMP, and I'm also okay with just stating that
> the full power requires use of QMP.  But I'll give such a followup patch
> a quick try, to see whether it is easy after all.

Thanks; I have set up NBD exports up via HMP a few times.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
