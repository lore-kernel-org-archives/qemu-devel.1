Received: from eggs.gnu.org ([2001:4830:134:3::10]:34850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1esnls-0007PF-Ln
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1esnlo-0007iT-Ql
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:55:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1esnlo-0007iF-Lq
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:55:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 357C44085010
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 10:55:04 +0000 (UTC)
Date: Mon, 5 Mar 2018 11:55:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180305105503.ec5hdwakjxmzjnqp@sirius.home.kraxel.org>
References: <1520243276-30197-1-git-send-email-thuth@redhat.com>
	<20180305104326.GC3131@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305104326.GC3131@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

> > +    qmp_screendump(filename, id != NULL, id, id != NULL, head, &err);
> >      hmp_handle_error(mon, &err);
> >  }
> 
> Looks ok from HMP; one question, is there a way to give an ID to the
> default VGA or only to extra devices?

It'll be whatever id you give to your video device.  For libvirt this is
"video$nr".  When starting qemu from the command line just use
"-device VGA,id=$yourchoice".

cheers,
  Gerd
