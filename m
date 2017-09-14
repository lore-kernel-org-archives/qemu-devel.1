Received: from eggs.gnu.org ([2001:4830:134:3::10]:59379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsWQE-0006HG-Qh
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsWQD-0002Ox-Tv
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:51:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dsWQD-0002Nr-Nf
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:51:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACCA9883C4
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 15:51:20 +0000 (UTC)
Date: Thu, 14 Sep 2017 16:51:14 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170914155114.GE11763@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908114407.25906-1-otubo@redhat.com>
	<20170908114407.25906-4-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908114407.25906-4-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv6 3/5] seccomp: add elevateprivileges
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

On Fri, Sep 08, 2017 at 01:44:05PM +0200, Eduardo Otubo wrote:
> This patch introduces the new argument
> [,elevateprivileges=allow|deny|children] to the `-sandbox on'. It allows
> or denies Qemu process to elevate its privileges by blacklisting all
> set*uid|gid system calls. The 'children' option will let forks and
> execves run unprivileged.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  1 +
>  qemu-options.hx          | 12 +++++++++---
>  qemu-seccomp.c           | 11 +++++++++++
>  vl.c                     | 27 +++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
