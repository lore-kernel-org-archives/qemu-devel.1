Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98333C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6528620659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMLd2QaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6528620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGZ4-0004w7-0L
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1idFKq-0000aJ-Eq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1idFKo-000323-8e
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:15:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1idFKm-0002xp-69
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575645353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vB2XuMyXHgayaNhAykaVXV3mvyry3p+Gq7ct1f4QJaQ=;
 b=FMLd2QaXFqdz6n2qxFI+ffor1iddeBJ2d8XeCvhf+quzYMO01mFEmp6+/xgnm1c+wHDYxm
 Sw1vwaKbYKog9TUkpFroeLrMy5apxemX1I90QO6g0/egTiTfVf97cuBzzEAOiHEwi48ssF
 Fl5Ay9lhzFWr14/0Q+JL/zHC5BQZFr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-a_ZFk2OoOYKeNo8FC4Q9Gg-1; Fri, 06 Dec 2019 10:15:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2340E107ACC4
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 15:15:50 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71F9819C70;
 Fri,  6 Dec 2019 15:15:42 +0000 (UTC)
Date: Fri, 6 Dec 2019 16:15:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH for-5.0 7/8] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
Message-ID: <20191206161540.1664aace@redhat.com>
In-Reply-To: <34d3e078-f4e5-149e-a8ef-798d524f53a5@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-8-git-send-email-imammedo@redhat.com>
 <34d3e078-f4e5-149e-a8ef-798d524f53a5@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: a_ZFk2OoOYKeNo8FC4Q9Gg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Dec 2019 14:03:01 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 12/04/19 18:05, Igor Mammedov wrote:
> > Extend CPU hotplug interface to return architecture specific
> > identifier for current CPU in 2 registers:
> >  - lower 32 bits existing ACPI_CPU_CMD_DATA_OFFSET_RW
> >  - upper 32 bits in new ACPI_CPU_CMD_DATA2_OFFSET_R at
> >    offset 0.  
> 
> OK.
> 
> > Target user is UEFI firmware, which needs a way to enumerate
> > all CPUs (including possible CPUs) to allocate and initialize
> > CPU structures on boot.  
> 
> (1) This is correct in general, but if we want to keep this description,
> then it should be moved to the commit message of the previous patch.
> CPHP_GET_CPU_ID_CMD is not needed for the purpose described above -- it
> will be necessary for handling the hotplug SMI.
> 
> For the boot time allocation / initialization, the "enumerating present
> and possible CPUs" workflow is necessary, and that is documented in the
> previous patch in this series.
> 
> So if we want to keep this paragraph, we should move it to the previous
> patch's commit message.
> 
> > (for x86: it needs APIC ID and later command will be used to
> > retrieve ARM's MPIDR which serves the similar to APIC ID purpose)  
> 
> (2) I would suggest some punctuation, to make this clearer. How about:
> 
> > On x86, guest UEFI firmware will use CPHP_GET_CPU_ID_CMD for fetching
> > the APIC ID when handling the hotplug SMI.
> >
> > Later, CPHP_GET_CPU_ID_CMD will be used on ARM to retrieve MPIDR,
> > which serves a purpose similar to the x86 APIC ID.

How about following commit message:

    Firmware can enumerate present at boot APs by broadcasting wakeup IPI,
    so that woken up secondary CPUs could register them-selves.
    However in CPU hotplug case, it would need to know architecture
    specific CPU IDs for possible and hotplugged CPUs so it could
    prepare enviroment for and wake hotplugged AP.
    
    Reuse and extend existing CPU hotplug interface to return architecture
    specific ID for currently selected CPU in 2 registers:
     - lower 32 bits in ACPI_CPU_CMD_DATA_OFFSET_RW
     - upper 32 bits in ACPI_CPU_CMD_DATA2_OFFSET_R
    
    On x86, firmware will use CPHP_GET_CPU_ID_CMD for fetching the APIC ID
    when handling hotplug SMI.
    
    Later, CPHP_GET_CPU_ID_CMD will be used on ARM to retrieve MPIDR,
    which serves the similar to APIC ID purpose.

[...]


