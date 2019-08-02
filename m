Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6191C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3852087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3852087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htYh9-0007g4-Tp
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 10:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1htYgk-0007Eg-H2
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1htYgj-0007PF-If
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1htYgj-0007NN-Bd
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:37:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A8C7B300BC74
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 14:37:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75694600D1;
 Fri,  2 Aug 2019 14:37:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02ACA1138619; Fri,  2 Aug 2019 16:37:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-23-armbru@redhat.com>
 <20190729201759.GK4313@habkost.net>
 <87a7cveq7y.fsf@dusky.pond.sub.org>
Date: Fri, 02 Aug 2019 16:37:42 +0200
In-Reply-To: <87a7cveq7y.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Tue, 30 Jul 2019 13:06:41 +0200")
Message-ID: <87zhkrhbux.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 02 Aug 2019 14:37:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 22/28] Include hw/boards.h a bit less
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Eduardo Habkost <ehabkost@redhat.com> writes:
>
>> On Fri, Jul 26, 2019 at 02:05:36PM +0200, Markus Armbruster wrote:
>>> hw/boards.h pulls in almost 60 headers.  The less we include it into
>>> headers, the better.  As a first step, drop superfluous inclusions,
>>> and downgrade some more to what's actually needed.  Gets rid of just
>>> one inclusion into a header.
>>> 
>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>> The following files use the MACHINE macro and require
>> hw/boards.h, but are touched by this patch:
>>
>> hw/acpi/cpu.c:    MachineState *machine = MACHINE(qdev_get_machine());
>> hw/acpi/memory_hotplug.c:    MachineState *machine = MACHINE(qdev_get_machine());
>> hw/i386/intel_iommu.c:    MachineState *ms = MACHINE(qdev_get_machine());
>> hw/i386/x86-iommu.c:    MachineState *ms = MACHINE(qdev_get_machine());
>> hw/ppc/spapr_rtas.c:    MachineState *ms = MACHINE(qdev_get_machine());
>> hw/s390x/s390-stattrib-kvm.c:    MachineState *machine = MACHINE(qdev_get_machine());
>> hw/s390x/s390-stattrib-kvm.c:    MachineState *machine = MACHINE(qdev_get_machine());
>
> Since they still compile, they obviously still get it indirectly.  I'll
> drop these hunks.
>
>> Maybe there are other files touched by this patch that require
>> struct MachineClass or struct MachineState contents to be
>> defined, but this is a bit trickier to verify.
>
> I tried to exclude those, but I might have screwed it up, just like I
> screwed up for MACHINE().  I'll double-check.

None contain matches for /\bMachine(Class|State) *[^ *]/.

