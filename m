Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB923C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927EA206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927EA206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSNu-0007ra-PV
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1joSNC-0007RP-98
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:57:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40740
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1joSNA-0002Fw-IB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:57:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PDWpCP088216; Thu, 25 Jun 2020 09:56:57 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31uwymse10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 09:56:56 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PDngid017871;
 Thu, 25 Jun 2020 13:56:56 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04dal.us.ibm.com with ESMTP id 31uurq7g7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 13:56:56 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05PDutm846858584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 13:56:55 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95EB4112062;
 Thu, 25 Jun 2020 13:56:55 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9267F112063;
 Thu, 25 Jun 2020 13:56:55 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2020 13:56:55 +0000 (GMT)
Subject: Re: [PULL v1 0/8] Merge tpm 2020/06/25 v1
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200625132325.2025245-1-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <ab351123-5a55-6f67-550f-72b7c8de9eeb@linux.ibm.com>
Date: Thu, 25 Jun 2020 09:56:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200625132325.2025245-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_08:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 cotscore=-2147483648 adultscore=0
 mlxlogscore=874 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 08:13:37
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 9:23 AM, Stefan Berger wrote:

Peter,

   please do not apply. Something is not working well.

    Stefan

> This series of patches enables TPM TIS interrupts on PCs via IRQ 13 and disables
> it for ARM.
>
>     Stefan
>
> The following changes since commit 0250c595c9dd61221515221e92737422c75dd38b:
>
>    Merge remote-tracking branch 'remotes/armbru/tags/pull-qdev-2020-06-23' into staging (2020-06-25 09:34:52 +0100)
>
> are available in the Git repository at:
>
>    git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-06-25-1
>
> for you to fetch changes up to dcee2d2f6111a3a7b3ec2c5e6ff8ad1f679e907b:
>
>    tpm: Disable interrupt support for TIS on sysbus (2020-06-25 08:45:53 -0400)
>
> ----------------------------------------------------------------
> Stefan Berger (8):
>        tpm_tis: Allow lowering of IRQ also when locality is not active
>        tpm: Extend TPMIfClass with get_irqnum() function
>        tests: Temporarily ignore DSDT table differences
>        tpm: Split TPM_TIS_IRQ into TPM_TIS_ISA_IRQ and TPM_TIS_SYSBUS_IRQ
>        acpi: Enable TPM IRQ
>        tests: Add updated DSDT
>        tpm: Guard irq related ops in case interrupts are disabled
>        tpm: Disable interrupt support for TIS on sysbus
>
>   hw/i386/acpi-build.c         |  11 +++++------
>   hw/tpm/tpm_tis_common.c      |  12 +++++++++---
>   hw/tpm/tpm_tis_isa.c         |  17 ++++++++++++++---
>   hw/tpm/tpm_tis_sysbus.c      |  12 +++++++++++-
>   include/hw/acpi/tpm.h        |   3 ++-
>   include/sysemu/tpm.h         |  12 ++++++++++++
>   tests/data/acpi/q35/DSDT.tis | Bin 8357 -> 8360 bytes
>   7 files changed, 53 insertions(+), 14 deletions(-)
>


