Received: from eggs.gnu.org ([2001:4830:134:3::10]:48835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cX1g1-0003bk-98
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cX1fx-0004wO-7G
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:14:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cX1fw-0004w3-Tt
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:14:29 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0R8DkK9059937
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:14:27 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 287vatkjp3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:14:27 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 27 Jan 2017 13:44:23 +0530
Date: Fri, 27 Jan 2017 13:44:16 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
	<148550455141.27.8723621652077562403@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148550455141.27.8723621652077562403@eba24e3a0d7f>
Message-Id: <20170127081416.GA17330@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/2] softfloat: Add round-to-odd
 rounding mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net

On Fri, Jan 27, 2017 at 12:09:13AM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> Your series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Subject: [Qemu-devel] [RFC PATCH v2 0/2] softfloat: Add round-to-odd rounding mode
> Message-id: 1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com
> 
> Checking PATCH 1/2: softfloat: Handle float64 rounding properly for underflow case...
> Checking PATCH 2/2: softfloat: Add round-to-odd rounding mode...
> ERROR: space prohibited after that '-' (ctx:WxW)
> #41: FILE: fpu/softfloat.c:641:
> +            return packFloat64( zSign, 0x7FF, - ( !overflow_to_inf ));
>                                                ^
> 
> ERROR: space prohibited after that open parenthesis '('
> #41: FILE: fpu/softfloat.c:641:
> +            return packFloat64( zSign, 0x7FF, - ( !overflow_to_inf ));
> 
> ERROR: space prohibited before that close parenthesis ')'
> #41: FILE: fpu/softfloat.c:641:
> +            return packFloat64( zSign, 0x7FF, - ( !overflow_to_inf ));
> 
> ERROR: space prohibited after that open parenthesis '('
> #69: FILE: fpu/softfloat.c:1199:
> +                 || ( roundingMode == float_round_to_odd )
> 
> ERROR: space prohibited before that close parenthesis ')'
> #69: FILE: fpu/softfloat.c:1199:
> +                 || ( roundingMode == float_round_to_odd )
> 
> total: 5 errors, 0 warnings, 62 lines checked

fpu/softfloat.c follows a different coding style and hence it made
sense to stick to the existing style in the file.

Regards,
Bharata.
