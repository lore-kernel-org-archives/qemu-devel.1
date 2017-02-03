Received: from eggs.gnu.org ([2001:4830:134:3::10]:46908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cZUM3-0001xa-Fu
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 22:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cZUM0-0004kw-LU
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 22:16:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cZUM0-0004kL-Cs
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 22:16:04 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v133Drt9095529
	for <qemu-devel@nongnu.org>; Thu, 2 Feb 2017 22:16:01 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28ccsu16r8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 22:16:01 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 3 Feb 2017 13:15:59 +1000
Date: Fri, 3 Feb 2017 08:45:01 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <20170203031501.GA12744@in.ibm.com>
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org

Peter,

On Fri, Jan 27, 2017 at 01:33:31PM +0530, Bharata B Rao wrote:
> 
> Changes in v2:
> -------------
> - Do odd or even for the right precision bit in 64bit rounding. (Peter Maydell)
> - Handle the overflow case correctly in 64bit rounding. (Peter Maydell)

Does this version of round-to-odd implementation look correct now ?

> - Add a patch to handle underflow case correctly in 64bit rounding.

Does this fix for underflow case make sense ?

Regards,
Bharata.
