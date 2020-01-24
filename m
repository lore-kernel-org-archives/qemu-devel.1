Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3467EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EF320718
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEixOQEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EF320718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzQK-0003nF-6q
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuzPc-0003Ob-9R
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuzPb-0004O1-6I
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:54:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuzPb-0004Nr-2Q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579874054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zI8GZHtk1brZrDKZjkILvYha8suWt+XwEPRXOUiX3wk=;
 b=gEixOQEkFQ9RjdupSyjRGUu2LRNQUGKXUZlLkuq9a3K0rTGaPXNxD6dcgYJNovTeWPqcFu
 3+WKvT5xORspiye5U9vA1HKhK9BH+0xb39QBpvPTXNUxBMRJV11UXHiGP2VLcqMR873opi
 4f9a2XQUPAyiv1KDFrCOX+malLPZw3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-d8TtE3xtOGW2EosK3JPa_A-1; Fri, 24 Jan 2020 08:54:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C2EA8010C9;
 Fri, 24 Jan 2020 13:54:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 828005DA76;
 Fri, 24 Jan 2020 13:54:06 +0000 (UTC)
Date: Fri, 24 Jan 2020 14:54:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [Question] Regarding containers
 "unattached/peripheral/anonymous" - their relation with hot(un)plug of
 devices
Message-ID: <20200124145404.1d15209e@redhat.com>
In-Reply-To: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
References: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: d8TtE3xtOGW2EosK3JPa_A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: pbonzini <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 11:20:15 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hello,
> I am working on vCPU Hotplug feature for ARM64 and I am in mid of understanding some aspect of device_add/device_del interface of the QEMU.
> 
> Observations:
> 1. Any object initialised by qmp_device_add() gets into /machine/unattached container. I traced the flow to code leg inside  device_set_realized()
> 2. I could see the reverse qmp_device_del() expects the device to be in  /machine/peripheral container.
> 3. I could see any object initially added to unattached container did not had their parents until object_add_property_child() was called further in the leg.
>     which effectively meant a new property was created and property table populated and child was parented.
> 4. Generally, container  /machine/peripheral was being used wherever DEVICE(dev)->id was present and non-null.
> 
> Question:
> 1. Wanted to confirm my understanding about the use of having separate containers like unattached, peripheral and anonymous.

> 2. At init time all the vcpus goes under *unattached* container. Now, qmp_device_del() cannot be used to unplug them. I am wondering

device is put into 'unattached' in case it wasn't assigned a parent.
Usually it happens when board creates device directly.

>    if all the hotplug devices need to go under the *peripheral* container while they are hotplugged and during object init time as well?

theoretically device_del may use QOM path (the later users can get with query-hotpluggable-cpus),
but I think it's mostly debugging feature.

users are supposed to specify 'id' during -device/device_add if they are going to manage that device
afterwards (like unplugging it). Then they could use that 'id' in other commands (including device_del)

So 'id'-ed devices end up in 'peripheral' container

> 3. I could not see any device being place under *anonymous* container during init time. What is the use of this container?

if I recall it right, devices created with help of device_add but without 'id' go to this container


> 
> I would be thankful for your valuable insights and answers and help in highlighting any gap in my understanding.
> 
> Thanks in anticipation!
> 
> Best Regards
> Salil
> 


