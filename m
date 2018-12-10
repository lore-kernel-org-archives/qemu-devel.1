Received: from eggs.gnu.org ([2001:4830:134:3::10]:38943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLmU-0006gr-PK
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLZk-00079S-Uz
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:26:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWLZi-00078m-Ts
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:26:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0342C89AC9
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 13:26:18 +0000 (UTC)
Date: Mon, 10 Dec 2018 14:26:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210132616.f7k6l5c5t4sawe22@sirius.home.kraxel.org>
References: <1543492248-28356-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543492248-28356-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] tests/display-vga: Enable
 virtio-vga test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Nov 29, 2018 at 12:50:48PM +0100, Thomas Huth wrote:
> There are some "#ifdef CONFIG_VIRTIO_VGA" in the code here which
> do not work as expected: CONFIG_VIRTIO_VGA is a Makefile switch,
> but not a CPP macro, so the "guarded" code currently simply never
> gets enabled.
> 
> So enable this code now unconditionally, with some runtime switches
> for the architectures that have the VIRTIO_VGA device enabled by
> default. Looking at the other if-statement in the main function here,
> it also seems like this test was originally supposed to be running
> on "mips" and "alpha", too, so enable it now for these architectures
> in the Makefile, too.

Added to vga queue.

thanks,
  Gerd
