Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC20C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A7420702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOfjYAUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A7420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1Uf-0000Ma-Nk
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iv1U4-0008ED-N4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iv1U3-0004YN-93
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:07:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iv1U3-0004XA-5q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579882018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OD6EmgVRI606kaR3df7L7ceXBYGNXrBYq3J7BJX4dU=;
 b=EOfjYAUdfvcWo7kEdLcqVVhIXELUcM5goTrW3VuXklX9wtBEDKhk6Tpirt5X09aqrnUAwt
 NoSKpupAp+zjUgk2EdhijqdLD6qUsKY6sOSKcudExAiKs/4S8K1vGcXrAXqwuibVUagMjr
 oX3L6jLlv9Ct12TSgD8lOrI4FtQ3w/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-GkHPOsdPN4ict0Gbpc1i6g-1; Fri, 24 Jan 2020 11:06:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE4BA192C0A5;
 Fri, 24 Jan 2020 16:06:48 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7447B4DA0D;
 Fri, 24 Jan 2020 16:06:47 +0000 (UTC)
Date: Fri, 24 Jan 2020 17:06:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [Question] Regarding containers
 "unattached/peripheral/anonymous" - their relation with hot(un)plug of
 devices
Message-ID: <20200124170645.3d794ac6@redhat.com>
In-Reply-To: <77dbc712482545078986adcd72567630@huawei.com>
References: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
 <20200124145404.1d15209e@redhat.com>
 <77dbc712482545078986adcd72567630@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GkHPOsdPN4ict0Gbpc1i6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 15:02:10 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: Friday, January 24, 2020 1:54 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> > 
> > On Fri, 24 Jan 2020 11:20:15 +0000
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> >   
> > > Hello,
> > > I am working on vCPU Hotplug feature for ARM64 and I am in mid of understanding
> > > some aspect of device_add/device_del interface of the QEMU.
> > >
> > > Observations:
> > > 1. Any object initialised by qmp_device_add() gets into /machine/unattached
> > > container. I traced the flow to code leg inside  device_set_realized()
> > > 2. I could see the reverse qmp_device_del() expects the device to be in
> > > /machine/peripheral container.
> > > 3. I could see any object initially added to unattached container did not had
> > > their parents until object_add_property_child() was called further in the leg.
> > > which effectively meant a new property was created and property table
> > > populated and child was parented.
> > > 4. Generally, container  /machine/peripheral was being used wherever
> > > DEVICE(dev)->id was present and non-null.
> > >
> > > Question:
> > > 1. Wanted to confirm my understanding about the use of having separate
> > > containers like unattached, peripheral and anonymous.  
> >   
> > > 2. At init time all the vcpus goes under *unattached* container. Now,
> > > qmp_device_del() cannot be used to unplug them. I am wondering  
> > 
> > device is put into 'unattached' in case it wasn't assigned a parent.
> > Usually it happens when board creates device directly.  
> 
> 
> Sure, but if we decide that certain number(N) of vcpus are hotplugabble
> and certain subset of N (say 'n' < 'N') should be allowed to be present
> or cold-plugged at the init time then I wonder which of the following
> is correct approach:
> 
> 1. Bring all of N vcpus at boot time under "peripheral" container
>                                    OR
> 2. Just bring subset 'n' of 'N' under "peripheral" container and rest
>     under "unattached" container? And later as and when rest of the
>     vcpus are hotplugged they should be transferred from "unattached"
>     container to "peripheral" container?

issue with that is that to put device into "peripheral" container,
'the user' must provide 'id'. (currently QEMU isn't able to do it on its own [1])

But it doesn't mean that cold-plugged CPUs can't be unpluged.
What current users could do is start QEMU like this (simplified version):

 $QEMU -smp 1,maxcpus=N -device foo-cpu-type,id=CPU00 -device foo-cpu-type,id=CPU01 ...

i.e. 1st CPU is not manageable due to lack if 'id' and is created by board code,
the rest have 'id' and could be managed.


Question is:
  why you are looking into 'what container' is used for CPUs?


1) here is what I could find on IDs topic
   https://lists.gnu.org/archive/html/qemu-block/2015-09/msg00011.html
 
> > >    if all the hotplug devices need to go under the *peripheral* container while
> > > they are hotplugged and during object init time as well?  
> > 
> > theoretically device_del may use QOM path (the later users can get with
> > query-hotpluggable-cpus),
> > but I think it's mostly debugging feature.  
> 
> 
> Sure.
> 
> 
> > users are supposed to specify 'id' during -device/device_add if they are going
> > to manage that device.
> > afterwards (like unplugging it). Then they could use that 'id' in other commands
> > (including device_del)
> > 
> > So 'id'-ed devices end up in 'peripheral' container.  
> 
> 
> Sure, what if hotplugged device is removed and then added again? It looks 
> qmp_device_add() interface will again end up calling the device_set_realized()
> which eventually would put hotplugged devices under "unattached" container?

it won't, see call chain:

  qmp_device_add()
      -> qdev_device_add()
          -> qdev_set_id()

 
> > > 3. I could not see any device being place under *anonymous* container during  
> > init time. What is the use of this container?
> > 
> > if I recall it right, devices created with help of device_add but without 'id'
> > go to this container  
> 
> 
> Any examples on top of your head where such an interface might be of use?

ex:
one could use -device/device_add without any ids if such devices aren't planned
to be unplugged during runtime or for unpluggable devices

> 
> 
> Many thanks
> Salil.
>


