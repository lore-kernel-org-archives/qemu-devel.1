Received: from eggs.gnu.org ([2001:4830:134:3::10]:59828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsWR3-0006yW-QY
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsWQz-0003tt-U7
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:52:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dsWQz-0003t9-NU
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:52:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ADF4AC0587DD
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 15:52:08 +0000 (UTC)
Date: Thu, 14 Sep 2017 16:51:58 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170914155158.GG11763@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908114407.25906-1-otubo@redhat.com>
	<20170908114407.25906-6-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908114407.25906-6-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv6 5/5] seccomp: add resourcecontrol
 argument to command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On Fri, Sep 08, 2017 at 01:44:07PM +0200, Eduardo Otubo wrote:
> This patch adds [,resourcecontrol=deny] to `-sandbox on' option. It
> blacklists all process affinity and scheduler priority system calls to
> avoid any bigger of the process.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  1 +
>  qemu-options.hx          |  9 ++++++---
>  qemu-seccomp.c           | 11 +++++++++++
>  vl.c                     | 16 ++++++++++++++++
>  4 files changed, 34 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
