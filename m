Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905F3C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC072081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQCMkYdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC072081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56965 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irljM-0000hl-Iz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irlhp-0007Qk-45
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irlhl-00074L-7J
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:39:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irlhl-000742-3J
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579106380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJ4Z5YRPzkg1zPbSaw71a/0MWwD5LEv3ibRX91MX2wI=;
 b=OQCMkYdRP0KhFGWcLcBqASHWmXpGcQmrsK7ji9AXRNuVmy2YbxjR6cmONWFahENPs7ZVM5
 hC0QWF/Li267SnAy8l2W6/dznXx8HpZSqVj6+hS0FeAQWMOkCusr1UHc2M3tBsiM9XhYw8
 96FIVqoEmKmb4aNG8WfAKDkYI7uZ5lE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-OF9kuqtUOWWN6sxjP1yDPQ-1; Wed, 15 Jan 2020 11:39:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1534919586C7
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 16:39:38 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D5DB5DDAA;
 Wed, 15 Jan 2020 16:39:37 +0000 (UTC)
Date: Wed, 15 Jan 2020 17:39:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/86] machine: introduce ram-memdev property
Message-ID: <20200115173935.0a527c9a@redhat.com>
In-Reply-To: <80dae4c8-a902-4f9e-9878-95b69f9390df@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-3-git-send-email-imammedo@redhat.com>
 <80dae4c8-a902-4f9e-9878-95b69f9390df@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: OF9kuqtUOWWN6sxjP1yDPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 16:56:30 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 15/01/20 16:06, Igor Mammedov wrote:
> >  
> > +    object_property_add_link(obj, "ram-memdev", TYPE_MEMORY_BACKEND,
> > +                             (Object **)&ms->ram_memdev,
> > +                             object_property_allow_set_link,
> > +                             OBJ_PROP_LINK_STRONG, &error_abort);
> > +    object_property_set_description(obj, "ram-memdev",
> > +                                    "Set RAM backend"
> > +                                    "Valid value is ID of hostmem based backend",
> > +                                     &error_abort);
> > +  
> 
> Obligatory bikeshedding, why not just ram (the MachineState field can
> remain "ram_memdev").  Or memory-backend matching the QOM type names.

I'd say it was inspired by "-numa node,memdev" option for some sort of consistency.
But I'm fine with any other name as far as there is consensus.
If I had to choose between 'ram' and 'memory-backend', I'd go for the later.


> 
> Paolo
> 


