Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC5EC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7325720863
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7325720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7LVs-0006FF-JI
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i7LUc-0005NM-N1
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i7LUZ-0006ES-AA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:22:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36590)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1i7LUZ-0006Dc-2b; Mon, 09 Sep 2019 11:22:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4327C10C0933;
 Mon,  9 Sep 2019 15:22:09 +0000 (UTC)
Received: from work-vm (ovpn-117-249.ams2.redhat.com [10.36.117.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65E7F10013D9;
 Mon,  9 Sep 2019 15:22:07 +0000 (UTC)
Date: Mon, 9 Sep 2019 16:22:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <20190909152205.GC2726@work-vm>
References: <ed421291-7178-d7bc-5ed3-9863d28ceba9@fnarfbargle.com>
 <dd33a398-3c1f-0c92-2318-00ad144e1e5d@fnarfbargle.com>
 <b1782119-abbc-9678-8217-ef576dbf8c93@fnarfbargle.com>
 <20190906190351.GB20068@work-vm>
 <a9799b8b-a294-59e3-f329-060b19cdcf0e@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9799b8b-a294-59e3-f329-060b19cdcf0e@fnarfbargle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 09 Sep 2019 15:22:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cross-posted : Odd QXL/KVM performance issue with
 a Windows 7 Guest
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Brad Campbell (lists2009@fnarfbargle.com) wrote:
> 
> On 7/9/19 03:03, Dr. David Alan Gilbert wrote:
> > * Brad Campbell (lists2009@fnarfbargle.com) wrote:
> > > On 2/9/19 6:23 pm, Brad Campbell wrote:
> > > 
> > > > Here is the holdup :
> > > > 
> > > > 11725@1567416625.003504:qxl_ring_command_check 0 native
> > > > 11725@1567416625.102653:qxl_io_write 0 native addr=0 (QXL_IO_NOTIFY_CMD)
> > > > val=0 size=1 async=0
> > > > 
> > > > ~100ms delay prior to each logged QXL_IO_NOTIFY_CMD on the AMD box which
> > > > explains the performance difference. Now I just need to figure out if
> > > > that lies in the guest, the guest QXL driver, QEMU or SPICE and why it
> > > > exhibits on the AMD box and not the i7.
> > > > 
> > > > To get to this point, I recompiled the kernel on the i7 box with both
> > > > AMD and Intel KVM modules. Once that was running I cloned the drive and
> > > > put it in the AMD box, so the OS, software stack and all dependencies
> > > > are identical.
> > > Reacp :
> > > 
> > > I have a machine with a Windows 7 VM which is running on an i7-3770. This
> > > works perfectly.
> > > 
> > > Clone the disk and put it in a new(ish) AMD Ryzen 1500x machine and the
> > > display output using qxl/spice is now limited to ~5-7fps.
> > > 
> > > I originally cloned the entire machine to keep the software versions
> > > identical.
> > > 
> > > To simplify debugging and reproduction I'm now using :
> > > - An identical SPICE version to that on the i7.
> > > - A fresh 64 bit Windows 7 VM.
> > > - The D2D benchmark from Crystalmark 2004R7.
> > > 
> > > The machine is booted with :
> > > 
> > > qemu -enable-kvm \
> > >   -m 8192\
> > >   -rtc base=localtime\
> > >   -vga qxl\
> > >   -device qxl\
> > >   -global qxl-vga.guestdebug=3\
> > >   -global qxl-vga.cmdlog=1\
> > >   -global qxl-vga.vram_size=65536\
> > >   -global qxl.vram_size=65536\
> > >   -global qxl-vga.ram_size=65536\
> > >   -global qxl.ram_size=65536\
> > >   -net nic,model=virtio\
> > >   -net tap,ifname=tap0,script=/etc/qemu-ifup,vhost=on\
> > >   -usbdevice tablet\
> > >   -spice port=5930,disable-ticketing\
> > >   -device virtio-serial\
> > >   -chardev spicevmc,id=vdagent,name=vdagent\
> > >   -device virtserialport,chardev=vdagent,name=com.redhat.spice.0\
> > >   -smp 3,maxcpus=3,cores=3,threads=1,sockets=1\
> > >   -cpu qemu64,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
> > -cpu qemu64 is almost always a bad idea;  does -cpu host help ?
> > 
> > Dave
> 
> 
> No. I was using -cpu host. I changed it to qemu64 for testing so I could add & remove -enable-kvm for testing without the machine changing drivers about.

Oh, hmm.
Sorry I don't know too much where to look then; you have any of:
  a) Windows
  b) guest graphics drivers
  c) spice server in qemu
 
and probalby some more.

So I think it's going to be a case of profiling on the two different
systems and see if you can spot anything in particular that stands out.

Dave

> Regards,
> 
> Brad
> 
> -- 
> An expert is a person who has found out by his own painful
> experience all the mistakes that one can make in a very
> narrow field. - Niels Bohr
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

