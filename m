Received: from eggs.gnu.org ([2001:4830:134:3::10]:48137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgA0r-0007ur-Is
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgA0n-0002lz-LU
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dgA0n-0002lY-Fu
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:30:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F5A27EAA1
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 13:30:00 +0000 (UTC)
Date: Fri, 11 Aug 2017 14:29:53 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811132953.GM2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170811131801.21763-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170811131801.21763-1-cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, thuth@redhat.com

On Fri, Aug 11, 2017 at 03:18:01PM +0200, Cornelia Huck wrote:
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

Total nit-pick - the first line has a trailing ' ', while the second
line has no leading or trailing ' ', and the third line has a leading
' '. The inconsistency bugs me - suggest using trailing ' ' in both
lines. No need to repost for that though, fine if it is touched up
for the PULL, so

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
