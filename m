Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C165DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 21:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E2382067B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 21:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2382067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgxqM-00027D-Rw
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 17:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jgxpE-00015E-13; Thu, 04 Jun 2020 17:55:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jgxpC-0000kf-GY; Thu, 04 Jun 2020 17:54:59 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 054LXdn1100432; Thu, 4 Jun 2020 17:54:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31f8yvgfww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2020 17:54:51 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 054LXhoL100532;
 Thu, 4 Jun 2020 17:54:51 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31f8yvgfwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2020 17:54:51 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 054Lo2XF030098;
 Thu, 4 Jun 2020 21:54:50 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 31bf4b2q8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2020 21:54:49 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 054LskPr29622772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Jun 2020 21:54:46 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2961BC6057;
 Thu,  4 Jun 2020 21:54:48 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 972BAC605A;
 Thu,  4 Jun 2020 21:54:44 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.160.104.193])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu,  4 Jun 2020 21:54:44 +0000 (GMT)
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <87tuzr5ts5.fsf@morokweng.localdomain>
 <20200604062124.GG228651@umbus.fritz.box>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
In-reply-to: <20200604062124.GG228651@umbus.fritz.box>
Date: Thu, 04 Jun 2020 18:54:40 -0300
Message-ID: <87r1uu1opr.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-04_13:2020-06-04,
 2020-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040152
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 17:54:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Gibson <david@gibson.dropbear.id.au> writes:

> On Thu, Jun 04, 2020 at 01:39:22AM -0300, Thiago Jung Bauermann wrote:
>> 
>> Hello David,
>> 
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> > A number of hardware platforms are implementing mechanisms whereby the
>> > hypervisor does not have unfettered access to guest memory, in order
>> > to mitigate the security impact of a compromised hypervisor.
>> >
>> > AMD's SEV implements this with in-cpu memory encryption, and Intel has
>> > its own memory encryption mechanism.  POWER has an upcoming mechanism
>> > to accomplish this in a different way, using a new memory protection
>> > level plus a small trusted ultravisor.  s390 also has a protected
>> > execution environment.
>> >
>> > The current code (committed or draft) for these features has each
>> > platform's version configured entirely differently.  That doesn't seem
>> > ideal for users, or particularly for management layers.
>> >
>> > AMD SEV introduces a notionally generic machine option
>> > "machine-encryption", but it doesn't actually cover any cases other
>> > than SEV.
>> >
>> > This series is a proposal to at least partially unify configuration
>> > for these mechanisms, by renaming and generalizing AMD's
>> > "memory-encryption" property.  It is replaced by a
>> > "guest-memory-protection" property pointing to a platform specific
>> > object which configures and manages the specific details.
>> >
>> > For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
>> 
>> Thank you very much for this series! Using a machine property is a nice
>> way of configuring this.
>> 
>> >From an end-user perspective, `-M pseries,guest-memory-protection` in
>> the command line already expresses everything that QEMU needs to know,
>> so having to add `-object pef-guest,id=pef0` seems a bit redundant. Is
>> it possible to make QEMU create the pef-guest object behind the scenes
>> when the guest-memory-protection property is specified?
>
> Not exactly - the object needs to exist for the QOM core to resolve it
> before we'd have a chance to look at the value to conditionally create
> the object.
>
> What we could do, however, is always create a PEF object in the
> machine, and it would just have no effect if the machine parameter
> wasn't specified.
>
> I did consider that option, but left it this way for greater
> consistency with AMD SEV - there the object can't be auto-created,
> since it has mandatory parameters needed to configure the encryption.
>
> I'm open to persuasion about changing that, though.

What about having it both ways?

QEMU could always create a PEF object, and if the command line defines
one, it will correspond to it. And if the command line doesn't define one,
then it would also work because the PEF object is already there.

That way, compatibility with AMD SEV is preserved but we also get
command line simplicity where it is not needed.


-- 
Thiago Jung Bauermann
IBM Linux Technology Center

