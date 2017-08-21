Received: from eggs.gnu.org ([2001:4830:134:3::10]:49258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djn9Q-0000eV-9m
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djn9L-00009b-CM
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:53:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1djn9L-00009M-5h
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:53:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2435B25C28
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 13:53:50 +0000 (UTC)
Message-ID: <1503323628.26016.25.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Aug 2017 15:53:48 +0200
In-Reply-To: <20170810155522.31099-1-berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/15] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

On Thu, 2017-08-10 at 16:55 +0100, Daniel P. Berrange wrote:
> The keycodemap project[1] provides a database mapping between
> many different keysym/keycode/scancode sets, along with a
> tool to generate mapping/lookup tables in various programming
> languages. It is already used by GTK-VNC, SPICE-GTK and
> libvirt.
> 
> This series enables its use in QEMU, thus fixing a great
> many bugs/ommissions in the 15+ key mapping tables people
> have manually written for QEMU.

Looks good on a quick look.  I'll have a closer look and test once I'm
done processing my vacation email backlog.

One thing for now:  I think we should not require the keycodemapdb at
build time.   Instead commit the generated files to git so the build
works without the submodule, then update the generated files each time
the submodule is updated (simliar to firmware blobs/submodules).

cheers,
  Gerd
