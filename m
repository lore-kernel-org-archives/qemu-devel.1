Received: from eggs.gnu.org ([2001:4830:134:3::10]:57881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1feyH4-0008RL-3t
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1feyGy-0003wt-Qc
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:50:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1feyGy-0003wR-FA
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:50:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5D1281663C2
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 07:50:19 +0000 (UTC)
References: <20180716073226.21127-1-armbru@redhat.com>
	<20180716073226.21127-2-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1ee4b354-7dbf-448e-f5dd-af799147b80f@redhat.com>
Date: Mon, 16 Jul 2018 09:50:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180716073226.21127-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-doc: Move appendix "Deprecated
 features" to its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, cohuck@redhat.com, pkrempa@redhat.com, berrange@redhat.com

On 16.07.2018 09:32, Markus Armbruster wrote:
> Consumers of QEMU need to track feature deprecation.  Keeping
> deprecation documentation in its own file helps in two small ways:
> 
> * You can track changes the easy and obvious way, with git-log.
>   Before, you had to resort to more complex gittery like "git-log
>   --oneline -L '/@node Deprecated features/,/@node Supported build
>   platforms/:qemu-doc.texi'"
> 
> * It lets us use MAINTAINERS to copy interested parties on deprecation
>   patches, so they can advise or object before they're a done deal.
>   The next commit will do that for libvirt.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-deprecated.texi | 234 ++++++++++++++++++++++++++++++++++++++++++
>  qemu-doc.texi        | 235 +------------------------------------------
>  2 files changed, 235 insertions(+), 234 deletions(-)
>  create mode 100644 qemu-deprecated.texi

Reviewed-by: Thomas Huth <thuth@redhat.com>
