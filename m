Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A9C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02492133D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02492133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtPY-00089p-8F
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60055)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pasic@linux.ibm.com>) id 1hhtOP-0007dL-L9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1hhtON-0001uv-3d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:18:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1hhtOJ-0001sN-DM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:18:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x61ADbmM034074
 for <qemu-devel@nongnu.org>; Mon, 1 Jul 2019 06:18:26 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tfe87pyxm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 06:18:25 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Mon, 1 Jul 2019 11:17:45 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 1 Jul 2019 11:17:43 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x61AHgwl51577040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jul 2019 10:17:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9269DAE051;
 Mon,  1 Jul 2019 10:17:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62278AE053;
 Mon,  1 Jul 2019 10:17:42 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.119])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jul 2019 10:17:42 +0000 (GMT)
Date: Mon, 1 Jul 2019 12:17:41 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20190626130820.12290-1-cohuck@redhat.com>
References: <20190626130820.12290-1-cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070110-0028-0000-0000-0000037F4984
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070110-0029-0000-0000-0000243F7E87
Message-Id: <20190701121741.65b58a54.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-01_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010127
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: add cpu feature/model
 files to KVM section
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 15:08:20 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The cpu features/models are not only relevant for TCG, but
> also for KVM. Make sure that the KVM maintainers are cc:ed
> on patches as well.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cad58b948791..d9b6c129076a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -383,6 +383,8 @@ F: target/s390x/kvm-stub.c
>  F: target/s390x/ioinst.[ch]
>  F: target/s390x/machine.c
>  F: target/s390x/sigp.c
> +F: target/s390x/cpu_features*.[ch]
> +F: target/s390x/cpu_models.[ch]
>  F: hw/intc/s390_flic.c
>  F: hw/intc/s390_flic_kvm.c
>  F: include/hw/s390x/s390_flic.h


