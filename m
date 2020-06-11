Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9331C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82930206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82930206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLr5-00044w-Pg
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjLqD-0002q4-H5
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:57:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30706
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjLqC-0005dR-IQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:57:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05BBZJid132622; Thu, 11 Jun 2020 07:57:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31kjks2krt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 07:57:49 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05BBaJhl135071;
 Thu, 11 Jun 2020 07:57:48 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31kjks2kp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 07:57:47 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05BBsujK023421;
 Thu, 11 Jun 2020 11:57:42 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma02wdc.us.ibm.com with ESMTP id 31g2s8v8a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 11:57:42 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05BBvgLw52756862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2020 11:57:42 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18B27112062;
 Thu, 11 Jun 2020 11:57:42 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E253C112061;
 Thu, 11 Jun 2020 11:57:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jun 2020 11:57:41 +0000 (GMT)
Subject: Re: [PATCH 7/8] hw/tpm: Make 'tpm_util.h' publicly accessible as
 "sysemu/tpm_util.h"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200610200247.21378-1-philmd@redhat.com>
 <20200610200247.21378-8-philmd@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <d7efa99f-f2b9-2a39-5a75-da339e1b5fcf@linux.ibm.com>
Date: Thu, 11 Jun 2020 07:57:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200610200247.21378-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-11_10:2020-06-10,
 2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 cotscore=-2147483648 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 06:23:08
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 4:02 PM, Philippe Mathieu-Daudé wrote:
> We are going to split the TPM backends from the TPM emulated
> hardware in the next commit. Make the TPM util helpers accessible
> by moving local "tpm_util.h" to global "sysemu/tpm_util.h".
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   {hw/tpm => include/sysemu}/tpm_util.h | 6 +++---
>   hw/tpm/tpm_crb.c                      | 2 +-
>   hw/tpm/tpm_emulator.c                 | 2 +-
>   hw/tpm/tpm_passthrough.c              | 2 +-
>   hw/tpm/tpm_spapr.c                    | 2 +-
>   hw/tpm/tpm_tis_common.c               | 2 +-
>   hw/tpm/tpm_util.c                     | 2 +-
>   7 files changed, 9 insertions(+), 9 deletions(-)
>   rename {hw/tpm => include/sysemu}/tpm_util.h (95%)
>
> diff --git a/hw/tpm/tpm_util.h b/include/sysemu/tpm_util.h
> similarity index 95%
> rename from hw/tpm/tpm_util.h
> rename to include/sysemu/tpm_util.h
> index cf61d830d7..63e872c3b2 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/include/sysemu/tpm_util.h
> @@ -19,8 +19,8 @@
>    * License along with this library; if not, see <http://www.gnu.org/licenses/>
>    */
>   
> -#ifndef TPM_TPM_UTIL_H
> -#define TPM_TPM_UTIL_H
> +#ifndef SYSEMU_TPM_UTIL_H
> +#define SYSEMU_TPM_UTIL_H
>   
>   #include "sysemu/tpm.h"
>   #include "qemu/bswap.h"
> @@ -69,4 +69,4 @@ static inline void tpm_cmd_set_error(void *b, uint32_t error)
>   void tpm_util_show_buffer(const unsigned char *buffer,
>                             size_t buffer_size, const char *string);
>   
> -#endif /* TPM_TPM_UTIL_H */
> +#endif /* SYSEMU_TPM_UTIL_H */
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 1cac4d671d..60247295d4 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -24,9 +24,9 @@
>   #include "hw/acpi/tpm.h"
>   #include "migration/vmstate.h"
>   #include "sysemu/tpm_backend.h"
> +#include "sysemu/tpm_util.h"
>   #include "sysemu/reset.h"
>   #include "tpm_prop.h"
> -#include "tpm_util.h"
>   #include "tpm_ppi.h"
>   #include "trace.h"
>   
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 3a0fc442f3..9605339f93 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -32,8 +32,8 @@
>   #include "qemu/sockets.h"
>   #include "io/channel-socket.h"
>   #include "sysemu/tpm_backend.h"
> +#include "sysemu/tpm_util.h"
>   #include "tpm_int.h"
> -#include "tpm_util.h"
>   #include "tpm_ioctl.h"
>   #include "migration/blocker.h"
>   #include "migration/vmstate.h"
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index f67244b5d4..7403807ec4 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -28,10 +28,10 @@
>   #include "qemu/module.h"
>   #include "qemu/sockets.h"
>   #include "sysemu/tpm_backend.h"
> +#include "sysemu/tpm_util.h"
>   #include "tpm_int.h"
>   #include "qapi/clone-visitor.h"
>   #include "qapi/qapi-visit-tpm.h"
> -#include "tpm_util.h"
>   #include "trace.h"
>   
>   #define TYPE_TPM_PASSTHROUGH "tpm-passthrough"
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index 65672048c7..cb4dfd1e6a 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -20,7 +20,7 @@
>   #include "migration/vmstate.h"
>   
>   #include "sysemu/tpm_backend.h"
> -#include "tpm_util.h"
> +#include "sysemu/tpm_util.h"
>   #include "tpm_prop.h"
>   
>   #include "hw/ppc/spapr.h"
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index 94704870f6..64206a6a3b 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -33,7 +33,7 @@
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
>   #include "sysemu/tpm_backend.h"
> -#include "tpm_util.h"
> +#include "sysemu/tpm_util.h"
>   #include "tpm_ppi.h"
>   #include "trace.h"
>   
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index c0a0f3d71f..d0ec2a8235 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -23,11 +23,11 @@
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
> -#include "tpm_util.h"
>   #include "tpm_int.h"
>   #include "exec/memory.h"
>   #include "hw/qdev-properties.h"
>   #include "sysemu/tpm_backend.h"
> +#include "sysemu/tpm_util.h"
>   #include "trace.h"
>   
>   /* tpm backend property */



