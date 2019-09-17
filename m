Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4A6C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1447C2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1447C2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADLy-00089F-5b
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iADGU-000486-8X
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iADGQ-0005zs-TP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:11:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iADGQ-0005yr-NJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:11:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90F85C060202;
 Tue, 17 Sep 2019 13:11:25 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4CED752D2;
 Tue, 17 Sep 2019 13:11:22 +0000 (UTC)
Date: Tue, 17 Sep 2019 15:11:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Laszlo Ersek" <lersek@redhat.com>
Message-ID: <20190917151121.41a199dc@redhat.com>
In-Reply-To: <8ed1ab55-d5ee-9703-dd28-cf50fbda5408@redhat.com>
References: <add488d0-df13-830f-28c5-c7232ccb741f@redhat.com>
 <20190905154925.30478-1-imammedo@redhat.com>
 <dbe8cc44-ef30-3104-2bd3-6a6fe4438ada@redhat.com>
 <20190910175841.176b26e4@redhat.com>
 <8ed1ab55-d5ee-9703-dd28-cf50fbda5408@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 17 Sep 2019 13:11:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [edk2-devel] [PATCH] q35: lpc: allow to lock down
 128K RAM at default SMBASE address
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, jiewen.yao@intel.com,
 jun.nakajima@intel.com, michael.d.kinney@intel.com, pbonzini@redhat.com,
 boris.ostrovsky@oracle.com, rfc@edk2.groups.io, joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 19:30:46 +0200
"Laszlo Ersek" <lersek@redhat.com> wrote:

> On 09/10/19 17:58, Igor Mammedov wrote:
> > On Mon, 9 Sep 2019 21:15:44 +0200
> > Laszlo Ersek <lersek@redhat.com> wrote:  
> 
> [...]
> 
> > It looks like fwcfg smi feature negotiation isn't reusable in this case.
> > I'd prefer not to add another device just for another SMI feature
> > negotiation/activation.  
> 
> I thought it could be a register on the new CPU hotplug controller that
> we're going to need anyway (if I understand correctly, at least).
If we don't have to 'park' hotplugged CPUs, then I don't see a need for
an extra controller.


> But:
> 
> > How about stealing reserved register from pci-host similar to your
> > extended TSEG commit (2f295167 q35/mch: implement extended TSEG sizes)?
> > (Looking into spec can (ab)use 0x58 or 0x59 register)  
> 
> Yes, that should work.
> 
> In fact, I had considered 0x58 / 0x59 when looking for unused registers
> for extended TSEG configuration:
> 
> http://mid.mail-archive.com/d8802612-0b11-776f-b209-53bbdaf67515@redhat.com
> 
> So I'm OK with this, thank you.
Thanks for the tip!
... patches with a stolen register are on the way to mail-list.



