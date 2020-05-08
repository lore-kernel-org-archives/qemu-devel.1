Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41EFC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 19:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B766920CC7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 19:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B766920CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX8UF-0006r5-S3
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 15:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jX8TW-0005l2-Mw; Fri, 08 May 2020 15:15:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jX8TV-0003gk-GS; Fri, 08 May 2020 15:15:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048J2SOC087931; Fri, 8 May 2020 15:15:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsrdqw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 15:15:53 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048J2ojq089766;
 Fri, 8 May 2020 15:15:53 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsrdqvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 15:15:52 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048JFJEM025405;
 Fri, 8 May 2020 19:15:51 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 30s0g89ea1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2020 19:15:51 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 048JFnvF11731412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2020 19:15:49 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63F0813604F;
 Fri,  8 May 2020 19:15:50 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AA8C136055;
 Fri,  8 May 2020 19:15:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2020 19:15:48 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] arm/acpi: Add the TPM2.0 device under the DSDT
To: Ard Biesheuvel <ardb@kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>
References: <20200505144419.29174-1-eric.auger@redhat.com>
 <20200505144419.29174-4-eric.auger@redhat.com>
 <976a1479-4443-da02-2ad8-1e1570742caa@gmail.com>
 <CAMj1kXHHn9mbowEzEf3O3L7eC=e5zY3w2CqzK2qop19kKRDa=A@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <260618f0-a6f5-0a5a-2174-f3e33fd221b5@linux.ibm.com>
Date: Fri, 8 May 2020 15:15:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHHn9mbowEzEf3O3L7eC=e5zY3w2CqzK2qop19kKRDa=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-08_16:2020-05-08,
 2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 13:59:37
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 gshan@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, imammedo@redhat.com,
 Laszlo Ersek <lersek@redhat.com>, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 11:25 AM, Ard Biesheuvel wrote:
> On Fri, 8 May 2020 at 17:24, Shannon Zhao <shannon.zhaosl@gmail.com> wrote:
>> Hi,
>>
>> On 2020/5/5 22:44, Eric Auger wrote:
>>> +static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>>> +{
>>> +    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
>>> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>>> +    MemoryRegion *sbdev_mr;
>>> +    SysBusDevice *sbdev;
>>> +    hwaddr tpm_base;
>>> +
>>> +    sbdev = (SysBusDevice *)object_dynamic_cast(OBJECT(tpm_find()),
>>> +                                                TYPE_SYS_BUS_DEVICE);
>> Does it need to check the tpm version like you do in previous patch?
>>
>> tpm_get_version(tpm_find()) == TPM_VERSION_2_0
>>
> I don't think so. The device node could in theory be used to describe
> a TPM 1.2/1.3 as well, even though we never actually do that.

There is no TPM 1.3. There may be a TIS v1.3.


