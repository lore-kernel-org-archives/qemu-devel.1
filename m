Received: from eggs.gnu.org ([2001:4830:134:3::10]:49375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVePr-0001AU-BS
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVePo-0005Bi-OC
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:48:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVePo-0005BE-JA
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC53D401EF00
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 14:48:55 +0000 (UTC)
Date: Wed, 20 Jun 2018 15:48:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180620144852.GO2549@work-vm>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org> <20180611174958.GP2661@work-vm>
	<20180612053720.pp2xvb7r34o6ort7@sirius.home.kraxel.org>
	<87k1r4use2.fsf@dusky.pond.sub.org> <20180612125254.GB2512@work-vm>
	<878t7gxc6v.fsf@dusky.pond.sub.org>
	<20180615184434.GD7451@localhost.localdomain>
	<20180618063632.5ifuck6ahlvb5rjv@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618063632.5ifuck6ahlvb5rjv@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] Abandon our QMP first policy? (was: [PATCH v3 5/7]
 hmp: Add info commands for preconfig)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,
> 
> > (Which I think is true in the specific case of "info usbhost",
> > because it's really just a wrapper around libusb.  I'm 100% sure
> > QEMU doesn't need to provide a QMP interface for libusb.)
> 
> Agree.
> 
> I think we can settle that specific case by deprecating and removing
> "info usbhost".  lsusb (comes with usbutils) can be used instead.

OK, I'll drop 'info usbhost' from this series, and we can remove it
completely sometime later.

Dave

> cheers,
>   Gerd
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
