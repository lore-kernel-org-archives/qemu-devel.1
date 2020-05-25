Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F072EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 17:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C965E20723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 17:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C965E20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdHG1-0002k9-0V
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 13:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jdHER-00015g-1n; Mon, 25 May 2020 13:49:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29552
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jdHEQ-0004y9-2z; Mon, 25 May 2020 13:49:46 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04PHVrq2083812; Mon, 25 May 2020 13:49:31 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316ytstwnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 13:49:30 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04PHkWko024402;
 Mon, 25 May 2020 17:49:30 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma04wdc.us.ibm.com with ESMTP id 316uf9cv5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 May 2020 17:49:30 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04PHnUMt32375104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 May 2020 17:49:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3AA1112062;
 Mon, 25 May 2020 17:49:29 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FCE6112063;
 Mon, 25 May 2020 17:49:29 +0000 (GMT)
Received: from arbab-vm.localdomain (unknown [9.160.36.204])
 by b01ledav004.gho.pok.ibm.com (Postfix) with SMTP;
 Mon, 25 May 2020 17:49:29 +0000 (GMT)
Received: from arbab-vm (localhost [IPv6:::1])
 by arbab-vm.localdomain (Postfix) with ESMTP id 2CFB610040E;
 Mon, 25 May 2020 12:49:27 -0500 (CDT)
Date: Mon, 25 May 2020 12:49:27 -0500
From: Reza Arbab <arbab@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] spapr: Add a new level of NUMA for GPUs
Message-ID: <20200525174927.aky64nw7p7xztqzh@arbab-vm>
Organization: IBM Linux Technology Center
References: <1590177213-4513-1-git-send-email-arbab@linux.ibm.com>
 <20200525050550.GA23110@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200525050550.GA23110@umbus.fritz.box>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-25_10:2020-05-25,
 2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=1 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 cotscore=-2147483648
 spamscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=arbab@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 13:49:43
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 03:05:50PM +1000, David Gibson wrote:
>On Fri, May 22, 2020 at 02:53:33PM -0500, Reza Arbab wrote:
>> --- a/hw/ppc/spapr_pci_nvlink2.c
>> +++ b/hw/ppc/spapr_pci_nvlink2.c
>> @@ -362,7 +362,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *=
sphb, void *fdt)
>>          uint32_t associativity[] =3D {
>>              cpu_to_be32(0x4),
>>              SPAPR_GPU_NUMA_ID,
>> -            SPAPR_GPU_NUMA_ID,
>> +            cpu_to_be32(nvslot->numa_id),
>>              SPAPR_GPU_NUMA_ID,
>>              cpu_to_be32(nvslot->numa_id)
>
>
>This doesn't look quite right.  In the new case we'll get {
>GPU_NUMA_ID, nvslot->numa_id, GPU_NUMA_ID, nvslot->numa_id }.

The associativity reference points are 4 (and now 2), so this is what we=20
want. I think what you've noticed is that reference points are 1-based=20
ordinals:

	"...the =E2=80=9Cibm,associativity-reference-points=E2=80=9D property indi=
cates
boundaries between associativity domains presented by the=20
=E2=80=9Cibm,associativity=E2=80=9D property containing =E2=80=9Cnear=E2=80=
=9D and =E2=80=9Cfar=E2=80=9D resources. The=20
first such boundary in the list represents the 1 based ordinal in the=20
associativity lists of the most significant boundary, with subsequent=20
entries indicating progressively less significant boundaries."

--=20
Reza Arbab

