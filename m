Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4288C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 20:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7775D21019
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 20:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7775D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnqyQ-0001g3-Nr
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 16:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41611)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnqyG-0001BC-7L
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 16:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnqyE-0004Vo-WD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 16:56:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hnqyA-0004Qn-UB; Wed, 17 Jul 2019 16:56:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6HKpvpA040076; Wed, 17 Jul 2019 16:56:07 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tt7udg2mv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jul 2019 16:56:07 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6HKtF6n017420;
 Wed, 17 Jul 2019 20:56:06 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma01dal.us.ibm.com with ESMTP id 2tq6x72ava-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jul 2019 20:56:06 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6HKu5AQ54264102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2019 20:56:05 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 543AFAC060;
 Wed, 17 Jul 2019 20:56:05 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22EC3AC05F;
 Wed, 17 Jul 2019 20:56:05 +0000 (GMT)
Received: from localhost (unknown [9.80.82.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jul 2019 20:56:05 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: David Gibson <david@gibson.dropbear.id.au>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190717020115.GD9123@umbus.fritz.box>
References: <20190716235313.29806-1-mdroth@linux.vnet.ibm.com>
 <20190716235313.29806-3-mdroth@linux.vnet.ibm.com>
 <20190717020115.GD9123@umbus.fritz.box>
Message-ID: <156339696136.9622.11882919467022106839@sif>
User-Agent: alot/0.7
Date: Wed, 17 Jul 2019 15:56:01 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-17_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170236
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH for-4.2 2/2] spapr: initial implementation
 for H_TPM_COMM/spapr-tpm-proxy
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting David Gibson (2019-07-16 21:01:15)
> On Tue, Jul 16, 2019 at 06:53:13PM -0500, Michael Roth wrote:
> > This implements the H_TPM_COMM hypercall, which is used by an
> > Ultravisor to pass TPM commands directly to the host's TPM device, or
> > a TPM Resource Manager associated with the device.
> > =

> > This also introduces a new virtual device, spapr-tpm-proxy, which
> > is used to configure the host TPM path to be used to service
> > requests sent by H_TPM_COMM hcalls, for example:
> > =

> >   -device spapr-tpm-proxy,id=3Dtpmp0,host-path=3D/dev/tpmrm0
> > =

> > By default, no spapr-tpm-proxy will be created, and hcalls will return
> > H_FUNCTION.
> > =

> > The full specification for this hypercall can be found in
> > docs/specs/ppc-spapr-uv-hcalls.txt
> =

> Mostly LGTM, but..
> =

> [...]
> >  #define H_SUCCESS         0
> > @@ -490,8 +492,9 @@ struct SpaprMachineState {
> >  #define H_INT_ESB               0x3C8
> >  #define H_INT_SYNC              0x3CC
> >  #define H_INT_RESET             0x3D0
> > +#define H_TPM_COMM              0xEF10
> =

> This is vastly increasing the size of the hcall dispatch table, which
> isn't great.  Is the 0xE... range reserved for PEF related hypercalls?
> I'm wondering if we want to make a third table here (we already have a
> separate one for the qemu-specific hypercalls).

Yes, that's probably a good idea. SVM hcalls use a reserved range
0xEF00-0xEF80. I'll send a v2 that uses a separate table for these.

> =

> >  =

> > -#define MAX_HCALL_OPCODE        H_INT_RESET
> > +#define MAX_HCALL_OPCODE        H_TPM_COMM
> >  =

> >  /* The hcalls above are standardized in PAPR and implemented by pHyp
> >   * as well.
> > diff --git a/include/hw/ppc/spapr_tpm_proxy.h b/include/hw/ppc/spapr_tp=
m_proxy.h
> > new file mode 100644
> > index 0000000000..4843cdaf58
> > --- /dev/null
> > +++ b/include/hw/ppc/spapr_tpm_proxy.h
> > @@ -0,0 +1,31 @@
> > +/*
> > + * SPAPR TPM Proxy/Hypercall
> > + *
> > + * Copyright IBM Corp. 2019
> > + *
> > + * Authors:
> > + *  Michael Roth      <mdroth@linux.vnet.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef HW_SPAPR_TPM_PROXY_H
> > +#define HW_SPAPR_TPM_PROXY_H
> > +
> > +#include "qom/object.h"
> > +#include "hw/qdev.h"
> > +
> > +#define TYPE_SPAPR_TPM_PROXY "spapr-tpm-proxy"
> > +#define SPAPR_TPM_PROXY(obj) OBJECT_CHECK(SpaprTpmProxy, (obj), \
> > +                                          TYPE_SPAPR_TPM_PROXY)
> > +
> > +typedef struct SpaprTpmProxy {
> > +    /*< private >*/
> > +    DeviceState parent;
> > +
> > +    char *host_path;
> > +    int host_fd;
> > +} SpaprTpmProxy;
> > +
> > +#endif /* HW_SPAPR_TPM_PROXY_H */
> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson

