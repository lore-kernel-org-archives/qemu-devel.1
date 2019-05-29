Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2125C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81F222CDA
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81F222CDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54840 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyzn-0004oq-59
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:51:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hVyye-0004Mg-La
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hVyyc-0004Hk-Mq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:50:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43088
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1hVyya-0004GE-Nz
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:50:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4TDoUN4020890
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:50:43 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ssu59rcdn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:50:31 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Wed, 29 May 2019 14:48:07 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
	by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 29 May 2019 14:48:05 +0100
Received: from b03ledav001.gho.boulder.ibm.com
	(b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4TDm35Y17629578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 29 May 2019 13:48:03 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B8B56E05F;
	Wed, 29 May 2019 13:48:03 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1D696E053;
	Wed, 29 May 2019 13:47:58 +0000 (GMT)
Received: from [9.80.235.171] (unknown [9.80.235.171])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed, 29 May 2019 13:47:57 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
	<20190507154733.28604-3-cohuck@redhat.com>
	<f2c65517-f6d8-41a4-3f8a-88a530cdcd41@linux.ibm.com>
	<20190521183235.7c3d0b37.cohuck@redhat.com>
	<192d35fa-12be-c840-e61c-716a3bd80943@linux.ibm.com>
	<20190529114828.046a832f.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Wed, 29 May 2019 09:47:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529114828.046a832f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19052913-0036-0000-0000-00000AC443D0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011179; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01210285; UDB=6.00635855;
	IPR=6.00991318; 
	MB=3.00027101; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-29 13:48:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052913-0037-0000-0000-00004BFD27B1
Message-Id: <ed4862e6-bd65-3521-d5cd-8b1dac583132@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-29_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905290091
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v4 2/2] vfio-ccw: support async command
 subregion
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
Cc: Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/29/19 5:48 AM, Cornelia Huck wrote:
> On Tue, 21 May 2019 16:47:45 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 5/21/19 12:32 PM, Cornelia Huck wrote:
> 
>>> Why mostly? I'm not sure yet whether we handling multiple requests for
>>> passthrough devices correctly yet (virtual should be fine.)
>>>
>>> Start vs. (start|halt|clear) is fine, as the code checks whether
>>> something is already pending before poking the kernel interface.
>>> Likewise, halt vs. (start|halt|clear) is fine, as the code checks for
>>> halt or clear and start and halt use different regions. The problematic
>>> one is clear, as that's something that's always supposed to go through.
>>> Probably fine if clear should always "win", but I need to think some
>>> more about that.  
>>
>> I suspect you are right, because of the check on the halt side, and
>> considering that the clear is the biggest recovery action we have.  So
>> this does seem like things are okay.  I'll ponder this overnight and
>> finish my review tomorrow.
> 
> Ok, what's the verdict here? :)

Gah, I left this sit in my draft folder before holiday.  Sorry about that!

> 
> (I'm trying to clean up my pending stuff :)
> 


