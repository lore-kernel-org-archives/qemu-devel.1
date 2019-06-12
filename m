Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27287C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1D820866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1D820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb3QT-0001bB-7k
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 09:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38733)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <farosas@linux.ibm.com>) id 1hb3Op-0008Vn-3o
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1hb3On-0002Jx-FZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:34:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1hb3On-0002Ij-4o; Wed, 12 Jun 2019 09:34:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5CDIMC5072725; Wed, 12 Jun 2019 09:34:32 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t2yr47p40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jun 2019 09:34:31 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5C9LJ0r032295;
 Wed, 12 Jun 2019 09:39:15 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01dal.us.ibm.com with ESMTP id 2t1x6sq7y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jun 2019 09:39:15 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5CDYJiv24773094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 13:34:19 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B332AE064;
 Wed, 12 Jun 2019 13:34:19 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42E04AE063;
 Wed, 12 Jun 2019 13:34:19 +0000 (GMT)
Received: from localhost (unknown [9.86.26.88])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 12 Jun 2019 13:34:19 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
In-Reply-To: <c5e92072-eb8d-7af5-3eef-fac256f29c98@ozlabs.ru>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
 <20190228225759.21328-6-farosas@linux.ibm.com>
 <b8a30b89-8c19-821e-e3a3-f1b71a088d9d@ozlabs.ru>
 <87ef73rl39.fsf@linux.ibm.com>
 <eadc5e30-5094-9b76-7268-cfb633ac40bd@ozlabs.ru>
 <c5e92072-eb8d-7af5-3eef-fac256f29c98@ozlabs.ru>
Date: Wed, 12 Jun 2019 10:34:17 -0300
Message-ID: <877e9r3p2e.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-12_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120092
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [RFC PATCH v4 5/5] target/ppc: support single
 stepping with KVM HV
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> Are you reposting this any time soon?

I have sent a v2 to the kernel side of it:

https://lore.kernel.org/kvm/20190529222219.27994-1-farosas@linux.ibm.com/

I'm depending on what we decide to do there. The core of this patchset
will not change, just the mechanism by which the feature is selected
(patch 2, kvm-all: Introduce kvm_set_singlestep).

> In meanwhile I hit a problem when I cannot step over the "stdu" instruction.
>
> I basically put this:
> stdu    r1,-368(r1)
>
> and "ni" in gdb does not stop on the next instruction which is quite
> confusing. Ideas?

Perhaps the next instruction is one that is not traced? See the programming
note at the end of section 6.5.15 in Book III.

Or maybe the step got preempted? You should see GDB messages indicating
changing threads right before or after the stdu. However that would only
happen with more than one VCPU and if 'show scheduler-locking' in GDB is
'off'. And even then, that should not cause any issues, but it is a more
complex scenario so there could be a bug in the code.

> On 20/03/2019 12:42, Alexey Kardashevskiy wrote:
>> 
>> 
>> On 20/03/2019 01:32, Fabiano Rosas wrote:
>>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>>
>>>> Looks good to me, does not break what already works. However I cannot
>>>> debug SLOF real mode and I am not sure why.
>>>>
>>>> (gdb) set endian big
>>>>
>>>> The target is assumed to be big endian
>>>> (gdb) b *0x3f00
>>>>
>>>> Breakpoint 2 at 0x3f00
>>>
>>> I think I'm missing the point here. Why 0x3f00?
>> 
>> Because I am stupid and did not realize that 0x3f00 is a relative offset
>> and 0x4000 is the correct address which works.
>> 
>> 
>> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> 
>> 
>>>
>>> (qemu) info roms
>>> addr=0000000000000000 size=0x0e22b8 mem=ram name="...qemu/slof.bin"                               
>>> addr=0000000000400000 size=0x17976d0 mem=ram name="...vmlinux"
>>>
>>>
>>> $ objdump -d board-qemu/llfw/stage1.elf | grep "_start>"
>>> 0000000000000100 <__start>:
>>>      100:       48 00 3f 00     b       4000 <_start>
>>> 0000000000004000 <_start>:
>>>
>>>
>>> Thread 1 hit Breakpoint 3, _start () at startup.S:82
>>> (gdb) p/x $pc
>>> $1 = 0x4000
>>> (gdb) si
>>> (gdb) p/x $pc
>>> $3 = 0x4004
>>> (gdb) c
>>> Thread 1 hit Breakpoint 4, early_c_entry (start_addr=49056, fdt_addr=49024) at stage2.c:202
>>> (gdb) p/x $pc
>>> $4 = 0x4d18
>>>
>> 

