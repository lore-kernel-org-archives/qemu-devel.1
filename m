Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0500C3F354
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1AB21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1AB21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JTk-00071p-Ld
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1j7JT6-0006T2-2T
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1j7JT5-0005yv-6A
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:44:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1j7JT5-0005yp-14
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:44:47 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01RDgYjs014056
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 08:44:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydhhpbrj7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 08:44:44 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Thu, 27 Feb 2020 13:44:38 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 27 Feb 2020 13:44:35 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01RDhbTL48431472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2020 13:43:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA04911C054;
 Thu, 27 Feb 2020 13:44:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FC1511C04A;
 Thu, 27 Feb 2020 13:44:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.75.238])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2020 13:44:33 +0000 (GMT)
Subject: Re: [PATCH] spapr: Fix Coverity warning while validating nvdimm
 options
To: Greg Kurz <groug@kaod.org>
References: <158271897341.44994.2741557659975232894.stgit@lep8c.aus.stglabs.ibm.com>
 <20200226134927.3cc5b6fb@bahia.home> <20200227132816.191b80ac@bahia.home>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Thu, 27 Feb 2020 19:14:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200227132816.191b80ac@bahia.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022713-0020-0000-0000-000003AE22FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022713-0021-0000-0000-000022064242
Message-Id: <9148d7ac-3ae9-3a97-fd21-9b15a1a8ee4d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-27_04:2020-02-26,
 2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=905 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270108
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/27/2020 05:58 PM, Greg Kurz wrote:
> On Wed, 26 Feb 2020 13:49:27 +0100
> Greg Kurz <groug@kaod.org> wrote:
>
>>> -    qemu_uuid_parse(uuidstr, &uuid);
> ... cause a segv in there because uuidstr will be dereferenced at
> some point without checking if it's NULL.
>
> AFAICT there are two scenarios that can cause object_property_get_str()
> to return NULL:
> - the property doesn't exist
> - the property isn't a string
>
> This can probably never happen with the current code base but we
> can't about future changes. In order to ensure we abort rather
> than segv, I'd pass &error_abort to object_property_get_str().
Thanks! I just posted the V2 fixing this as well.

Regards,
Shivaprasad


