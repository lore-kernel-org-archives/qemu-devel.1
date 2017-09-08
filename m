Received: from eggs.gnu.org ([2001:4830:134:3::10]:60567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFea-0002gD-OV
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFeU-0005nY-7p
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:32:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqFeU-0005m6-2s
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:32:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25E3880460
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 09:32:41 +0000 (UTC)
Date: Fri, 8 Sep 2017 10:32:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908093236.GE3609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908091027.9104-1-otubo@redhat.com>
	<20170908091027.9104-4-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908091027.9104-4-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv5 3/5] seccomp: add elevateprivileges
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

On Fri, Sep 08, 2017 at 11:10:25AM +0200, Eduardo Otubo wrote:
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
>  qemu-seccomp.c           | 19 +++++++++++++++++++
>  vl.c                     | 27 +++++++++++++++++++++++++++
>  4 files changed, 56 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
