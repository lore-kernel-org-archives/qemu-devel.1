Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED3EC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 19:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6CC26E93
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 19:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6CC26E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48366 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWnYM-0003Xr-Du
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 15:51:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWnXL-00032W-8J
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWnXK-0004Lc-94
	for qemu-devel@nongnu.org; Fri, 31 May 2019 15:49:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hWnXI-0004Ie-4Y; Fri, 31 May 2019 15:49:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4BDF30C1E3A;
	Fri, 31 May 2019 19:49:47 +0000 (UTC)
Received: from localhost (ovpn-120-246.rdu2.redhat.com [10.10.120.246])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3217578380;
	Fri, 31 May 2019 19:49:45 +0000 (UTC)
Date: Fri, 31 May 2019 16:49:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190531194944.GL22103@habkost.net>
References: <20190529160747.778-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529160747.778-1-lvivier@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 31 May 2019 19:49:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] numa: improve cpu hotplug error message
 with a wrong node-id
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 06:07:47PM +0200, Laurent Vivier wrote:
> On pseries, core-ids are strongly binded to a node-id by the command
> line option. If an user tries to add a CPU to the wrong node, he has
> an error but it is not really helpful:
> 
>   qemu-system-ppc64 ... -smp 1,maxcpus=64,cores=1,threads=1,sockets=1 \
>                         -numa node,nodeid=0 -numa node,nodeid=1 ...
> 
>   (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=30,node-id=1
>   Error: node-id=1 must match numa node specified with -numa option
> 
> This patch improves this error message by giving to the user the good
> node-id to use with the core-id he's providing
> 
>   Error: invalid node-id, must be 0
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Queued, thanks.

-- 
Eduardo

