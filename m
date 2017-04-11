Received: from eggs.gnu.org ([2001:4830:134:3::10]:47406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cxkUE-0007tV-5y
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cxkUA-0006ib-Uv
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:20:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53386
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cxkUA-0006iL-P0
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:20:46 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3B1Iqx5041421
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 21:20:45 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29rkcu498m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 21:20:45 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 10 Apr 2017 21:20:44 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170407222016.15308-5-f4bug@amsat.org>
References: <20170407222016.15308-1-f4bug@amsat.org>
	<20170407222016.15308-5-f4bug@amsat.org>
Date: Mon, 10 Apr 2017 20:20:26 -0500
Message-Id: <149187362699.15312.3273219849572595103@loki>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qga: improve error handling in
 transfer_memory_block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

Quoting Philippe Mathieu-Daud=C3=A9 (2017-04-07 17:20:16)
> Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
> =

> Michael should I use Signed-off-by instead of the Suggested-by (since it =
is your
> code)?

I suppose it could go either way depending on the circumstances
(assuming you've asked for / obtained their SoB obviously), but
speaking for myself here I don't think it's necessary.

> =

>  qga/commands-posix.c | 3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index fc45102a1e..ca5a24b2c9 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2128,6 +2128,9 @@ static void transfer_memory_block(GuestMemoryBlock =
*mem_blk, bool sys2memblk,
>              if (errno =3D=3D ENOENT) {
>                  result->response =3D
>                      GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPO=
RTED;
> +            } else {
> +                result->response =3D
> +                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
>              }
>              goto out1;
>          }
> -- =

> 2.11.0
>=20
