Received: from eggs.gnu.org ([209.51.188.92]:54565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1gmiJ6-00055s-Lx
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1gmiJ4-0007mg-Fc
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:56:48 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lfy@google.com>) id 1gmiJ4-0007jt-4E
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:56:46 -0500
Received: by mail-ot1-x343.google.com with SMTP id a11so5819403otr.10
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 08:56:45 -0800 (PST)
MIME-Version: 1.0
References: <1521039163-138-1-git-send-email-juterry@microsoft.com>
	<00e8dbed-6ada-d023-46b9-89881fcbfb1f@weilnetz.de>
In-Reply-To: <00e8dbed-6ada-d023-46b9-89881fcbfb1f@weilnetz.de>
From: Frank Yang <lfy@google.com>
Date: Thu, 24 Jan 2019 08:56:33 -0800
Message-ID: <CAEkmjvWcuME6gzQGZ3sEvH16r_aPcru5K5hjcA3AT_=W2+N22w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] WHPX introduce changes for Windows
 Insider SDK 17110
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: "Justin Terry (VM)" <juterry@microsoft.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, ehabkost@redhat.com, rth@twiddle.net

Is this useful at all for the Android Emulator? Does it break backward
compatibility for older Windows versions?

On Thu, Jan 17, 2019 at 12:39 PM Stefan Weil <sw@weilnetz.de> wrote:

> Am 14.03.2018 um 15:52 schrieb Justin Terry (VM) via Qemu-devel:
> > This change set fixes two breaking changes that were introduced in the
> > Windows Insider SDK 17110. First, a change to the WHvGetCapability
> function
> > decl to include the 'out' WrittenSizeInBytes. Second, changes to the
> > WHvSetPartitionProperty function decl and WHV_PARTITION_PROPERTY
> structure
> > to directly pass the PropertyCode at invocation.
> >
> > Lastly, it introduces a major performance improvement in
> whpx_vcpu_post_run
> > using the VpContext exit structure rather than another round trip call to
> > WHvGetVirtualProcessorRegisters to synchronize vp state.
> >
> > QEMU compiled against this SDK (17110+) is expected to work on all
> Windows
> > Insider Builds (17115+).
> >
> > Thanks,
> > Justin Terry
>
>
> Hi Justin,
>
> as far as I know it still not possible to cross build a legal QEMU for
> Windows on a Linux machine due to the license limitations of the SDK
> which is needed. The header files needed for the QEMU build are "All
> rights reserved".
>
> People often ask me to add WHPX support to the QEMU installer for
> Windows, but I have to tell them that I cannot do that currently.
>
> This problem could be solved if the necessary header files were added to
> QEMU with a permissive license by someone who has the rights to do so.
>
> Could you add WinHvEmulation.h and WinHvPlatform.h or am I allowed to
> make such files from the documentation at https://docs.microsoft.com/?
>
> Thanks,
> Stefan Weil
>
>
