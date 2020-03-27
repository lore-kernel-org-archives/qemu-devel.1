Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5966FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252FA206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqL9cKsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252FA206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHpdO-0005lV-Aj
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 10:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHpcl-00052p-2b
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHpcj-0003Gb-Le
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:06:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHpcj-0003Dj-Gr
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585317972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDI7Dw1+2Nv0M9U/UMl9cIxYRYKqgiRS8IybhaFcF0c=;
 b=cqL9cKsuxqpd5JvPVEg7XCeniXmiYqMeEUUYGOd2IKfMJ16UFELKM7eofAmOJge2cPCHEO
 WrjGCItuL3NXuQEB2Vg0qnjf4W/RYAM1F7wQxo+VyIue8lxI2puQG+/CZ9Tlrzz+i/Gkjo
 5wNoNcDanyIe1VH95awYyjvnos6Q+CA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-TWC0Z_UXOgmLPMGTSIymDQ-1; Fri, 27 Mar 2020 10:06:09 -0400
X-MC-Unique: TWC0Z_UXOgmLPMGTSIymDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A59800D4E;
 Fri, 27 Mar 2020 14:06:08 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AD8A5DA81;
 Fri, 27 Mar 2020 14:05:55 +0000 (UTC)
Date: Fri, 27 Mar 2020 15:05:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200327150530.3b0e178f@redhat.com>
In-Reply-To: <20200327120628.imoivpn3naj562xo@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200325133212.6fd0fefb@redhat.com>
 <20200325150339.7kqibe5cfkzxhtzr@sirius.home.kraxel.org>
 <20200325194434.58b50148@redhat.com>
 <20200327120628.imoivpn3naj562xo@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 13:06:28 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > I just quickly hacked hw-reduced acpi (using arm/virt as model)  
> 
> Can you send the patch or push a branch nevertheless?
It's no suitable for patch but I pushed it to my github repo

https://github.com/imammedo/qemu.git microvm_acpi

I just copy-pasted a bunch of code for test.

from cleanup point of view

we probably can generalize acpi_ram_update/acpi_build_update/acpi_build_reset/AcpiBuildState
across arm/pc/microvm and make a shared acpi_setup for arm + microvm
somewhere in hw/acpi/

the rest of common with pc things, I've copy-pasted, could be moved
to hw/i386/x86_acpi.c and I'd rename acpi-build.c to pc_acpi.c to make naming consistent

> 
> thanks,
>   Gerd
> 


