Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2DBC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D436C204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D436C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6yf-00088D-4o
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hg6pd-00015r-Mm
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hg6pc-0008Cf-GI
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:15:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hg6pc-0006OX-9M; Wed, 26 Jun 2019 08:15:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F1ACD307D945;
 Wed, 26 Jun 2019 12:14:32 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C30465C1A1;
 Wed, 26 Jun 2019 12:14:25 +0000 (UTC)
Date: Wed, 26 Jun 2019 14:14:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190626141423.0bbd86eb.cohuck@redhat.com>
In-Reply-To: <b2351294-c3f1-ca67-6ebf-dea591b2441d@de.ibm.com>
References: <1561475829-19202-1-git-send-email-walling@linux.ibm.com>
 <1561475829-19202-3-git-send-email-walling@linux.ibm.com>
 <b2351294-c3f1-ca67-6ebf-dea591b2441d@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 26 Jun 2019 12:14:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 2/2] s390: diagnose 318 info reset and
 migration support
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
Cc: Collin Walling <walling@linux.ibm.com>, david@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 11:12:04 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 25.06.19 17:17, Collin Walling wrote:
> > index a606547..4c26754 100644
> > --- a/target/s390x/cpu.h
> > +++ b/target/s390x/cpu.h
> > @@ -39,7 +39,13 @@
> >  
> >  #define MMU_USER_IDX 0
> >  
> > -#define S390_MAX_CPUS 248
> > +/*
> > + * HACK: The introduction of additional facility bytes in the Read Info
> > + * struct consumes space used for CPU entries, thus we must reduce the
> > + * original maximum CPUs of 248 by one for each new byte or risk smashing
> > + * the stack.
> > + */
> > +#define S390_MAX_CPUS 247  
> 
> I think we decided to not change that. Only if the cpu model contains the diag318
> feature we are limited to 247 but only for the sclp response.
> So we said: 
> - we continue to allow 248 cpus
> - the sclp response will be limited to 247 CPUs if the feature is one
> - (optional) we print a warning that the guest might not see all CPUs
> 

Yes, that's what I remember as well... and printing/logging a warning
is a good idea.

