Received: from eggs.gnu.org ([2001:4830:134:3::10]:51948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f5pxI-0005LF-Kr
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f5pxF-00087T-Eo
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:52:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58454
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1f5pxF-00086m-9I
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:52:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3A9p9a4033621
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 05:52:43 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h8sq6kq5x-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 05:52:43 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 10 Apr 2018 10:52:41 +0100
Date: Tue, 10 Apr 2018 15:22:33 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180331185536.4835-1-bala24@linux.vnet.ibm.com>
	<87sh8bz6is.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh8bz6is.fsf@secure.mitica>
Message-Id: <20180410095233.GA11713@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Apr 04, 2018 at 11:04:59AM +0200, Juan Quintela wrote:
> Balamuruhan S <bala24@linux.vnet.ibm.com> wrote:
> > expected_downtime value is not accurate with dirty_pages_rate * page_size,
> > using ram_bytes_remaining would yeild it correct.
> >
> > Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> See my other mail on the thread, my understanding is that your change is
> corret (TM).

Juan, Please help to merge it.

Regards,
Bala

> 
> Thanks, Juan.
> 
> > ---
> >  migration/migration.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 58bd382730..4e43dc4f92 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2245,8 +2245,7 @@ static void migration_update_counters(MigrationState *s,
> >       * recalculate. 10000 is a small enough number for our purposes
> >       */
> >      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> > -        s->expected_downtime = ram_counters.dirty_pages_rate *
> > -            qemu_target_page_size() / bandwidth;
> > +        s->expected_downtime = ram_bytes_remaining() / bandwidth;
> >      }
> >  
> >      qemu_file_reset_rate_limit(s->to_dst_file);
> 
