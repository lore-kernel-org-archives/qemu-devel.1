Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BABCC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3CE2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3CE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEuPn-0003hh-ER
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:32:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEuOr-00035S-V3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEuOr-0007df-5O
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hEuOq-0007d2-RX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:31:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9806230821C2;
	Fri, 12 Apr 2019 11:31:15 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 787C161102;
	Fri, 12 Apr 2019 11:31:14 +0000 (UTC)
Date: Fri, 12 Apr 2019 13:31:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190412133111.028a9c6d.cohuck@redhat.com>
In-Reply-To: <20190409155831.18764-1-eric.auger@redhat.com>
References: <20190409155831.18764-1-eric.auger@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 12 Apr 2019 11:31:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] vfio/common: Introduce
 vfio_set_irq_signaling helper
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
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qemu-devel@nongnu.org,
	eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412113111.bjk5WA218QrIQu7mr1XAPs3aRrlXHlmwdgu0NY6QHXI@z>

On Tue,  9 Apr 2019 17:58:31 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> The code used to assign an interrupt index/subindex to an
> eventfd is duplicated many times. Let's introduce an helper that
> allows to set/unset the signaling for an ACTION_TRIGGER or
> ACTION_UNMASK action.

I like that, and it looks like ccw can use the new function as well. (I
can do a patch on top.)

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> This is a follow-up to
> [PATCH v2 0/2] vfio-pci: Introduce vfio_set_event_handler().
> It looks to me that introducing vfio_set_irq_signaling() has more
> benefits in term of code reduction and the helper abstraction
> looks cleaner.
> ---
>  hw/vfio/common.c              |  61 +++++++++
>  hw/vfio/pci.c                 | 224 ++++++++--------------------------
>  hw/vfio/platform.c            |  55 +++------
>  include/hw/vfio/vfio-common.h |   2 +
>  4 files changed, 134 insertions(+), 208 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

