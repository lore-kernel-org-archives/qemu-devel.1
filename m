Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8484C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7917B2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7917B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4UP-0004iI-LK
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1jT4Te-00047t-D1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1jT4Td-0000Iw-PG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:11:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27748
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1jT4Td-0000Hl-Ai
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:11:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03RE9Ibb142416
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 10:11:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30mfbrs460-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 10:11:09 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03REA6oC146040
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 10:11:09 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30mfbrs45f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2020 10:11:09 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03REAfQS026808;
 Mon, 27 Apr 2020 14:11:08 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma01dal.us.ibm.com with ESMTP id 30mcu6gn28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2020 14:11:08 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03REB7P146793198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2020 14:11:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63A14112064;
 Mon, 27 Apr 2020 14:11:07 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78588112062;
 Mon, 27 Apr 2020 14:11:06 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.92])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2020 14:11:06 +0000 (GMT)
Subject: Re: [PATCH 04/11] s390x/pci: Fix harmless mistake in zpci's property
 fid's setter
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-5-armbru@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <a461ce39-e603-43ad-aea0-4aebf031ce52@linux.ibm.com>
Date: Mon, 27 Apr 2020 10:11:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424192027.11404-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-27_09:2020-04-24,
 2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270116
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:11:09
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
Cc: Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 3:20 PM, Markus Armbruster wrote:
> s390_pci_set_fid() sets zpci->fid_defined to true even when
> visit_type_uint32() failed.  Reproducer: "-device zpci,fid=junk".
> Harmless in practice, because qdev_device_add() then fails, throwing
> away @zpci.  Fix it anyway.
> 
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index ed8be124da..19ee1f02bb 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1276,7 +1276,9 @@ static void s390_pci_set_fid(Object *obj, Visitor *v, const char *name,
>           return;
>       }
>   
> -    visit_type_uint32(v, name, ptr, errp);
> +    if (!visit_type_uint32(v, name, ptr, errp)) {
> +        return;
> +    }

Hi Markus,

Am I missing something here (a preceding patch maybe?) -- 
visit_type_uint32 is a void function.  A quick look, no other callers 
are checking it for a return value either...

The error value might get set in visit_type_uintN though.  Taking a hint 
from other places that handle this sort of case (ex: 
cpu_max_set_sve_max_vq), maybe something like:

Error *err = NULL;
...
visit_type_uint32(v, name, ptr, &err);
if (err) {
	error_propogate(errp, err);
	return;
}
zpci->fid_defined = true;

Instead?




