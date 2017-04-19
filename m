Received: from eggs.gnu.org ([2001:4830:134:3::10]:43679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d0loF-0004nz-SY
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d0loB-0003Cy-Tg
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d0loB-0003CV-O5
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:21:55 -0400
Date: Wed, 19 Apr 2017 10:21:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170419092152.GF4019@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492621028-16280-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: add
 guest-network-get-interface-stat command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Thu, Apr 20, 2017 at 12:57:08AM +0800, ZhiPeng Lu wrote:
> we can get the  network card statistics inside  a virtual machine by
> guest-network-get-interface-stat command.
> it is very userful for us to monitor and analyze network traff.

In most cases you can already monitor guest network traffic from the
statistics on the QEMU backend device (ie tap device). The exception
is when doing PCI device assignment. Is the latter the reason why you
need to add this functionality instead of just quuerying the host
backend ?

There have been a lot of proposals for new QEMU geust agent commands in
the past few weeks

 - NIC statistics
 - Logged in users
 - Timezone offset
 - Hostname
 - OS version / product

This makes me wonder what our intended scope is for the guest agent ? Are we
happy to add arbitrary functionality to the guest agent, allowing it grow in
size & complexity without bound. Or is it better to restrict it to tasks which
are needed in order to coordinate management of the host virtualization layer
and leave general purpose guest OS management to another app.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
