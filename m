Received: from eggs.gnu.org ([2001:4830:134:3::10]:51662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cowUO-0004Am-32
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cowUJ-00054N-CK
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:20:36 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cowUJ-000549-4E
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:20:31 -0400
Received: by mail-qk0-x241.google.com with SMTP id o135so10787302qke.2
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 11:20:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170317152214.6148-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <43868400-23cc-43d6-614d-2e2032c0d124@amsat.org>
Date: Fri, 17 Mar 2017 15:20:27 -0300
MIME-Version: 1.0
In-Reply-To: <20170317152214.6148-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: fix compilation on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 03/17/2017 12:22 PM, Paolo Bonzini wrote:
> si_band is not found in OpenBSD.   It is marked as obsolescent in
> POSIX, so we can delete it without any remorse.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/oslib-posix.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 94d81b9..3fe6089 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -709,8 +709,6 @@ void sigaction_invoke(struct sigaction *action,
>          si.si_pid = info->ssi_pid;
>          si.si_status = info->ssi_status;
>          si.si_uid = info->ssi_uid;
> -    } else if (info->ssi_signo == SIGIO) {
> -        si.si_band = info->ssi_band;
>      }
>      action->sa_sigaction(info->ssi_signo, &si, NULL);
>  }
>
