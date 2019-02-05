Received: from eggs.gnu.org ([209.51.188.92]:49811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqxFc-0003NW-Vk
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqxFb-0007Q8-TU
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:42:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqxFa-0007Mx-Gh
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:42:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B73D59440
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 09:42:35 +0000 (UTC)
Date: Tue, 5 Feb 2019 10:42:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205094229.5p27mdjj55awy3j2@sirius.home.kraxel.org>
References: <cb3e0855-a729-9a3d-e6ef-bfebea17b2cb@redhat.com>
	<20190205075249.6tx74rgbnojzssyp@sirius.home.kraxel.org>
	<225bc7bb-3c2c-1e26-4a29-4a900f60fe11@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225bc7bb-3c2c-1e26-4a29-4a900f60fe11@redhat.com>
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

On Tue, Feb 05, 2019 at 10:31:24AM +0100, Thomas Huth wrote:
> On 2019-02-05 08:52, Gerd Hoffmann wrote:
> > On Mon, Feb 04, 2019 at 04:10:37PM +0100, Thomas Huth wrote:
> >>
> >>  Hi Gerd,
> >>
> >> I noticed that certain FreeDOS images are not working correctly anymore
> >> with the current version of QEMU, for example
> >> http://www.qemu-advent-calendar.org/2016/download/day10.tar.xz ... It
> >> aborts with:
> >>
> >>  Error reading from drive C: DOS area: write-protection violation attempted
> >>
> >> I've bisected the issue, and it has apparently been introduced with:
> >>
> >>  cd1bfd5ef336166b275a09dc9842542bf5e63ae3
> >>  seabios: update bios and vgabios binaries
> >>
> >> Any idea what might be going wrong here?
> > 
> > Hmm, no.  bisect seabios?
> 
> I haven't bisected yet, but it seems to be related to CONFIG_ATA_DMA=y
> in our roms/config.seabios-128k config file. When I switch that to "n",
> then the old FreeDOS disks are working again...

Hmm, guess I should turn that off again on the next update (there will
be a seabios 1.12.1 release before qemu 4.0).

cheers,
  Gerd
