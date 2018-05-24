Received: from eggs.gnu.org ([2001:4830:134:3::10]:44941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLrzC-0000tu-AK
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLrz4-0003cH-LB
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:17:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fLrz4-0003bp-GV
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:16:54 -0400
References: <1527161340-3200-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1527161340-3200-3-git-send-email-suhang16@mails.ucas.ac.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13868e98-f6ab-40d1-0ebc-27d11985eaad@redhat.com>
Date: Thu, 24 May 2018 10:16:52 -0500
MIME-Version: 1.0
In-Reply-To: <1527161340-3200-3-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/2] Add QTest testcase for the Intel
 Hexadecimal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au
Cc: qemu-devel@nongnu.org

On 05/24/2018 06:29 AM, Su Hang wrote:
> 'test.hex' file is a bare metal ARM software stored in Hexadecimal
> Object Format. When it's loaded by QEMU, it will print "Hello world!\n"
> on console.
> 
> `pre_store` array in 'hexloader-test.c' file, stores the binary format
> of 'test.hex' file, which is used to verify correctness.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Suggested-by: Steffen Gortz <qemu.ml@steffen-goertz.de>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>   MAINTAINERS                          |  6 ++++
>   configure                            |  4 +++
>   tests/Makefile.include               |  2 ++
>   tests/hex-loader-check-data/test.hex | 12 ++++++++
>   tests/hexloader-test.c               | 56 ++++++++++++++++++++++++++++++++++++

The previous patch also touched:

  hw/arm/boot.c       |   7 +-
  hw/core/loader.c    | 246 
++++++++++++++++++++++++++++++++++++++++++++++++++++
  include/hw/loader.h |  12 +++

> +++ b/MAINTAINERS
> @@ -1291,6 +1291,12 @@ F: hw/core/generic-loader.c
>   F: include/hw/core/generic-loader.h
>   F: docs/generic-loader.txt
> 
> +Intel Hexadecimal Object File Loader
> +M: Su Hang <suhang16@mails.ucas.ac.cn>
> +S: Maintained
> +F: tests/hexloader-test.c
> +F: tests/hex-loader-check-data/test.hex
> +

It looks odd having a maintainer that claims only test files; do you 
want to also list some of the other files touched by this patch so that 
you get notification if one of the implementation files has subsequent 
patches (rather than just the test files)?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
