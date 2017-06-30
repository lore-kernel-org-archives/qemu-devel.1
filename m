Received: from eggs.gnu.org ([2001:4830:134:3::10]:35181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQtSw-00016F-I2
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQtSt-0000V4-HE
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dQtSt-0000Tg-9u
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:47:55 -0400
References: <1498584769-12439-1-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c5197e7-d53f-74d4-9150-c97673b9cc02@redhat.com>
Date: Fri, 30 Jun 2017 12:47:44 +0200
MIME-Version: 1.0
In-Reply-To: <1498584769-12439-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] main_loop: Make main_loop_wait()
 return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>



On 27/06/2017 19:32, Peter Maydell wrote:
> This patchset removes the useless return value from
> main_loop_wait().
> 
> Changes v2->v3:
>  * add initial patch which removes the use of the return value
>    from the version of main_loop in test-char.c -- it didn't
>    really need it anyway.
>  * removed unnecessary 'return;' at end of function
> 
> NB: I've just also noticed that there is exactly one use in the
> tree of the argument to main_loop_wait() now which doesn't
> pass 'false' -- that is in a function in hw/display/xenfb.c
> that was added 8 years ago with a comment claiming it was
> strictly temporary ;-)
> 
> 
> Peter Maydell (2):
>   tests/test-char.c: Don't use main_loop_wait()'s return value
>   main_loop: Make main_loop_wait() return void
> 
>  include/qemu/main-loop.h | 2 +-
>  tests/test-char.c        | 6 +-----
>  util/main-loop.c         | 8 +-------
>  3 files changed, 3 insertions(+), 13 deletions(-)
> 

Queued, thanks.

Paolo
