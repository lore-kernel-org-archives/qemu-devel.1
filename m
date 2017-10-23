Received: from eggs.gnu.org ([2001:4830:134:3::10]:38704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e6kZN-0006Y5-Ln
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e6kZK-0007ST-IH
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:47:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50101
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e6kZK-0007S7-Cg
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:47:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9NLiRcK038686
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 17:47:30 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dsheuc229-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 17:47:30 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 23 Oct 2017 15:47:29 -0600
References: <20171023213359.23025-1-f4bug@amsat.org>
	<20171023213359.23025-4-f4bug@amsat.org>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 23 Oct 2017 17:47:23 -0400
MIME-Version: 1.0
In-Reply-To: <20171023213359.23025-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d72adc87-3cc6-a6cd-8fc8-50ba8e0fbe88@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] vl: remove unnecessary #ifdef
 CONFIG_TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

On 10/23/2017 05:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> a stub is now provided.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   vl.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 0723835bbf..ec299099ff 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4624,11 +4624,9 @@ int main(int argc, char **argv, char **envp)
>           exit(1);
>       }
>
> -#ifdef CONFIG_TPM
>       if (tpm_init() < 0) {
>           exit(1);
>       }
> -#endif
>
>       /* init the bluetooth world */
>       if (foreach_device_config(DEV_BT, bt_parse))


Now you should be able to also remove the #ifdef CONFIG_TPM from ./tpm.c.

    Stefan
