Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6742C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD8F2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1JZP0tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD8F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWrx-0004CW-U8
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEWrK-0003lh-Vt
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEWrJ-00021g-V2
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:27:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEWrJ-000202-Pw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584530857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYE9+n5Cpj3GioVDi0YVzGLCrFuflSG6bCLiWByCIgg=;
 b=N1JZP0trohNgDt3kQpZmWEmRaNQc8e8qKroZgacnXjdRCEvwM6nWqPqtlY7jThbYx5p92p
 irH27K1orXBWoyoo5aVmTffel8zO0k+guivInfTz1vW/giSvqJMq4S0w68AV/bwii0ONwl
 t8aM5xgQGpPc+4pQcLABMLUdm3e0Qzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-Lyti_5TqNSW1d3IH_MmpNQ-1; Wed, 18 Mar 2020 07:27:33 -0400
X-MC-Unique: Lyti_5TqNSW1d3IH_MmpNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B87AE13EA;
 Wed, 18 Mar 2020 11:27:32 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7930E7387B;
 Wed, 18 Mar 2020 11:27:31 +0000 (UTC)
Date: Wed, 18 Mar 2020 12:27:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Documentation: create/move s390x documentation
Message-ID: <20200318122728.1e04240e.cohuck@redhat.com>
In-Reply-To: <CAFEAcA_6SBf61GpVVMc6m_zQHbtr9HUfiwP00wKjartH70k2tA@mail.gmail.com>
References: <20200318103940.1169-1-cohuck@redhat.com>
 <CAFEAcA_6SBf61GpVVMc6m_zQHbtr9HUfiwP00wKjartH70k2tA@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 11:12:11 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 18 Mar 2020 at 10:39, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > Create a subdirectory for s390x under docs/system/ and move the
> > existing vfio-ap documentation there.
> >
> > Create an initial document describing s390x system emulation.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >
> > Mostly an initial version so that Janosch can base his protected virt
> > documentation on something; there's room for more here :)
> >
> > If this looks good, I'll queue it on my s390-next branch for 5.1.  
> 
> I would be happy to take documentation cleanups like this
> for 5.0 during the early to mid part of freeze.

Even better; I'll just wait for an R-b/A-b from someone then.


