Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8809C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C585207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+ld9LeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C585207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFv4-0008MJ-Pj
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jeFuX-0007xQ-9J
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:37:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jeFuV-00011A-PE
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590662234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oSlKTHtAWyidzyd3zYoJXQJTpD80td5Cq9n48uhAS6Q=;
 b=X+ld9LeUtkRhpIqL6Z73HibcqiNNAS8oJhVyY+BIDQsGrbLcgFkUjQXovx119u2TPg6v6Y
 DwVxsodP6H+TJ/TSRVR10EBN6TyL5dRwj2H+CgPjtJE58yxkFsuRrc5aHi/bXK8bAUCNo4
 pBDwdOdzaNnZSnOgAGymB7kxtdDfLZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-dbst3ZdHO3-wQ0VrJiCmpQ-1; Thu, 28 May 2020 06:37:10 -0400
X-MC-Unique: dbst3ZdHO3-wQ0VrJiCmpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CC7A474;
 Thu, 28 May 2020 10:37:08 +0000 (UTC)
Received: from localhost (unknown [10.40.208.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE8445C1D6;
 Thu, 28 May 2020 10:37:02 +0000 (UTC)
Date: Thu, 28 May 2020 12:37:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200528123700.0a364b0e@redhat.com>
In-Reply-To: <20200528052642.GB3071@jondnuc>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
 <20200511182121.GA1307176@rvkaganb.lan>
 <20200513173414.62e3cb4e@redhat.com>
 <fb1661c0-7282-58b4-03b4-a77793cc8e97@redhat.com>
 <20200522104053.4e7834a8@nas.mammed.net>
 <20200528052642.GB3071@jondnuc>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, Roman Kagan <rvkagan@yandex-team.ru>,
 liran.alon@oracle.com, Roman Kagan <rkagan@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 08:26:42 +0300
Jon Doron <arilou@gmail.com> wrote:

> On 22/05/2020, Igor Mammedow wrote:
> >On Thu, 21 May 2020 18:02:07 +0200
> >Paolo Bonzini <pbonzini@redhat.com> wrote:
> >  
> >> On 13/05/20 17:34, Igor Mammedov wrote:  
> >> > I'd rather avoid using random IRQ numbers (considering we are
> >> > dealing with black-box here). So if it's really necessary to have
> >> > IRQ described here, I'd suggest to implement them in device model
> >> > so they would be reserved and QEMU would error out in a sane way if
> >> > IRQ conflict is detected.  
> >>
> >> We don't generally detect ISA IRQ conflicts though, do we?  
> >
> >that I don't know that's why I'm not suggesting how to do it.
> >The point is hard-coding in AML random IRQs is not right thing to do,
> >(especially with the lack of 'any' spec), as minimum AML should pull
> >it from device model and that probably should be configurable and set
> >by board.
> >
> >Other thing is:
> >I haven't looked at VMBus device model in detail, but DSDT part aren't
> >matching device though (device model is not ISA device hence AML part
> >shouldn't be on in ISA scope), where to put it is open question.
> >There were other issues with AML code, I've commented on, so I was
> >waiting on respin with comments addressed.
> >I don't think that this patch is good enough for merging.
> >
> >  
> 
> But it seems like the current patch does match what's Microsoft HyperV 
> is publishing in it's APCI tables.
> 
> I dont think it's correct for us to "fix" Microsoft emulation even if 
> it's wrong, since that's what Windows probably expects to see...
> 
> I tried looking where Microsoft uses the ACPI tables to identify the 
> VMBus but without much luck in order to understand how flexible a change 
> would be for the OS to still detect the VMBus device, but in general 
> I think "correcting" something that is emulated 1:1 because there is no 
> spec is the right way.

I'd agree, if removing nonsense would break VMBus detection (does it?).
if something is that doesn't make sense but has to stay because it is need
to make windows happy, that's fine , just add annotate is with comment,
so it won't confuse anyone why that code exists there later on.

I suggest to:
 1. try dropping _PS* & _STA as it doesn't actually does anything and _PS3 is plain wrong
 2. drop one IRQ, newer hyper-v seems to be doing fine with only one
 3. it's not ISA device, I'd suggest to move into _SB scope
 4. I don't know much about IRQs but
       git grep DEFINE_PROP_ | grep -i iqr
    yields nothing so I'm not sure if it's acceptable. Typically it's board that assigns
    IRQ and not device, for Sysbus devices (see: sysbus_init_irq/sysbus_connect_irq).
    So I'd leave it upto Paolo or someone else to decide/comment on.

> 
> >>
> >> Paolo
> >>  
> >  
> 


