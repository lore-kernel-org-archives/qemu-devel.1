Received: from eggs.gnu.org ([2001:4830:134:3::10]:35090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNaSt-0003i4-Nc
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNaSo-0006Px-Qj
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:31:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNaSo-0006PJ-LP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:30:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9AD43680A
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:30:56 +0000 (UTC)
Date: Fri, 16 Nov 2018 10:30:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181116093055.jyhb2cscyrbmujsa@sirius.home.kraxel.org>
References: <cover.1542294676.git.eskultet@redhat.com>
	<49306290-125b-8d63-ae27-495c0c17e113@redhat.com>
	<20181116084352.t7in4ztnnhkgd37b@sirius.home.kraxel.org>
	<20181116092430.GA13547@ridgehead>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116092430.GA13547@ridgehead>
Subject: Re: [Qemu-devel] [PATCH 0/3] Introduce 'rendernode' option for
 egl-headless display type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Fri, Nov 16, 2018 at 10:24:30AM +0100, Erik Skultety wrote:
> On Fri, Nov 16, 2018 at 09:43:52AM +0100, Gerd Hoffmann wrote:
> > It's simple enough and we are early in the -rc cycle still, I think it
> > would be okay for 3.1.
> 
> As far as upstream's concerned, I'm okay with both because libvirt has to add
> another version specific capability enum for this anyway. It's been broken
> since libvirt 4.6.0 where I added egl-headless graphics type. Luckily, even
> though it's far from optimal, a working solution exists, just change the
> permissions on the device.

I'm fine either way too.  So just pick a version, update the doc
comments and repost.

thanks,
  Gerd
