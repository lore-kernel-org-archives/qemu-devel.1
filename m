Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32824C2D0E7
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0101C2073B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUaFCFgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0101C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJXUo-0007iH-49
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 03:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1jJXU5-0007H2-2a
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1jJXU4-0003Nz-3O
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:08:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1jJXU3-0003Me-Vz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585724899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXFKGUcpEntEa0/2+0P2cXbXVfVdtf0kK7YKg3k5Nvw=;
 b=XUaFCFgqEGhyVCXk0EBg9+5seBRlDRn71vTE5R9Bfjkq7A/Q87E83qqTNXTCcq9pnKTA0/
 xefVRr3J/8NzXXAJDhcEQxi85AjDL3TmcWG1F6PxtGS6FAXaf4rDoegfUvY2wf181rJj9Y
 Bd0J2SmUaCyOMbQXWPPo0bBwVIxtGY8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-hN8FVMXOOdemgqqZd6OYhg-1; Wed, 01 Apr 2020 03:08:17 -0400
X-MC-Unique: hN8FVMXOOdemgqqZd6OYhg-1
Received: by mail-wm1-f71.google.com with SMTP id l13so1332524wme.7
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 00:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=padfdPEehzjHA1VcUON+cBcmCSreihSsNPT/otSx1EU=;
 b=EsIAzv5HzoRoRGBhhYcEKvtJTOcD4zqwZXFSka0b3gjwKz3sPeaad7lounLQOeuWtL
 PaO1yrNP+BIl6dCjKK6UgzKTnzbB4Get4DvSupSuFITC7TU2NgDvUUK0gu3FHxtw6uLK
 a0W472XlkrAJ9LC/+0g4Wxqx8xjTJuXTJC8fYK7WecE2gCAyj3/vExaQ0u2XfhIXnCvJ
 V0BXWP293xTwNPxcQTCqrVDPrEGBOdXGDeIA3YVLaNy03VtrD5MjAqxmxO2VS3wAK0kN
 k1ZNenVFeddijoTj3g0vDDY5gY9ukQ3LR1tyYBYwW5cCEoPLP8jUqM09J1+OTdIyDNWk
 ypIw==
X-Gm-Message-State: ANhLgQ0tUGr0bt3gAPNC+5kj4By7vd6WB+IlSRaUnoMCG6RvXSMahVJP
 UyftMosXatJtmsxLEt9AEJQdkeI372b6v52EGtwhTc+stVtapeMbVNIrQB6LDgdsPjqV0kAt+qr
 7zQv7VK7H7Wa37U4=
X-Received: by 2002:adf:ff82:: with SMTP id j2mr23510987wrr.48.1585724896151; 
 Wed, 01 Apr 2020 00:08:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvCKG857+HQTFfUgMpH18wQV3sqLWvFyHKOh456oII1zJXEUB/3Kdt2crW63Sly5X/VUwcNcw==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr23510968wrr.48.1585724895944; 
 Wed, 01 Apr 2020 00:08:15 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id n124sm1475093wma.11.2020.04.01.00.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 00:08:15 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
In-Reply-To: <20200331172640.GE2896@work-vm>
References: <20200331162752.1209928-1-vkuznets@redhat.com>
 <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>
 <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
 <BY5PR11MB3960FE6E5F51F95EF9DFAAAB9AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
 <20200331172640.GE2896@work-vm>
Date: Wed, 01 Apr 2020 09:08:13 +0200
Message-ID: <874ku31y5e.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Montes,
 Julio" <julio.montes@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> So you would think that would tkae care of RDSEED exiting - but what
> about VMCS shadowing?
>

SECONDARY_EXEC_SHADOW_VMCS is special, we are able to emulate it in KVM
even when it is not supported by hardware, see
nested_vmx_setup_ctls_msrs():

=09/*
=09 * We can emulate "VMCS shadowing," even if the hardware
=09 * doesn't support it.
=09 */
=09msrs->secondary_ctls_high |=3D
=09=09SECONDARY_EXEC_SHADOW_VMCS;

--=20
Vitaly


