Received: from eggs.gnu.org ([209.51.188.92]:40212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gqhwY-0006ev-KX
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gqhwX-0001QL-Qe
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:22:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gqhwX-0001OW-9H
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:22:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 723E1A9707
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 17:21:59 +0000 (UTC)
Date: Mon, 4 Feb 2019 17:21:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190204172151.GA3023@work-vm>
References: <cb3e0855-a729-9a3d-e6ef-bfebea17b2cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb3e0855-a729-9a3d-e6ef-bfebea17b2cb@redhat.com>
Subject: Re: [Qemu-devel] SeaBIOS regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

* Thomas Huth (thuth@redhat.com) wrote:
> 
>  Hi Gerd,
> 
> I noticed that certain FreeDOS images are not working correctly anymore
> with the current version of QEMU, for example
> http://www.qemu-advent-calendar.org/2016/download/day10.tar.xz ... It
> aborts with:
> 
>  Error reading from drive C: DOS area: write-protection violation attempted

Ah, I'd also seen that on an older image, it doesn't seem to happen
on the current FreeDOS when I tried to reproduce it.

Dave

> I've bisected the issue, and it has apparently been introduced with:
> 
>  cd1bfd5ef336166b275a09dc9842542bf5e63ae3
>  seabios: update bios and vgabios binaries
> 
> Any idea what might be going wrong here?
> 
>  Thomas
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
