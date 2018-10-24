Received: from eggs.gnu.org ([2001:4830:134:3::10]:33386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFRzs-0001zB-7c
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 18:51:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFRsT-00070P-RI
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 18:43:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFRsT-0006zc-JN
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 18:43:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so7234926wrw.11
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 15:43:48 -0700 (PDT)
References: <20181024191458.1277823-1-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d694d457-4871-b3ed-ec1e-be555cacfbf5@redhat.com>
Date: Thu, 25 Oct 2018 00:43:46 +0200
MIME-Version: 1.0
In-Reply-To: <20181024191458.1277823-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tpm: Zero-init structure to avoid
 uninitialized variables in valgrind log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>

On 24/10/18 21:14, Stefan Berger wrote:
> Zero-init the ptm_loc structure so that we don't have fields that
> are not initialised.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/tpm/tpm_emulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 10bc20dbec..968f06ae3b 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -158,7 +158,7 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
>   static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty_number,
>                                        Error **errp)
>   {
> -    ptm_loc loc;
> +    ptm_loc loc = { 0 };
>   
>       if (tpm_emu->cur_locty_number == locty_number) {
>           return 0;
> 
