Received: from eggs.gnu.org ([209.51.188.92]:35953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gyLSH-00083G-IB
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gyLSG-0002b5-MX
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:58:21 -0500
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:40868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gyLSG-0002X3-BH
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:58:20 -0500
Received: from player158.ha.ovh.net (unknown [10.109.159.139])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id D7E0E1F910B
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 19:58:17 +0100 (CET)
References: <20190225170155.1972-1-muriloo@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5b70e0f2-0464-cda6-9f3f-3add525fa6bc@kaod.org>
Date: Mon, 25 Feb 2019 19:58:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190225170155.1972-1-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] ppc/pnv: increase kernel size limit
 to 256MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>, qemu-devel@nongnu.org
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org

On 2/25/19 6:01 PM, Murilo Opsfelder Araujo wrote:
> First patch increases kernel size limit to 256MiB to fit images generated with
> CONFIG_DEBUG_INFO.
> 
> Second patch just fixes a misleading comment regarding initrd size limit.
> 
> Third patch uses IEC prefixes to represent size constants.

They look fine.

Have you tried these patches on a P9 machine ? You will need to use
the powernv-4.0 branch on my github for that.

Thanks,

C. 

> 
> v1..v2:
>   Use IEC prefixes as per Eric Blake' suggestion.
> 
> Murilo Opsfelder Araujo (3):
>   ppc/pnv: increase kernel size limit to 256MiB
>   ppc/pnv: add INITRD_MAX_SIZE constant
>   ppc/pnv: use IEC binary prefixes to represent sizes
> 
>  hw/ppc/pnv.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
