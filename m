Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923EEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B8520734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B8520734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0wG-00055M-PM
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihajlov@linux.ibm.com>)
 id 1jj0dq-00042a-O9; Wed, 10 Jun 2020 09:19:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12574
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihajlov@linux.ibm.com>)
 id 1jj0dp-0006Je-C0; Wed, 10 Jun 2020 09:19:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05AD5Gox141896; Wed, 10 Jun 2020 09:19:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31k03hrdfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 09:19:30 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05AD67Ap143849;
 Wed, 10 Jun 2020 09:19:30 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31k03hrdev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 09:19:30 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05ADGjD3031466;
 Wed, 10 Jun 2020 13:19:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04fra.de.ibm.com with ESMTP id 31g2s7u59u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2020 13:19:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05ADJPxP58589226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2020 13:19:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D1B14C046;
 Wed, 10 Jun 2020 13:19:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 161EA4C04A;
 Wed, 10 Jun 2020 13:19:24 +0000 (GMT)
Received: from oc6604088431.ibm.com (unknown [9.145.22.8])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2020 13:19:24 +0000 (GMT)
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM if
 PV
To: David Hildenbrand <david@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
 <20200609182839.7ac80938.pasic@linux.ibm.com>
 <20200609124155-mutt-send-email-mst@kernel.org>
 <20200610043118.GF494336@umbus.fritz.box>
 <4e5d62d8-9bfb-67d5-7398-2079729fd85e@redhat.com>
 <20200610100756.GO494336@umbus.fritz.box>
 <858e9554-a4c7-6487-121b-ac3eaa209cb7@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Message-ID: <4738b708-9d19-beae-4345-b77453afc585@linux.ibm.com>
Date: Wed, 10 Jun 2020 15:19:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <858e9554-a4c7-6487-121b-ac3eaa209cb7@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-10_07:2020-06-10,
 2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100096
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mihajlov@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:25:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/10/20 12:24 PM, David Hildenbrand wrote:
> On 10.06.20 12:07, David Gibson wrote:
>> On Wed, Jun 10, 2020 at 09:22:45AM +0200, David Hildenbrand wrote:
>>> On 10.06.20 06:31, David Gibson wrote:
>>>> On Tue, Jun 09, 2020 at 12:44:39PM -0400, Michael S. Tsirkin wrote:
>>>>> On Tue, Jun 09, 2020 at 06:28:39PM +0200, Halil Pasic wrote:
>>>>>> On Tue, 9 Jun 2020 17:47:47 +0200
>>>>>> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
>>>>>>
>>>>>>> On Tue, 9 Jun 2020 11:41:30 +0200
>>>>>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> I don't know. Janosch could answer that, but he is on vacation. Adding
>>>>>>>> Claudio maybe he can answer. My understanding is, that while it might
>>>>>>>> be possible, it is ugly at best. The ability to do a transition is
>>>>>>>> indicated by a CPU model feature. Indicating the feature to the guest
>>>>>>>> and then failing the transition sounds wrong to me.
>>>>>>>
>>>>>>> I agree. If the feature is advertised, then it has to work. I don't
>>>>>>> think we even have an architected way to fail the transition for that
>>>>>>> reason.
>>>>>>>
>>>>>>> What __could__ be done is to prevent qemu from even starting if an
>>>>>>> incompatible device is specified together with PV.
>>>>>>
>>>>>> AFAIU, the "specified together with PV" is the problem here. Currently
>>>>>> we don't "specify PV" but PV is just a capability that is managed by the
>>>>>> CPU model (like so many other).
>>>>>
>>>>> So if we want to keep it user friendly, there could be
>>>>> protection property with values on/off/auto, and auto
>>>>> would poke at host capability to figure out whether
>>>>> it's supported.
>>>>>
>>>>> Both virtio and CPU would inherit from that.
>>>>
>>>> Right, that's what I have in mind for my 'host-trust-limitation'
>>>> property (a generalized version of the existing 'memory-encryption'
>>>> machine option).  My draft patches already set virtio properties
>>>> accordingly, it should be possible to set (default) cpu properties as
>>>> well.
>>>
>>> No crazy CPU model hacks please (at least speaking for the s390x).
>>
>> Uh... I'm not really sure what you have in mind here.
>>
> 
> Reading along I got the impression that we want to glue the availability
> of CPU features to other QEMU cmdline parameters (besides the
> accelerator). ("to set (default) cpu properties as well"). If we are
> talking about other CPU properties not expressed as CPU features (e.g.,
> -cpu X,Y=on ...), then there is no issue.
> 

The reason that the capability to run in PV mode is expressed in the CPU
model is that this capability *is* provided by the CPU in terms of
available instructions. I wouldn't see a benefit in providing
a meta-property that needs to be synced with the CPU model.

So, if something has to be concluded from the fact that a VM
could run in PV mode, that decision should be derived from the
CPU model.

-- 
Kind Regards,
    Viktor

