Received: from eggs.gnu.org ([2001:4830:134:3::10]:42289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMDTY-0005gX-PD
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMDTT-00085H-St
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:46:04 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181005145202.8005-1-berto@igalia.com>
References: <20181005145202.8005-1-berto@igalia.com>
Date: Mon, 12 Nov 2018 15:45:45 +0100
Message-ID: <w51h8gmbbhi.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] crypto: Fix defaults in
 QCryptoBlockCreateOptionsLUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

ping

On Fri 05 Oct 2018 04:52:02 PM CEST, Alberto Garcia wrote:
> The values specified in the documentation don't match the actual
> defaults set in qcrypto_block_luks_create().
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qapi/crypto.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index a51b434412..b2a4cff683 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -181,11 +181,11 @@
>  # The options that apply to LUKS encryption format initialization
>  #
>  # @cipher-alg: the cipher algorithm for data encryption
> -#              Currently defaults to 'aes'.
> +#              Currently defaults to 'aes-256'.
>  # @cipher-mode: the cipher mode for data encryption
> -#               Currently defaults to 'cbc'
> +#               Currently defaults to 'xts'
>  # @ivgen-alg: the initialization vector generator
> -#             Currently defaults to 'essiv'
> +#             Currently defaults to 'plain64'
>  # @ivgen-hash-alg: the initialization vector generator hash
>  #                  Currently defaults to 'sha256'
>  # @hash-alg: the master key hash algorithm
> -- 
> 2.11.0
