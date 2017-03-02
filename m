Received: from eggs.gnu.org ([2001:4830:134:3::10]:45664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjIug-0003fs-GF
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 00:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cjIuc-0004H8-HZ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 00:04:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38314
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cjIuc-0004Gw-Ce
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 00:04:22 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v22549qP044997
	for <qemu-devel@nongnu.org>; Thu, 2 Mar 2017 00:04:21 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28xcd4h4df-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 00:04:21 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 2 Mar 2017 15:04:18 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <CALAZu3_e8AWbOpASxY9s97AyNd+CX=BYCMx3g4KrG2Ki6w1CZg@mail.gmail.com>
References: <1488381854-7275-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170302002933.GL12571@umbus.fritz.box>
	<32926f1f-ec40-420f-210b-8f5991cc9d67@twiddle.net>
	<CALAZu3_e8AWbOpASxY9s97AyNd+CX=BYCMx3g4KrG2Ki6w1CZg@mail.gmail.com>
Date: Thu, 02 Mar 2017 10:33:05 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874lzc1d9y.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v1] target/ppc: rewrite
 f[n]m[add, sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj Dadhania <nikunj.dadhania@gmail.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, bharata@linux.vnet.ibm.com


Oh, some gmail issues, resending:

> On 02-Mar-2017 7:53 AM, "Richard Henderson" <rth@twiddle.net> wrote:
>
> On 03/02/2017 11:29 AM, David Gibson wrote:
>
>> On Wed, Mar 01, 2017 at 08:54:14PM +0530, Nikunj A Dadhania wrote:
>>
>>> Use the softfloat api for fused multiply-add. Also, generate VXISI using
>>> a helper function by computing intermediate result.
>>>
>>
>> Um.. I really need some information on why this is a good thing to
>> do.  Is it a bugfix?  Enhancement? Simplification?
>>
>
> Looks like a bugfix to me.  Previously we were attempting the operation via
> float128 as an intermediate type, which can result in double rounding
> errors.
>

Was discussed here

https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg02000.html

Nikunj
