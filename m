Received: from eggs.gnu.org ([2001:4830:134:3::10]:41545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2vZt-0004px-OD
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2vZs-0008HA-UE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:12:05 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2vZs-0008G7-Mm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:12:04 -0400
Received: by mail-wr0-x235.google.com with SMTP id z52so62791783wrc.2
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 01:12:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54CC82B4-7CDC-41BC-8CD9-58C026A9EF15@gmail.com>
References: <54CC82B4-7CDC-41BC-8CD9-58C026A9EF15@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 09:11:42 +0100
Message-ID: <CAFEAcA9Y-HBbd-xrC3YXjTBNHdW8ztKj15VKGg_qCGPDM1oJjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 8/9] Add end of test message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 25 April 2017 at 04:24, G 3 <programmingkidx@gmail.com> wrote:
> Print the message "End of test" on the risu host end.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  risu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/risu.c b/risu.c
> index ed5b605..e7cbd57 100644
> --- a/risu.c
> +++ b/risu.c
> @@ -63,6 +63,7 @@ void apprentice_sigill(int sig, siginfo_t *si, void *uc)
>           return;
>        case 1:
>           /* end of test */
> +         printf("End of test\n");
>           exit(0);
>        default:
>           /* mismatch */

This code is a signal handler, you can't use printf() here.

thanks
-- PMM
