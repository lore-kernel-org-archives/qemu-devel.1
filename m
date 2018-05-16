Received: from eggs.gnu.org ([2001:4830:134:3::10]:44722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIqoT-0008Ab-GE
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIqoQ-0003fO-5G
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:25:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIqoP-0003eu-V7
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:25:26 -0400
References: <20180515182700.31736-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d7f22f4-576d-2f1d-9b5c-6bf96b4ae5e0@redhat.com>
Date: Wed, 16 May 2018 09:25:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180515182700.31736-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] exec.c: Initialize sa_flags passed to
 sigaction()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 15/05/2018 20:27, Peter Maydell wrote:
> Coverity points out that in the user-only version of cpu_abort() we
> call sigaction() with a partially initialized struct sigaction
> (CID 1005351). Correct the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  exec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/exec.c b/exec.c
> index ffa1099547..bd8833fc9d 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1124,6 +1124,7 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
>          struct sigaction act;
>          sigfillset(&act.sa_mask);
>          act.sa_handler = SIG_DFL;
> +        act.sa_flags = 0;
>          sigaction(SIGABRT, &act, NULL);
>      }
>  #endif
> 

Queued, thanks.

Paolo
