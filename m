Received: from eggs.gnu.org ([2001:4830:134:3::10]:38459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e737L-0008PZ-RK
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e737J-0000oF-Pw
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:35:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60234
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e737J-0000n6-Kz
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:35:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9OHUpHV133315
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 13:35:48 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dt5jeqsv1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 13:35:48 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 24 Oct 2017 11:35:47 -0600
References: <20171024122045.30072-1-f4bug@amsat.org>
	<20171024122045.30072-4-f4bug@amsat.org>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 24 Oct 2017 13:35:41 -0400
MIME-Version: 1.0
In-Reply-To: <20171024122045.30072-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0d7dd764-27e5-b7b7-de42-56e6e1b1cebd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] tpm: remove unnecessary #ifdef
 CONFIG_TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

On 10/24/2017 08:20 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Makefile.objs now checks for $(CONFIG_TPM).
>
> Suggested-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   tpm.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/tpm.c b/tpm.c
> index 45520f555d..ab5d29e91e 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -30,8 +30,6 @@ void tpm_register_model(enum TpmModel model)
>       tpm_models[model] =3D true;
>   }
>
> -#ifdef CONFIG_TPM
> -
>   static const TPMBackendClass *
>   tpm_be_find_by_type(enum TpmType type)
>   {
> @@ -192,8 +190,6 @@ int tpm_config_parse(QemuOptsList *opts_list, const=
 char *optarg)
>       return 0;
>   }
>
> -#endif /* CONFIG_TPM */
> -
>   /*
>    * Walk the list of active TPM backends and collect information about=
 them
>    * following the schema description in qapi-schema.json.
