Received: from eggs.gnu.org ([209.51.188.92]:46078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqvXM-0002RE-0b
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqvXJ-0007p8-2o
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:52:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqvXI-0007mP-Pb
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:52:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AAAD811D5
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 07:52:51 +0000 (UTC)
Date: Tue, 5 Feb 2019 08:52:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205075249.6tx74rgbnojzssyp@sirius.home.kraxel.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Feb 04, 2019 at 04:10:37PM +0100, Thomas Huth wrote:
> 
>  Hi Gerd,
> 
> I noticed that certain FreeDOS images are not working correctly anymore
> with the current version of QEMU, for example
> http://www.qemu-advent-calendar.org/2016/download/day10.tar.xz ... It
> aborts with:
> 
>  Error reading from drive C: DOS area: write-protection violation attempted
> 
> I've bisected the issue, and it has apparently been introduced with:
> 
>  cd1bfd5ef336166b275a09dc9842542bf5e63ae3
>  seabios: update bios and vgabios binaries
> 
> Any idea what might be going wrong here?

Hmm, no.  bisect seabios?

cheers,
  Gerd
