Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7BEC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 20:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7108B20850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 20:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7108B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF30v-0003cC-LT
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 16:43:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF30A-0003JI-9s
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 16:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF305-0007bk-Bq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 16:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hF305-0007bI-3r
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 16:42:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 006CB308621F;
	Fri, 12 Apr 2019 20:42:16 +0000 (UTC)
Received: from localhost (ovpn-116-78.gru2.redhat.com [10.97.116.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36C5E600C5;
	Fri, 12 Apr 2019 20:42:14 +0000 (UTC)
Date: Fri, 12 Apr 2019 17:42:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190412204213.GI31999@habkost.net>
References: <20190405064121.23662-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405064121.23662-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 20:42:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/4] cleanup select_machine
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412204213.OcVczT3a19lUVVK4-GvmcnJiEO_e6BSDiUu7EaIyRxQ@z>

On Fri, Apr 05, 2019 at 02:41:17PM +0800, Wei Yang wrote:
> Here is two simple change related to select_machine()
> 
> [1]: make find_default_machine() local since no one outside file use it
> [2]: allocate TYPE_MACHINE list only once to select machine type
> [3]: cleanup after previous commit
> [4]: Simplify machine_parse()

Thanks!  Queued on machine-next, for 4.1.

> 
> ---
> v2:
>   * adjust changelog in [1]
>   * Markus provides [3-4]
> 
> Markus Armbruster (2):
>   vl: Clean up after previous commit
>   vl: Simplify machine_parse()
> 
> Wei Yang (2):
>   vl.c: make find_default_machine() local
>   vl.c: allocate TYPE_MACHINE list once during bootup
> 
>  include/hw/boards.h |  1 -
>  vl.c                | 69 ++++++++++++++++++---------------------------
>  2 files changed, 28 insertions(+), 42 deletions(-)
> 
> -- 
> 2.19.1
> 
> 

-- 
Eduardo

