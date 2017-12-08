Received: from eggs.gnu.org ([2001:4830:134:3::10]:52560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eNIQ7-0007aR-JL
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eNIQ4-0002pg-Sz
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:10:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eNIQ4-0002o9-Gn
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:10:24 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB8D9kIU118881
	for <qemu-devel@nongnu.org>; Fri, 8 Dec 2017 08:10:23 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2equ7y8n5e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 08:10:19 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 8 Dec 2017 13:00:05 -0000
References: <20171207153141.15523-1-david@redhat.com>
	<20171207153141.15523-5-david@redhat.com>
	<2e29bd7a-d0d2-bafd-0579-9c8235727c4c@twiddle.net>
	<b17be673-28ab-98bb-1367-76f7f97157f1@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 8 Dec 2017 14:00:01 +0100
MIME-Version: 1.0
In-Reply-To: <b17be673-28ab-98bb-1367-76f7f97157f1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <aea6fca2-0c82-1edf-26fa-7c50ce3db4ea@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 4/5] s390x/tcg: indicate value
 of TODPR in STCKE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>



On 12/08/2017 01:45 PM, David Hildenbrand wrote:
> On 08.12.2017 01:02, Richard Henderson wrote:
>> On 12/07/2017 07:31 AM, David Hildenbrand wrote:
>>> +    /* 16 bit value store in an uint32_t (only valid bits set) */
>>> +    tcg_gen_ld32u_i64(todpr, cpu_env, offsetof(CPUS390XState, todpr));
>>
>> Any reason not to use a uint16_t and use tcg_gen_ld16u_i64 here?
>>
> 
> Yes, KVM introduced and uses this field. As it is used for migration, we
> cannot easily change it. (any maybe it was designed that way for future
> changes)

FWIW, if you look at the POP the TOD programmable register is 32bit (of which
bits 0-15 in IBM speak) are 0.
