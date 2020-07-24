Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D284CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94998206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4+Da4Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94998206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxHw-0006ty-R3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 08:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxHG-0006LF-EW
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:58:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyxHD-0005OL-SZ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 08:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595595494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s5g+//p0NXZFHSQOOgz8fL1BegMSJHJEl5qKyUk0F08=;
 b=H4+Da4Kj+LN0VwGApV7DiFDjPWgp9l7cpfUMGW38IAWeyvFBDpx6ReAyxgdOWzs8CN/F1J
 QBYbgm7diDeSkhqVuVSggAA7vtWUEflNQxblwNEezemGcOmrdkzVOcdnlQtxgzpp9J+oUD
 rpiL73Zdw1E+CErTZPWkQJ8+95+z9jM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-2YBWr6NQNUSDuWr3lNwSDA-1; Fri, 24 Jul 2020 08:58:13 -0400
X-MC-Unique: 2YBWr6NQNUSDuWr3lNwSDA-1
Received: by mail-wr1-f71.google.com with SMTP id 89so2131292wrr.15
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 05:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s5g+//p0NXZFHSQOOgz8fL1BegMSJHJEl5qKyUk0F08=;
 b=WVCrPs/713oP8kVZaZGrM/oc4+pPZTuEG14/JU9ZyK8DUouKF/4C22wzyGaZxp+NP4
 2Sw8rQOhl4m/rHcv919KHKV6chHHFL+akcZTtmdmd0HCojU5uaTJ3LEAeE0xYCwRW7DV
 Ur0s0Tlp8o4JlMlAaDD4QY/aYCUsZqacXzLAJtZzg3el20bfrg7FcJ2/PRW/7xMo7qNT
 zoID62NPfpXJPL5AcxWvPcVm65BpECDrxJ7t7lHVE6erOZb/hqYtyiBvjUWC9HlxPbQJ
 CL2ZIvTPFZUWO6m7eWdhU+aygoD8ARr3UpTz3+6tTz9syZ1WSeL6logrqj49hLaK8xzZ
 eVdw==
X-Gm-Message-State: AOAM530RX1CbpNSBVe+KjOb0nVQcHtHXwUcX4Rt/kGG2ofRaRztSvb5i
 97VxkICO2YGBapmzKniVHE15sapTzQSev6UpBIlkllDpPxm+NKE7HmJc1JG3/7FI+mXIP4NRcbH
 QCxZweIGJp0Qlfz0=
X-Received: by 2002:adf:facb:: with SMTP id a11mr8963579wrs.277.1595595491967; 
 Fri, 24 Jul 2020 05:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsvH0zkCkieOP4jS2eRQ7jzKXB2fM5LJpqBZJBfFFqCActzK1z8avrUBfV/9Y3nazHW0AWpw==
X-Received: by 2002:adf:facb:: with SMTP id a11mr8963559wrs.277.1595595491619; 
 Fri, 24 Jul 2020 05:58:11 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id s14sm1218868wrv.24.2020.07.24.05.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 05:58:11 -0700 (PDT)
Date: Fri, 24 Jul 2020 08:58:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Wangjing (Hogan,
 Cloud Infrastructure Service Product Dept.)" <king.wang@huawei.com>
Subject: Re: [PATCH v1] hw/pci-host: save/restore pci host config register
Message-ID: <20200724085630-mutt-send-email-mst@kernel.org>
References: <ec09235475524a94b8aeb5dc73cd0e74@huawei.com>
MIME-Version: 1.0
In-Reply-To: <ec09235475524a94b8aeb5dc73cd0e74@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 "Wangxin \(Alexander\)" <wangxinxin.wang@huawei.com>,
 "jusual@redhat.com" <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 03:21:58AM +0000, Wangjing (Hogan, Cloud Infrastructure Service Product Dept.) wrote:
