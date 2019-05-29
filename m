Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A7CC04AB6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 02:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CB421721
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 02:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CB421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVokE-0007H8-NC
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 22:55:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVojR-0006yX-BD
	for qemu-devel@nongnu.org; Tue, 28 May 2019 22:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hVojQ-0003EA-3w
	for qemu-devel@nongnu.org; Tue, 28 May 2019 22:54:25 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hVojP-0003CP-Ub
	for qemu-devel@nongnu.org; Tue, 28 May 2019 22:54:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id p18so547560qkk.0
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 19:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=sK94ZQEu7nCfJWCAM4Vdr/Kw6sMPbuAyj+5ga4g9G90=;
	b=ZJ1QuMInlrHNXnNistpksN8BI4pYxxreO+Axk3Lybw3P4kjbLYSy0I4v8SGAGdNz9p
	qMuPbwHsOY6emwShAs9Tp/M+nn3SbDhPtJPx8qZDiTmhhACqyIuT1GiuCD1iV5VWRNqb
	memAuMHgQWefYYdRQGQAzERZdNrTPSLUdlKVYIWtBrmqjDzv3FggkNPDG4T7uJPMqw2m
	bTPLYn/0cdknmLpgaEnHfdFRaGBSXjbvtY2BCVqjtsbjm765Yzw3D9UbDQ+67PWPvyWm
	/lOQhHPxPxuHDUWLDUp4yqbBO9IDJ2QUaFxEnMgPWNzvKa4daIenVU6X6J/5RCmbHOIU
	xgIQ==
X-Gm-Message-State: APjAAAXtmKO8lBL1spzHAgmsFFxbTClJ/ACOYeqWzQYlpEwGCEVGd/EQ
	HUsEh/B4HbI5OzH5wyapb+J5hg==
X-Google-Smtp-Source: APXvYqzUmJ4rJcXWSm6Hp48OXv6sGFdGDO4nQ/igWgX/3UT7ZL2ir55d9wZ+5f8YimrY/mom5SUQhg==
X-Received: by 2002:a37:9706:: with SMTP id z6mr69007408qkd.249.1559098463147; 
	Tue, 28 May 2019 19:54:23 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id j33sm572323qtc.10.2019.05.28.19.54.21
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 28 May 2019 19:54:22 -0700 (PDT)
Date: Tue, 28 May 2019 22:54:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <20190528225039-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190520165657.2293c5d7@x1.home>
	<20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
	<20190521073511-mutt-send-email-mst@kernel.org>
	<20190521184918.n4nnk6ack3ssp6jv@jenstp.localdomain>
	<d116bc65-0715-2c6a-2616-49f67cd685c8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d116bc65-0715-2c6a-2616-49f67cd685c8@oracle.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.193
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	aadam@redhat.com, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>, laine@redhat.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 05:14:22PM -0700, si-wei liu wrote:
> 
> 
> On 5/21/2019 11:49 AM, Jens Freimann wrote:
> > On Tue, May 21, 2019 at 07:37:19AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, May 21, 2019 at 09:21:57AM +0200, Jens Freimann wrote:
> > > > On Mon, May 20, 2019 at 04:56:57PM -0600, Alex Williamson wrote:
> > > > > On Fri, 17 May 2019 14:58:16 +0200
> > > > > Jens Freimann <jfreimann@redhat.com> wrote:
> > > > > > Command line example:
> > > > > >
> > > > > > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
> > > > > >         -machine q35,kernel-irqchip=split -cpu host   \
> > > > > >         -k fr   \
> > > > > >         -serial stdio   \
> > > > > >         -net none \
> > > > > >         -qmp unix:/tmp/qmp.socket,server,nowait \
> > > > > >         -monitor telnet:127.0.0.1:5555,server,nowait \
> > > > > >         -device
> > > > pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
> > > > > >         -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
> > > > > >         -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
> > > > > >         -netdev
> > > > tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on
> > > > \
> > > > > >         -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on
> > > > \
> > > > > >         /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> > > > > >
> > > > > > Then the primary device can be hotplugged via
> > > > > >  (qemu) device_add
> > > > vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1
> > > > >
> > > > > Is this standby= option only valid for Network/Ethernet class code
> > > > > devices?  If so, perhaps vfio-pci code should reject the
> > > > option on any
> > > > > non-ethernet devices.  The option is also non-intuitive for
> > > > users, only
> > > > > through examples like above can we see it relates to the id of the
> > > > > secondary device.  Could we instead name it something like
> > > > > "standby_net_failover_pair_id="?
> > > > 
> > > > It is only for ethernet (VFs), I will add code to reject
> > > > non-ethernet VF devices.
> > > > I agree the name is not descriptive and the one you suggest
> > > > seems good to
> > > > me.
> > > > >
> > > > > Also, this feature requires matching MAC addresses per the
> > > > description,
> > > > > where is that done?  Is it the user's responsibility to set
> > > > the MAC on
> > > > > the host device prior to the device_add?  If so, is this actually not
> > > > > only specific to ethernet devices, but ethernet VFs?
> > > > 
> > > > Yes, it's the users responsibility and the MACs are then matched by
> > > > the net_failover driver in the guest. It makes sense for
> > > > ethernet VFs only,
> > > > I'll add a check for that.
> > > 
> > > Actually is there a list of devices for which this has been tested
> > > besides mlx5? I think someone said some old intel cards
> > > don't support this well, we might need to blacklist these ...
> > 
> > So far I've tested mlx5 and XL710 which both worked, but I'm
> > working on testing with more devices. But of course help with testing
> > is greatly appreciated.
> It won't work on Intel ixgbe and Broadcom bnxt_en, which requires toggling
> the state of tap backing the virtio-net in order to release/reprogram MAC
> filter. Actually, it's very few NICs that could work with this - even some
> works by chance the behavior is undefined. Instead of blacklisting it makes
> more sense to whitelist the NIC that supports it - with some new sysfs
> attribute claiming the support presumably.
> 
> -Siwei

I agree for many cards we won't know how they behave until we try.  One
can consider this a bug in Linux that cards don't behave in a consistent
way.  The best thing to do IMHO would be to write a tool that people can
run to test the behaviour.


> > 
> > regards,
> > Jens

