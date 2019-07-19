Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C373C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70632082E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70632082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoOdj-0003HD-41
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 04:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57723)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sbhat@linux.ibm.com>) id 1hoOdX-0002mS-LH
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1hoOdW-00068G-NF
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:53:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hoOdV-00064N-3h
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:53:06 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6J8qYIl112093
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:52:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tu83s5qwy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:52:58 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Fri, 19 Jul 2019 09:52:56 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 19 Jul 2019 09:52:52 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x6J8qcTp36241742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2019 08:52:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC588A4053;
 Fri, 19 Jul 2019 08:52:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01BE0A4040;
 Fri, 19 Jul 2019 08:52:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.45.205])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jul 2019 08:52:50 +0000 (GMT)
To: Greg Kurz <groug@kaod.org>
References: <156346318478.57409.13978029359288402904.stgit@lep8c.aus.stglabs.ibm.com>
 <20190718181756.49b06085@bahia.lab.toulouse-stg.fr.ibm.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Fri, 19 Jul 2019 14:22:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190718181756.49b06085@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19071908-0012-0000-0000-000003345474
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071908-0013-0000-0000-0000216DD930
Message-Id: <55be3d21-c0a5-b08f-0547-d6636436de29@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-19_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=845 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907190103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] ppc: make idle_timer a
 per-cpu variable
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 07/18/2019 09:47 PM, Greg Kurz wrote:
> On Thu, 18 Jul 2019 10:21:28 -0500
> Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +
> +    timer_deinit(&cpu->idle_timer);
> As stated in the timer.h header file, timer_del() should always be called
> before timer_deinit().
>
> With that fixed:
>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks. Fixed, and posted the v4.

Regards,
Shivaprasad


