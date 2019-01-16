Received: from eggs.gnu.org ([209.51.188.92]:51128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gje0q-0000Ua-H1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjdzV-0006Me-Bi
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:43:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjdzV-0006J2-3D
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:43:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D28DC05B1E7
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 05:43:48 +0000 (UTC)
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-4-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4598ec57-bc31-1d7e-daea-c22881f8098f@redhat.com>
Date: Wed, 16 Jan 2019 06:43:46 +0100
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
Cc: lvivier@redhat.com

On 2019-01-15 19:19, Paolo Bonzini wrote:
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

Fixes: e2f3f221885a90de766ce9a38b87badeb658635a

Reviewed-by: Thomas Huth <thuth@redhat.com>
