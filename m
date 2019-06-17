Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBEDC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578802054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578802054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcrRJ-0006Om-KN
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52401)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hcrQK-0005IP-R2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hcrQI-0001k4-K9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:11:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hcrQI-0001gv-CG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:11:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B23653092676
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 13:11:41 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EF0F179E8;
 Mon, 17 Jun 2019 13:11:38 +0000 (UTC)
Date: Mon, 17 Jun 2019 15:11:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190617151133.0af9fd43@redhat.com>
In-Reply-To: <1559205199-233510-1-git-send-email-imammedo@redhat.com>
References: <1559205199-233510-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 17 Jun 2019 13:11:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/3] numa: deprecate '-numa node,
 mem' and default memory distribution
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 May 2019 10:33:16 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> Changes since v3:
>   - simplify series by dropping idea of showing property values in "qom-list-properties"
>     and use MachineInfo in QAPI schema instead
> 
> Changes since v2:
>   - taking in account previous review, implement a way for mgmt to intospect if
>     '-numa node,mem' is supported by machine type as suggested by Daniel at
>              https://www.mail-archive.com/qemu-devel@nongnu.org/msg601220.html
>       * ammend "qom-list-properties" to show property values
>       * add "numa-mem-supported" machine property to reflect if '-numa node,mem=SZ'
>         is supported. It culd be used with '-machine none' or at runtime with
>         --preconfig before numa memory mapping are configured
>   * minor fixes to deprecation documentation mentioning "numa-mem-supported" property
> 
>  1) "I'm considering to deprecating -mem-path/prealloc CLI options and replacing
> them with a single memdev Machine property to allow interested users to pick
> used backend for initial RAM (fixes mixed -mem-path+hostmem backends issues)
> and as a transition step to modeling initial RAM as a Device instead of
> (ab)using MemoryRegion APIs."
> (for more details see: https://www.mail-archive.com/qemu-devel@nongnu.org/msg596314.html)
> 
> However there is a couple of roadblocks on the way (s390x and numa memory handling).
> I think I finally thought out a way to hack s390x in migration compatible manner,
> but I don't see any way to do it for -numa node,mem and default RAM assignement
> to nodes. Considering both numa usecases aren't meaningfully using NUMA (aside
> guest side testing) and could be replaced with explicitly used memdev parameter,
> I'd like to propose removing these fake NUMA friends on new machine types,
> hence this deprecation. And once the last machie type that supported the option
> is removed we would be able to remove option altogether.
> 
> As result of removing deprecated options and replacing initial RAM allocation
> with 'memdev's (1), QEMU will allocate guest RAM in consistent way, fixing mixed
> use-case and allowing boards to move towards modelling initial RAM as Device(s).
> Which in its own turn should allow to cleanup NUMA/HMP/memory accounting code
> more by dropping ad-hoc node_mem tracking and reusing memory device enumeration
> instead.

Eduardo,

could you take and merge it via numa/machine tree?

> 
> Reference to previous versions:
>  * https://www.mail-archive.com/qemu-devel@nongnu.org/msg617694.html
> 
> CC: libvir-list@redhat.com
> CC: ehabkost@redhat.com
> CC: pbonzini@redhat.com
> CC: berrange@redhat.com
> CC: armbru@redhat.com
> 
> Igor Mammedov (3):
>   machine: show if CLI option '-numa node,mem' is supported in QAPI
>     schema
>   numa: deprecate 'mem' parameter of '-numa node' option
>   numa: deprecate implict memory distribution between nodes
> 
>  include/hw/boards.h  |  3 +++
>  hw/arm/virt.c        |  1 +
>  hw/i386/pc.c         |  1 +
>  hw/ppc/spapr.c       |  1 +
>  numa.c               |  5 +++++
>  qapi/misc.json       |  5 ++++-
>  qemu-deprecated.texi | 24 ++++++++++++++++++++++++
>  vl.c                 |  1 +
>  8 files changed, 40 insertions(+), 1 deletion(-)
> 


