Received: from eggs.gnu.org ([209.51.188.92]:51880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gk4Gz-0007p7-LH
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gk4Gy-0001rH-Va
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:47:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gk4Gy-0001ql-N4
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:47:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B22D9C03347E
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 09:47:39 +0000 (UTC)
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-4-git-send-email-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f9fe204a-8ce0-fb4a-5348-8686a1d12398@redhat.com>
Date: Thu, 17 Jan 2019 10:47:37 +0100
MIME-Version: 1.0
In-Reply-To: <1547576349-13337-4-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] tests: remove rule for nonexisting
 qdev-monitor-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 15/01/2019 19:19, Paolo Bonzini wrote:
> This test was merged into drive_del-test in 2014.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/Makefile.include | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 195af1f..8b88cd5 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -737,7 +737,6 @@ tests/qom-test$(EXESUF): tests/qom-test.o
>  tests/test-hmp$(EXESUF): tests/test-hmp.o
>  tests/machine-none-test$(EXESUF): tests/machine-none-test.o
>  tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
> -tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
>  tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
>  tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
>  tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