> On Sat, Jul 25, 2020 at 10:53:03AM Hogan Wang wrote:
> > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > On Thu, Jul 23, 2020 at 02:12:54PM +0100, Dr. David Alan Gilbert wrote:
> > > > * Michael S. Tsirkin (mst@redhat.com) wrote:
> > > > > On Thu, Jul 23, 2020 at 08:53:03PM +0800, Hogan Wang wrote:
> > > > > > From: Hogan Wang <king.wang@huawei.com>
> > > > > > 
> > > > > > The pci host config register is used to save PCI address for 
> > > > > > read/write config data. If guest write a value to config 
> > > > > > register, and then pause the vcpu to migrate, After the 
> > > > > > migration, the guest continue to write pci config data, and the 
> > > > > > write data will be ignored because of new qemu process lost the config register state.
> > > > > > 
> > > > > > Reproduction steps are:
> > > > > > 1. guest booting in seabios.
> > > > > > 2. guest enable the SMRAM in seabios:piix4_apmc_smm_setup, and then
> > > > > >    expect to disable the SMRAM by pci_config_writeb.
> > > > > > 3. after guest write the pci host config register, and then pasued vcpu
> > > > > >    to finish migration.
> > > > > > 4. guest write config data(0x0A) fail to disable the SMRAM becasue of
> > > > > >    config register state lost.
> > > > > > 5. guest continue to boot and crash in ipxe option ROM due to SMRAM in
> > > > > >    enabled state.
> > > > > > 
> > > > > > Signed-off-by: Hogan Wang <king.wang@huawei.com>
> > > > > 
> > > > > I guess this is like v3 right?
> > > > > 
> > > > > thanks a lot for the patch!
> > > > > 
> > > > > My question stands : does anyone see a way to pass this info 
> > > > > around without breaking migration for all existing machine types?
> > > > 
> > > > You need a .needed clause in the vmstate_i440fx_pcihost and 
> > > > vmstate_q35_pcihost which is a pointer to a function which enables 
> > > > it on new machine types and ignores it on old ones.
> > > > 
> > > > Or, if it always crashes if the SMRAM is enabled, then the migration 
> > > > is dead anyway; so you could make the .needed only save the config 
> > > > if the SMRAM is opened, so you'd get a unknown section error, which 
> > > > is nasty but it would only happen in the case it would crash anyway.
> > > > 
> > > > Dave
> > > 
> > > Problem is we never know whether it's needed.
> > > 
> > > For example: guest programs cf8, then cfc.
> > > Guest on destination can crash if migrated after writing cf8 before 
> > > writing cfc.
> > > But in theory it can also crash if guest assumes
> > > cf8 is unchanged and just writes cfc.
> > > 
> > > So what I'd prefer to do is put it in some data that old qemu ignores. 
> > > Then once qemu on destination is updated, it will start interpreting 
> > > it.
> > 
> > We don't have a way to do that; the choice is:
> >   a) Not sending it for old versions, so you only get the
> >     fix for new machine types
> > 
> >   b) Trying to second guess when it will crash
> > 
> > I recommend (a) generally - but the format has no way to ignore unknown data.
> > 
> > Dave
> > 
> 
> The i440fx and q35 machines integrate i440FX or ICH9-LPC PCI device by
> default. Refer to i440FX and ICH9-LPC spcifications, there are some reserved
> configuration registers can used to save/restore PCIHostState.config_reg,
> like i440FX.config[0x57] used for Older coreboot to get RAM size from QEMU.
> 
> whitch is nasty but it friendly to old ones.

Right. So what I propose is a series of two patches:
1. a patch to add it in a clean way to new machine types only.

2. a patch on top for old machine types to stick it in some
   reserved register.

Then people can review both approaches and we can decide.


> > > 
> > > > > 
> > > > > > ---
> > > > > >  hw/pci-host/i440fx.c       | 11 +++++++++++
> > > > > >  hw/pci-host/q35.c          | 11 +++++++++++
> > > > > >  hw/pci/pci_host.c          | 11 +++++++++++
> > > > > >  hw/pci/pcie_host.c         | 11 +++++++++++
> > > > > >  include/hw/pci/pci_host.h  | 10 ++++++++++  
> > > > > > include/hw/pci/pcie_host.h | 10 ++++++++++
> > > > > >  6 files changed, 64 insertions(+)
> > > > > > 
> > > > > 
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


