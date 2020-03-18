Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45461C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1093020774
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOSjkxt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1093020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZt6-0001b7-7f
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEZsB-0008QT-A6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEZsA-0000MI-7U
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:40:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEZsA-0000LE-37
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584542441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9g6aTtMIBpxVqX2f0AwVQ0to+z2O5QEEUca45vdkCxM=;
 b=dOSjkxt6L+BkJJesCfJBAj4sgcvJxUnwF+XTU+/twvtPMpBYTAanKeIXNDbg5IzD+Zz3rx
 jNiTBzffIqrW0K4ZNK2hecaXJTpamhLf4Y2XRhNYA0uK9S5WyumWnZsFZTm6Cc5SrPy/Jm
 E5BxetIdzweuLDEcpg4DeAvPp2U1YOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-fMNZgNwmNeCIxjxkgD5N8A-1; Wed, 18 Mar 2020 10:40:40 -0400
X-MC-Unique: fMNZgNwmNeCIxjxkgD5N8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2001A0CBF;
 Wed, 18 Mar 2020 14:40:38 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92F5B17B91;
 Wed, 18 Mar 2020 14:40:37 +0000 (UTC)
Date: Wed, 18 Mar 2020 15:40:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH] Documentation: create/move s390x documentation
Message-ID: <20200318154032.6636c449.cohuck@redhat.com>
In-Reply-To: <20200318103940.1169-1-cohuck@redhat.com>
References: <20200318103940.1169-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 11:39:40 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Create a subdirectory for s390x under docs/system/ and move the
> existing vfio-ap documentation there.
> 
> Create an initial document describing s390x system emulation.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Mostly an initial version so that Janosch can base his protected virt
> documentation on something; there's room for more here :)
> 
> If this looks good, I'll queue it on my s390-next branch for 5.1.
> 
> ---
>  MAINTAINERS                         |  5 +++--
>  docs/system/index.rst               |  1 -
>  docs/system/{ => s390x}/vfio-ap.rst |  0
>  docs/system/target-s390x.rst        | 26 ++++++++++++++++++++++++++
>  docs/system/targets.rst             |  1 +
>  5 files changed, 30 insertions(+), 3 deletions(-)
>  rename docs/system/{ => s390x}/vfio-ap.rst (100%)
>  create mode 100644 docs/system/target-s390x.rst

Queued to s390-fixes.


