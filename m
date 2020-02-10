Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68F5C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5DB214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5DB214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15YZ-0007q6-Ps
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msuchanek@suse.de>) id 1j15Xr-0006sg-Qz
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msuchanek@suse.de>) id 1j15Xq-0000PH-9a
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:39:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:41374)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <msuchanek@suse.de>)
 id 1j15Xq-0000Mc-03; Mon, 10 Feb 2020 04:39:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EB186ADEE;
 Mon, 10 Feb 2020 09:39:55 +0000 (UTC)
Date: Mon, 10 Feb 2020 10:39:52 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Restrictions of libnet (was: Re: VW ELF loader)
Message-ID: <20200210093952.GC4113@kitsune.suse.cz>
References: <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <d13eea1d-7942-47e0-6189-a66ce9639db4@redhat.com>
 <20200204095403.04d9dd29.conny@cornelia-huck.de>
 <4794cf7a-7b53-5fea-c89d-baa01d3ed0ce@redhat.com>
 <20200205053049.GF60221@umbus.fritz.box>
 <bfe9398a-7108-9bf7-8589-6d01580bbb3a@redhat.com>
 <20200210075516.GF22584@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210075516.GF22584@umbus.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Cornelia Huck <conny@cornelia-huck.de>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 06:55:16PM +1100, David Gibson wrote:
> On Wed, Feb 05, 2020 at 07:24:04AM +0100, Thomas Huth wrote:
> > On 05/02/2020 06.30, David Gibson wrote:
> > > On Tue, Feb 04, 2020 at 10:20:14AM +0100, Thomas Huth wrote:
> > >> On 04/02/2020 09.54, Cornelia Huck wrote:
> > >>> On Tue, 4 Feb 2020 07:16:46 +0100
> > >>> Thomas Huth <thuth@redhat.com> wrote:
> > >>>
> > >>>> On 04/02/2020 00.26, Paolo Bonzini wrote:
> > >>>>>
> > >>>>>
> > >>>>> Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru
> > >>>>> <mailto:aik@ozlabs.ru>> ha scritto:
> > >>>>>
> > >>>>>     Speaking seriously, what would I put into the guest?
> > >>>>>
> > >>>>> Only things that would be considered drivers. Ignore the partitions
> > >>>>> issue for now so that you can just pass the device tree services to QEMU
> > >>>>> with hypercalls.
> > >>>>>
> > >>>>>     Netboot's dhcp/tftp/ip/ipv6 client? It is going to be another SLOF,
> > >>>>>     smaller but adhoc with only a couple of people knowing it.
> > >>>>>
> > >>>>>
> > >>>>> You can generalize and reuse the s390 code. All you have to write is the
> > >>>>> PCI scan and virtio-pci setup.  
> > >>>>
> > >>>> Well, for netbooting, the s390-ccw bios uses the libnet code from SLOF,
> > >>>> so re-using this for a slim netboot client on ppc64 would certainly be
> > >>>> feasible (especially since there are also already virtio drivers in SLOF
> > >>>> that are written in C), but I think it is not very future proof. The
> > >>>> libnet from SLOF only supports UDP, and no TCP. So for advanced boot
> > >>>> scenarios like booting from HTTP or even HTTPS, you need something else
> > >>>> (i.e. maybe grub is the better option, indeed).
> > >>>
> > >>> That makes me wonder what that means for s390: We're inheriting
> > >>> libnet's limitations, but we don't have grub -- do we need to come up
> > >>> with something different? Or improve libnet?
> > >>
> > >> I don't think that it makes sense to re-invent the wheel yet another
> > >> time and write yet another TCP implementation (which is likely quite a
> > >> bit of work, too, especially if you also want to do secure HTTPS in the
> > >> end). So yes, in the long run (as soon as somebody seriously asks for
> > >> HTTP booting on s390x) we need something different here.
> > >>
> > >> Now looking at our standard s390x bootloader zipl - this has been giving
> > >> us a headache a couple of times in the past, too (from a distro point of
> > >> view since s390x is the only major platform left that does not use grub,
> > >> but also from a s390-ccw bios point of view, see e.g.
> > >> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03046.html and
> > >> related discussions).
> > >>
> > >> So IMHO the s390x world should move towards grub2, too. We could e.g.
> > >> link it initially into the s390-ccw bios bios ... and if that works out
> > >> well, later also use it as normal bootloader instead of zipl (not sure
> > >> if that works in all cases, though, IIRC there were some size
> > >> constraints and stuff like that).
> > > 
> > > petitboot would be another reasonable thing to consider here.  Since
> > > it's Linux based, you have all the drivers you have there.  It's not
> > > quite grub, but it does at least parse the same configuration files.
> > > 
> > > You do need kexec() of course, I don't know if you have that already
> > > for s390 or not.
> > 
> > AFAIK we have kexec on s390. So yes, petitboot would be another option
> > for replacing the s390-ccw bios. But when it comes to LPARs and z/VMs, I
> > don't think it's really feasible to replace the zipl bootloader there
> > with petitboot, so in that case grub2 still sounds like the better
> > option to me.
> 
> Actually, between that and Paolo's suggestions, I thought of another
> idea that could be helpful for both s390 and power.  Could we load
> non-kexec() things (legacy kernels, non-Linux OSes) from Petitboot by
> having it kexec() into a shim mini-kernel that just sets up the boot
> environment for the other thing.
> 
> What I'm imagining is that petitboot loads everything that will be
> needed for the other OS into RAM - probably as (or part of) the
> "initrd" image.  That means the shim doesn't need to have drivers or
> a network stack to load that in.  It just needs to construct
> environment and jump into the real kernel.

How does that differ from what kexec normally does?

It does support the kernel format that is usually booted on the
architecture.

Thanks

Michal

