Received: from eggs.gnu.org ([2001:4830:134:3::10]:45559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fpFyR-00032W-2M
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fpFyM-0003VJ-1l
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:45:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fpFyL-0003Uq-TJ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:45:37 -0400
Date: Mon, 13 Aug 2018 17:45:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180813164533.GF2488@work-vm>
References: <CAEkmjvUix62F8EK9pHboRZOcpycCgMapiqVNM976UVkv-B6u5g@mail.gmail.com>
	<8487b7ec-271c-4ba1-b1f8-539635943603@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8487b7ec-271c-4ba1-b1f8-539635943603@redhat.com>
Subject: Re: [Qemu-devel] RAMBlocks and memory_region_init_ram_nomigrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Frank Yang <lfy@google.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 13/08/2018 18:16, Frank Yang wrote:
> > Hi Paolo,
> > 
> > I see that migration/ram.c saves RAMBlocks associated with memory
> > regions initialized with nomigrate. Is this intended?
> 
> Probably the name and size of the RAMBlocks must match but the contents
> need not (but honestly I haven't looked at the code to find the answer).
>  CCing the qemu mailing list (always a good idea) and a couple people
> that might know.

All the migration code should now be using RAMBLOCK_FOREACH_MIGRATABLE and
qemu_ram_is_migratable whenever it's iterating the ramblock list,
so that *shouldn't* happen these days.
Of course we could have messed it up somewhere; what are you seeing?

Dave
> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
