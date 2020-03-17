Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF90C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C9A20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RelydGDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C9A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEH8v-0004Co-87
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEGsJ-000487-0t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEGsG-000218-HA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:23:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32191)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEGsG-0001uT-Am
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584469411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nO5V8856P41MxakkAqC2DD3v+ad+TC8mRBucL/oVy2Q=;
 b=RelydGDY/8DK1SqAUp6WfzpTRjHtVXx9gU8Q8OYdMgD3nDVM5vvqUsdAx6eIE3t+0ZT0dr
 Zpbs+wPikVfts6KvcIFpyPFruLrg3GThPphUREjee0o4wm1mluuEv0pOVAJviwUU79PXmT
 3dqA3ITqw8jqmeC0a6LE6iHvnjRtyzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-ItZIrJQwPsql_MK_tM5EVA-1; Tue, 17 Mar 2020 14:23:29 -0400
X-MC-Unique: ItZIrJQwPsql_MK_tM5EVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C11E100550E;
 Tue, 17 Mar 2020 18:23:28 +0000 (UTC)
Received: from gondolin (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58E2D5D9E2;
 Tue, 17 Mar 2020 18:23:24 +0000 (UTC)
Date: Tue, 17 Mar 2020 19:23:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v9 14/15] docs: Add protvirt docs
Message-ID: <20200317192321.3c6e3d21.cohuck@redhat.com>
In-Reply-To: <CAFEAcA84eNDe82ZNCDO3apgjhoa3UEriWo1+2aW7L4ok0hMZgQ@mail.gmail.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-15-frankja@linux.ibm.com>
 <CAFEAcA84eNDe82ZNCDO3apgjhoa3UEriWo1+2aW7L4ok0hMZgQ@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 13:28:56 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 11 Mar 2020 at 13:31, Janosch Frank <frankja@linux.ibm.com> wrote:
> >
> > Lets add some documentation for the Protected VM functionality.
> >
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > ---
> >  docs/system/index.rst    |  1 +
> >  docs/system/protvirt.rst | 56 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> >  create mode 100644 docs/system/protvirt.rst
> >
> > diff --git a/docs/system/index.rst b/docs/system/index.rst
> > index 6e5f20fa1333ce23..74afbd7cc3fc0296 100644
> > --- a/docs/system/index.rst
> > +++ b/docs/system/index.rst
> > @@ -34,3 +34,4 @@ Contents:
> >     deprecated
> >     build-platforms
> >     license
> > +   protvirt  
> 
> The order of this list in index.rst determines the order
> of the table of contents in the manual. Could you put
> your new document at a reasonable place in the manual,
> not just at the bottom of the list, please?
> 
> For something that is s390 specific, the ideal would
> be to create a new docs/system/target-s390x.rst
> which is then the place where all s390 docs can
> hang off of. This is how we're handling various
> other guest architecture docs. It doesn't all
> have to go in a single page -- eg target-arm.rst
> is an example of putting some sub-documents into
> docs/system/arm/ and referring to them from
> target-arm.rst.

That sounds like a good idea; let me see whether I can come up with
something that Janosch can base his change on.

(There's already the vfio-ap documentation that's s390x specific; I'll
also move it.)


