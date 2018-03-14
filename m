Received: from eggs.gnu.org ([2001:4830:134:3::10]:53575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew7me-00035k-MH
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew7md-0001Mt-6N
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew7md-0001Mn-1n
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:53:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EA064023155
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 14:53:38 +0000 (UTC)
Date: Wed, 14 Mar 2018 14:53:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180314145334.GE3006@work-vm>
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-9-quintela@redhat.com>
	<20180313165339.GI3545@work-vm> <87vadyso9c.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vadyso9c.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v10 08/24] migration: Add multifd test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> We set the x-multifd-page-count and x-multifd-channels.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >
> >
> > This should probably go nearer the end of the series;
> 
> it is _much_ better here.  It makes so much easier to test that I don't
> break neither migration nor multifd while developing O:-)

OK, not a biggy.

> > we've also got the problem that things are a bit delicate with TCG so
> > adding more migration tests probably shouldn't happen until Paolo's
> > TCG fixes are worked out.
> 
> 
> 
> > Also, should we be checking for some stats to show all 4 channels were
> > used?
> 
> There are traces now, I can add new counters is that is what you want.

If it's easy then it's worth it.

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
