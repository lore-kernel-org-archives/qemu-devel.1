Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709FBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C91206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C91206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglLC-00074M-CE
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jghfM-0002su-9d; Thu, 04 Jun 2020 00:39:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jghfL-0000W9-6M; Thu, 04 Jun 2020 00:39:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05442LB6099781; Thu, 4 Jun 2020 00:39:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31epx7vjp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2020 00:39:32 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0544Hf6A147403;
 Thu, 4 Jun 2020 00:39:32 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31epx7vjn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2020 00:39:32 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0544ToLe026352;
 Thu, 4 Jun 2020 04:39:31 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01dal.us.ibm.com with ESMTP id 31bwg36ruv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2020 04:39:30 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0544dUmL49152500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Jun 2020 04:39:30 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2607C112061;
 Thu,  4 Jun 2020 04:39:30 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FAD8112062;
 Thu,  4 Jun 2020 04:39:26 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.160.46.38])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu,  4 Jun 2020 04:39:26 +0000 (GMT)
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
In-reply-to: <20200521034304.340040-1-david@gibson.dropbear.id.au>
Date: Thu, 04 Jun 2020 01:39:22 -0300
Message-ID: <87tuzr5ts5.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-03_23:2020-06-02,
 2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=1 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040020
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 00:39:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 04 Jun 2020 04:33:11 -0400
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hello David,

David Gibson <david@gibson.dropbear.id.au> writes:

> A number of hardware platforms are implementing mechanisms whereby the
> hypervisor does not have unfettered access to guest memory, in order
> to mitigate the security impact of a compromised hypervisor.
>
> AMD's SEV implements this with in-cpu memory encryption, and Intel has
> its own memory encryption mechanism.  POWER has an upcoming mechanism
> to accomplish this in a different way, using a new memory protection
> level plus a small trusted ultravisor.  s390 also has a protected
> execution environment.
>
> The current code (committed or draft) for these features has each
> platform's version configured entirely differently.  That doesn't seem
> ideal for users, or particularly for management layers.
>
> AMD SEV introduces a notionally generic machine option
> "machine-encryption", but it doesn't actually cover any cases other
> than SEV.
>
> This series is a proposal to at least partially unify configuration
> for these mechanisms, by renaming and generalizing AMD's
> "memory-encryption" property.  It is replaced by a
> "guest-memory-protection" property pointing to a platform specific
> object which configures and manages the specific details.
>
> For now this series covers just AMD SEV and POWER PEF.  I'm hoping it

Thank you very much for this series! Using a machine property is a nice
way of configuring this.

From an end-user perspective, `-M pseries,guest-memory-protection` in
the command line already expresses everything that QEMU needs to know,
so having to add `-object pef-guest,id=pef0` seems a bit redundant. Is
it possible to make QEMU create the pef-guest object behind the scenes
when the guest-memory-protection property is specified?

Regardless, I was able to successfuly launch POWER PEF guests using
these patches:

Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> can be extended to cover the Intel and s390 mechanisms as well,
> though.
>
> Note: I'm using the term "guest memory protection" throughout to refer
> to mechanisms like this.  I don't particular like the term, it's both
> long and not really precise.  If someone can think of a succinct way
> of saying "a means of protecting guest memory from a possibly
> compromised hypervisor", I'd be grateful for the suggestion.

Is "opaque guest memory" any better? It's slightly shorter, and slightly
more precise about what the main characteristic this guest property conveys.

--
Thiago Jung Bauermann
IBM Linux Technology Center

