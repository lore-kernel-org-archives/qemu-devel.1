Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226BFC2D0E5
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CE72083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CE72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtbF-0005Xh-3U
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pasic@linux.ibm.com>) id 1jHtXO-0007Yb-JJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pasic@linux.ibm.com>) id 1jHtXN-0008DX-6V
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:16:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1jHtXM-0008Ac-UP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:16:57 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02RI4D3W052928
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 14:16:55 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywbtmmx2e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 14:16:55 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
 Fri, 27 Mar 2020 18:16:47 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 27 Mar 2020 18:16:43 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02RIGle940304842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2020 18:16:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F240A4040;
 Fri, 27 Mar 2020 18:16:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86CFDA4051;
 Fri, 27 Mar 2020 18:16:46 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.186.193])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2020 18:16:46 +0000 (GMT)
Date: Fri, 27 Mar 2020 19:16:30 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] s390x: Reject unaligned RAM sizes
In-Reply-To: <20200327174620.06b9c324@redhat.com>
References: <20200327152930.66636-1-david@redhat.com>
 <64cefab8-f1e0-fbc7-27d3-4f28758c595a@de.ibm.com>
 <d8fb50c1-639a-826c-0dce-e2ddc26ae5e1@redhat.com>
 <24681aa0-9053-238f-89da-8ce08d34241d@de.ibm.com>
 <20200327174620.06b9c324@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032718-0008-0000-0000-000003656C95
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032718-0009-0000-0000-00004A86E786
Message-Id: <20200327191630.6d46e7a8.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-27_06:2020-03-27,
 2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270148
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, "Dr .
 David Alan Gilbert" <dgilbert@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 17:46:20 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 27 Mar 2020 17:05:34 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 27.03.20 17:01, David Hildenbrand wrote:
> > > On 27.03.20 16:34, Christian Borntraeger wrote:  
> > >>
> > >>
> > >> On 27.03.20 16:29, David Hildenbrand wrote:  
> > >>> Historically, we fixed up the RAM size (rounded it down), to fit into
> > >>> storage increments. Since commit 3a12fc61af5c ("390x/s390-virtio-ccw: use
> > >>> memdev for RAM"), we no longer consider the fixed-up size when
> > >>> allcoating the RAM block - which will break migration.
> > >>>
> > >>> Let's simply drop that manual fixup code and let the user supply sane
> > >>> RAM sizes. This will bail out early when trying to migrate (and make
> > >>> an existing guest with e.g., 12345 MB non-migratable), but maybe we
> > >>> should have rejected such RAM sizes right from the beginning.
> > >>>
> > >>> As we no longer fixup maxram_size as well, make other users use ram_size
> > >>> instead. Keep using maxram_size when setting the maximum ram size in KVM,
> > >>> as that will come in handy in the future when supporting memory hotplug
> > >>> (in contrast, storage keys and storage attributes for hotplugged memory
> > >>>  will have to be migrated per RAM block in the future).
> > >>>
> > >>> This fixes (or rather rejects early):
> > >>>
> > >>> 1. Migrating older QEMU to upstream QEMU (e.g., with "-m 1235M"), as the
> > >>>    RAM block size changed.  
> > >>
> > >> Not sure I like this variant. Instead of breaking migration (that was 
> > >> accidentially done by Igors changes) we now reject migration from older
> > >> QEMUs to 5.0. This is not going to help those that still have such guests
> > >> running and want to migrate.   
> > > 
> > > As Igor mentioned on another channel, you most probably can migrate an
> > > older guest by starting it on the target with a fixed-up size.
> > > 
> > > E.g., migrate an old QEMU "-m 1235M" to a new QEMU "-m 1234M"  
> > 
> > Yes, that should probably work.
> I'm in process of testing it.
> 
> > > Not sure how many such weird-size VMs we actually do have in practice.  
> > 
> > I am worried about some automated deployments where tooling has created
> > these sizes for dozens or hundreds of containers in VMS and so.
> Yep, it's possible but then that tooling/configs should be fixed to work with
> new QEMU that validates user's input.
> 

@David: I'm a little confused. Is this fix about adding user input
validation, or is it about changing what valid inputs are?

I don't see this alignment requirement documented, so my guess is the
latter. And then, I'm not sure I'm sold on this.

Regards,
Halil




