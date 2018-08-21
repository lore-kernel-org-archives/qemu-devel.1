Received: from eggs.gnu.org ([2001:4830:134:3::10]:39898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsBPS-0006cQ-83
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsBPR-0003WU-Il
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:29:42 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsBPQ-0003VM-Iq
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:29:41 -0400
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so33759948oie.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 11:29:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180821172324.29331-1-r.bolshakov@yadro.com>
References: <20180821172324.29331-1-r.bolshakov@yadro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 19:29:19 +0100
Message-ID: <CAFEAcA85U43m4HbXXy+B-fw+sLMU4gZYTDjHUpT87970MN91NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] char: Enable build of pty on macOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 21 August 2018 at 18:23, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
> For some reason __APPLE__ was not checked in pty code. pty chardev
> should be available on macOS, according to man page.
>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  chardev/char-pty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 68fd4e20c3..cb00257ebe 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -33,7 +33,7 @@
>
>  #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
>      || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
> -    || defined(__GLIBC__)
> +    || defined(__GLIBC__) || defined(__APPLE__)

We should fix this by figuring out what the code is actually looking
for (ie what OS functions), having a configure test for those
functions, and dropping the big long list of OS ifdefs. Otherwise
we've just got exactly the same problem for the next unix-ish
OS that comes along...

thanks
-- PMM
