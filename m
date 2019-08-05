Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A72C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB0D20880
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB0D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huYcy-0007wK-QZ
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 04:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52810)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1huYby-0006jF-64
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1huYbw-0006Ku-VK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:44:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41202
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1huYbu-0006Ec-8D; Mon, 05 Aug 2019 04:44:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x758gH2C052336; Mon, 5 Aug 2019 04:44:44 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2u6gepa859-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Aug 2019 04:44:44 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x758YkIY016649;
 Mon, 5 Aug 2019 08:44:43 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 2u51w6fhj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Aug 2019 08:44:43 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x758igpr58655032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Aug 2019 08:44:42 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F33FBE053;
 Mon,  5 Aug 2019 08:44:42 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D81F8BE05D;
 Mon,  5 Aug 2019 08:44:40 +0000 (GMT)
Received: from [9.124.31.101] (unknown [9.124.31.101])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon,  5 Aug 2019 08:44:40 +0000 (GMT)
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190719024555.18845-1-aik@ozlabs.ru>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <ae3e5bd1-c7dd-d893-5c0e-803f4e4f2325@linux.vnet.ibm.com>
Date: Mon, 5 Aug 2019 14:14:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190719024555.18845-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-05_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050101
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries REPOST]
 pseries: Update SLOF firmware image
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexey/David,

With the SLOF changes, QEMU cannot resize the RTAS blob. Resizing is
required for FWNMI support which extends the RTAS blob to include an
error log upon a machine check.

The check to valid RTAS buffer fails in the guest because the rtas-size
updated in QEMU is not reflecting in the guest.

Any workaround for this?

The following FWNMI work which is under review modifies the rtas-size to
accommodate the error log:
https://lists.nongnu.org/archive/html/qemu-ppc/2019-06/msg00142.html


Regards,
Aravinda

On Friday 19 July 2019 08:15 AM, Alexey Kardashevskiy wrote:
> I messed up with my local git so reposting.
> 
> The following changes since commit 216965b20b04fbf74e0ce3a3175a9171dba210de:
> 
>   ppc/pnv: update skiboot to v6.4 (2019-07-18 16:49:57 +1000)
> 
> are available in the Git repository at:
> 
>   git@github.com:aik/qemu.git tags/qemu-slof-20190719
> 
> for you to fetch changes up to 300118db53cc454b049d64418c7b2588165a1c35:
> 
>   pseries: Update SLOF firmware image (2019-07-19 12:43:27 +1000)
> 
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
> 
>  pc-bios/README   |   2 +-
>  pc-bios/slof.bin | Bin 926432 -> 926784 bytes
>  roms/SLOF        |   2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> *** Note: this is not for master, this is for pseries
> 

-- 
Regards,
Aravinda

