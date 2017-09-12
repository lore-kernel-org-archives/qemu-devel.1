Received: from eggs.gnu.org ([2001:4830:134:3::10]:60356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkph-0004oy-5t
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkpX-0000UG-Tf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:02:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkpX-0000Tn-Nh
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:02:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0CA3C04B333
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 13:02:18 +0000 (UTC)
Date: Tue, 12 Sep 2017 14:02:15 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912130215.GH17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1504771369.git.mprivozn@redhat.com>
	<ce2790634e6a1b3b6cf90462399d17bad83f0290.1504771369.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce2790634e6a1b3b6cf90462399d17bad83f0290.1504771369.git.mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] watchdog.h: Drop local redefinition
 of actions enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Thu, Sep 07, 2017 at 10:05:25AM +0200, Michal Privoznik wrote:
> We already have enum that enumerates all the actions that a
> watchdog can take when hitting its timeout: WatchdogAction.
> Use that instead of inventing our own.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  hw/watchdog/watchdog.c    | 45 ++++++++++++++++++++-------------------------
>  hw/watchdog/wdt_diag288.c |  6 +++---
>  include/sysemu/watchdog.h | 12 ++----------
>  3 files changed, 25 insertions(+), 38 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
