Received: from eggs.gnu.org ([2001:4830:134:3::10]:59399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dpcOE-0005Al-8Y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1dpcO8-0005Eh-48
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:37:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1dpcO7-0005Cf-UZ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:37:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0B22356D4
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:37:10 +0000 (UTC)
Date: Wed, 6 Sep 2017 16:37:09 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170906153709.GQ20914@redhat.com>
References: <cover.1504696921.git.mprivozn@redhat.com>
	<874lsfvo5j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lsfvo5j.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4 0/3] watchdog: Allow setting action on
 the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org

On Wed, Sep 06, 2017 at 05:32:08PM +0200, Markus Armbruster wrote:
> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Perhaps Rich would like to have a look, too.

I looked at them and they seemed OK but I didn't review them.

I also added this comment on the bug which maybe relevant,
maybe not ...

https://bugzilla.redhat.com/show_bug.cgi?id=1447169#c4

  "Not that it matters, but the real hardware was built into the
   southbridge and so not hotpluggable.

   Do you know what happens (or should happen) if the guest kernel
   loads the i6300esb driver with nowayout=1 and the hardware is
   unplugged?  My reading of the driver says that this will not break
   or crash, although it probably won't work as the guest user
   expects.  You can tell from the qemu side if the guest selected
   nowayout because ESB_WDT_LOCK is written to the ESB_LOCK_REG
   register.

   Anyway, this may not matter."

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
