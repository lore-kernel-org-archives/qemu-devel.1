Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC12C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5832F278E7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5832F278E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36111 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoKI-0005NM-Ih
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 10:52:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stli@linux.ibm.com>) id 1hXoHj-0003IB-W7
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stli@linux.ibm.com>) id 1hXo83-0004Cg-J9
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:40:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39846
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stli@linux.ibm.com>) id 1hXo83-0004B6-DB
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:40:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x53EYTW6060523
	for <qemu-devel@nongnu.org>; Mon, 3 Jun 2019 10:40:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sw4htk6c1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:39:59 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stli@linux.ibm.com>;
	Mon, 3 Jun 2019 15:39:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 3 Jun 2019 15:39:54 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x53EdpeV51052792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 3 Jun 2019 14:39:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B64CAE053;
	Mon,  3 Jun 2019 14:39:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46129AE045;
	Mon,  3 Jun 2019 14:39:51 +0000 (GMT)
Received: from oc4452167425.ibm.com (unknown [9.152.222.74])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  3 Jun 2019 14:39:51 +0000 (GMT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531145608.28183-1-david@redhat.com>
	<20190531145608.28183-3-david@redhat.com>
	<b16f8afd-3458-591c-5b47-e1672e53e64a@linux.ibm.com>
	<dcf1b51b-78c8-7936-092b-439e8a9a3c8b@redhat.com>
From: Stefan Liebler <stli@linux.ibm.com>
Date: Mon, 3 Jun 2019 16:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dcf1b51b-78c8-7936-092b-439e8a9a3c8b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060314-0020-0000-0000-000003443BFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060314-0021-0000-0000-000021973EAC
Message-Id: <3bec7cf0-9be1-ea6f-7dbc-cbf95fd08293@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-06-03_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=617 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1906030103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/tcg: Store only the necessary
 amount of doublewords for STFLE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@de.ibm.com>,
	Andreas Krebbel <Andreas.Krebbel@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 12:45 PM, David Hildenbrand wrote:
> On 03.06.19 12:38, Stefan Liebler wrote:
>> On 5/31/19 4:56 PM, David Hildenbrand wrote:
>>> The PoP (z14, 7-382) says:
>>>       Doublewords to the right of the doubleword in which the
>>>       highest-numbered facility bit is assigned for a model
>>>       may or may not be stored.
>>>
>>> However, stack protection in certain binaries can't deal with that.
>>> "gzip" example code:
>>>
>>> f1b4:       a7 08 00 03             lhi     %r0,3
>>> f1b8:       b2 b0 f0 a0             stfle   160(%r15)
>>> f1bc:       e3 20 f0 b2 00 90       llgc    %r2,178(%r15)
>>> f1c2:       c0 2b 00 00 00 01       nilf    %r2,1
>>> f1c8:       b2 4f 00 10             ear     %r1,%a0
>>> f1cc:       b9 14 00 22             lgfr    %r2,%r2
>>> f1d0:       eb 11 00 20 00 0d       sllg    %r1,%r1,32
>>> f1d6:       b2 4f 00 11             ear     %r1,%a1
>>> f1da:       d5 07 f0 b8 10 28       clc     184(8,%r15),40(%r1)
>>> f1e0:       a7 74 00 06             jne     f1ec <file_read@@Base+0x1bc>
>>> f1e4:       eb ef f1 30 00 04       lmg     %r14,%r15,304(%r15)
>>> f1ea:       07 fe                   br      %r14
>>> f1ec:       c0 e5 ff ff 9d 6e       brasl   %r14,2cc8 <__stack_chk_fail@plt>
>>>
>>> In QEMU, we currently have:
>>>       max_bytes = 24
>>> the code asks for (3 + 1) doublewords == 32 bytes.
>>>
>>> If we write 32 bytes instead of only 24, and return "2 + 1" doublewords
>>> ("one less than the number of doulewords needed to contain all of the
>>>    facility bits"), the example code detects a stack corruption.
>>>
>>> In my opinion, the code is wrong. However, it seems to work fine on
>>> real machines. So let's limit storing to the minimum of the requested
>>> and the maximum doublewords.
>> Hi David,
>>
>> Thanks for catching this. I've reported the "gzip" example to Ilya and
>> indeed, r0 is setup too large. He will fix it in gzip.
>>
>> You've mentioned, that this is detected in certain binaries.
>> Can you please share those occurrences.
> 
> Hi Stafan,
> 
> thanks for your reply.
> 
> I didn't track all occurrences, it *could* be that it was only gzip in
> the background making other processes fail.
> 
> For example, the systemd "vitual console setup" unit failed, too, which
> was fixed by this change.
At least "objdump -d /usr/lib/systemd/systemd-vconsole-setup" does not 
contain the stfle instruction, but "ldd 
/usr/lib/systemd/systemd-vconsole-setup" is showing libz.so which could 
also contain Ilya's patches with the stfle instruction (I assume there 
is the same bug as in gzip). But I have no idea if libz is really called.
> 
> I also remember, seeing segfaults in rpmbuild, for example. They only
> "changed" with this fix - I m still chasing different errors. :)
The same applies for rpmbuild.
> 
> You mentioned "He will fix it in gzip", so I assume this is a gzip issue
> and not a gcc/glibc/whatever toolchain issue?
> 
Yes, this is a gzip bug. r0 was initialized with:
(sizeof(array-on-stack) / 8)
instead of:
(sizeof(array-on-stack) / 8) - 1

Ilya will fix it in gzip and zlib.
@Ilya: Please correct me if I'm wrong.


