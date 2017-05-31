Received: from eggs.gnu.org ([2001:4830:134:3::10]:44531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dFvz2-0006A4-L6
	for qemu-devel@nongnu.org; Wed, 31 May 2017 01:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dFvyx-0000yU-JE
	for qemu-devel@nongnu.org; Wed, 31 May 2017 01:15:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34949
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dFvyx-0000yQ-D5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 01:15:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4V5EKdO111231
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 01:15:41 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aspg3tcy1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 01:15:41 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 31 May 2017 15:15:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4V5FTbo65011916
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 15:15:37 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4V5EuA2003857
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 15:14:57 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <1496162375-1571-1-git-send-email-peter.maydell@linaro.org>
References: <1496162375-1571-1-git-send-email-peter.maydell@linaro.org>
Date: Wed, 31 May 2017 10:44:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9u9bobl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH risu] ppc64.risu: Fix broken constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Sandipan Das <sandipandas1990@gmail.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Commit c10b97092 changed some field names in rldicr and rldimi patterns
> but forgot to update the constraints to match the change. Since the
> field (previously 'rb' and now 'sh') is an immediate rather than a
> register number, the correct fix is to just delete the constraint
> since we don't need to avoid particular values.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks for fixing it.


> ---
>  ppc64.risu | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/ppc64.risu b/ppc64.risu
> index dd304e2..e2fd4f6 100644
> --- a/ppc64.risu
> +++ b/ppc64.risu
> @@ -1473,17 +1473,17 @@ RLDICLd PPC64LE 011110 rs:5 ra:5 sh:5 mb:6 000 sha:1 1 \
>
>  # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
>  RLDICR PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 0 \
> -!constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
> +!constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
>  # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
>  RLDICRd PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 1 \
> -!constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
> +!constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
>
>  # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
>  RLDIMI PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 0 \
> -!constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
> +!constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
>  # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
>  RLDIMId PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 1 \
> -!constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
> +!constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
>
>  # format:M book:I page:102 v:P1 SR rlwimi[.] Rotate Left Word Immediate then Mask Insert
>  RLWIMI PPC64LE 010100 rs:5 ra:5 sh:5 mb:5 me:5 0 \
> -- 
> 2.7.4
