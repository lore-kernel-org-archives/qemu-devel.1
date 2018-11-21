Received: from eggs.gnu.org ([2001:4830:134:3::10]:52387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gPPVv-00061u-P8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gPPS2-0006ew-D6
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:09:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gPPRz-0006aO-9l
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:09:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 101AC3001A52
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:09:36 +0000 (UTC)
Date: Wed, 21 Nov 2018 11:09:00 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20181121100900.GA27801@beluga.usersys.redhat.com>
References: <20181120085603.31472-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120085603.31472-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qapi: add query-display-options command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Nov 20, 2018 at 09:56:03AM +0100, Gerd Hoffmann wrote:
> Add query-display-options command, which allows to query the qemu
> display configuration, and -- as intentional side effect -- makes
> DisplayOptions discoverable via query-qmp-schema so libvirt can go
> figure which display options are supported.
>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Direct testing with qemu works, as the necessary data appears in the QAPI
schema a can be traversed, so it looks good, but I'm still yet to test
traversing with libvirt.

Tested-by: Erik Skultety <eskultet@redhat.com>
