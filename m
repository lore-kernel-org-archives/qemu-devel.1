Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE067C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8001D2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8001D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmCDo-0001ul-RW
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 04:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jmCD2-0001QL-Mx; Fri, 19 Jun 2020 04:17:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jmCD0-0001pE-L7; Fri, 19 Jun 2020 04:17:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05J81iPT047617; Fri, 19 Jun 2020 04:17:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rsacru4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 04:17:08 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05J823Ea049359;
 Fri, 19 Jun 2020 04:17:08 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rsacru44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 04:17:07 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J89wXq006390;
 Fri, 19 Jun 2020 08:17:06 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04fra.de.ibm.com with ESMTP id 31r18v0sxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 08:17:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05J8H3jX65143130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 08:17:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23E57A4060;
 Fri, 19 Jun 2020 08:17:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D26FA405C;
 Fri, 19 Jun 2020 08:17:02 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.147.95])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2020 08:17:02 +0000 (GMT)
Date: Fri, 19 Jun 2020 10:17:01 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/2] virtio-ccw: fix virtio_set_ind_atomic
Message-ID: <20200619101701.1a7b0e64.pasic@linux.ibm.com>
In-Reply-To: <da550b98-a555-0e1c-6b5f-90da88100b7f@redhat.com>
References: <20200616045035.51641-1-pasic@linux.ibm.com>
 <20200616045035.51641-2-pasic@linux.ibm.com>
 <11e8278e-23cc-1e7f-4086-10ecef75b96a@de.ibm.com>
 <20200616083333.2d4edfac.cohuck@redhat.com>
 <20200618015641.1db429fc.pasic@linux.ibm.com>
 <da550b98-a555-0e1c-6b5f-90da88100b7f@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_04:2020-06-18,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 cotscore=-2147483648
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 04:13:05
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andreas Krebbel <krebbel@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 09:33:44 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 18.06.20 01:56, Halil Pasic wrote:
> > On Tue, 16 Jun 2020 08:33:33 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> >>>  #define atomic_cmpxchg__nocheck(ptr, old, new)    ({                    \   
> >>>  
> >>>      typeof_strip_qual(*ptr) _old = (old);                               \   
> >>>  
> >>>      (void)__atomic_compare_exchange_n(ptr, &_old, new, false,           \   
> >>>  
> >>>                                __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);      \   
> >>>  
> >>>      _old;                                                               \   
> >>>  
> >>>  })
> >>>  
> >>> ind_old is copied into _old in the macro. Instead of doing the copy from the
> >>> register the compiler reloads the value from memory. The result is that _old
> >>> and ind_old end up having different values. _old in r1 with the bits set
> >>> already and ind_old in r10 with the bits cleared. _old gets updated by CS
> >>> and matches ind_old afterwards - both with the bits being 0. So the !=
> >>> compare is false and the loop is left without having set any bits.
> >>>
> >>>
> >>> Paolo (to),
> >>> I am asking myself if it would be safer to add a barrier or something like
> >>> this in the macros in include/qemu/atomic.h.   
> >>
> >> I'm also wondering whether this has been seen on other architectures as
> >> well? There are also some callers in non-s390x code, and dealing with
> >> this in common code would catch them as well.
> > 
> > Quite a bunch of users use something like old = atomic_read(..), where
> > atomic_read is documented as in docs/devel/atomics.rst:
> > - ``atomic_read()`` and ``atomic_set()``; these prevent the compiler from
> >   optimizing accesses out of existence and creating unsolicited
> >   accesses, but do not otherwise impose any ordering on loads and
> >   stores: both the compiler and the processor are free to reorder
> >   them.
> > 
> > Maybe I should have used that instead of volatile, but my problem was
> > that I didn't fully understand what atomic_read() does, and if it does
> > more than we need. I found the documentation just now.
> 
> IIRC, atomic_read() is the right way of doing it, at least in the
> kernel. 

In kernel I would use READ_ONCE. 

https://elixir.bootlin.com/linux/v5.8-rc1/source/include/asm-generic/atomic.h#L171

In this case we are not manipulating an atomic variable. For uint8_t
that boils down to an access through a volatile pointer. And that is
what I did :).

> I use such a loop in QEMU in
> 
> https://lkml.kernel.org/r/20200610115419.51688-2-david@redhat.com
> 
> But reading docs/devel/atomics.rst:"Comparison with Linux kernel
> primitives" I do wonder if that is sufficient.
> 
> Any experts around?
> 

IMHO what we want here is READ_ONCE, i.e. volatile access, and not
necessarily atomic access. But I suppose atomic access implies volatile
access (the C11 standard refers to atomic_load as 
C atomic_load(volatile A *object)). Because QEMU seems to use atomic_read()
in such situations, and does not have READ_ONCE, for me atomic_read would
also do.

Regards,
Halil


