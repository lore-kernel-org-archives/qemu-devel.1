Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583E8C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3048320645
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3048320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35369 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVcVH-0002TA-Ep
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 09:50:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVcR5-0008JD-7J
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVcR4-0004lV-7H
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hVcR4-0004kq-2W
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:46:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66E7B81E10
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 13:46:32 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EBF0960852;
	Tue, 28 May 2019 13:46:27 +0000 (UTC)
Date: Tue, 28 May 2019 15:46:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190528154623.07e153bd@redhat.com>
In-Reply-To: <87imtvj1me.fsf@dusky.pond.sub.org>
References: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
	<1558079119-320634-2-git-send-email-imammedo@redhat.com>
	<87imtvj1me.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 28 May 2019 13:46:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/6] pc: fix possible NULL pointer
 dereference in pc_machine_get_device_memory_region_size()
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 May 2019 18:36:25 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > QEMU will crash when device-memory-region-size property is read if ms->device_memory
> > wasn't initialized yet (ex: property being inspected during preconfig time).  
> 
> Reproduced:
> 
>     $ qemu-system-x86_64 -nodefaults -S -display none -preconfig -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 4}, "package": "v4.0.0-828-ga7b21f6762"}, "capabilities": ["oob"]}}
>     {"execute": "qmp_capabilities"}
>     {"return": {}}
>     {"execute": "qom-get", "arguments": {"path": "/machine", "property": "device-memory-region-size"}}
>     Segmentation fault (core dumped)
> 
> First time I started looking at this series, I went "I'll need a
> reproducer to fully understand what's up, and I don't feel like finding
> one now; next series, please".  Second time, I had to spend a few
> minutes on the reproducer.  Wasn't hard, since you provided a clue.
> Still: make review easy, include a reproducer whenever you can.

sure

> 
> > Instead of crashing return 0 if ms->device_memory hasn't been initialized.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/i386/pc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index d98b737..de91e90 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -2461,7 +2461,11 @@ pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
> >                                           Error **errp)
> >  {
> >      MachineState *ms = MACHINE(obj);
> > -    int64_t value = memory_region_size(&ms->device_memory->mr);
> > +    int64_t value = 0;
> > +
> > +    if (ms->device_memory) {
> > +        memory_region_size(&ms->device_memory->mr);
> > +    }
> >  
> >      visit_type_int(v, name, &value, errp);
> >  }  
> 
> This makes qom-get return 0 for the size of memory that doesn't exist,
> yet.
> 
> A possible alternative would be setting an error.
> 
> Opinions?
We don't have a notion of property not set in QOM, so a code that
will receive a text based error will have to parse it (horrible idea)
to avoid generation of related ACPI parts.

In case of not enabled memory hotplug, PC_MACHINE_DEVMEM_REGION_SIZE == 0
is valid value and it's what's expected by other code.




