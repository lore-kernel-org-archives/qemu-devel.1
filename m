Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC8C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB115222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB115222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JOh-0004Fc-VP
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1j2JNs-0003bL-TF
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1j2JNr-0000Av-Sq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:38:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1j2JNr-00006W-JV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:38:43 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01DIZ56q065927
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 13:38:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y57askb9r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 13:38:40 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Thu, 13 Feb 2020 18:38:38 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Feb 2020 18:38:35 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01DIcXbS61145320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2020 18:38:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3800A4051;
 Thu, 13 Feb 2020 18:38:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88853A4040;
 Thu, 13 Feb 2020 18:38:33 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.41])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 13 Feb 2020 18:38:33 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] docs: rstfy vfio-ap documentation
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
 "Jason J . Herne" <jjherne@linux.ibm.com>
References: <20200213162942.14177-1-cohuck@redhat.com>
 <20200213162942.14177-3-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 13 Feb 2020 19:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213162942.14177-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021318-0016-0000-0000-000002E68BA9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021318-0017-0000-0000-000033498F6A
Message-Id: <d0fb1979-7041-e21e-29f1-a38e3f2dd7e9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-13_07:2020-02-12,
 2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130130
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020-02-13 17:29, Cornelia Huck wrote:
> Move to system/, as this is mostly about configuring vfio-ap.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   MAINTAINERS                              |   2 +-
>   docs/system/index.rst                    |   1 +
>   docs/{vfio-ap.txt => system/vfio-ap.rst} | 796 ++++++++++++-----------
>   3 files changed, 420 insertions(+), 379 deletions(-)
>   rename docs/{vfio-ap.txt => system/vfio-ap.rst} (55%)

...snip...

>   
> -   Example 1: Valid configuration:
> -   ------------------------------
> -   Guest1: adapters 1,2  domains 5,6
> -   Guest2: adapter  1,2  domain 7
> +Example 1: Valid configuration
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> ++----------+--------+--------+
> +|          | Guest1 | Guest2 |
> ++==========+========+========+
> +| adapters |  1, 2  |  1, 2  |
> ++----------+--------+--------+
> +| domains  |  5, 6  |  7     |
> ++----------+--------+--------+
> +

Here when leaving the first cell empty I have a bad rendering with LaTeX.
It is correct when it is filled with something like:

+----------+--------+--------+
|  type    | Guest1 | Guest2 |
+==========+========+========+
| adapters |  1, 2  |  1     |
+----------+--------+--------+
| domains  |  5, 6  |  6, 7  |
+----------+--------+--------+

However it may be because I do not use the right tools.
Did not find which one I am suppose to use.
Currently using:
rst2latex vfio-ap.rst > vfio-ap.tex && pdflatex vfio-ap.tex

Regards,
Pierre




-- 
Pierre Morel
IBM Lab Boeblingen


