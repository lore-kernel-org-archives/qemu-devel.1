Received: from eggs.gnu.org ([209.51.188.92]:47269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHDSx-000741-3Z
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHDSw-0006FH-92
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHDSw-0006Ep-1f
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:17:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2618F7EBC1
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:17:01 +0000 (UTC)
Date: Thu, 18 Apr 2019 17:16:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418201659.GL25134@habkost.net>
References: <20190418034501.5038-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418034501.5038-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cpu: Fix crash with empty -cpu option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Thu, Apr 18, 2019 at 12:45:01AM -0300, Eduardo Habkost wrote:
> Fix the following crash:
> 
>   $ qemu-system-x86_64 -cpu ''
>   qemu-system-x86_64: qom/cpu.c:291: cpu_class_by_name: \
>       Assertion `cpu_model && cc->class_by_name' failed.
> 
> Regression test script included.
> 
> Fixes: commit 99193d8f2ef5 ("cpu: drop unnecessary NULL check and cpu_common_class_by_name()")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Queued on machine-next.

-- 
Eduardo
