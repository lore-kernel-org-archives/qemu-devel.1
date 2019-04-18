Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73853C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 14:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C8920835
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 14:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C8920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH80S-0003oN-Gd
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 10:27:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hH7zg-0003Wo-Vm
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hH7zg-0005OK-3n
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hH7zf-0005Nn-UW
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A895BDD1;
	Thu, 18 Apr 2019 14:26:27 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 894405D9CC;
	Thu, 18 Apr 2019 14:26:26 +0000 (UTC)
Date: Thu, 18 Apr 2019 11:26:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190418142624.GH25134@habkost.net>
References: <20190418064602.24558-1-tao3.xu@intel.com>
	<20190418064602.24558-2-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418064602.24558-2-tao3.xu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 18 Apr 2019 14:26:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] numa: move numa global variable
 nb_numa_nodes into MachineState
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
Message-ID: <20190418142624.90jldruuc-2DT2sZ0deoxUXy740sau6oPdIrD3cK_OM@z>

On Thu, Apr 18, 2019 at 02:46:00PM +0800, Tao Xu wrote:
> The aim of this patch is to add struct NumaState in MachineState
> and move existing numa global nb_numa_nodes into NumaState.
> And add variable numa_support into MachineClass to decide which
> submachines support NUMA.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
[...]
> +    int nb_numa_nodes = ms->numa_state ? ms->numa_state->nb_numa_nodes : 0;

I see 17 occurrences of this same pattern in the patch, and I had
to double-check the ones that didn't check if ms->numa_state is
NULL.

I think a
  int machine_num_numa_nodes(MachineState *ms)
helper would be useful.

While at it, I suggest naming the nb_numa_nodes field "num_nodes"
or "nr_nodes", because it's already inside a struct called
NumaState.

-- 
Eduardo

