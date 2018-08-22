Received: from eggs.gnu.org ([2001:4830:134:3::10]:58714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsXTx-0008FC-Ac
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 14:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsXTt-00007X-4T
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 14:03:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsXTs-00005z-Qc
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 14:03:45 -0400
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534514633-13725-63-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <421b6b2a-4f4a-82e4-bbed-c1df196f8f91@vivier.eu>
Date: Wed, 22 Aug 2018 20:02:32 +0200
MIME-Version: 1.0
In-Reply-To: <1534514633-13725-63-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v10 62/65] linux-user: Add nanoMIPS support
 in scripts/qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

Le 17/08/2018 à 16:03, Aleksandar Markovic a écrit :
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Add support for nanomips[eb] variant in scripts/qemu-binfmt-conf.sh.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  scripts/qemu-binfmt-conf.sh | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
....
> @@ -137,6 +145,12 @@ qemu_get_family() {
>      mips*)
>          echo "mips"
>          ;;
> +    nanomips)
> +        echo "nanomips"
> +        ;;
> +    nanomipseb)
> +        echo "nanomipseb"
> +        ;;

You don't need to add these lines, it's only needed if $cpu != $family.
The default case manages it:

    case "$cpu" in
...
    *)
        echo $cpu
        ;;

Thanks,
Laurent
