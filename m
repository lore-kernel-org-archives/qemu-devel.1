Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24D1C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 06:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F6720848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 06:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F6720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRWC1-0005qi-UZ
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 02:18:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hRWAq-0005F9-8F
	for qemu-devel@nongnu.org; Fri, 17 May 2019 02:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hRWAo-0002IW-Gc
	for qemu-devel@nongnu.org; Fri, 17 May 2019 02:16:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hRWAo-0002Hy-BQ; Fri, 17 May 2019 02:16:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DE0A30642AA;
	Fri, 17 May 2019 06:16:53 +0000 (UTC)
Received: from gondolin (ovpn-204-129.brq.redhat.com [10.40.204.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B399C5C231;
	Fri, 17 May 2019 06:16:50 +0000 (UTC)
Date: Fri, 17 May 2019 08:16:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger
	<borntraeger@de.ibm.com>
Message-ID: <20190517081647.79d600a9.cohuck@redhat.com>
In-Reply-To: <20190516133327.11430-1-cohuck@redhat.com>
References: <20190516133327.11430-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 17 May 2019 06:16:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] s390/css: handle CCW_FLAG_SKIP
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 May 2019 15:33:27 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> If a ccw has CCW_FLAG_SKIP set, and the command is of type
> read, read backwards, or sense, no data should be written
> to the guest for that command.
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Will queue this unless someone complains.
> 
> v3 -> v4: use MEMTX_OK [Eric]
> v2 -> v3: fixed checks even more [Pierre]
> v1 -> v2: fixed checks for command type [Eric]
> 
> ---
>  hw/s390x/css.c         | 22 ++++++++++++++++++----
>  include/hw/s390x/css.h |  1 +
>  2 files changed, 19 insertions(+), 4 deletions(-)

Queued to s390-next.

