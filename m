Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C78C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7FE20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7FE20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVuQ9-0006ty-37
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 04:58:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVuPN-0006Z5-N8
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVuPM-0005AJ-Hl
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:58:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hVuPM-0005A0-9P
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:58:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3078B308795E;
	Wed, 29 May 2019 08:58:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CEC01A4D9;
	Wed, 29 May 2019 08:57:54 +0000 (UTC)
Date: Wed, 29 May 2019 10:57:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190529105750.696fe6d2@redhat.com>
In-Reply-To: <20190529003214.GA24428@richard>
References: <20190411071739.22889-1-richardw.yang@linux.intel.com>
	<20190527142114.521ab953@redhat.com>
	<20190528013548.GA8813@richard>
	<20190528142627.6841e91a@redhat.com>
	<20190529003214.GA24428@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 29 May 2019 08:58:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: check apci hotplug capability
 before nvdimm's
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
Cc: pbonzini@redhat.com, thuth@redhat.com, rth@twiddle.net,
	qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 08:32:14 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Tue, May 28, 2019 at 02:26:27PM +0200, Igor Mammedov wrote:
> >On Tue, 28 May 2019 09:35:48 +0800
> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >  
> >> On Mon, May 27, 2019 at 02:21:14PM +0200, Igor Mammedov wrote:  
> >> >On Thu, 11 Apr 2019 15:17:39 +0800
> >> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >> >    
> >> >> pc_memory_pre_plug() is called during hotplug for both pc-dimm and
> >> >> nvdimm. This is more proper to check apci hotplug capability before
> >> >> check nvdimm specific capability.    
> >> >not sure what this about.
> >> >Currently we are checking if ACPI is enabled
> >> >  if (!pcms->acpi_dev || !acpi_enabled) { ...
> >> >before nvdimm check and it looks better to me that we cancel
> >> >nvdimm hotplug earlier than passing it to
> >> >    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err)
> >> >with this patch ACPI device handler will be called before
> >> >nvdimm check happens, so it's +1 unnecessary call chain in
> >> >the case of nvdimm, which I'd rather not have.
> >> >
> >> >Are there any issues with current call flow?
> >> >(commit message doesn't really explaining why we need this patch)
> >> >    
> >> 
> >> My idea is to check more generic requirement and then specific one.
> >> 
> >> For example, the call flow looks like this:
> >> 
> >> pc_memory_pre_plug
> >> 
> >>     piix4_device_pre_plug_cb | ich9_pm_device_pre_plug_cb
> >>         if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> >>             !lpc->pm.acpi_memory_hotplug.is_enabled)
> >> 
> >>     if (is_nvdimm && !ms->nvdimms_state->is_enabled)
> >>     
> >> 
> >> In hotplug_handler_pre_plug(), it checks the acpi hotplug capability. And then
> >> if it has memory hotplug capability and is nvdimm, we check whether nvdimm is
> >> enabled.  
> >
> >I don't think pc_memory_pre_plug() should rely on what hotplug_handler_pre_plug()
> >checks or does. Similarly the later is taking care of whatever piix4 needs to care
> >and shouldn't care about what machine code does.
> >  
> 
> Agree. It is not proper to let hotplug_handler_pre_plug() take care about
> machine code.
> 
> >Moreover when hotplug_handler_pre_plug() starts to reserve resources, then
> >if you move check as suggested you'd need to rollback all that
> >hotplug_handler_pre_plug() done to gracefully abort hotplug.
> >  
> 
> Confused.
> 
> hotplug_handler_pre_plug() doesn't reserve resources.


it's not currently, but if it would it would not work with your patch properly
or break unexpectedly since whoever would change hotplug_handler_pre_plug()
might not notice that machine code need to be taken care of.

Try to consider devices and machine as separate libraries. Which should
in reasonable limits be independent and work through documented interfaces.
In that case likehood of breaking something would be less than relying on
current code impl./call order with implicit inter-dependencies. 

> pc_dimm_pre_plug() does.
> 
> I didn't plan to move the code after pc_dimm_pre_plug().
> 
> >So I'd leave the code as it is now, since it doesn't depend on concrete
> >hotplug_handler_pre_plug() implementation and won't break if
> >hotplug_handler_pre_plug() will start consuming resources (which could
> >happen and you won't even notice it since changed code is in piix4/q35
> >files when reviewing patches).  
> >> This is why I suggest to change the order here. No functional issue for
> >> current code.
> >>   
> 


