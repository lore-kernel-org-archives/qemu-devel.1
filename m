Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB731C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F75920663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F75920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg59a-0006tc-Cj
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47089)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hg4ww-0004rN-WE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hg4wv-0004LU-Pq
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:14:46 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hg4wq-0003j1-TB
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:14:41 -0400
Received: by mail-wm1-f49.google.com with SMTP id w9so4266318wmd.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 03:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B2pU4TWo/bR51g7Wxh79Ied5ngUN7ijs23qJYlIUjP8=;
 b=ANy0DWpzRf2As+xMNOcMS+uS6aW7j944eleWihQw8aKdhcGLbf5tY8yx4JEdHGnijB
 Tvj4YdjPtx9WK27Tk7EmjUx/OXfFKrNES3DkDZzlQo/6em2SRR6Hrdx/8ZUBeWj3bnUY
 t3WvkxPxtnenLFPi/0sWsiXMlO2cWdETxe3SgZY0AJNyZW14VOYL3fmwPctgZlskpGJY
 5vNY+Oyr+jnKAlze+jJGjHHnfyVRAFPhBZhMqqbaqXxlXzZ5FEvW7t+0P7LIjxKNLgkX
 685JTXfZBhuSA9TqGIdQrhW8hFJq6eUVHH5U2c4zG67+Ewro8MJ1QGrSL7yFerQz+yF2
 RHig==
X-Gm-Message-State: APjAAAWDFcny56WSXkx8kloSSYrk6dAPJYzyyt3AUvKrOUvs8WJYS8zw
 z6Ul2Hp/npyfCjKpjKrn+cp5+A==
X-Google-Smtp-Source: APXvYqzhAqHBEe2TFlBRzRbYRxKxwyITG6KsT0si4UJ6stoc7oejuGBP6+7PzEM+sos5C1iC56NbeA==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr2152400wmc.13.1561544056623; 
 Wed, 26 Jun 2019 03:14:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e88d:856c:e081:f67d?
 ([2001:b07:6468:f312:e88d:856c:e081:f67d])
 by smtp.gmail.com with ESMTPSA id z5sm14413675wrh.16.2019.06.26.03.14.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 03:14:15 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190617081205.GA26990@apples.localdomain>
 <c754211f-b41d-4b69-585b-b287fb776d81@redhat.com>
 <20190624080154.GA4263@apples.localdomain>
 <20190624101828.GC12855@linux.fritz.box>
 <3571317f-84c2-8649-ba63-0e6508679b05@redhat.com>
 <87wohajjq6.fsf@dusky.pond.sub.org>
 <20190625164726.GB21148@apples.localdomain>
 <87o92lkl6x.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d94d5af-002a-d079-4e23-8a8b06c11152@redhat.com>
Date: Wed, 26 Jun 2019 12:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87o92lkl6x.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.49
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] nvme: how to support multiple
 namespaces
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/19 06:46, Markus Armbruster wrote:
>> I'm not sure how to wire it together without the bus abstraction? So
>> I'll stick with the bus for now. It *is* extremely convenient!
> 
> As far as I can tell offhand, a common use of bus-less connections
> between devices is wiring together composite devices.  Example:
> 
>     static void designware_pcie_host_init(Object *obj)
>     {
>         DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(obj);
>         DesignwarePCIERoot *root = &s->root;
> 
>         object_initialize_child(obj, "root",  root, sizeof(*root),
>                                 TYPE_DESIGNWARE_PCIE_ROOT, &error_abort, NULL);
>         qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
>         qdev_prop_set_bit(DEVICE(root), "multifunction", false);
>     }
> 
> This creates a TYPE_DESIGNWARE_PCIE_ROOT device "within" the
> TYPE_DESIGNWARE_PCIE_HOST device.
> 
> Bus-less connections between separate devices (i.e. neither device is a
> part of the other) are also possible.  But I'm failing at grep right
> now.  Here's an example for connecting a device to a machine:
> 
>     static void mch_realize(PCIDevice *d, Error **errp)
>     {
>         int i;
>         MCHPCIState *mch = MCH_PCI_DEVICE(d);
> 
>         [...]
>         object_property_add_const_link(qdev_get_machine(), "smram",
>                                        OBJECT(&mch->smram), &error_abort);
>         [...]
>     }

This is a link to a memory region.  A connection to a separate device
can be found in hw/dma/xilinx_axidma.c and hw/net/xilinx_axienet.c,
where you have

         data stream <------------> data stream
       /                                        \
   dma                                            enet
       \                                        /
         control stream <------> control stream

where the horizontal links in the middle are set up by board code, while
the diagonal lines on the side are set up by device code.

> Paolo, can you provide guidance on when to use a bus, and when not to?

I would definitely use a bus if 1) it is common for the user (and not
for machine code) to set up the connection 2) the relationship is
parent-child.  Link properties are basically unused on the command line,
and it only makes sense to make something different if the connection is
some kind of graph so bus-child does not cut it.

Paolo

