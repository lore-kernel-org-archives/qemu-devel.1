Received: from eggs.gnu.org ([2001:4830:134:3::10]:56687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqJ0u-0004of-S6
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqJ0u-0000WG-24
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:08:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dqJ0t-0000VG-SM
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:08:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D67E381DEF
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 13:08:02 +0000 (UTC)
References: <20170908114407.25906-1-otubo@redhat.com>
	<20170908114407.25906-2-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b6920cb-89c9-89b7-dc71-9f973709f339@redhat.com>
Date: Fri, 8 Sep 2017 15:07:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170908114407.25906-2-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv6 1/5] seccomp: changing from whitelist to
 blacklist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org

On 08.09.2017 13:44, Eduardo Otubo wrote:
> This patch changes the default behavior of the seccomp filter from
> whitelist to blacklist. By default now all system calls are allowed and
> a small black list of definitely forbidden ones was created.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |   2 +
>  qemu-seccomp.c           | 260 +++++------------------------------------------
>  vl.c                     |   1 -
>  3 files changed, 30 insertions(+), 233 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
