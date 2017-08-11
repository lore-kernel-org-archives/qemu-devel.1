Received: from eggs.gnu.org ([2001:4830:134:3::10]:48690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgA2z-0000da-JT
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgA2u-0004NR-KD
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:32:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dgA2u-0004M8-Df
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:32:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 580FCDB2EF
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 13:32:11 +0000 (UTC)
References: <20170811131801.21763-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9c54e391-694b-35d3-a60e-a3944370f0ad@redhat.com>
Date: Fri, 11 Aug 2017 15:32:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170811131801.21763-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] boot-serial-test: fallback to kvm
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 11.08.2017 15:18, Cornelia Huck wrote:
> Currently, at least x86_64 and s390x support building with --disable-tcg.
> Instead of forcing tcg (which causes the test to fail on such builds),
> allow to use kvm as well.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> v1->v2: switch around kvm and tcg
> 
> Added Paolo on cc:; I can still take this through the s390x tree, though.
> 
> ---
>  tests/boot-serial-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 11f48b049c..78303b14ce 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -78,7 +78,8 @@ static void test_machine(const void *data)
>      fd = mkstemp(tmpname);
>      g_assert(fd != -1);
>  
> -    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
> +    args = g_strdup_printf("-M %s,accel=kvm:tcg "
> +                           "-chardev file,id=serial0,path=%s"
>                             " -no-shutdown -serial chardev:serial0 %s",
>                             test->machine, tmpname, test->extra);

Reviewed-by: Thomas Huth <thuth@redhat.com>
