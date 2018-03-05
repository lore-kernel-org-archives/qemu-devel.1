Received: from eggs.gnu.org ([2001:4830:134:3::10]:37185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esnvx-0004Yx-Pd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1esnvu-0006we-M1
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:05:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1esnvu-0006vk-HG
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:05:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ADF17B4AD
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 11:05:30 +0000 (UTC)
Date: Mon, 5 Mar 2018 11:05:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180305110526.GE3131@work-vm>
References: <1520243276-30197-1-git-send-email-thuth@redhat.com>
	<20180305104326.GC3131@work-vm>
	<20180305105503.ec5hdwakjxmzjnqp@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305105503.ec5hdwakjxmzjnqp@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v2] Allow to specify a display device ID
 and head whith the screendump command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> > > +    qmp_screendump(filename, id != NULL, id, id != NULL, head, &err);
> > >      hmp_handle_error(mon, &err);
> > >  }
> > 
> > Looks ok from HMP; one question, is there a way to give an ID to the
> > default VGA or only to extra devices?
> 
> It'll be whatever id you give to your video device.  For libvirt this is
> "video$nr".  When starting qemu from the command line just use
> "-device VGA,id=$yourchoice".

Ah OK, that works, what I'd tried was
     -device qxl,id=foo      rather than
     -device qxl-vga,id=foo  which works.

Dave

> cheers,
>   Gerd
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
