Received: from eggs.gnu.org ([2001:4830:134:3::10]:55424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gQ4vS-0006ja-2X
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gQ4vM-0007h6-Qa
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:26:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gQ4vM-0007dM-LW
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:26:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C11BCC02C78D
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 06:26:43 +0000 (UTC)
Date: Fri, 23 Nov 2018 07:26:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181123062642.2a72mbhp5tn7ozfb@sirius.home.kraxel.org>
References: <20181122071613.2889-1-kraxel@redhat.com>
	<20181122145802.GE27801@beluga.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122145802.GE27801@beluga.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qapi: add query-display-options command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Nov 22, 2018 at 03:58:02PM +0100, Erik Skultety wrote:
> On Thu, Nov 22, 2018 at 08:16:13AM +0100, Gerd Hoffmann wrote:
> > Add query-display-options command, which allows querying the qemu
> > display configuration, and -- as an intentional side effect -- makes
> > DisplayOptions discoverable via query-qmp-schema so libvirt can go
> > figure which display options are supported.
> >
> > Use case: commit d4dc4ab1 added rendernode parameter for egl-headless.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Tested-by: Eric Blake <eblake@redhat.com>
> > Tested-by: Erik Skultety <eskultet@redhat.com>
> > ---
> 
> FYI I have the first libvirt prototype patches [1] (need some polishing though)
> ready and everything worked even with this v3 patch.
> 
> [1] https://github.com/eskultety/libvirt/commits/egl-headless

Good.  Queued up for 3.1

cheers,
  Gerd
