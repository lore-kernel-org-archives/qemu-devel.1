Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC22EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9723020775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6FVEWl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9723020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkH3-0004E4-NO
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jGkFd-0002W8-Gc
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jGkFb-0008T4-VR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:09:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jGkFb-0008RT-QY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585058990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bbn+fYkrC9qHY9BZTC/0khbeSR26eUGhkO2vuStDI4o=;
 b=J6FVEWl/d6iAtfOLiDSLxUn+4IP9UEbGLo38EzIPqq7ojed9Pa/nDfi3i6j2Zm+cUfUWxb
 9VjAOkG9xZf6S1wtQxWFlkl5NEwjaemTw5h16JvVT6/Ty3dy6gKV9Ue0aFClAnjrpkxtvT
 84ifgdl7WzQ9WJqDsaugkACXYNmeVPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-mM4d6S6_PlCuM_85bIoO5g-1; Tue, 24 Mar 2020 10:09:49 -0400
X-MC-Unique: mM4d6S6_PlCuM_85bIoO5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61D93107ACC7;
 Tue, 24 Mar 2020 14:09:48 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC5C819C6A;
 Tue, 24 Mar 2020 14:09:37 +0000 (UTC)
Date: Tue, 24 Mar 2020 15:09:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani.sinha@nutanix.com>
Subject: Re: Hot unplug disabling on pci-pci bridge
Message-ID: <20200324150935.4bfe8464@redhat.com>
In-Reply-To: <95F47446-8E5E-4CF1-A076-24D714F7A827@nutanix.com>
References: <BF9E6F48-E047-4D1B-BEF1-A58024DE0C6E@nutanix.com>
 <20200324120828.2b50d41e@redhat.com>
 <95F47446-8E5E-4CF1-A076-24D714F7A827@nutanix.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 11:49:53 +0000
Ani Sinha <ani.sinha@nutanix.com> wrote:

> > On Mar 24, 2020, at 4:38 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > question is do you need to disable only unplug side both
> > (plug+unplug) operations (like we did with PCIE)?  
> 
> I need to disable the unplug side only.

I don't know  about SHPC (i.e you probably can only have both or none)

For ACPI hotplug it should be possible to hack current impl.,
one would need to remove _EJ0->PCEJ methods.
That should hide ability to eject device in Windows but IO ports
will still be there so malicious guest will still be able to eject device.

But I'd emulate real hardware behavior where one would have plug+unplug
or none or disable acpi pci hotplug globally for VM.


> 
> Ani
> 
> 


