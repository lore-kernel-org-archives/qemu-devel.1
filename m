Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB9EC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D2B206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D2B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlMd-0008EN-R9
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1jTlHR-0007VY-6F
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1jTlHQ-00026G-NS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:53:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16816
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jTlHO-00024e-FP; Wed, 29 Apr 2020 07:53:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03TBVGKg168157; Wed, 29 Apr 2020 07:53:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30q80pj2g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 07:53:26 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03TBdMDu189276;
 Wed, 29 Apr 2020 07:53:26 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30q80pj2fy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 07:53:25 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03TBj2qW011051;
 Wed, 29 Apr 2020 11:53:25 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma02dal.us.ibm.com with ESMTP id 30mcu6wjh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2020 11:53:25 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03TBrOKj19071432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2020 11:53:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 842FEAE05F;
 Wed, 29 Apr 2020 11:53:24 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AA08AE05C;
 Wed, 29 Apr 2020 11:53:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2020 11:53:24 +0000 (GMT)
Subject: Re: [PATCH 0/2] virt: Set tpm-tis-device ppi property to off by
 default
To: Cornelia Huck <cohuck@redhat.com>
References: <20200427143145.16251-1-eric.auger@redhat.com>
 <20200428123826.1ec68e6c.cohuck@redhat.com>
 <0257ca1e-2323-e437-4e19-d8a4dfa6d792@linux.ibm.com>
 <20200429081129.18e9760a.cohuck@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b109541b-36cf-03b3-eac7-910f1caafa55@linux.ibm.com>
Date: Wed, 29 Apr 2020 07:53:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200429081129.18e9760a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-29_04:2020-04-29,
 2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290093
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 07:53:27
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 2:11 AM, Cornelia Huck wrote:
> On Tue, 28 Apr 2020 16:13:05 -0400
> Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>> On 4/28/20 6:38 AM, Cornelia Huck wrote:
>>> On Mon, 27 Apr 2020 16:31:43 +0200
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>   
>>>> Instead of using a compat in the mach-virt machine to force
>>>> PPI off for all virt machines (PPI not supported by the
>>>> tpm-tis-device device), let's simply change the default value
>>>> in the sysbus device.
>>>>
>>>> Best Regards
>>>>
>>>> Eric
>>>>
>>>> Eric Auger (2):
>>>>     tpm: tpm-tis-device: set PPI to false by default
>>>>     hw/arm/virt: Remove the compat forcing tpm-tis-device PPI to off
>>>>
>>>>    hw/arm/virt.c           | 5 -----
>>>>    hw/tpm/tpm_tis_sysbus.c | 2 +-
>>>>    2 files changed, 1 insertion(+), 6 deletions(-)
>>>>   
>>> I think we can apply the compat machines patch on top of these two
>>> patches.
>>>
>>> Q: Who will queue this and the machine types patch? It feels a bit
>>> weird taking arm patches through the s390 tree :)
>>>   
>> I can queue them and would send the PR soon. I am also fine with someone
>> else doing it.
> Would be great if you could queue these together with
> https://patchew.org/QEMU/20200424090314.544-1-cohuck@redhat.com/
> (hopefully should still apply cleanly, let me know if a respin is
> needed).
>
It's probably better to respin:

 > patches apply id:20200424090314.544-1-cohuck@redhat.com
Applying: hw: add compat machines for 5.1
Using index info to reconstruct a base tree...
M    hw/arm/virt.c
Falling back to patching base and 3-way merge...
Auto-merging hw/arm/virt.c
CONFLICT (content): Merge conflict in hw/arm/virt.c
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch' to see the failed patch
Patch failed at 0001 hw: add compat machines for 5.1
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".



