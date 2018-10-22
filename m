Received: from eggs.gnu.org ([2001:4830:134:3::10]:55297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gEbQr-00031e-R8
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gEbQn-0002vs-Qq
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:43:49 -0400
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:37222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1gEbQn-0002v0-IO
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 10:43:45 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w9MEhEik023603
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 10:43:44 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 983336D
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 10:43:44 -0400 (EDT)
Received: from sendprodmail04.cc.columbia.edu (sendprodmail04.cc.columbia.edu
	[128.59.72.16]) by hazelnut (Postfix) with ESMTP id 78C7080
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 10:43:44 -0400 (EDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
	[209.85.208.71])
	by sendprodmail04.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w9MEhhE9035269
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 10:43:44 -0400
Received: by mail-ed1-f71.google.com with SMTP id h24-v6so24732797eda.10
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 07:43:44 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com.
	[209.85.128.42]) by smtp.gmail.com with ESMTPSA id
	gy12-v6sm6820379ejb.32.2018.10.22.07.43.41
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 Oct 2018 07:43:41 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id y144-v6so10611176wmd.4
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 07:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHyh4xiVxNOxwWeKDw2ccAURx3zRMTd+nVLD=oav6ShqCBdjXw@mail.gmail.com>
	<20181022092710.GH32717@xz-x1>
In-Reply-To: <20181022092710.GH32717@xz-x1>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Mon, 22 Oct 2018 10:43:32 -0400
Message-ID: <CAHyh4xgOkoPokm5GQSH8dBDRrB-o1_MLhO8SnWK71VahUL8f+w@mail.gmail.com>
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

On Mon, Oct 22, 2018 at 5:27 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 22, 2018 at 12:22:02AM -0400, Jintack Lim wrote:
> > Hi,
> >
> > I wonder if vIOMMU is working for Windows VM?
> >
> > I tried it with v2.11.0, but it didn't seem to work. I assume that seaBIOS
> > sets IOMMU on by default as is the case when I launched a Linux VM. But I
> > might be missing something. Can somebody shed some light on it?
>
> Hi, Jintack,
>

Thanks Peter,

> I think at least the latest QEMU should work for Windows, but I don't
> really run Windows that frequently.
>
> What is the error you've encountered?  Have you tried the latest QEMU,
> or switching Windows versions to try?

I ran Windows commands in Windows Powershell like below. Well, I guess
this is not the best way to check IOMMU presence, but couldn't find a
better way to do it.

$ (Get-VMHost).IovSupport
false
$ (Get-VMHost).IovSupportReasons
The chipset on the system does not do DMA remapping, ...

I just tried QEMU v3.0.0, but I see the same symptom. I'm using
Windows server 2016.  Unfortunately, trying another Windows version
would be hard for me at this point.

I just wonder if there's way to check if Vt-d is on in SeaBIOS?

>
> What I can remember about Windows is that Ladi had fixed a bug for
> windows-only (8991c460be, "intel_iommu: relax iq tail check on
> VTD_GCMD_QIE enable", 2017-07-03) but it should be even in 2.10 so I
> guess it's not the problem you've encountered.

I'm CCing Ladi, just in case he has some idea :)

Thanks,
Jintack

>
> Regards,
>
> --
> Peter Xu
>
