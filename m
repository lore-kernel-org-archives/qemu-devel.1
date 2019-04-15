Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F77EC10F12
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BDF20818
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BDF20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51715 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG3VR-0003SX-A9
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 11:26:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hG3UB-0002nu-Hx
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hG3UA-0004b8-K1
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:25:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38244
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hG3UA-0004Zr-5U
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:25:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FFOd1a138786
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 11:25:28 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rvuk0kcy2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 11:25:28 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 15 Apr 2019 16:25:27 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
	by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 15 Apr 2019 16:25:25 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
	[9.57.199.108])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x3FFPO7V36962506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 15 Apr 2019 15:25:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 245F1B2070;
	Mon, 15 Apr 2019 15:25:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14F64B2064;
	Mon, 15 Apr 2019 15:25:24 +0000 (GMT)
Received: from [9.56.58.129] (unknown [9.56.58.129])
	by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2019 15:25:24 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-7-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 15 Apr 2019 11:25:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190301093902.27799-7-cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041515-0040-0000-0000-000004E12454
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010932; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000284; SDB=6.01189479; UDB=6.00623230;
	IPR=6.00970266; 
	MB=3.00026453; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 15:25:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041515-0041-0000-0000-000008EC2E1C
Message-Id: <0820ad60-9654-b031-a953-658abff6d6f8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-15_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=850 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904150106
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v4 6/6] vfio-ccw: add handling for async
 channel instructions
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
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415152523.ka1NfYj_GyDwHPk9jG-HzCkGaWjePnVq5rVvsWsd_BI@z>



On 03/01/2019 04:39 AM, Cornelia Huck wrote:
> Add a region to the vfio-ccw device that can be used to submit
> asynchronous I/O instructions. ssch continues to be handled by the
> existing I/O region; the new region handles hsch and csch.
> 
> Interrupt status continues to be reported through the same channels
> as for ssch.
> 
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>


