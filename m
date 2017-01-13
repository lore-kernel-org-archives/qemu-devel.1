Received: from eggs.gnu.org ([2001:4830:134:3::10]:34467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRtRp-0001nT-LW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 23:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRtRl-00056a-Mb
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 23:26:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47534
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRtRl-000565-Gz
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 23:26:37 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0D4O1AH068722
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 23:26:36 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27xqsd86bf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 23:26:36 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 13 Jan 2017 09:56:33 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <7277d5da-dbc4-b76a-c0a7-8af205c8f771@twiddle.net>
References: <1484279649-22286-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1484279649-22286-2-git-send-email-nikunj@linux.vnet.ibm.com>
	<7277d5da-dbc4-b76a-c0a7-8af205c8f771@twiddle.net>
Date: Fri, 13 Jan 2017 09:56:23 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tw93fuvk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target-ppc: Add xvtstdc[sp,
 dp] instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:

> On 01/12/2017 07:54 PM, Nikunj A Dadhania wrote:
>> +    uint32_t match = 0;                                     \
>> +                                                            \
>> +    getVSR(xbn, &xb, env);                                  \
>> +    memset(&xt, 0, sizeof(xt));                             \
>> +    dcmx = DCMX_XV(opcode);                                 \
>> +                                                            \
>> +    for (i = 0; i < nels; i++) {                            \
>> +        sign = tp##_is_neg(xb.fld);                         \
>> +        if (tp##_is_any_nan(xb.fld)) {                      \
>> +            match = extract32(dcmx, 6, 1);                  \
>
> Failing to clear match for each elt.

Oops, will send an update :(

Regards,
Nikunj
