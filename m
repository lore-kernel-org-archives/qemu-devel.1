Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504CAC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 17:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E6D20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 17:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E6D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56479 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDXwa-0007lW-9f
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 13:20:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hDXvg-0007MY-PD
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hDXve-0003U1-Mb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:19:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46298
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hDXve-0003Tj-EM
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:19:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x38H4AF0185103
	for <qemu-devel@nongnu.org>; Mon, 8 Apr 2019 13:19:29 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rr96vm62k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:19:28 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 8 Apr 2019 18:19:28 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
	by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 8 Apr 2019 18:19:24 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
	[9.57.199.107])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x38HJNSj30736638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 8 Apr 2019 17:19:23 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C9D6124058;
	Mon,  8 Apr 2019 17:19:23 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CDE8124055;
	Mon,  8 Apr 2019 17:19:23 +0000 (GMT)
Received: from [9.56.58.129] (unknown [9.56.58.129])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon,  8 Apr 2019 17:19:23 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 8 Apr 2019 13:19:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190408190747.12e3618b.cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040817-0040-0000-0000-000004DE16AF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010890; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000284; SDB=6.01186196; UDB=6.00621238;
	IPR=6.00966953; 
	MB=3.00026346; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-08 17:19:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040817-0041-0000-0000-000008E91BD9
Message-Id: <b0ff9cf2-f311-2056-a8b1-415c61a419fc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-08_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=688 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904080138
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe to access
 channel programs
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
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408171923.u4fFsuqhJwuTH0DSY4WFoMptFPi4pSBVQFuEkQFf84E@z>



On 04/08/2019 01:07 PM, Cornelia Huck wrote:
> On Mon, 8 Apr 2019 13:02:12 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 03/01/2019 04:38 AM, Cornelia Huck wrote:
>>> When we get a solicited interrupt, the start function may have
>>> been cleared by a csch, but we still have a channel program
>>> structure allocated. Make it safe to call the cp accessors in
>>> any case, so we can call them unconditionally.
>>>
>>> While at it, also make sure that functions called from other parts
>>> of the code return gracefully if the channel program structure
>>> has not been initialized (even though that is a bug in the caller).
>>>
>>> Reviewed-by: Eric Farman<farman@linux.ibm.com>
>>> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
>>> ---
>>
>> Hi Connie,
>>
>> My series of fixes for vfio-ccw depends on this patch as I would like to
>> call cp_free unconditionally :) (I had developed my code on top of your
>> patches).
>>
>> Could we pick this patch up as well when/if you pick up my patch series?
>> I am in the process of sending out a v2.
>>
>> Regarding this patch we could merge it as a stand alone patch, separate
>> from this series. And also the patch LGTM
>>
>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> 
> Actually, I wanted to ask how people felt about merging this whole
> series for the next release :) It would be one thing less on my plate...
> 
> 

I have been testing with your patches for a while now and I haven't hit 
any problems due to the patches.

IMHO I think we can merge the patches for the next release.

Thanks
Farhan


