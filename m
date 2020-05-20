Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27154C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4160207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HI1b1JZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4160207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLyt-0002RW-3l
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbLxw-0001ZE-Bx
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:28:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbLxu-0000YF-9T
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589970524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vt8rXZC5HzxKtvxdS8o24FqMNV3ejlzzDCbmFdRoygE=;
 b=HI1b1JZwu8c69gVE+eaNKN77CorQFqpvH4Y0ycq2BlSiItwkpkXWEFrF4qVWsjLoI+TPl8
 xErWrQKdL4sybZE14gtvAfU1npkhDDH8ChZgz3FlgWUXJUZn5QRgMEfh4EzYBC3jNbRod7
 Sf2vpyZp66lq8fchtLro/7owSpPum/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-lkM5CSyuP5KvENo3NnhOfA-1; Wed, 20 May 2020 06:28:42 -0400
X-MC-Unique: lkM5CSyuP5KvENo3NnhOfA-1
Received: by mail-wm1-f72.google.com with SMTP id f9so1047022wml.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 03:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vt8rXZC5HzxKtvxdS8o24FqMNV3ejlzzDCbmFdRoygE=;
 b=Kk4exbw/gwddwpJ7fo9WVnIaIlFUkEkqhfsWTVDkgC3jLqU7xJ7nP96pSSYgd8cNqp
 bHqxMsbecKkoLy70qawgX3p8X7U/5wVPYlI097dEcOnaLur7djIKITtsa19UoVsN4+3r
 sD7I19Ws2BYaTxuDRWnMax6GnXbioLKgwz0bxfbsiQTXCcCi2HYkYnYQ7KhC756Lnn9V
 qClfJTZhALNHkqFvDlFizVH1WG0dBtpEeaI93aS/36ANuRr8+T+7S0crbeydffqmce32
 NQDqzX2J5b0hFm0oN/8s51OEy3TZ3a09lcTz4FTxV91ZraQ8sPj2SP7uH7I5SRz36VEw
 Zafw==
X-Gm-Message-State: AOAM533c2n9/wY3/hiQxLtY7tE5NZ9kspU+AP5EjsW+S/IbVLUkilLLA
 wqP0Hq8yW7OhsOUsw5kbpLpE8JxwdKq8QK+XPIwGqY42bvl+CQDgxyw6jGpZqQj2TygvMnfV+lA
 cQGA0DymmiMWGQDI=
X-Received: by 2002:a7b:c201:: with SMTP id x1mr3962029wmi.14.1589970521215;
 Wed, 20 May 2020 03:28:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrFGqe/i6YKfFDbEECwrG6VWF/epv0PkQyYUnFk5Fj0T4ARX30pKQRP8bQ12LBqlVvE7xzhw==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr3962014wmi.14.1589970520925;
 Wed, 20 May 2020 03:28:40 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 t129sm3043661wmg.27.2020.05.20.03.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 03:28:40 -0700 (PDT)
Date: Wed, 20 May 2020 06:28:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedow <imammedo@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200520060645-mutt-send-email-mst@kernel.org>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200511205352.05ff541a@redhat.com>
 <9941B800-BBEF-4DF8-BEE0-EC39D2A20D98@nutanix.com>
 <20200513214312.0dfa4752@redhat.com>
 <7FF83CE8-F25A-4458-80A7-EAA6296EF175@nutanix.com>
 <20200520114354.1982cb63@nas.mammed.net>
 <20200520054714-mutt-send-email-mst@kernel.org>
 <20200520115626.6a2a2355@nas.mammed.net>
