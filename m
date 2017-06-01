Received: from eggs.gnu.org ([2001:4830:134:3::10]:35498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGJ8S-0007t4-M3
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGJ8P-0005kg-Kk
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:59:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dGJ8P-0005jE-Es
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:59:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2339467EAF
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 05:59:00 +0000 (UTC)
Date: Thu, 1 Jun 2017 13:58:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170601055853.GE32741@pxdev.xzpeter.org>
References: <20170531091720.21697-1-quintela@redhat.com>
	<20170531091720.21697-4-quintela@redhat.com>
	<20170531113924.GH2141@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170531113924.GH2141@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] migration: Remove section_id
 parameter from vmstate_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com

On Wed, May 31, 2017 at 12:39:25PM +0100, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > Everything else assumes that we always load a device from its own
> > savevm handler.
> 
> Except for the title (it's the version_id you're removing not
> section_id) but now I think this series is ok because you're always
> using
> the load_* stuff.
> 
> I guess in manyways the LoadStateEntry list made some sense; it was
> harder to accidentally use version_id rather than load_version_id if
> it was on a different pointer.

Indeed. After all it was:

struct LoadStateEntry {
    QLIST_ENTRY(LoadStateEntry) entry;
    SaveStateEntry *se;
    int section_id;
    int version_id;
};

And we moved the two variables into SaveStateEntry.

(I admit I didn't really notice the difference in v1...)

> 
> But generally now for the series:
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> 
> Dave
> 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
