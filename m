Received: from eggs.gnu.org ([2001:4830:134:3::10]:58232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnJRH-0004dP-3p
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnJRE-00019y-0z
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:03:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fnJRD-00019c-Q6
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:03:23 -0400
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1533574847-19294-80-git-send-email-aleksandar.markovic@rt-rk.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3faec1f-295b-69ca-8319-a9ea7586f00d@redhat.com>
Date: Wed, 8 Aug 2018 10:03:10 +0200
MIME-Version: 1.0
In-Reply-To: <1533574847-19294-80-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 79/80] qemu-doc: Amend MIPS-related items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pburton@wavecomp.com, smarkovic@wavecomp.com, riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu, armbru@redhat.com, arikalo@wavecomp.com, philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

On 08/06/2018 07:00 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Amend MIPS-related items in qemu-doc.texi
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>

As far as I've understood the SoB process, your SoB should go last if
you're the last person who has touched this patch, Alexander. I think it
would also be good if you'd use the same e-mail for sending patches as
you used for the SoB in the patches (you sent with rt-rk.com, but used
wavecomp.com in the SoB).

> ---
>  qemu-doc.texi | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index abfd2db..8ea6bfa 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2693,8 +2693,17 @@ The binary format is detected automatically.
>  @command{qemu-microblaze} TODO.
>  
>  @cindex user mode (MIPS)
> -@command{qemu-mips} TODO.
> -@command{qemu-mipsel} TODO.
> +@command{qemu-mips} executes 32-bit big endian MIPS binaries (MIPS O32 ABI).
> +
> +@command{qemu-mipsel} executes 32-bit little endian MIPS binaries (MIPS O32 ABI).
> +
> +@command{qemu-mips64} executes 64-bit big endian MIPS binaries (MIPS O64 ABI).
> +
> +@command{qemu-mips64el} executes 64-bit little endian MIPS binaries (MIPS O64 ABI).
> +
> +@command{qemu-mipsn32} executes 32-bit big endian MIPS binaries (MIPS N32 ABI).
> +
> +@command{qemu-mipsn32el} executes 32-bit little endian MIPS binaries (MIPS N32 ABI).

Looks reasonable to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
