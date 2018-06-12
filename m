Received: from eggs.gnu.org ([2001:4830:134:3::10]:45645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSbzf-0005vu-RF
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSbzd-0007m5-Op
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:37:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fSbzd-0007lj-Je
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 01:37:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2945E4002248
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 05:37:21 +0000 (UTC)
Date: Tue, 12 Jun 2018 07:37:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180612053720.pp2xvb7r34o6ort7@sirius.home.kraxel.org>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org> <20180611174958.GP2661@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611174958.GP2661@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

  Hi,

> > Now let's review the three commands:
> > 
> > * Gerd, why does "info usbhost" have no QMP equivalent?

Works only when running qemu directly, in the libvirt sandbox qemu
hasn't the permissions needed to scan the host usb bus so that would be
rather pointless ...

cheers,
  Gerd
