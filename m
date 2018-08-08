Received: from eggs.gnu.org ([2001:4830:134:3::10]:58305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnJSF-00055h-3d
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnJSB-0001hN-Ry
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:04:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39726 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fnJSB-0001h1-K1
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 04:04:23 -0400
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1533574847-19294-81-git-send-email-aleksandar.markovic@rt-rk.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d78dfa4a-bcdb-1148-eea4-7da7a130bacc@redhat.com>
Date: Wed, 8 Aug 2018 10:04:19 +0200
MIME-Version: 1.0
In-Reply-To: <1533574847-19294-81-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 80/80] qemu-doc: Add nanoMIPS-related
 items
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
> Add nanoMIPS-related items in qemu-doc.texi
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  qemu-doc.texi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 8ea6bfa..ab2471d 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2705,6 +2705,8 @@ The binary format is detected automatically.
>  
>  @command{qemu-mipsn32el} executes 32-bit little endian MIPS binaries (MIPS N32 ABI).
>  
> +@command{qemu-nanomips} executes 32-bit little endian nanoMIPS binaries (MIPS P32 ABI).
> +
>  @cindex user mode (NiosII)
>  @command{qemu-nios2} TODO.

I think you could merge this with patch 79/80. Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
