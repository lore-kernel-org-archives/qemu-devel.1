Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E9E20899
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWxtjYzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E9E20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLLH-0008Fp-2N
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 05:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbLKW-0007bk-G6
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:48:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48991
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jbLKV-0001wV-Ef
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589968082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cG3Gg0Y+atRmrInFifA4mw9+iVeFnWEzbLqSe0yu/HU=;
 b=BWxtjYzAdvWii+MKNIyoDZbPZ2VtHRtPZQiiCBVQgDnmZgXleMQYyxbDVLJEGmKkleAuOh
 VKSBJ+VJjKefMI7T32tsMUEKI20Tw69A2U33kDd42inZ2ExyegvtbdyLTQMZ0jlRPgPgGG
 HSZZrCEmQNW4AicXbbegVONvfhwObzM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-7hHcN3oVOJ2RGQv6j6nkag-1; Wed, 20 May 2020 05:47:58 -0400
X-MC-Unique: 7hHcN3oVOJ2RGQv6j6nkag-1
Received: by mail-wm1-f70.google.com with SMTP id a67so1012295wme.6
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 02:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cG3Gg0Y+atRmrInFifA4mw9+iVeFnWEzbLqSe0yu/HU=;
 b=W3iq8tJJ21LNYR+hm8jUnUtVr7UeHSk3B9EZhFXeOHhQU/AW8ED+5wY198d/g3Nqri
 gEDR/wllsgrsAn+ft0/HXs+o5vSrQSVilMXIdedTPrtREd7iNnKt4FXf/r4NARM0GaWk
 rC9bDevGnevUrYZTkI/PKGDc/2on4hAK6uvcanpHReOyR4/oXvRefVOUtWiCgYr/w0oZ
 dxKBQEWF9K+WoSKWknGI0O0Uky0mtRFgGiLG9vjlCAXLsIQB4dzdokNTlbIzJHhKJxCm
 FtOSGR/bw3eNA57cU/Dzgwf2HUtLBWZ6oR3g8nCX4X8/r149tz9fnLuyDVolDPHiMFEd
 t5WQ==
X-Gm-Message-State: AOAM531Ft70kAOnuX4V46Me8ZIs3J2XcvJWJpXOvIdBiC70zXVK10Gxn
 GdWO46a/2xz2NB0srUSFscD6NhjLFBwgLPXp/wA8cdVrB5u6W7h4cVgOvW71oqE4zbbPOPJCI//
 lN/oBegI4I2Mxjs4=
X-Received: by 2002:a1c:e188:: with SMTP id y130mr4162812wmg.83.1589968077459; 
 Wed, 20 May 2020 02:47:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeRwm705w+jwXArWDZqI2fpoAwE5+6ZZyNxAnp5KtAlmCpTzhd3XhYfSbU7bIMuuyX8i3OJw==
X-Received: by 2002:a1c:e188:: with SMTP id y130mr4162792wmg.83.1589968077181; 
 Wed, 20 May 2020 02:47:57 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 5sm2490616wmd.19.2020.05.20.02.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 02:47:56 -0700 (PDT)
Date: Wed, 20 May 2020 05:47:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedow <imammedo@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200520054714-mutt-send-email-mst@kernel.org>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200511205352.05ff541a@redhat.com>
 <9941B800-BBEF-4DF8-BEE0-EC39D2A20D98@nutanix.com>
 <20200513214312.0dfa4752@redhat.com>
 <7FF83CE8-F25A-4458-80A7-EAA6296EF175@nutanix.com>
 <20200520114354.1982cb63@nas.mammed.net>
MIME-Version: 1.0
In-Reply-To: <20200520114354.1982cb63@nas.mammed.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Wed, May 20, 2020 at 11:43:54AM +0200, Igor Mammedow wrote:
> On Fri, 15 May 2020 12:13:53 +0000
> Ani Sinha <ani.sinha@nutanix.com> wrote:
> 
> > > On May 14, 2020, at 1:13 AM, Igor Mammedov <imammedo@redhat.com>
> > > wrote: 
> > >> 
> > >>   
> > >>> Will following hack work for you?
> > >>> possible permutations
> > >>> 1) ACPI hotplug everywhere
> > >>> -global PIIX4_PM.acpi-pci-hotplug=on -global
> > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on -device
> > >>> pci-bridge,chassis_nr=1,shpc=doesnt_matter -device
> > >>> e1000,bus=pci.1,addr=01,id=netdev1 
> > >>> 
> > >>> 2) No hotplug at all
> > >>> -global PIIX4_PM.acpi-pci-hotplug=off -global
> > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=on -device
> > >>> pci-bridge,chassis_nr=1,shpc=off -device
> > >>> e1000,bus=pci.1,addr=01,id=netdev1
> > >>> 
> > >>> -global PIIX4_PM.acpi-pci-hotplug=off -global
> > >>> PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off -device
> > >>> pci-bridge,chassis_nr=1,shpc=doesnt_matter  -device
> > >>> e1000,bus=pci.1,addr=01,id=netdev1    
> > >> 
> > >> Given that my patch is not acceptable, I’d prefer the following in
> > >> the order of preference:
> > >> 
> > >> (a) Have an option to disable hot ejection of PCI-PCI bridge so
> > >> that Windows does not even show this HW in the “safely remove HW”
> > >> option. If we can do this then from OS perspective the GUI options
> > >> will be same as what is available with PCIE/q35 - none of the
> > >> devices will be hot ejectable if the hot plug option is turned off
> > >> from the PCIE slots where devices are plugged into. I looked at
> > >> the code. It seems to manipulate ACPI tables of the empty slots of
> > >> the root bus where no devices are attached (see comment "/* add
> > >> hotplug slots for non present devices */ “). For cold plugged
> > >> bridges, it recurses down to scan the slots of the bridge. Is it
> > >> possible to disable hot plug for the slot to which the bridge is
> > >> attached?  
> > > 
> > > I don't think it's possible to have per slot hotplug on
> > > conventional PCI hardware. it's per bridge property.  
> > 
> > We add the AMLs per empty slot though. When the pic bridge is
> > attached, we do nothing, just recurse into the bridge slots. That is
> > what I was asking, if it was possible to just disable the AMLs or use
> > some tricks to say that this particular slot is not hotpluggable. I
> > am not sure why Windows is trying to eject the PCI bridge and
> > failing. Maybe something related to this comment?
> > 
> > 
> > /* When hotplug for bridges is enabled, bridges are
> >                               
> >          * described in ACPI separately (see build_pci_bus_end).
> >                                       
> >          * In this case they aren't themselves hot-pluggable.
> >                                       
> >          * Hotplugged bridges *are* hot-pluggable.
> > */
> 
> thinking some more on this topic, it seems that with ACPI hotplug we
> already have implicit non-hotpluggble slot (slot with bridge) while
> the rest are staying hotpluggable.
> 
> So my question is: if it's acceptable to add 'PCIDevice::hotpluggable"
> property to all PCI devices so that user / libvirt could set it to
> false in case they do not want coldplugged device be considered as
> hotpluggable? (this way other devices could be treated the same way as
> bridges)
> 
> [...]


I think Julia already posted a patch adding this to downstream pcie
bridges. Adding this to pci slots sounds like a reasonable thing.

-- 
MST


