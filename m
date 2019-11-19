Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91698C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6230D222A2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6230D222A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5ll-0001fg-Kj
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1iX5kW-0000dN-P3
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1iX5kV-000162-QE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:49:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31928
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1iX5kV-00015l-Kk; Tue, 19 Nov 2019 10:49:03 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAJFgNZI010833; Tue, 19 Nov 2019 10:49:03 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf57n6j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 10:49:03 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xAJFguPX013220;
 Tue, 19 Nov 2019 10:49:02 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf57n6hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 10:49:02 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAJFfDJa026938;
 Tue, 19 Nov 2019 15:49:01 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02dal.us.ibm.com with ESMTP id 2wa8r6bhhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2019 15:49:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAJFn1Oj49807638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 15:49:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D08EB2065;
 Tue, 19 Nov 2019 15:49:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B163BB2064;
 Tue, 19 Nov 2019 15:49:00 +0000 (GMT)
Received: from [9.80.210.113] (unknown [9.80.210.113])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2019 15:49:00 +0000 (GMT)
Subject: Re: [RFC PATCH v1 1/8] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL for
 EIO
To: Cornelia Huck <cohuck@redhat.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-2-farman@linux.ibm.com>
 <20191118191334.001f9343.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <124b3b51-24db-7821-48c6-3a0789ae3037@linux.ibm.com>
Date: Tue, 19 Nov 2019 10:49:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191118191334.001f9343.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_05:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190142
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/18/19 1:13 PM, Cornelia Huck wrote:
> On Fri, 15 Nov 2019 04:34:30 +0100
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> From: Farhan Ali <alifm@linux.ibm.com>
>>
>> EIO is returned by vfio-ccw mediated device when the backing
>> host subchannel is not operational anymore. So return cc=3
>> back to the guest, rather than returning a unit check.
>> This way the guest can take appropriate action such as
>> issue an 'stsch'.
> 
> Hnm, I'm trying to recall whether that was actually a conscious choice,
> but I can't quite remember... the change does make sense at a glance,
> however.
> 
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> 
> I would need your s-o-b for that one, though :)

Oops.  :)

> 
>> ---
>>  hw/vfio/ccw.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 6863f6c69f..0919ddbeb8 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -114,6 +114,7 @@ again:
>>          return IOINST_CC_BUSY;
>>      case -ENODEV:
>>      case -EACCES:
>> +    case -EIO:
>>          return IOINST_CC_NOT_OPERATIONAL;
>>      case -EFAULT:
>>      default:
> 

