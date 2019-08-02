Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10932C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 01:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52B52080C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 01:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52B52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htLzo-0000rx-3d
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 21:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42473)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <daniel@linux.ibm.com>) id 1htLzG-0000Mv-Kh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 21:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <daniel@linux.ibm.com>) id 1htLzF-00032O-Fd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 21:04:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <daniel@linux.ibm.com>)
 id 1htLzF-00030G-7e
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 21:04:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7211vJH005475
 for <qemu-devel@nongnu.org>; Thu, 1 Aug 2019 21:03:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u48hamrj0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 21:03:58 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <daniel@linux.ibm.com>;
 Fri, 2 Aug 2019 02:03:56 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 2 Aug 2019 02:03:54 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7213r4x53870724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2019 01:03:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4705352052;
 Fri,  2 Aug 2019 01:03:53 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A1FE952051;
 Fri,  2 Aug 2019 01:03:52 +0000 (GMT)
Received: from volution.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 88B1EA0194;
 Fri,  2 Aug 2019 11:03:51 +1000 (AEST)
Date: Fri, 2 Aug 2019 11:03:48 +1000
From: Daniel Black <daniel@linux.ibm.com>
To: Greg Kurz <groug@kaod.org>
In-Reply-To: <20190801124159.75d9fa48@bahia.lan>
References: <20190801033819.29664-1-daniel@linux.ibm.com>
 <20190801124159.75d9fa48@bahia.lan>
Organization: IBM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19080201-0008-0000-0000-000003037D63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080201-0009-0000-0000-000022728254
Message-Id: <20190802110348.60f22d92@volution.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020007
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: quantify error
 messages regarding capability settings
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
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Aug 2019 12:41:59 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Thu,  1 Aug 2019 13:38:19 +1000
> Daniel Black <daniel@linux.ibm.com> wrote:
> 
> > Its not immediately obvious how cap-X=Y setting need to be applied
> > to the command line so, for spapr capability error messages, this
> > has been clarified to:
> > 
...
> > index bbb001f84a..1c0222a081 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -37,6 +37,8 @@
> >  
> >  #include "hw/ppc/spapr.h"
> >  
> > +#define CAPABILITY_ERROR(X) "appending -machine " X  
> 
> I would make that:
> 
> #define CAPABILITY_HINT() "try appending -machine " X
> 
> because it is really an hint for the user, not an
> error,

Works for me. At the lowest layer it is a hint.

> and all original strings have "try",

True.

> except...


> > @@ -249,11 +255,13 @@ static void
> > cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val, if
> > (tcg_enabled() && val) { /* TCG only supports broken, allow other
> > values and print a warning */ error_setg(&local_err,
> > -                   "TCG doesn't support requested feature,
> > cap-cfpc=%s",
> > +                   "TCG doesn't support requested feature, "
> > +                   CAPABILITY_ERROR("cap-cfpc=%s"),  
> 
> ... this one, but it doesn't look like a hint to me. It just tells
> which is the unsupported cap.

This is one of 3 that local_error (commit
006e9d3618698eeef2f3e07628d22cb6f5c2a039) - intentionally just a
warning and to TLDR the commit/Suraj conversation; defaults apply
to all machine types; hardware security measures don't make sense in
TCG; hence warning.

For every function with CAPABILITY_[ERROR|HINT] its called by
spapr_caps_apply, has its errp as &error_fatal (intentionally - spoke
to Suraj - migrations to machines without capabilities need to fail and
defaults (kvm) should be secure unless explicitly disabled).

> >                     cap_cfpc_possible.vals[val]);
> >      } else if (kvm_enabled() && (val > kvm_val)) {
> >          error_setg(errp,
> > -"Requested safe cache capability level not supported by kvm, try
> > cap-cfpc=%s", +"Requested safe cache capability level not supported
> > by kvm, try "
> > +                   CAPABILITY_ERROR("cap-cfpc=%s"),
> >                     cap_cfpc_possible.vals[kvm_val]);  
> 
> Also, we have a dedicated API for hints, which are only printed under
> the monitor but ignored under QMP.

Ok.
 
> Not sure why it isn't used here but it should be something like:

If error_append_hint should be used for fatal errors (all that use
errp), then this patten should be applied further to
CAPABILITY_[HINT|ERROR] functions.

If error_append_hint needs to apply to warnings
cap_[cfpc/sbbc/ibs]_apply functions need to use it.

Would I be right in I'm assuming that the below pattern needs to apply
to both of these cases?

>         error_setg(errp, 
>                    "Requested safe cache capability level not
> supported by kvm");
>         error_append_hint(errp,
> CAPABILITY_HINT("cap-cfpc=%s") "\n", cap_cfpc_possible.vals[kvm_val]);

This is going a little beyond the scope of fixing a message, ok, but
lets not extend the scope too much more.


