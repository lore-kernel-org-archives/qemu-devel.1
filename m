Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA9BC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88843216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk9c4lGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88843216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprOv-00011D-OL
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50639)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hprOj-0000Zr-6m
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hprOh-0008DJ-Rz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:47:53 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:33913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hprOh-0008DD-OF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:47:51 -0400
Received: by mail-qt1-x841.google.com with SMTP id k10so41322771qtq.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ApRfjcvVtBtBG5LDTqnHenu2GEl5sEwwSQ2w05TprPc=;
 b=lk9c4lGF9RR6w0jaUh0HBP/sYcpsEtzweJbkGBrBxjU2oYl/y/ytwt69PceN2TMoaP
 knWRWeIVhNFmkQbciCJSOkVUH/KbXS3O6tY/rZDm+jzDoH38hnkrcSUh1uqk1qgMMJ5n
 QvqDbOupVIgR18J8WFyigKKadC6t0SNsZEuN/PZGIwNcoINxyKkJT8ik2L474J4biEWL
 pQM5PT67jFpK7uAJGHye3j3O8j5A9Tw9TGPHtoyEaEHxE21AA3HiFg75fkc0rFC8g86Q
 SAwpdlO3yAj3tFoUsvt9m11+3nRM6enIrnePpArfczWEVBvad1yukDB3RoTQBNbw7XBx
 PP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ApRfjcvVtBtBG5LDTqnHenu2GEl5sEwwSQ2w05TprPc=;
 b=PW5r9wxMQofc8u9Wkek+nmZzye/1TZZjzUvzfvApO2GnEIldhmlSzmB7nNjvlkuMli
 7z+DZuApvY+gLJ834AhYSDxjYdwZKsEpZLjdNAPiIhPuSUAz5LVh1YR1uAGfDyH7Tq17
 nFo0J8EjVNq9OsejyHsQ4FI1b8eTzKf/2q6g7zRIxCEEgZo11r1Fwyhv/xmMTOAvgzS8
 uaXJ9ioiYxzSn5AtB1m2NXDvLkLWpmMdc0CgBDpQirj2+6AEonMqU7QPkXPjTHF1GrRN
 98nQcDgtbl93kX+34yybPWfnQAgo4lxJuDQ+tBp9BKjNKKUCPb3SZfQienqPmSuOVpoL
 xy7g==
X-Gm-Message-State: APjAAAWzVpzvNxqO0l/sft6wUbbnZicg5WwfKkxEo3UPPV9ZUcuKRwmB
 pz/jHqH4WKb5EaIGP18lVySNwKYwHuyX9NW4EVw=
X-Google-Smtp-Source: APXvYqyGxfPX2/EqweuLzdoE16dvygPMRkmeUMJsGjbNCy5lacWtT9pnAeOYekSWyagUOvsFDtm/RWJdCLiY07NCSC8=
X-Received: by 2002:a0c:b521:: with SMTP id d33mr54202271qve.239.1563875271184; 
 Tue, 23 Jul 2019 02:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190702121106.28374-1-slp@redhat.com>
 <20190703095825.GE11844@stefanha-x1.localdomain>
 <87d0i7tlkl.fsf@redhat.com> <20190719102915.GG18585@stefanha-x1.localdomain>
 <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
 <87tvbdrvin.fsf@redhat.com>
