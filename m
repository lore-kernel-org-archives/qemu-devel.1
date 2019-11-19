Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECEAC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD4121D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD4121D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5fM-0005O5-I7
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1iX5eR-0004mm-NR
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1iX5eQ-00063u-EW
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:42:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1iX5eQ-0005pk-6Z; Tue, 19 Nov 2019 10:42:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAJFgPe1070806; Tue, 19 Nov 2019 10:42:28 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf564hc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 10:42:27 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAJFgQGJ070854;
 Tue, 19 Nov 2019 10:42:26 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf564h03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 10:42:26 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAJFfCFd007256;
 Tue, 19 Nov 2019 15:42:11 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma01wdc.us.ibm.com with ESMTP id 2wa8r64bmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 15:42:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAJFg6NR45547990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 15:42:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DB55B2067;
 Tue, 19 Nov 2019 15:42:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD0CEB205F;
 Tue, 19 Nov 2019 15:42:05 +0000 (GMT)
Received: from [9.80.210.113] (unknown [9.80.210.113])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2019 15:42:05 +0000 (GMT)
Subject: Re: [RFC PATCH v1 1/8] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL for
 EIO
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-2-farman@linux.ibm.com>
 <20191118191334.001f9343.cohuck@redhat.com>
 <20191119122340.41c77c5b.pasic@linux.ibm.com>
 <20191119130220.7c0eef35.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <341dd3fc-c609-f6b2-161a-923e9acef6ea@linux.ibm.com>
Date: Tue, 19 Nov 2019 10:42:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191119130220.7c0eef35.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_05:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Jason Herne <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/19/19 7:02 AM, Cornelia Huck wrote:
> On Tue, 19 Nov 2019 12:23:40 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Mon, 18 Nov 2019 19:13:34 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>>> EIO is returned by vfio-ccw mediated device when the backing
>>>> host subchannel is not operational anymore. So return cc=3
>>>> back to the guest, rather than returning a unit check.
>>>> This way the guest can take appropriate action such as
>>>> issue an 'stsch'.    
>>>
>>> Hnm, I'm trying to recall whether that was actually a conscious choice,
>>> but I can't quite remember... the change does make sense at a glance,
>>> however.  
>>
>> Is EIO returned if and only if the host subchannel/device is not
>> operational any more, or are there cases as well? 
> 
> Ok, I walked through the kernel code, and it seems -EIO can happen
> - when we try to do I/O while in the NOT_OPER or STANDBY states... cc 3
>   makes sense in those cases
> - when the cp is not initialized when trying to fetch the orb... which
>   is an internal vfio-ccw kernel module error
> 
> Btw., this patch only changes one of the handlers; I think you have to
> change all of start/halt/clear?

Correct; this patch must've been written before the halt/clear handlers
landed and I missed that nuance in the rebase.  I'll fix that up...

> 
> [Might also be good to double-check the handling for the different
> instructions.]

...and do the double-checking.

> 
>> Is the mapping
>> (cc to condition) documented? By the QEMU code I would think that
>> we already have ENODEV and EACCESS for 'not operational' -- no idea
>> why we need two codes though.
> 
> -ENODEV: device gone
> -EACCES: no path operational
> 
> We should be able to distinguish between the two; in the 'no path
> operational' case, the device may still be accessible with a different
> path mask in the request.
> 

As long as we don't ignore the guest LPM.  Gotta drop that patch.  ;)