MIME-Version: 1.0
In-Reply-To: <20200520115626.6a2a2355@nas.mammed.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ani Sinha <ani@anisinha.ca>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 11:56:26AM +0200, Igor Mammedow wrote:
> On Wed, 20 May 2020 05:47:53 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, May 20, 2020 at 11:43:54AM +0200, Igor Mammedow wrote:
> > > On Fri, 15 May 2020 12:13:53 +0000
> > > Ani Sinha <ani.sinha@nutanix.com> wrote:
> > >   
> > > > > On May 14, 2020, at 1:13 AM, Igor Mammedov <imammedo@redhat.com>
> > > > > wrote:   
> > > > >> 
> > > > >>     
> > > > >>> Will following hack work for you?
> > > > >>> possible permutations
> > > > >>> 1) ACPI hotplug everywhere
> > > > >>> -global PIIX4_PM.acpi-pci-hotplug=on -global
> > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on -device
> > > > >>> pci-bridge,chassis_nr=1,shpc=doesnt_matter -device
> > > > >>> e1000,bus=pci.1,addr=01,id=netdev1 
> > > > >>> 
> > > > >>> 2) No hotplug at all
> > > > >>> -global PIIX4_PM.acpi-pci-hotplug=off -global
> > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on -device
> > > > >>> pci-bridge,chassis_nr=1,shpc=off -device
> > > > >>> e1000,bus=pci.1,addr=01,id=netdev1
> > > > >>> 
> > > > >>> -global PIIX4_PM.acpi-pci-hotplug=off -global
> > > > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off -device
> > > > >>> pci-bridge,chassis_nr=1,shpc=doesnt_matter  -device
> > > > >>> e1000,bus=pci.1,addr=01,id=netdev1      
> > > > >> 
> > > > >> Given that my patch is not acceptable, I’d prefer the
> > > > >> following in the order of preference:
> > > > >> 
> > > > >> (a) Have an option to disable hot ejection of PCI-PCI bridge so
> > > > >> that Windows does not even show this HW in the “safely remove
> > > > >> HW” option. If we can do this then from OS perspective the GUI
> > > > >> options will be same as what is available with PCIE/q35 - none
> > > > >> of the devices will be hot ejectable if the hot plug option is
> > > > >> turned off from the PCIE slots where devices are plugged into.
> > > > >> I looked at the code. It seems to manipulate ACPI tables of
> > > > >> the empty slots of the root bus where no devices are attached
> > > > >> (see comment "/* add hotplug slots for non present devices */
> > > > >> “). For cold plugged bridges, it recurses down to scan the
> > > > >> slots of the bridge. Is it possible to disable hot plug for
> > > > >> the slot to which the bridge is attached?    
> > > > > 
> > > > > I don't think it's possible to have per slot hotplug on
> > > > > conventional PCI hardware. it's per bridge property.    
> > > > 
> > > > We add the AMLs per empty slot though. When the pic bridge is
> > > > attached, we do nothing, just recurse into the bridge slots. That
> > > > is what I was asking, if it was possible to just disable the AMLs
> > > > or use some tricks to say that this particular slot is not
> > > > hotpluggable. I am not sure why Windows is trying to eject the
> > > > PCI bridge and failing. Maybe something related to this comment?
> > > > 
> > > > 
> > > > /* When hotplug for bridges is enabled, bridges are
> > > >                               
> > > >          * described in ACPI separately (see build_pci_bus_end).
> > > >                                       
> > > >          * In this case they aren't themselves hot-pluggable.
> > > >                                       
> > > >          * Hotplugged bridges *are* hot-pluggable.
> > > > */  
> > > 
> > > thinking some more on this topic, it seems that with ACPI hotplug we
> > > already have implicit non-hotpluggble slot (slot with bridge) while
> > > the rest are staying hotpluggable.
> > > 
> > > So my question is: if it's acceptable to add
> > > 'PCIDevice::hotpluggable" property to all PCI devices so that user
> > > / libvirt could set it to false in case they do not want
> > > coldplugged device be considered as hotpluggable? (this way other
> > > devices could be treated the same way as bridges)
> > > 
> > > [...]  
> > 
> > 
> > I think Julia already posted a patch adding this to downstream pcie
> > bridges. Adding this to pci slots sounds like a reasonable thing.
> Question was more about external interface, were we do not have ports
> as separate devices with conventional PCI. The only knob we have is a
> a PCI device, where we have a property to turn on/off hotplug. ex:
>   -device e1000,hotpluggable=off
> and if libvirt would be able to use it

It would make sense but is it practical to add the capability is added
in a generic way to all bridges and hosts?
If not how do users probe for presence of the capability?


-- 
MST


