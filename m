Received: from eggs.gnu.org ([2001:4830:134:3::10]:34398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d5uzG-0005Tq-FE
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d5uzC-00043V-HF
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:10:38 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:33711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d5uzC-00041Z-9n
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:10:34 -0400
Received: by mail-wm0-x22f.google.com with SMTP id n198so22653236wmg.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 07:10:34 -0700 (PDT)
References: <20170503115909.4490-1-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170503115909.4490-1-pbonzini@redhat.com>
Date: Wed, 03 May 2017 15:11:11 +0100
Message-ID: <87bmrani80.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Update paths for main loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, lvivier@redhat.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> Moved by c2b38b2 ("block: move AioContext, QEMUTimer, main-loop to
> libqemuutil"), let's update MAINTAINERS too.
>
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 62d62a6675..b54c0568c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1307,8 +1307,8 @@ Main loop
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: cpus.c
> -F: main-loop.c
> -F: qemu-timer.c
> +F: util/main-loop.c
> +F: util/qemu-timer.c
>  F: vl.c
>
>  Human Monitor (HMP)


--
Alex Bennée
