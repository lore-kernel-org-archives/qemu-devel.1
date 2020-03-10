Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C6EC18E5C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3D521D56
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qxf2l550"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3D521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjKU-0005a6-AL
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBjJs-0005As-5J
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBjJq-0003qd-Un
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:09:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBjJq-0003ki-L1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:09:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AI2MLj028482;
 Tue, 10 Mar 2020 18:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fOV+0LlfPIaSEgwlhZCI+VQDh0LUqIh1voVb/0zM7LY=;
 b=Qxf2l550i7elZLpmvEy6KvQqF6qWptbwnbMj98YKhB2GO2pGNxAV0EpzOHleKyLkLWee
 jM2D0MYuoy9j8Af/oJHNpEGcOx6I2SSjVFdRpo5Twj7xQDf9W7giexE1q7tHz5+ogBlW
 XD8sFHwbH9nnpGsW1M6aPGTBVIlFhEc2XxjaKVV+A+S+4cPVZ5FR0oy5apLoMqCUv45g
 7SWL7J64068NlCX4nckQkSkC3/u1FcOU7WCO7P2iSDOSWMJdYuw6J2okKNOyGBjpY6tm
 /4R7eZtQdlzweBE8+svGcUXOYGdaUHyoiXiJE95zcXYhiG+AMYjrBrYp/ZRMZ3IZDDhS Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yp9v629xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 18:09:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AI3mEE001652;
 Tue, 10 Mar 2020 18:09:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yp8rkc4ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 18:09:15 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AI9EBH024141;
 Tue, 10 Mar 2020 18:09:14 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 11:09:14 -0700
Subject: Re: [PATCH v2 00/16]: hw/i386/vmport: Bug fixes and improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
 <20200310133932-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <bcf7f439-7954-a6dc-322e-f8cbddd51d24@oracle.com>
Date: Tue, 10 Mar 2020 20:09:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310133932-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100109
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: nikita.leshchenko@oracle.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/03/2020 19:44, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 06:53:16PM +0200, Liran Alon wrote:
>> Hi,
>>
>> This series aims to fix several bugs in VMPort and improve it by supporting
>> more VMPort commands and make command results more configurable to
>> user via QEMU command-line.
>>
>> This functionality was proven to be useful to run various VMware VMs
>> when attempting to run them as-is on top of QEMU/KVM.
>>
>> For more details, see commit messages.
> Well two versions in one day and some review comments weren't addressed.
There is a single review comment that wasn't addressed which is 
replacing an enum with a comment. And I explicitly mentioned that it's 
because I want additional opinion on this.
I don't see why such a small thing should block review for 15 patches...
All the rest of the comments (Which were great) have been addressed. 
Unless I have mistakenly missed something, which please point it out if 
I did.
> Some people do this, try to wear the maintainers out by sheer volume.
> It works sometimes but it's not a nice tactic. I personally think it's
> worth taking the time to think harder about ways to address all
> comments, not try to dismiss them.
That's not what I tried to do. I carefully fixed all comments I saw in 
the review discussion and run tests.
The only thing which wasn't addressed is removing an enum and replacing 
it with a comment.
The hint that I try to manipulate maintainers is disrespectful. I assume 
that this isn't your intention, as we all just want to collaborate 
together here. No need to make this a personal discussion.

If you think that replacing the enum with a comment is a blocker for v2 
patch-series, I will go ahead and submit v3 with that change.
Is there any other comment you made on v1 patch-series you think I missed?

Thanks,
-Liran

>
> Thanks!
>
>> Regards,
>> -Liran
>>
>> v1->v2:
>> * Fix coding convention [Patchew Bot & MST].
>> * Create new header file for vmport.h [MST].
>> * Move KVM_APIC_BUS_FREQUENCY from linux-headers/asm-x86/kvm.h
>>    auto-generated header [MST]
>> * Elaborate more that vmx-version refers to the VMware userspace
>>    VMM in commit message. [MST]
>> * Use le32_to_cpu() on BIOS_UUID vmport command. [MST]
>> * Introduce VMPort compatability version property to maintain migration
>>    compatibility. [MST]

