Received: from eggs.gnu.org ([2001:4830:134:3::10]:56934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gQ50B-0002W7-KZ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gQ506-0004Mg-NP
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gQ506-0004GC-Ha
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:31:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D71AF3086249
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:31:37 +0000 (UTC)
Date: Fri, 23 Nov 2018 07:31:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181123063136.57uvdz3y7nngbn4d@sirius.home.kraxel.org>
References: <20181122133207.29928-1-kraxel@redhat.com>
	<20181122155212.GA2863@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122155212.GA2863@work-vm>
Subject: Re: [Qemu-devel] [PATCH] audio/hda: fix guest triggerable assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Nov 22, 2018 at 03:52:12PM +0000, Dr. David Alan Gilbert wrote:
> * Gerd Hoffmann (kraxel@redhat.com) wrote:
> > Guest writes to a readonly register trigger the assert in
> > intel_hda_reg_write().  Add a check and just ignore them.
> > 
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1628433
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Does make you wonder:
>   a) Why the guest was writing to a read-only register
>   b) Wth it only did it in the weird combination of
>      devices tested.

Note that we also have pci hotplug involved.  Probably a bug in the
guest, maybe due to a register access landing at the wrong device while
reshuffling the bars or something like that.

cheers,
  Gerd
