Received: from eggs.gnu.org ([2001:4830:134:3::10]:36865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gExKt-0007pM-5L
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 10:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gExKn-0007y9-9X
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 10:07:07 -0400
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:58398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1gExKm-0007dG-H9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 10:07:01 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w9NE4Brd010635
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 10:06:52 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 9659F80
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 10:06:52 -0400 (EDT)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id 810E682
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 10:06:52 -0400 (EDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
	[209.85.208.72])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w9NE6pCH032715
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 10:06:52 -0400
Received: by mail-ed1-f72.google.com with SMTP id y23-v6so1006670eds.12
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 07:06:52 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com.
	[209.85.128.41]) by smtp.gmail.com with ESMTPSA id
	j22-v6sm719189edh.47.2018.10.23.07.06.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Oct 2018 07:06:49 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id i8-v6so1932724wmg.0
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 07:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHyh4xiVxNOxwWeKDw2ccAURx3zRMTd+nVLD=oav6ShqCBdjXw@mail.gmail.com>
	<20181022092710.GH32717@xz-x1>
	<CAHyh4xgOkoPokm5GQSH8dBDRrB-o1_MLhO8SnWK71VahUL8f+w@mail.gmail.com>
	<20181023132505.GJ32717@xz-x1>
In-Reply-To: <20181023132505.GJ32717@xz-x1>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Tue, 23 Oct 2018 10:06:36 -0400
Message-ID: <CAHyh4xiqe2069UBQ2bgrCxvNTDsK0AYLRdAoC8qj9kCCioCB6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Virtual IOMMU is working for Windows VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, lprosek@redhat.com

On Tue, Oct 23, 2018 at 9:25 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 22, 2018 at 10:43:32AM -0400, Jintack Lim wrote:
> > On Mon, Oct 22, 2018 at 5:27 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Mon, Oct 22, 2018 at 12:22:02AM -0400, Jintack Lim wrote:
> > > > Hi,
> > > >
> > > > I wonder if vIOMMU is working for Windows VM?
> > > >
> > > > I tried it with v2.11.0, but it didn't seem to work. I assume that seaBIOS
> > > > sets IOMMU on by default as is the case when I launched a Linux VM. But I
> > > > might be missing something. Can somebody shed some light on it?
> > >
> > > Hi, Jintack,
> > >
> >
> > Thanks Peter,
> >
> > > I think at least the latest QEMU should work for Windows, but I don't
> > > really run Windows that frequently.
> > >
> > > What is the error you've encountered?  Have you tried the latest QEMU,
> > > or switching Windows versions to try?
> >
> > I ran Windows commands in Windows Powershell like below. Well, I guess
> > this is not the best way to check IOMMU presence, but couldn't find a
> > better way to do it.
> >
> > $ (Get-VMHost).IovSupport
> > false
> > $ (Get-VMHost).IovSupportReasons
> > The chipset on the system does not do DMA remapping, ...
> >
> > I just tried QEMU v3.0.0, but I see the same symptom. I'm using
> > Windows server 2016.  Unfortunately, trying another Windows version
> > would be hard for me at this point.
> >
> > I just wonder if there's way to check if Vt-d is on in SeaBIOS?
>
> I'm not sure whether SeaBIOS would enable VT-d or has any kind of
> support of it at all even if the translation unit is provided.
>

All right. I then assume the BIOS doesn't disable it as is the case
for Linux guest.

> >
> > >
> > > What I can remember about Windows is that Ladi had fixed a bug for
> > > windows-only (8991c460be, "intel_iommu: relax iq tail check on
> > > VTD_GCMD_QIE enable", 2017-07-03) but it should be even in 2.10 so I
> > > guess it's not the problem you've encountered.
> >
> > I'm CCing Ladi, just in case he has some idea :)
>
> Good idea, though I'm afraid the RH email could be stall though. :)

Ah.. :)

>
> I can try to install one Windows Server 2016 some day but I cannot
> really guarantee.  Feel free to try to debug it on your own :).
> Basically I would consider to enable the IOMMU traces in intel_iommu.c
> just like what you have done before when with the vfio-pci devices and
> check out the log.  Normally we should see plenty of MMIOs to setup
> the device and hopefully that would provide hint on what's wrong there.

Thanks. I will. Now that Linux guest can recognize vIOMMU well, hope I
can spot where things go wrong with Window guest hopefully!

Best,
Jintack

>
> Regards,
>
> --
> Peter Xu
>
