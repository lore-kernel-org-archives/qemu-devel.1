Received: from eggs.gnu.org ([2001:4830:134:3::10]:40827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpFgg-0005N8-Jc
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpFgd-0004xc-E4
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:27:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpFgd-0004xS-6n
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:27:19 -0400
References: <CAEkmjvUix62F8EK9pHboRZOcpycCgMapiqVNM976UVkv-B6u5g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8487b7ec-271c-4ba1-b1f8-539635943603@redhat.com>
Date: Mon, 13 Aug 2018 18:27:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAEkmjvUix62F8EK9pHboRZOcpycCgMapiqVNM976UVkv-B6u5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] RAMBlocks and memory_region_init_ram_nomigrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frank Yang <lfy@google.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 13/08/2018 18:16, Frank Yang wrote:
> Hi Paolo,
> 
> I see that migration/ram.c saves RAMBlocks associated with memory
> regions initialized with nomigrate. Is this intended?

Probably the name and size of the RAMBlocks must match but the contents
need not (but honestly I haven't looked at the code to find the answer).
 CCing the qemu mailing list (always a good idea) and a couple people
that might know.

Paolo
