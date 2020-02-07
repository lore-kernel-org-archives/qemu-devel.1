Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B71C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9308C222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8q2AtKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9308C222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05TW-0006DA-NR
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j05Sv-0005ib-Ip
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j05St-0003ts-Ay
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:22:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j05St-0003t2-13
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581088962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yk80xZRAQSpG56SE36xTJq4b75lDgQG76fnM+EFJPlo=;
 b=d8q2AtKSY5XhkZI3InM9sa/mZ72PBe78+6IMfvHDLFy+U0y55YKrVqKufVPsuj6bfNfK8G
 c232WykDwf6N55fRKkl/2BxHNFCZhixWBB8KKYnZ9/+z2G5rcptJpTUFGaqpAIJf/+svsQ
 /PmL8BIY3xug1XQw1lEBompS1pju3/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-aYQCcNAoNZSub-IOeX5hMg-1; Fri, 07 Feb 2020 10:22:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7230CDB2C;
 Fri,  7 Feb 2020 15:22:26 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 663A65C28C;
 Fri,  7 Feb 2020 15:22:23 +0000 (UTC)
Date: Fri, 7 Feb 2020 16:22:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC 1/2] docs: rstfy s390 dasd ipl documentation
Message-ID: <20200207162221.371dfd05.cohuck@redhat.com>
In-Reply-To: <CAFEAcA9kkxNZg7ij5vXQU-pA+sxed13L0GB6RfiWsvyT2rPPYg@mail.gmail.com>
References: <20200128180142.15132-1-cohuck@redhat.com>
 <20200128180142.15132-2-cohuck@redhat.com>
 <CAFEAcA9kkxNZg7ij5vXQU-pA+sxed13L0GB6RfiWsvyT2rPPYg@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: aYQCcNAoNZSub-IOeX5hMg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 12:05:09 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 28 Jan 2020 at 19:36, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > While at it, also fix the numbering in 'What QEMU does'.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---  
> 
> > diff --git a/docs/devel/s390-dasd-ipl.txt b/docs/devel/s390-dasd-ipl.rst
> > similarity index 77%
> > rename from docs/devel/s390-dasd-ipl.txt
> > rename to docs/devel/s390-dasd-ipl.rst
> > index 9107e048e4e6..1f6a7ea01ce6 100644
> > --- a/docs/devel/s390-dasd-ipl.txt
> > +++ b/docs/devel/s390-dasd-ipl.rst
> > @@ -1,25 +1,28 @@
> > -*****************************
> > -***** s390 hardware IPL *****
> > -*****************************
> > +Booting from real channel-attached devices on s390x
> > +===================================================
> > +
> > +s390 hardware IPL
> > +-----------------
> >
> >  The s390 hardware IPL process consists of the following steps.
> >
> > -1. A READ IPL ccw is constructed in memory location 0x0.
> > +1. A READ IPL ccw is constructed in memory location ``0x0``.
> >      This ccw, by definition, reads the IPL1 record which is located on the disk
> >      at cylinder 0 track 0 record 1. Note that the chain flag is on in this ccw
> >      so when it is complete another ccw will be fetched and executed from memory
> > -    location 0x08.
> > +    location ``0x08``.  
> 
> I think the indentation here is off -- rST likes to see every line
> in a multiline bullet point start in the same column, like this:
> 
> 1. A READ IPL ccw is constructed in memory location ``0x0``.
>    This ccw, by ...
>    at cylinder...
> 
> Otherwise I think you end up with a blockquote by accident.

Hm, the resulting html looked sane to me... but making this consistent
is a good idea anyway.

> 
> Formatting-wise the rest looks OK to me (and the other enumerated
> lists in this document don't have this odd indentation, just this
> first set of 1..4).

Thanks for looking!

> 
> thanks
> -- PMM
> 


