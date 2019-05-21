Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A2BC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564A920862
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 11:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564A920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51773 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT35z-0006B0-JZ
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 07:38:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT35F-0005uF-3g
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT35E-0007fu-4V
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:37:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hT35E-0007fX-0V
	for qemu-devel@nongnu.org; Tue, 21 May 2019 07:37:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id z19so19928371qtz.13
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 04:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=VGjpwKL/2zR/T+tNNnXQux4BuY8bAVRicC7iTWUdyWI=;
	b=Aco4aI9jyGlPwxSNjs7DDlVcthHPBl21GX2V3zV1rl4f0HVmX0Iqhai06Yi4xwj/cJ
	KP3gFssEtolq8BAVzH7KJg20TYKp3uuPCLIRYHsamLmGhWpvG7c8k0dvNrnKZywmnrcw
	W7TaZrzhIzMD3R9xk7jo2laIiWiLDfr3H7cvrV4ZYdUhWYzLBwYyzqaDPyDgVOmI+JXb
	WvMrdi2MCQAaO0YCwwGyZ+ZwYjZlxj1CkUJbI2gXKzc8CNoEsx6cLgP1hFFrKnsHwA1Q
	k8SlEfZWGaNFj+VlZEZmNXYQIGRB//ZZ9dvpypbezFe4QDc1qjl71IYsuMmlTUDq2uHp
	E3NA==
X-Gm-Message-State: APjAAAUxNw6C22mcQmZsC5XqFqswvj0F54OvWsu4SWv34UO5hPNkdg3y
	5+G49/ZmJeKscYO8InDeccnsYixk9XY=
X-Google-Smtp-Source: APXvYqxU7JxMTwbWO7jztO80whBRciCuGGneOZ+rx9YHMvKU5spj5qdIlHmQxDvNIG1RXH7dFEnayw==
X-Received: by 2002:ac8:2c6a:: with SMTP id e39mr51263030qta.179.1558438647530;
	Tue, 21 May 2019 04:37:27 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	k53sm10236651qtb.65.2019.05.21.04.37.26
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 04:37:26 -0700 (PDT)
Date: Tue, 21 May 2019 07:37:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190521073511-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190520165657.2293c5d7@x1.home>
	<20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
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
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 09:21:57AM +0200, Jens Freimann wrote:
> On Mon, May 20, 2019 at 04:56:57PM -0600, Alex Williamson wrote:
> > On Fri, 17 May 2019 14:58:16 +0200
> > Jens Freimann <jfreimann@redhat.com> wrote:
> > > Command line example:
> > > 
> > > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
> > >         -machine q35,kernel-irqchip=split -cpu host   \
> > >         -k fr   \
> > >         -serial stdio   \
> > >         -net none \
> > >         -qmp unix:/tmp/qmp.socket,server,nowait \
> > >         -monitor telnet:127.0.0.1:5555,server,nowait \
> > >         -device pcie-root-port,id=root0,multifunction=on,chassis=0,addr=0xa \
> > >         -device pcie-root-port,id=root1,bus=pcie.0,chassis=1 \
> > >         -device pcie-root-port,id=root2,bus=pcie.0,chassis=2 \
> > >         -netdev tap,script=/root/bin/bridge.sh,downscript=no,id=hostnet1,vhost=on \
> > >         -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on \
> > >         /root/rhel-guest-image-8.0-1781.x86_64.qcow2
> > > 
> > > Then the primary device can be hotplugged via
> > >  (qemu) device_add vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,standby=net1
> > 
> > Is this standby= option only valid for Network/Ethernet class code
> > devices?  If so, perhaps vfio-pci code should reject the option on any
> > non-ethernet devices.  The option is also non-intuitive for users, only
> > through examples like above can we see it relates to the id of the
> > secondary device.  Could we instead name it something like
> > "standby_net_failover_pair_id="?
> 
> It is only for ethernet (VFs), I will add code to reject non-ethernet VF devices.
> I agree the name is not descriptive and the one you suggest seems good to
> me.
> > 
> > Also, this feature requires matching MAC addresses per the description,
> > where is that done?  Is it the user's responsibility to set the MAC on
> > the host device prior to the device_add?  If so, is this actually not
> > only specific to ethernet devices, but ethernet VFs?
> 
> Yes, it's the users responsibility and the MACs are then matched by
> the net_failover driver in the guest. It makes sense for ethernet VFs only,
> I'll add a check for that.

Actually is there a list of devices for which this has been tested
besides mlx5? I think someone said some old intel cards
don't support this well, we might need to blacklist these ...

> > 
> > Finally, please copy me on code touching vfio.  Thanks,
> 
> I'm sorry about that, will do.
> 
> Thanks for the review Alex!
> 
> regards,
> Jens

