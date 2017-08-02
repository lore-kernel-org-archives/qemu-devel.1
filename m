Received: from eggs.gnu.org ([2001:4830:134:3::10]:44877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1CK-00014p-Oz
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1CF-0004iE-SO
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:28:56 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1CF-0004i4-NJ
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:28:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id a77so5844331qkb.2
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 14:28:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170802201512.29142-1-crosa@redhat.com>
	<20170802201512.29142-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <95ac9aa9-5969-674b-929a-095cc75f52c3@amsat.org>
Date: Wed, 2 Aug 2017 18:28:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170802201512.29142-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/tcg/linux-test.c: include
 definitions for getrusage()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org

Hi Cleber,

On 08/02/2017 05:15 PM, Cleber Rosa wrote:
> A include for <sys/resources.h> is missing, and prevents
> tests/tcg/linux-test from compiling.

getrusage() I presume, don't know if worth adding in commit message.

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/tcg/linux-test.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/tcg/linux-test.c b/tests/tcg/linux-test.c
> index 1c6c013..15c9d7f 100644
> --- a/tests/tcg/linux-test.c
> +++ b/tests/tcg/linux-test.c
> @@ -39,6 +39,7 @@
>   #include <dirent.h>
>   #include <setjmp.h>
>   #include <sys/shm.h>
> +#include <sys/resource.h>
>   
>   #define TESTPATH "/tmp/linux-test.tmp"
>   #define TESTPORT 7654
> 
