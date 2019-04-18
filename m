Received: from eggs.gnu.org ([209.51.188.92]:41904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hH26Y-0002o3-Jz
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hH26X-0007bA-IF
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:09:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hH26X-0007am-9A
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:09:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so1749911wmi.5
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 01:09:09 -0700 (PDT)
Date: Thu, 18 Apr 2019 10:09:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190418080904.egxbetgrraw6ktjb@steredhat>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>

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
> ---
>  exec.c                              |  4 ++++
>  tests/acceptance/empty_cpu_model.py | 19 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 tests/acceptance/empty_cpu_model.py
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
