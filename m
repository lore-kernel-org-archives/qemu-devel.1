Received: from eggs.gnu.org ([2001:4830:134:3::10]:49817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1corWP-0000se-CX
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1corWM-0004Ju-AV
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:02:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1corWM-0004Je-4G
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:02:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D501C67BCA
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 13:02:17 +0000 (UTC)
Date: Fri, 17 Mar 2017 13:02:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170317130212.GK2396@work-vm>
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-14-quintela@redhat.com>
	<b1d7d458-d3d3-a396-a048-21eea329a05c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d7d458-d3d3-a396-a048-21eea329a05c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/16] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> 
> 
> On 13/03/2017 13:44, Juan Quintela wrote:
> >          case RAM_SAVE_FLAG_MULTIFD_PAGE:
> >              fd_num = qemu_get_be16(f);
> > -            if (fd_num != 0) {
> > -                /* this is yet an unused variable, changed later */
> > -                fd_num = fd_num;
> > -            }
> > +            multifd_recv_page(host, fd_num);
> >              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> >              break;
> 
> I still believe this design is a mistake.

Is it a use of a separate FD carrying all of the flags/addresses that
you object to?

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
