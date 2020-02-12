Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D032DC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F975206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG9k6cqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F975206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1uAw-0004PT-Ql
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 10:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j1uAH-0003o0-IW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j1uAF-0000rj-VA
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:43:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22252
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j1uAF-0000r2-MC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581522178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQrJPk2rJ0QbcGbsgJk4n5LlyL0dE4tmMfLIjSxsPVs=;
 b=SG9k6cqXAel2ADORhXzEA11GBV1DYWy1+dnUhmnzAu+fal0Rg8ooBCrB4rnU4QznwAcYpm
 KWzLq0BJyptJHS0ZmKg6tpYOE9r8ktrld2urW380O73LGoatfvZ8w5jvNqAufrO/fHqa8U
 flquLY7k/4PxDMuz+BJZkZn3rcuHx2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-wS0jEJ_qP028dPDUrbUWAw-1; Wed, 12 Feb 2020 10:42:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B683D107ACC7;
 Wed, 12 Feb 2020 15:42:53 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5425D60BF1;
 Wed, 12 Feb 2020 15:42:52 +0000 (UTC)
Date: Wed, 12 Feb 2020 16:41:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.ibm.com>, "Jason J . Herne"
 <jjherne@linux.ibm.com>
Subject: Re: [PATCH RFC 2/2] docs: rstfy vfio-ap documentation
Message-ID: <20200212164155.06877c01.cohuck@redhat.com>
In-Reply-To: <20200128180142.15132-3-cohuck@redhat.com>
References: <20200128180142.15132-1-cohuck@redhat.com>
 <20200128180142.15132-3-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wS0jEJ_qP028dPDUrbUWAw-1
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
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 19:01:42 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Move to system/, as this is mostly about configuring vfio-ap.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS                              |   2 +-
>  docs/system/index.rst                    |   1 +
>  docs/{vfio-ap.txt => system/vfio-ap.rst} | 755 ++++++++++++-----------
>  3 files changed, 387 insertions(+), 371 deletions(-)
>  rename docs/{vfio-ap.txt => system/vfio-ap.rst} (56%)
> 

> -Example: Configure AP Matrixes for Three Linux Guests:
> -=====================================================
> +Example: Configure AP Matrices for Three Linux Guests
> +-----------------------------------------------------
>  Let's now provide an example to illustrate how KVM guests may be given
>  access to AP facilities. For this example, we will show how to configure
>  three guests such that executing the lszcrypt command on the guests would
> -look like this:
> -
> -Guest1
> -------
> -CARD.DOMAIN TYPE  MODE
> -------------------------------
> -05          CEX5C CCA-Coproc
> -05.0004     CEX5C CCA-Coproc
> -05.00ab     CEX5C CCA-Coproc
> -06          CEX5A Accelerator
> -06.0004     CEX5A Accelerator
> -06.00ab     CEX5C CCA-Coproc
> -
> -Guest2
> -------
> -CARD.DOMAIN TYPE  MODE
> -------------------------------
> -05          CEX5A Accelerator
> -05.0047     CEX5A Accelerator
> -05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
> -
> -Guest3
> -------
> -CARD.DOMAIN TYPE  MODE
> -------------------------------
> -06          CEX5A Accelerator
> -06.0047     CEX5A Accelerator
> -06.00ff     CEX5A Accelerator
> +look like this::
> +
> +  Guest1
> +  ------
> +  CARD.DOMAIN TYPE  MODE
> +  ------------------------------
> +  05          CEX5C CCA-Coproc
> +  05.0004     CEX5C CCA-Coproc
> +  05.00ab     CEX5C CCA-Coproc
> +  06          CEX5A Accelerator
> +  06.0004     CEX5A Accelerator
> +  06.00ab     CEX5C CCA-Coproc
> +
> +  Guest2
> +  ------
> +  CARD.DOMAIN TYPE  MODE
> +  ------------------------------
> +  05          CEX5A Accelerator
> +  05.0047     CEX5A Accelerator
> +  05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),

Just noticed this trailing stuff (had already been in the original
file). Looks like a stray paste, will remove.

> +
> +  Guest3
> +  ------
> +  CARD.DOMAIN TYPE  MODE
> +  ------------------------------
> +  06          CEX5A Accelerator
> +  06.0047     CEX5A Accelerator
> +  06.00ff     CEX5A Accelerator


