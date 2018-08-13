Received: from eggs.gnu.org ([2001:4830:134:3::10]:41418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpFjk-0007d5-PE
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpFjk-0005rl-3a
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:30:32 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:47085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpFjj-0005rd-MW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:30:32 -0400
Received: by mail-oi0-x231.google.com with SMTP id y207-v6so28244045oie.13
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 09:30:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8487b7ec-271c-4ba1-b1f8-539635943603@redhat.com>
References: <CAEkmjvUix62F8EK9pHboRZOcpycCgMapiqVNM976UVkv-B6u5g@mail.gmail.com>
	<8487b7ec-271c-4ba1-b1f8-539635943603@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Aug 2018 17:30:10 +0100
Message-ID: <CAFEAcA8r1N=oebGSRMoCB717j-p3nuBT2+D5bG5X9jD7VbNJyw@mail.gmail.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Frank Yang <lfy@google.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 13 August 2018 at 17:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 13/08/2018 18:16, Frank Yang wrote:
>> Hi Paolo,
>>
>> I see that migration/ram.c saves RAMBlocks associated with memory
>> regions initialized with nomigrate. Is this intended?

Which regions, and which version of QEMU? In general for
current-head-of-master this shouldn't happen, unless the
code has subsequently manually registered the ramblock
for migration by calling vmstate_register_ram() itself
at some point after the MR is initialized.

thanks
-- PMM
