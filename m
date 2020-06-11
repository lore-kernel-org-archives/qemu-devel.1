Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A972BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E79D20792
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E79D20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQ59-00051r-Oq
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjPx3-000085-FZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:21:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49994
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjPwX-0005B2-ST
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:21:13 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05BG3a4k089226; Thu, 11 Jun 2020 12:20:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31kg2w7sce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 12:20:35 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05BG3ohp091012;
 Thu, 11 Jun 2020 12:20:34 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31kg2w7sc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 12:20:34 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05BGKUpa009053;
 Thu, 11 Jun 2020 16:20:34 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma04dal.us.ibm.com with ESMTP id 31g2sautq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 16:20:34 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05BGKXdi45482442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2020 16:20:33 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6333D112062;
 Thu, 11 Jun 2020 16:20:33 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50EAB112061;
 Thu, 11 Jun 2020 16:20:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jun 2020 16:20:33 +0000 (GMT)
Subject: Re: [PATCH v2 02/11] backends: Add TPM files into their own directory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200611160306.2751-1-philmd@redhat.com>
 <20200611160306.2751-3-philmd@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8adc54e8-2546-ced9-c22b-895c965e99c1@linux.ibm.com>
Date: Thu, 11 Jun 2020 12:20:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200611160306.2751-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-11_15:2020-06-11,
 2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 cotscore=-2147483648 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 11:19:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 12:02 PM, Philippe Mathieu-Daudé wrote:
> As we will have various TPM backend files, it is cleaner
> to use a single directory.
>
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   backends/{tpm.c => tpm/tpm_backend.c} | 0
>   MAINTAINERS                           | 2 +-
>   backends/Makefile.objs                | 2 +-
>   backends/tpm/Makefile.objs            | 1 +
>   4 files changed, 3 insertions(+), 2 deletions(-)
>   rename backends/{tpm.c => tpm/tpm_backend.c} (100%)
>   create mode 100644 backends/tpm/Makefile.objs
>
> diff --git a/backends/tpm.c b/backends/tpm/tpm_backend.c
> similarity index 100%
> rename from backends/tpm.c
> rename to backends/tpm/tpm_backend.c
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3abe3faa4e..9deb15b268 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2385,7 +2385,7 @@ F: hw/tpm/*
>   F: include/hw/acpi/tpm.h
>   F: include/sysemu/tpm*
>   F: qapi/tpm.json
> -F: backends/tpm.c
> +F: backends/tpm/
>   F: tests/qtest/*tpm*
>   T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
>   
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 28a847cd57..22d204cb48 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -1,7 +1,7 @@
>   common-obj-y += rng.o rng-egd.o rng-builtin.o
>   common-obj-$(CONFIG_POSIX) += rng-random.o
>   
> -common-obj-$(CONFIG_TPM) += tpm.o
> +common-obj-$(CONFIG_TPM) += tpm/
>   
>   common-obj-y += hostmem.o hostmem-ram.o
>   common-obj-$(CONFIG_POSIX) += hostmem-file.o
> diff --git a/backends/tpm/Makefile.objs b/backends/tpm/Makefile.objs
> new file mode 100644
> index 0000000000..8cf5772824
> --- /dev/null
> +++ b/backends/tpm/Makefile.objs
> @@ -0,0 +1 @@
> +common-obj-y += tpm_backend.o



