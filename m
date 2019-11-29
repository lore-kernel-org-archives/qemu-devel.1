Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679C7C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC302070B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC302070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahlH-0003WM-QX
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 10:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mihajlov@linux.ibm.com>) id 1iahI6-0005cm-Ul
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mihajlov@linux.ibm.com>) id 1iahI3-00086v-PI
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:30:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mihajlov@linux.ibm.com>)
 id 1iahI3-0007zr-3E
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:30:35 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xATERFLC108625
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 09:30:33 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wjvsg12np-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 09:30:32 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mihajlov@linux.ibm.com>;
 Fri, 29 Nov 2019 14:30:30 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 29 Nov 2019 14:30:27 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xATEUQmD34799936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2019 14:30:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A30FA405F;
 Fri, 29 Nov 2019 14:30:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0E4BA4054;
 Fri, 29 Nov 2019 14:30:25 +0000 (GMT)
Received: from oc6604088431.ibm.com (unknown [9.152.222.31])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 29 Nov 2019 14:30:25 +0000 (GMT)
Subject: Re: [PATCH 00/15] s390x: Protected Virtualization support
To: Janosch Frank <frankja@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191129110820.GF2260471@redhat.com>
 <699bb3bc-f42a-2fcf-acb3-b91d783e7ce4@linux.ibm.com>
 <20191129123524.GI2260471@redhat.com>
 <c2c4b71b-d42e-3487-01d8-ae4f5751748b@linux.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Date: Fri, 29 Nov 2019 15:30:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <c2c4b71b-d42e-3487-01d8-ae4f5751748b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112914-0008-0000-0000-00000339F15A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112914-0009-0000-0000-00004A5901B1
Message-Id: <d654442f-58f3-d691-76c9-8ed3db2d1d67@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-29_04:2019-11-29,2019-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911290125
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
Cc: thuth@redhat.com, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/29/19 3:02 PM, Janosch Frank wrote:
[...]
>>
>> As a mgmt app I think there will be a need to be able to determine
>> whether a host + QEMU combo is actually able to support protected
>> machines. If the mgmt app is given an image and the users says it
>> required protected mode, then the mgmt app needs to know which
>> host(s) are able to run it.
>>
>> Doing version number checks is not particularly desirable, so is
>> there a way libvirt can determine if QEMU + host in general supports
>> protected machines, so that we can report this feature to mgmt apps ?
> 
> I thought that would be visible via the cpu model by checking for the
> unpack facility (161)?
> Time for somebody else to explain that.
> 
> 
> @Viktor @Boris: This one's for you.
> 
Right, a management app could check the supported CPU model, with 
something like virsh domcapabilities. The domain's CPU model would have 
to require the 'unpack' facility. So, in theory any management app 
establishing CPU model compatibility using the libvirt APIs should be 
able to find appropriate hosts.
[...]
-- 
Kind Regards,
    Viktor