In-Reply-To: <87tvbdrvin.fsf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 23 Jul 2019 10:47:39 +0100
Message-ID: <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "Montes, Julio" <julio.montes@intel.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 9:43 AM Sergio Lopez <slp@redhat.com> wrote:
> Montes, Julio <julio.montes@intel.com> writes:
>
> > On Fri, 2019-07-19 at 16:09 +0100, Stefan Hajnoczi wrote:
> >> On Fri, Jul 19, 2019 at 2:48 PM Sergio Lopez <slp@redhat.com> wrote:
> >> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >> > > On Thu, Jul 18, 2019 at 05:21:46PM +0200, Sergio Lopez wrote:
> >> > > > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >> > > >
> >> > > > > On Tue, Jul 02, 2019 at 02:11:02PM +0200, Sergio Lopez wrote:
> >> > > >  --------------
> >> > > >  | Conclusion |
> >> > > >  --------------
> >> > > >
> >> > > > The average boot time of microvm is a third of Q35's (115ms vs.
> >> > > > 363ms),
> >> > > > and is smaller on all sections (QEMU initialization, firmware
> >> > > > overhead
> >> > > > and kernel start-to-user).
> >> > > >
> >> > > > Microvm's memory tree is also visibly simpler, significantly
> >> > > > reducing
> >> > > > the exposed surface to the guest.
> >> > > >
> >> > > > While we can certainly work on making Q35 smaller, I definitely
> >> > > > think
> >> > > > it's better (and way safer!) having a specialized machine type
> >> > > > for a
> >> > > > specific use case, than a minimal Q35 whose behavior
> >> > > > significantly
> >> > > > diverges from a conventional Q35.
> >> > >
> >> > > Interesting, so not a 10x difference!  This might be amenable to
> >> > > optimization.
> >> > >
> >> > > My concern with microvm is that it's so limited that few users
> >> > > will be
> >> > > able to benefit from the reduced attack surface and faster
> >> > > startup time.
> >> > > I think it's worth investigating slimming down Q35 further first.
> >> > >
> >> > > In terms of startup time the first step would be profiling Q35
> >> > > kernel
> >> > > startup to find out what's taking so long (firmware
> >> > > initialization, PCI
> >> > > probing, etc)?
> >> >
> >> > Some findings:
> >> >
> >> >  1. Exposing the TSC_DEADLINE CPU flag (i.e. using "-cpu host")
> >> > saves a
> >> >     whooping 120ms by avoiding the APIC timer calibration at
> >> >     arch/x86/kernel/apic/apic.c:calibrate_APIC_clock
> >> >
> >> > Average boot time with "-cpu host"
> >> >  qemu_init_end: 76.408950
> >> >  linux_start_kernel: 116.166142 (+39.757192)
> >> >  linux_start_user: 242.954347 (+126.788205)
> >> >
> >> > Average boot time with default "cpu"
> >> >  qemu_init_end: 77.467852
> >> >  linux_start_kernel: 116.688472 (+39.22062)
> >> >  linux_start_user: 363.033365 (+246.344893)
> >>
> >> \o/
> >>
> >> >  2. The other 130ms are a direct result of PCI and ACPI presence
> >> > (tested
> >> >     with a kernel without support for those elements). I'll publish
> >> > some
> >> >     detailed numbers next week.
> >>
> >> Here are the Kata Containers kernel parameters:
> >>
> >> var kernelParams = []Param{
> >>         {"tsc", "reliable"},
> >>         {"no_timer_check", ""},
> >>         {"rcupdate.rcu_expedited", "1"},
> >>         {"i8042.direct", "1"},
> >>         {"i8042.dumbkbd", "1"},
> >>         {"i8042.nopnp", "1"},
> >>         {"i8042.noaux", "1"},
> >>         {"noreplace-smp", ""},
> >>         {"reboot", "k"},
> >>         {"console", "hvc0"},
> >>         {"console", "hvc1"},
> >>         {"iommu", "off"},
> >>         {"cryptomgr.notests", ""},
> >>         {"net.ifnames", "0"},
> >>         {"pci", "lastbus=0"},
> >> }
> >>
> >> pci lastbus=0 looks interesting and so do some of the others :).
> >>
> >
> > yeah, pci=lastbus=0 is very helpful to reduce the boot time in q35,
> > kernel won't scan the 255.. buses :)
>
> I can confirm that adding pci=lastbus=0 makes a significant
> improvement. In fact, is the only option from Kata's kernel parameter
> list that has an impact, probably because the kernel is already quite
> minimalistic.
>
> Average boot time with "-cpu host" and "pci=lastbus=0"
>  qemu_init_end: 73.711569
>  linux_start_kernel: 113.414311 (+39.702742)
>  linux_start_user: 190.949939 (+77.535628)
>
> That's still ~40% slower than microvm, and the breach quickly widens
> when adding more PCI devices (each one adds 10-15ms), but it's certainly
> an improvement over the original numbers.
>
> On the other hand, there isn't much we can do here from QEMU's
> perspective, as this is basically Guest OS tuning.

fw_cfg could expose this information so guest kernels know when to
stop enumerating the PCI bus.  This would make all PCI guests with new
kernels boot ~50 ms faster, regardless of machine type.

The difference between microvm and tuned Q35 is 76 ms now.

microvm:
qemu_init_end: 64.043264
linux_start_kernel: 65.481782 (+1.438518)
linux_start_user: 114.938353 (+49.456571)

Q35 with -cpu host and pci=lasbus=0:
qemu_init_end: 73.711569
linux_start_kernel: 113.414311 (+39.702742)
linux_start_user: 190.949939 (+77.535628)

There is a ~39 ms difference before linux_start_kernel.  SeaBIOS is
loading the PVH Option ROM.

Stefano: any recommendations for profiling or tuning SeaBIOS?

Stefan

