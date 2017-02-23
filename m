Received: from eggs.gnu.org ([2001:4830:134:3::10]:46517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgt7c-0005Gv-Ai
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgt7Z-0000hE-6G
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:07:48 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgt7Z-0000h1-2M
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:07:45 -0500
Received: by mail-qt0-x243.google.com with SMTP id x35so4132594qtc.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 05:07:45 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170223081109.4686-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49250441-cbe0-f4ec-19a8-f38384264f06@amsat.org>
Date: Thu, 23 Feb 2017 10:07:41 -0300
MIME-Version: 1.0
In-Reply-To: <20170223081109.4686-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tpm-tis: set selftest flag on all
 localities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com

On 02/23/2017 05:11 AM, Marc-André Lureau wrote:
> Set the flag on all localities, as the original commit
> fd859081453f94c3cbd652 intended to.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/tpm/tpm_tis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index a6440fef91..b3c2114bdd 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -398,7 +398,7 @@ static void tpm_tis_receive_cb(TPMState *s, uint8_t locty,
>
>      if (is_selftest_done) {
>          for (l = 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
> -            tis->loc[locty].sts |= TPM_TIS_STS_SELFTEST_DONE;
> +            tis->loc[l].sts |= TPM_TIS_STS_SELFTEST_DONE;
>          }
>      }
>
>
