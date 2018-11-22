Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gPqQn-0006tz-JP
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gPqQk-0001BR-HD
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:58:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gPqQk-00019e-AZ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:58:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E93858F4E2
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 14:58:07 +0000 (UTC)
Date: Thu, 22 Nov 2018 15:58:02 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20181122145802.GE27801@beluga.usersys.redhat.com>
References: <20181122071613.2889-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122071613.2889-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qapi: add query-display-options command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Nov 22, 2018 at 08:16:13AM +0100, Gerd Hoffmann wrote:
> Add query-display-options command, which allows querying the qemu
> display configuration, and -- as an intentional side effect -- makes
> DisplayOptions discoverable via query-qmp-schema so libvirt can go
> figure which display options are supported.
>
> Use case: commit d4dc4ab1 added rendernode parameter for egl-headless.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Tested-by: Eric Blake <eblake@redhat.com>
> Tested-by: Erik Skultety <eskultet@redhat.com>
> ---

FYI I have the first libvirt prototype patches [1] (need some polishing though)
ready and everything worked even with this v3 patch.

[1] https://github.com/eskultety/libvirt/commits/egl-headless

Thanks,
Erik
