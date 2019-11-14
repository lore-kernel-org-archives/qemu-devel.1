Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB25C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2187206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2187206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVJ9j-0005VZ-Nv
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iVJ8m-000514-K4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iVJ8l-00088b-Lw
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:42:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iVJ8l-00088M-DS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:42:43 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xAEHYLxT071016
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 12:42:42 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w99e2weaj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 12:42:42 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Thu, 14 Nov 2019 17:42:40 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 14 Nov 2019 17:42:37 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAEHgaDu53412084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 17:42:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F08E35204E;
 Thu, 14 Nov 2019 17:42:35 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.27])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AE85F5204F;
 Thu, 14 Nov 2019 17:42:35 +0000 (GMT)
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub Channels
 tests
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
 <20191114113823.5d752648.cohuck@redhat.com>
 <20191114140235.30a788d6.pasic@linux.ibm.com>
 <20191114141915.6dd5b9c8.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 18:42:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191114141915.6dd5b9c8.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19111417-0028-0000-0000-000003B6EC0D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111417-0029-0000-0000-00002479FAA4
Message-Id: <2c10ed4f-2b9e-89e7-0e3e-704355523239@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140152
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
Cc: qemu-devel@nongnu.org, frankja@linux.ibm.com, thuth@redhat.com,
 qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019-11-14 14:19, Cornelia Huck wrote:
> On Thu, 14 Nov 2019 14:02:35 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On Thu, 14 Nov 2019 11:38:23 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
>>
>>> On Wed, 13 Nov 2019 20:02:33 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>
...snip...
>> We made some different design decisions, while aiming essentially for the
>> same. Maybe it's due to different scope, maybe not. For instance one
>> can't test IDA with PONG, I guess.
> Now that I saw this again, I also recall the discussion of comparing it
> with the "testdev" for pci/isa. Anybody knows if these are used by
> kvm-unit-tests?

Only by X.

Regards,

Pierre


-- 
Pierre Morel
IBM Lab Boeblingen


