Received: from eggs.gnu.org ([2001:4830:134:3::10]:33412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cizcB-00008L-AT
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cizc6-000882-DL
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:28:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cizc6-00087j-39
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:27:58 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v218JIp3145243
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 03:27:56 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28wtkx9249-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 03:27:55 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 13:54:15 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <87h93d5rxg.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <1488354251-20802-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170301075913.GC17196@in.ibm.com>
	<87h93d5rxg.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Date: Wed, 01 Mar 2017 13:54:02 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1e15rrx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: rewrite f[n]m[add,
 sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bharata@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, qemu-devel@nongnu.org

Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:

> Bharata B Rao <bharata@linux.vnet.ibm.com> writes:
>
>> On Wed, Mar 01, 2017 at 01:14:11PM +0530, Nikunj A Dadhania wrote:
>>> Use the softfloat api for fused multiply-add. As we are using the fused
>>> multiply-add, the intermediate result for setting VXISI is not
>>> available.
>>
>> Isn't the behaviour of setting VXISI similar to vector muladd instructions ?
>> If so refer to VSX_MADD() to see when VXISI is set.
>
>                 if ((float64_is_infinity(xa.fld) ||
>                      float64_is_infinity(b->fld)) &&
>                      float64_is_infinity(c->fld))) {
>                    float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, sfprf);
>                }
>                
> AFAIU, VXISI is set when (infinity - infinity). The above doesn't take
> into consideration about substraction.

To be precise:

"If the product of x and y is an Infinity and z is an Infinity of the
opposite sign, vxisi_flag is set to 1."

Regards
Nikunj
