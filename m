Received: from eggs.gnu.org ([2001:4830:134:3::10]:57567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqJ3o-0005dQ-Hb
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqJ3l-0004Pd-BB
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dqJ3l-0004Oe-4l
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:11:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 339F34A6E6
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 13:11:00 +0000 (UTC)
References: <20170908114407.25906-1-otubo@redhat.com>
	<20170908114407.25906-3-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <43a508ee-b3c8-bc0f-e29f-892bbfa44308@redhat.com>
Date: Fri, 8 Sep 2017 15:10:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170908114407.25906-3-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv6 2/5] seccomp: add obsolete argument to
 command line
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
> This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
> option. It allows Qemu to run safely on old system that still relies on
> old system calls.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  3 ++-
>  qemu-options.hx          | 12 ++++++++++--
>  qemu-seccomp.c           | 19 ++++++++++++++++++-
>  vl.c                     | 23 ++++++++++++++++++++++-
>  4 files changed, 52 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
