Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195C8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FFB20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8CTKu8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FFB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhJZ-00011k-In
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvhIM-0000Jv-3H
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:17:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53018
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvhIJ-0006vP-UH
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594819074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99fIbDFpOjpEY5XdPL6ROGsRjo9oSHgCFVr/4G443rI=;
 b=i8CTKu8najs049Z8/ZAM5V8gY3E/bJT2oq3GJdUjFg9QCjzT2HWC0koN7RR2S36a3mw75n
 4tb51cnQ2WlPioEVm9D+bTUTeQiPs5DwY2/3BczuJNvYqoZ2m7cm0H3u3tVhOpAmBuIgol
 +PSf2jErTWBTSXhY9isJIWusCoBLr7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-obVLDf2AOJCPHTeVCCiL5A-1; Wed, 15 Jul 2020 09:17:52 -0400
X-MC-Unique: obVLDf2AOJCPHTeVCCiL5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E5D3C746A;
 Wed, 15 Jul 2020 13:17:51 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0797852C;
 Wed, 15 Jul 2020 13:17:24 +0000 (UTC)
Date: Wed, 15 Jul 2020 15:17:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC PATCH 3/5] hw/i386/acpi-build: Add ACPI PCI hot-plug
 methods to q35
Message-ID: <20200715151720.21789077@redhat.com>
In-Reply-To: <20200715065751.ogchtdqmnn7cxsyi@sirius.home.kraxel.org>
References: <20200708224615.114077-1-jusual@redhat.com>
 <20200708224615.114077-4-jusual@redhat.com>
 <20200713163954.565722a5@redhat.com>
 <20200715065751.ogchtdqmnn7cxsyi@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org, "Michael S.
 Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 08:57:51 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, Jul 13, 2020 at 04:39:54PM +0200, Igor Mammedov wrote:
> > On Thu,  9 Jul 2020 00:46:13 +0200
> > Julia Suvorova <jusual@redhat.com> wrote:
> >   
> > > Implement notifications and gpe to support q35 ACPI PCI hot-plug.
> > > The addresses specified in [1] remain the same to make fewer changes.
> > > 
> > > [1] docs/spec/acpi_pci_hotplug.txt  
> > 
> > CCing Gerd his opinion on reusing piix4 IO port range for q35  

[...]

> While being at it:  Shouldn't we reserve these port ranges somehow?
> Using an acpi device for example, simliar to fw_cfg?  The guest OS
> should better know there is something at those ports ...

we do it at ACPI level in DSDT, look for comment
/* reserve PCIHP resources */

It should make Windows trip over in case of another range overlap with
reserved ports. (linux kernel is more tolerant and may silently ignore
or print a warning) 

> take care,
>   Gerd
> 


