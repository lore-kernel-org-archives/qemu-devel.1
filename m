Received: from eggs.gnu.org ([2001:4830:134:3::10]:58416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqJ7t-0008UZ-UR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqJ7q-0001lt-O0
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:15:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dqJ7q-0001l8-Hi
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:15:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3886C04B941
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 13:15:13 +0000 (UTC)
References: <20170908114407.25906-1-otubo@redhat.com>
	<20170908114407.25906-6-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a7251cd6-c285-b790-fd31-fe668a4c6a8d@redhat.com>
Date: Fri, 8 Sep 2017 15:15:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170908114407.25906-6-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org

On 08.09.2017 13:44, Eduardo Otubo wrote:
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
