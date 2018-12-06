Received: from eggs.gnu.org ([2001:4830:134:3::10]:59639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUybY-0006TR-NX
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUybU-0005Xn-Ny
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:42:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gUybU-0005X6-Hy
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:42:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3EFE3969
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 18:42:27 +0000 (UTC)
References: <1544114998-1513-1-git-send-email-thuth@redhat.com>
	<1544114998-1513-2-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <794f00c2-661d-3534-b3c0-a52d626c1c75@redhat.com>
Date: Thu, 6 Dec 2018 12:42:24 -0600
MIME-Version: 1.0
In-Reply-To: <1544114998-1513-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/5] tests/boot-serial: Get rid of
 global_qtest variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 12/6/18 10:49 AM, Thomas Huth wrote:
> The test does not use any of the functions that require global_qtest,
> so we can simply get rid of this global variable here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/boot-serial-test.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 

> -    global_qtest = qtest_initf("%s %s -M %s,accel=tcg:kvm "
> -                               "-chardev file,id=serial0,path=%s "
> -                               "-no-shutdown -serial chardev:serial0 %s",
> -                               codeparam, code ? codetmp : "",
> -                               test->machine, serialtmp, test->extra);
> +    qts = qtest_initf("%s %s -M %s,accel=tcg:kvm -no-shutdown "
> +                      "-chardev file,id=serial0,path=%s "
> +                      " -serial chardev:serial0 %s",

What happened to -no-shutdown?

> +                      codeparam, code ? codetmp : "", test->machine,
> +                      serialtmp, test->extra);
>       if (code) {
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
