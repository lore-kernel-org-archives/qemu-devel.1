Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D154C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A23214C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A23214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46795 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHDeo-0002cJ-LI
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:29:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHDe1-0002Dd-GB
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHDdz-0006Pp-L4
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:28:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHDdx-0006LA-K3
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:28:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABB788553A;
	Thu, 18 Apr 2019 20:28:22 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E64560BE5;
	Thu, 18 Apr 2019 20:28:22 +0000 (UTC)
Date: Thu, 18 Apr 2019 17:28:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190418202820.GM25134@habkost.net>
References: <20190418064602.24558-1-tao3.xu@intel.com>
	<20190418064602.24558-4-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418064602.24558-4-tao3.xu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 18 Apr 2019 20:28:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/3] numa: move numa global variable
 numa_info into MachineState
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
Cc: imammedo@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org,
	pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418202820.q4mfNuMf52wNK1TmLwqnE1RH2NZ3q6WqgU6lq57PeOg@z>

On Thu, Apr 18, 2019 at 02:46:02PM +0800, Tao Xu wrote:
> The aim of this patch is to move existing numa global numa_info
> into NumaState.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

`ms->numa_state->numa_info[i]` is not a very descriptive
expression.  Also, we don't need the "numa" prefix anymore, if
the identifier is not in global scope.

I suggest renaming it to NumaState::nodes.  So this:
>  ms->numa_state->numa_info[i].distance[j]
would become:
  ms->numa_state->nodes[i].distance[j]

This wouldn't block me from merging this patch, but it's a
suggestion in case you send v3 to address the comments on patch
1/3.

-- 
Eduardo

