Received: from eggs.gnu.org ([2001:4830:134:3::10]:49146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dChOb-0007Mz-Bm
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dChOX-0000es-Sq
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:04:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52793
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dChOX-0000cL-Mk
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:04:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4M6x8iN103074
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 03:04:44 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aktkk9e87-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 03:04:43 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 22 May 2017 17:04:41 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4M74VjC19005610
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:04:39 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
	by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4M745rB025671
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:04:06 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <1495433816-4265-1-git-send-email-sandipandas1990@gmail.com>
References: <1495433816-4265-1-git-send-email-sandipandas1990@gmail.com>
Date: Mon, 22 May 2017 12:33:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a865nzjy.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH risu] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandipan Das <sandipandas1990@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, joserz@linux.vnet.ibm.com

Sandipan Das <sandipandas1990@gmail.com> writes:

> The patterns for the following instructions are fixed:
>  * Rotate Left Doubleword then Clear Right (rldcr[.])
>  * Rotate Left Doubleword Immediate then Clear Right (rldicr[.])
>  * Rotate Left Doubleword Immediate then Mask Insert (rldimi[.])
>
> Signed-off-by: Sandipan Das <sandipandas1990@gmail.com>
> ---
>  ppc64.risu | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/ppc64.risu b/ppc64.risu
> index 28df9da..0f29248 100644
> --- a/ppc64.risu
> +++ b/ppc64.risu
> @@ -1451,7 +1451,7 @@ RLDCLd PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10001 \
>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>
>  # format:MDS book:I page:103 PPC SR rldcr Rotate Left Dword then Clear Right
> -RLCDR PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10010 \
> +RLDCR PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10010 \
>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>  # format:MDS book:I page:103 PPC SR rldcr Rotate Left Dword then Clear Right
>  RLDCRd PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10011 \
> @@ -1472,17 +1472,17 @@ RLDICLd PPC64LE 011110 rs:5 ra:5 sh:5 mb:6 000 sha:1 1 \
>  !constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
>
>  # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
> -RLDICR PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00010 \
> +RLDICR PPC64LE 011110 rs:5 ra:5 rb:5 me:6 001 sha:1 0 \

   RLDICR PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 0

Also "rb:5" be changed as "sh:5"?

>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>  # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
> -RLDICRd PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00011 \
> +RLDICRd PPC64LE 011110 rs:5 ra:5 rb:5 me:6 001 sha:1 1 \

   RLDICRd PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 0


>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>
>  # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
> -RLDIMI PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00110 \
> +RLDIMI PPC64LE 011110 rs:5 ra:5 rb:5 me:6 011 sha:1 0 \

   RLDIMI PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 0


>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>  # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
> -RLDIMId PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00111 \
> +RLDIMId PPC64LE 011110 rs:5 ra:5 rb:5 me:6 011 sha:1 1 \

   RLDIMId PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 1

>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>
>  # format:M book:I page:102 v:P1 SR rlwimi[.] Rotate Left Word Immediate then Mask Insert
> -- 
> 2.7.4

Regards,
Nikunj
