Received: from eggs.gnu.org ([2001:4830:134:3::10]:49857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cqInu-0003kU-R7
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cqInq-00010D-J4
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cqInq-000108-Cv
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:22:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CCA1635E9
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 12:22:18 +0000 (UTC)
Date: Tue, 21 Mar 2017 12:22:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170321122211.GD3248@work-vm>
References: <20170320173840.3626-1-dgilbert@redhat.com>
	<87bmsuomgf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmsuomgf.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 0/2 for 2.10] Remove some monitor_printf's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:
> 
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > I found myself trying to understand cur_mon and found a bunch
> > of uses that could easily be replaced by error_report or Error **.
> 
> Speaking of cur_mon: a patch making it thread-local would be most
> welcome.

Yep, that's what I was thinking about while I was just working out where
it's used.

> Some of error wavcapture messages still aren't so great, but it's an
> obvious improvement, so
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
