Received: from eggs.gnu.org ([209.51.188.92]:36323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hIng0-00021b-Fp
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hInfz-0006aJ-JA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:09:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hInfz-0006ZK-9j
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79EE5C0AF7B7
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 05:09:02 +0000 (UTC)
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-3-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <62fbd0db-3868-07b7-42fd-4cf577b37ca1@redhat.com>
Date: Tue, 23 Apr 2019 07:09:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190422210448.2488-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qtest: Don't compile qtest accel on
 non-POSIX systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 22/04/2019 23.04, Eduardo Habkost wrote:
> qtest_available() will always return 0 on non-POSIX systems.
> It's simpler to just not compile the accelerator code on those
> systems instead of relying on the AccelClass::available function.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/sysemu/qtest.h | 9 ---------
>  accel/qtest.c          | 1 -
>  accel/Makefile.objs    | 2 +-
>  3 files changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
