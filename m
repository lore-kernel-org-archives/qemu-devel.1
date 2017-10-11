Received: from eggs.gnu.org ([2001:4830:134:3::10]:48250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2GdQ-0000Dl-C0
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2GdK-0006TS-Ig
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:01:16 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:51169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2GdK-0006SI-CH
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:01:10 -0400
Received: by mail-wm0-x22b.google.com with SMTP id u138so4492540wmu.5
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 06:01:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507726772-16661-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507726772-16661-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 14:00:48 +0100
Message-ID: <CAFEAcA8_sxivZkh0hSjjef=a3qzUfvzvdSvtx7JL6a78=9P-2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tpm: Use EMSGSIZE instead of EBADMSG to
 compile on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, amarnath.valluri@intel.com, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>

On 11 October 2017 at 13:59, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> EMSGSIZE was only added to OpenBSD very recently. To make QEMU

Do you mean "EBADMSG" in this line?

> compileable on older OpenBSD versions use EMSGSIZE instead when
> a mismatch between number of received bytes and message size in-
> dicated in the header was found.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index fb929f6..1129155 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -91,7 +91,7 @@ static int tpm_util_test(int fd,
>      resp = (struct tpm_resp_hdr *)buf;
>      /* check the header */
>      if (be32_to_cpu(resp->len) != n) {
> -        return EBADMSG;
> +        return EMSGSIZE;
>      }
>
>      *return_tag = be16_to_cpu(resp->tag);
> --
> 2.5.5
>

thanks
-- PMM
