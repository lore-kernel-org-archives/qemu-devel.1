Received: from eggs.gnu.org ([2001:4830:134:3::10]:44589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1fpK3S-0007Zn-1g
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 17:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1fpK3R-0008EG-1F
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 17:07:10 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:39022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lfy@google.com>) id 1fpK3Q-0008E4-R7
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 17:07:08 -0400
Received: by mail-qt0-x22d.google.com with SMTP id q12-v6so19030407qtp.6
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 14:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEkmjvUix62F8EK9pHboRZOcpycCgMapiqVNM976UVkv-B6u5g@mail.gmail.com>
	<8487b7ec-271c-4ba1-b1f8-539635943603@redhat.com>
	<20180813164533.GF2488@work-vm>
In-Reply-To: <20180813164533.GF2488@work-vm>
From: Frank Yang <lfy@google.com>
Date: Mon, 13 Aug 2018 14:06:56 -0700
Message-ID: <CAEkmjvVJEMgVX5pTFt-O3b9s6DwUOBPGj4-F2VB8R6P=EXpqYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] RAMBlocks and memory_region_init_ram_nomigrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, peter.maydell@linaro.org, qemu-devel <qemu-devel@nongnu.org>

Ah got it, thanks for the replies / info!

We're using a modified QEMU 2.12, and I don't see the migratable-only loops
and field, so it either got missed in the rebase or was added after 2.12.

Frank

On Mon, Aug 13, 2018 at 9:45 AM Dr. David Alan Gilbert <dgilbert@redhat.com>
wrote:

> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> > On 13/08/2018 18:16, Frank Yang wrote:
> > > Hi Paolo,
> > >
> > > I see that migration/ram.c saves RAMBlocks associated with memory
> > > regions initialized with nomigrate. Is this intended?
> >
> > Probably the name and size of the RAMBlocks must match but the contents
> > need not (but honestly I haven't looked at the code to find the answer).
> >  CCing the qemu mailing list (always a good idea) and a couple people
> > that might know.
>
> All the migration code should now be using RAMBLOCK_FOREACH_MIGRATABLE and
> qemu_ram_is_migratable whenever it's iterating the ramblock list,
> so that *shouldn't* happen these days.
> Of course we could have messed it up somewhere; what are you seeing?
>
> Dave
> > Paolo
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
