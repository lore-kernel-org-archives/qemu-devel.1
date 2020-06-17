Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10064C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 23:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CD220882
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 23:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CD220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlhvs-0007pK-55
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 19:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jlhvK-0007Ii-1K; Wed, 17 Jun 2020 19:56:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52552
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jlhvI-0004av-7G; Wed, 17 Jun 2020 19:56:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05HNVjHW005437; Wed, 17 Jun 2020 19:56:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31qnk7dgx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2020 19:56:49 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05HNhSsp034699;
 Wed, 17 Jun 2020 19:56:48 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31qnk7dgwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2020 19:56:48 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05HNukMI021100;
 Wed, 17 Jun 2020 23:56:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma02fra.de.ibm.com with ESMTP id 31q6ckrrru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2020 23:56:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05HNuhVS60489752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2020 23:56:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF228A4053;
 Wed, 17 Jun 2020 23:56:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BF28A404D;
 Wed, 17 Jun 2020 23:56:43 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.74.214])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2020 23:56:43 +0000 (GMT)
Date: Thu, 18 Jun 2020 01:56:41 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] virtio-ccw: fix virtio_set_ind_atomic
Message-ID: <20200618015641.1db429fc.pasic@linux.ibm.com>
In-Reply-To: <20200616083333.2d4edfac.cohuck@redhat.com>
References: <20200616045035.51641-1-pasic@linux.ibm.com>
 <20200616045035.51641-2-pasic@linux.ibm.com>
 <11e8278e-23cc-1e7f-4086-10ecef75b96a@de.ibm.com>
 <20200616083333.2d4edfac.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-17_12:2020-06-17,
 2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 cotscore=-2147483648
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170173
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 19:56:49
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andreas Krebbel <krebbel@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 08:33:33 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> >  #define atomic_cmpxchg__nocheck(ptr, old, new)    ({                    \   
> >  
> >      typeof_strip_qual(*ptr) _old = (old);                               \   
> >  
> >      (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \   
> >  
> >                                __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);      \   
> >  
> >      _old;                                                               \   
> >  
> >  })
> >  
> > ind_old is copied into _old in the macro. Instead of doing the copy from the
> > register the compiler reloads the value from memory. The result is that _old
> > and ind_old end up having different values. _old in r1 with the bits set
> > already and ind_old in r10 with the bits cleared. _old gets updated by CS
> > and matches ind_old afterwards - both with the bits being 0. So the !=
> > compare is false and the loop is left without having set any bits.
> > 
> > 
> > Paolo (to),
> > I am asking myself if it would be safer to add a barrier or something like
> > this in the macros in include/qemu/atomic.h.   
> 
> I'm also wondering whether this has been seen on other architectures as
> well? There are also some callers in non-s390x code, and dealing with
> this in common code would catch them as well.

Quite a bunch of users use something like old = atomic_read(..), where
atomic_read is documented as in docs/devel/atomics.rst:
- ``atomic_read()`` and ``atomic_set()``; these prevent the compiler from
  optimizing accesses out of existence and creating unsolicited
  accesses, but do not otherwise impose any ordering on loads and
  stores: both the compiler and the processor are free to reorder
  them.

Maybe I should have used that instead of volatile, but my problem was
that I didn't fully understand what atomic_read() does, and if it does
more than we need. I found the documentation just now.

Another bunch uses constants as old, which is also fine. And there is
a third bunch where I don't know whats up, partly because I did not
dig deep enough.

Regards,
Halil



