Received: from eggs.gnu.org ([2001:4830:134:3::10]:60050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFdz-0002BR-Dr
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFdr-0005DL-Nz
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:32:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqFdr-0005Ct-Ip
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:32:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF004C0587ED
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 09:32:02 +0000 (UTC)
Date: Fri, 8 Sep 2017 10:31:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908093156.GD3609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908091027.9104-1-otubo@redhat.com>
	<20170908091027.9104-3-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908091027.9104-3-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv5 2/5] seccomp: add obsolete argument to
 command line
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

On Fri, Sep 08, 2017 at 11:10:24AM +0200, Eduardo Otubo wrote:
> This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
> option. It allows Qemu to run safely on old system that still relies on
> old system calls.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  3 ++-
>  qemu-options.hx          | 12 ++++++++++--
>  qemu-seccomp.c           | 20 +++++++++++++++++++-
>  vl.c                     | 22 +++++++++++++++++++++-
>  4 files changed, 52 insertions(+), 5 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
