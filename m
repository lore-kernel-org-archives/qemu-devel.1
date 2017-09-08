Received: from eggs.gnu.org ([2001:4830:134:3::10]:58077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqJ5m-0007Hb-AR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqJ5g-00070O-Pg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dqJ5g-0006zM-JK
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:13:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B40FBC047B68
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 13:12:59 +0000 (UTC)
References: <20170908114407.25906-1-otubo@redhat.com>
	<20170908114407.25906-4-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7c5cc7fd-cd79-acaf-9e5c-fe4728481b57@redhat.com>
Date: Fri, 8 Sep 2017 15:12:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170908114407.25906-4-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org

On 08.09.2017 13:44, Eduardo Otubo wrote:
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
