Received: from eggs.gnu.org ([2001:4830:134:3::10]:48511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72ek-0001ga-MA
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72ef-0002h2-DF
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:34:06 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72ef-0002gw-8J
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:34:01 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so4845794qkh.0
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 09:34:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-4-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4871fe04-9829-022e-8684-715266a45d38@amsat.org>
Date: Sat, 6 May 2017 13:33:56 -0300
MIME-Version: 1.0
In-Reply-To: <20170505032340.26467-4-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] docker: Use unconfined security profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi Fam, Alex, Paolo,

On 05/05/2017 12:23 AM, Fam Zheng wrote:
> Some by default blocked syscalls are required to run tests for example
> userfaultfd.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 0ed8c3d..09d157c 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -127,6 +127,7 @@ docker-run: docker-qemu-src
>  	$(call quiet-command,						\
>  		$(SRC_PATH)/tests/docker/docker.py run 			\
>  			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
> +			--security-opt seccomp=unconfined		\

I think this should be an option in the matrix, and eventually run tests 
using userfaultfd() apart.

                 $(if $(UNCONFINED),,--security-opt seccomp=unconfined)

I'm having the same problem with getcontext() using x32 ABI.

>  			$(if $V,,--rm) 					\
>  			$(if $(DEBUG),-i,--net=none) 			\
>  			-e TARGET_LIST=$(TARGET_LIST) 			\
>

Regards,

Phil.
