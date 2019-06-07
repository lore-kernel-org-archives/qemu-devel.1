Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6F1C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4597208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4597208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKOD-0002k0-Kn
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hZJCK-0006yl-2o
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hZJCJ-0007uj-6I
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hZJCI-0007r2-Ua
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:02:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C5693082A8F
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 18:02:27 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC8815C896;
 Fri,  7 Jun 2019 18:02:24 +0000 (UTC)
Date: Fri, 7 Jun 2019 15:02:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190607180223.GC22416@habkost.net>
References: <1559205199-233510-1-git-send-email-imammedo@redhat.com>
 <1559205199-233510-2-git-send-email-imammedo@redhat.com>
 <87h8915m7u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8915m7u.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 07 Jun 2019 18:02:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/3] machine: show if CLI option '-numa
 node, mem' is supported in QAPI schema
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
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 07:39:17PM +0200, Markus Armbruster wrote:
> This is correct when the TYPE_VIRT_MACHINE, TYPE_PC_MACHINE and
> TYPE_SPAPR_MACHINE are exactly the machines supporting NUMA.  How could
> I check that?

parse_numa_node() rejects the -numa option if the machine doesn't
implement MachineClass::get_default_cpu_node_id().

Grepping for it:

$ git grep -pw get_default_cpu_node_id
hw/arm/virt.c=static void virt_machine_class_init(ObjectClass *oc, void *data)
hw/arm/virt.c:    mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
hw/core/machine.c=static void machine_numa_finish_cpu_init(MachineState *machine)
hw/core/machine.c:            props.node_id = mc->get_default_cpu_node_id(machine, i);
hw/i386/pc.c=static void pc_machine_class_init(ObjectClass *oc, void *data)
hw/i386/pc.c:    mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
hw/ppc/spapr.c=static void spapr_machine_class_init(ObjectClass *oc, void *data)
hw/ppc/spapr.c:    mc->get_default_cpu_node_id = spapr_get_default_cpu_node_id;
include/hw/boards.h=typedef struct {
include/hw/boards.h: * @get_default_cpu_node_id:
include/hw/boards.h=struct MachineClass {
include/hw/boards.h:    int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
numa.c=static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
numa.c:    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) {


Related:
  [PATCH v4 01/11] numa: move numa global variable nb_numa_nodes into MachineState
which adds a MachineClass::numa_supported flag to those machines.

-- 
Eduardo

