Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C68C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2D120674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcoLZBaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2D120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izII8-00011J-VY
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1izIHR-0000Yc-Bc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1izIHQ-0006I6-8L
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:51:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25979
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1izIHQ-0006CJ-4j
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580899895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHOOP2tvO1zWdPfmHY+m0psxdSpxrlLoc2DvWc445dQ=;
 b=KcoLZBaBDEaQhz3pkqPsRnddWnn8hFPCIaApx/oe4z+b7O+HovqmTjZ3F3CwYj39QtJzLj
 iuYTflgamR5Gm/xEo+uA9jOCYqpcbv2FQ/7KR7X218TrAb9saQRdpRYp46zdnAgHczs9fU
 D56dD8BfQA8cGFXJWneOM82ux5bd1gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-UNALZOEkPn6BP2iLVQ3D-Q-1; Wed, 05 Feb 2020 05:51:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A4238C1C0C;
 Wed,  5 Feb 2020 10:51:28 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C456E60BF4;
 Wed,  5 Feb 2020 10:51:26 +0000 (UTC)
Date: Wed, 5 Feb 2020 11:51:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.ibm.com>, "Jason J . Herne"
 <jjherne@linux.ibm.com>
Subject: Re: [PATCH RFC 0/2] docs: rstfy some s390 docs
Message-ID: <20200205115124.351e74df.cohuck@redhat.com>
In-Reply-To: <20200128180142.15132-1-cohuck@redhat.com>
References: <20200128180142.15132-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: UNALZOEkPn6BP2iLVQ3D-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 19:01:40 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> https://qemu.readthedocs.io/en/latest/index.html collects various
> documents from the QEMU docs/ subdirectory; however, none of the
> s390 files are currently included. Therefore, I set out to convert
> the existing files to rst and hook them up.
> 
> s390-dasd-ipl was straightforward enough; I also found a numbering
> issue.
> 
> vfio-ap was quite a bit more involved, but I hope I have produced
> something readable (would benefit from some more review). I also
> moved this into the system/ subdirectory; not sure if that is the
> best resting place, but it seemed to be the most reasonable one.
> 
> Tested via running 'make html' and inspecting the output.
> 
> Branch: https://github.com/cohuck/qemu rstfy-s390
> 
> Cornelia Huck (2):
>   docs: rstfy s390 dasd ipl documentation
>   docs: rstfy vfio-ap documentation
> 
>  MAINTAINERS                                   |   4 +-
>  docs/devel/index.rst                          |   1 +
>  .../{s390-dasd-ipl.txt => s390-dasd-ipl.rst}  |  65 +-
>  docs/system/index.rst                         |   1 +
>  docs/{vfio-ap.txt => system/vfio-ap.rst}      | 755 +++++++++---------
>  5 files changed, 424 insertions(+), 402 deletions(-)
>  rename docs/devel/{s390-dasd-ipl.txt => s390-dasd-ipl.rst} (77%)
>  rename docs/{vfio-ap.txt => system/vfio-ap.rst} (56%)
> 

Friendly ping. Anybody got some spare cycles to look at this?


