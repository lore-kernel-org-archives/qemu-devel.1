Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FF7C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E6D20869
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E6D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46687 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHDTy-0007Wl-AN
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:18:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHDSx-000741-3Z
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHDSw-0006FH-92
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHDSw-0006Ep-1f
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:17:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2618F7EBC1
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:17:01 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B213919C58;
	Thu, 18 Apr 2019 20:17:00 +0000 (UTC)
Date: Thu, 18 Apr 2019 17:16:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190418201659.GL25134@habkost.net>
References: <20190418034501.5038-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418034501.5038-1-ehabkost@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 18 Apr 2019 20:17:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] cpu: Fix crash with empty -cpu option
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
Cc: Igor Mammedov <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418201659.mb5YnRb_T4O1PQIDX34Q70hPkdg3qCCPfR7M-_yONuI@z>

On Thu, Apr 18, 2019 at 12:45:01AM -0300, Eduardo Habkost wrote:
> Fix the following crash:
> 
>   $ qemu-system-x86_64 -cpu ''
>   qemu-system-x86_64: qom/cpu.c:291: cpu_class_by_name: \
>       Assertion `cpu_model && cc->class_by_name' failed.
> 
> Regression test script included.
> 
> Fixes: commit 99193d8f2ef5 ("cpu: drop unnecessary NULL check and cpu_common_class_by_name()")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Queued on machine-next.

-- 
Eduardo

