Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51811C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248052073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248052073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxpro-0000RV-B7
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 06:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihajlov@linux.ibm.com>)
 id 1jxpqa-000862-Kl
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:50:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihajlov@linux.ibm.com>)
 id 1jxpqY-0006Rh-69
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:50:08 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06LAXX5T150076
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:50:01 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32dn6xfx32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:50:01 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LAYvA5022902
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 10:49:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04ams.nl.ibm.com with ESMTP id 32brq83sgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 10:49:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06LAnvfg26411202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 10:49:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3785B42041
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 10:49:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15B254203F
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 10:49:57 +0000 (GMT)
Received: from oc6604088431.ibm.com (unknown [9.145.77.244])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 10:49:56 +0000 (GMT)
Subject: Re: [PATCH 1/1] s390x/protvirt: allow to IPL secure execution guests
 with -no-reboot
To: qemu-devel@nongnu.org
References: <20200721103202.30610-1-borntraeger@de.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Message-ID: <f053d6a2-7791-4f68-0a02-8d4c22f976ee@linux.ibm.com>
Date: Tue, 21 Jul 2020 12:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200721103202.30610-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-21_03:2020-07-21,
 2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210075
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mihajlov@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 06:32:08
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/21/20 12:32 PM, Christian Borntraeger wrote:
> Right now -no-reboot does prevent secure execution guests from running.
> This is right from an implementation aspect, as we have modeled the
> transition from non-secure to secure as a program directed IPL.
>  From a user perspective, this is not the behavior of least surprise.
> 
> We should implement the IPL into secure mode similar to the functions
> that we use for kdump/kexec. In other words we do not stop here when
> -no-reboot is specified on the command line. Like function 0 or function
> 1 Function 10 is not a classic reboot. For example it can only be called
> once. To call it a 2nd time a real reboot/reset must happen in-between.
> So function code 10 is more or less a state transition reset, but not a
> "standard" reset or reboot.
> 
> Fixes: 4d226deafc44 ("s390x: protvirt: Support unpack facility")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   hw/s390x/ipl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index ce21494c08..e312a35133 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -633,7 +633,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>           }
>       }
>       if (reset_type == S390_RESET_MODIFIED_CLEAR ||
> -        reset_type == S390_RESET_LOAD_NORMAL) {
> +        reset_type == S390_RESET_LOAD_NORMAL ||
> +        reset_type == S390_RESET_PV) {
>           /* ignore -no-reboot, send no event  */
>           qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
>       } else {
> 

I agree that the observable behavior is more logical this way, as the
transition to secure mode is more like to kexec (transfer control to an
in-memory kernel) than to the other IPL methods (boot from a device).

Acked-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>

-- 
Kind Regards,
    Viktor

