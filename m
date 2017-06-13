Received: from eggs.gnu.org ([2001:4830:134:3::10]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKjxm-00011A-Qi
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dKjxj-00035e-O4
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:26:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dKjxj-00035Y-Hm
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 07:26:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A92A6810D
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 11:26:18 +0000 (UTC)
Date: Tue, 13 Jun 2017 12:26:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170613112612.GG2096@work-vm>
References: <20170320173840.3626-1-dgilbert@redhat.com>
	<20170320173840.3626-3-dgilbert@redhat.com>
	<1490078281.7490.0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490078281.7490.0.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] wavcapture: Convert to error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, quintela@redhat.com

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> On Mo, 2017-03-20 at 17:38 +0000, Dr. David Alan Gilbert (git) wrote:
> > Kill off a pile of monitor_printf's and cur_mon usage.
> > The only one left in wavcapture.c is the info case.
> 
> Reviewed-by: Gerd Hoffmann <kraxel@gmail.com>

Can you pick that one up via your audio tree?

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
