Received: from eggs.gnu.org ([2001:4830:134:3::10]:59914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNaMq-0007GZ-JS
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNaMk-0002gh-Ts
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:24:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gNaMh-0002do-77
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:24:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54D8E3082B63
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:24:36 +0000 (UTC)
Date: Fri, 16 Nov 2018 10:24:30 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20181116092430.GA13547@ridgehead>
References: <cover.1542294676.git.eskultet@redhat.com>
	<49306290-125b-8d63-ae27-495c0c17e113@redhat.com>
	<20181116084352.t7in4ztnnhkgd37b@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116084352.t7in4ztnnhkgd37b@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Fri, Nov 16, 2018 at 09:43:52AM +0100, Gerd Hoffmann wrote:
> On Thu, Nov 15, 2018 at 09:47:44AM -0600, Eric Blake wrote:
> > On 11/15/18 9:15 AM, Erik Skultety wrote:
> > > Since QEMU always picks the default DRI device, libvirt doesn't know which one
> > > to put into the mount namespace and relabel it accordingly, hence hitting
> > > permission issues, unless admin tweaks the default permissions of the DRI
> > > devices.
> > >
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1648236
> >
> > This is borderline between fixing a bug that gets in the way of libvirt (and
> > thus useful for 3.1) and a feature (thus for 4.0, since we won't have a 3.2
> > release). I'll let Gerd decide.
>
> It's simple enough and we are early in the -rc cycle still, I think it
> would be okay for 3.1.

As far as upstream's concerned, I'm okay with both because libvirt has to add
another version specific capability enum for this anyway. It's been broken
since libvirt 4.6.0 where I added egl-headless graphics type. Luckily, even
though it's far from optimal, a working solution exists, just change the
permissions on the device.

Thanks,
Erik
