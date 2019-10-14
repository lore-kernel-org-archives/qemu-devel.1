Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B584C47404
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 07:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6593207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 07:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6593207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJuOz-0003A8-VC
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 03:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iJuNc-0002IY-74
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 03:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iJuNa-0008SR-Nt
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 03:02:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iJuNa-0008OJ-G2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 03:02:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9E72gah041378
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:02:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vmc7nb1tq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:02:43 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 14 Oct 2019 08:02:34 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 14 Oct 2019 08:02:31 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9E72UJa46334284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2019 07:02:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96ED5A40A6;
 Mon, 14 Oct 2019 07:02:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A286A408D;
 Mon, 14 Oct 2019 07:02:30 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2019 07:02:30 +0000 (GMT)
Received: from yukon.kaod.org (sig-9-145-30-87.uk.ibm.com [9.145.30.87])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 0E7E022010B;
 Mon, 14 Oct 2019 09:02:29 +0200 (CEST)
Subject: Re: [PATCH 3/9] ppc/xive: Record the IPB in the associated NVT
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191007084102.29776-1-clg@kaod.org>
 <20191007084102.29776-4-clg@kaod.org> <20191014053257.GU4080@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Date: Mon, 14 Oct 2019 09:02:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014053257.GU4080@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19101407-4275-0000-0000-00000371D4DC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101407-4276-0000-0000-00003884E285
Message-Id: <4eb20acc-f1c8-08a2-f519-3728c9693dab@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140068
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9E72gah041378
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/10/2019 07:32, David Gibson wrote:
> On Mon, Oct 07, 2019 at 10:40:56AM +0200, C=E9dric Le Goater wrote:
>> When an interrupt can not be presented to a vCPU, the XIVE presenter
>> updates the Interrupt Pending Buffer of the XIVE NVT if backlog is
>> activated in the END.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> This commit message doesn't really make it clear what was happening
> before, which certainly looks like an update to the IPB field in the
> NVT, via a different method.
>=20
> Is this just a cleanup, or a fix?

This is a small fix. Here is an update changelog :

"
When an interrupt can not be presented to a vCPU, the XIVE presenter
updates the Interrupt Pending Buffer of the XIVE NVT if backlog is
activated in the END.

Fix the current model that also updates the PIPR which is not how HW=20
operates and use the XIVE field structure routines to get/set the=20
IPB register backup value in the XIVE NVT structure.
"

=20
>> ---
>>  include/hw/ppc/xive_regs.h |  1 +
>>  hw/intc/xive.c             | 11 +++++++++--
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
>> index 55307cd1533c..530f232b04f8 100644
>> --- a/include/hw/ppc/xive_regs.h
>> +++ b/include/hw/ppc/xive_regs.h
>> @@ -255,6 +255,7 @@ typedef struct XiveNVT {
>>          uint32_t        w2;
>>          uint32_t        w3;
>>          uint32_t        w4;
>> +#define NVT_W4_IPB               PPC_BITMASK32(16, 23)
>>          uint32_t        w5;
>>          uint32_t        w6;
>>          uint32_t        w7;
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index cbe4ae6c294d..2bf7b4ad7006 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -1600,14 +1600,21 @@ static void xive_router_end_notify(XiveRouter =
*xrtr, uint8_t end_blk,
>>       * - logical server : forward request to IVPE (not supported)
>>       */
>>      if (xive_end_is_backlog(&end)) {
>> +        uint8_t ipb;
>> +
>>          if (format =3D=3D 1) {
>>              qemu_log_mask(LOG_GUEST_ERROR,
>>                            "XIVE: END %x/%x invalid config: F1 & backl=
og\n",
>>                            end_blk, end_idx);
>>              return;
>>          }
>> -        /* Record the IPB in the associated NVT structure */
>> -        ipb_update((uint8_t *) &nvt.w4, priority);
>> +        /*
>> +         * Record the IPB in the associated NVT structure for later
>> +         * use. The presenter will resend the interrupt when the vCPU
>> +         * is dispatched again on a HW thread.
>> +         */
>> +        ipb =3D xive_get_field32(NVT_W4_IPB, nvt.w4) | priority_to_ip=
b(priority);
>> +        nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, ipb);
>>          xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
>> =20
>>          /*
>=20


