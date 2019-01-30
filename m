Received: from eggs.gnu.org ([209.51.188.92]:54844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1goutk-0007Ib-01
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1goutd-0003Lz-O0
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:47:40 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:42022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1goutU-0003BY-9y
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:47:33 -0500
Received: by mail-pf1-x436.google.com with SMTP id 64so218526pfr.9
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 10:47:14 -0800 (PST)
Date: Wed, 30 Jan 2019 10:47:12 -0800 (PST)
In-Reply-To: <603b6279-8670-d614-e1ac-4c13bf870ec9@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-1940b8f6-61f9-4fce-b1fc-b97158239424@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/35] target/riscv: Convert to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, sagark@eecs.berkeley.edu

On Wed, 30 Jan 2019 01:08:33 PST (-0800), Bastian Koppelmann wrote:
> Hi Palmer,
>
> On 1/29/19 8:22 PM, Palmer Dabbelt wrote:
>> [..]
>> Well, that pretty much exhausts my testing scheme :).  I think
>> Alistair might have a setup for booting a 32-bit Yocto-based distro in
>> QEMU.  Assuming he has the flow set up and it boots then I don't see
>> any reason not to merge it.
>>
>> Thanks for pulling this all together, it's really great to have a
>> cleaner decoder!
>>
>> Alistair: if that's true, can you give this a shot?
>>
>> Bastian: do you mind collecting the relevant tags (Reviwed-by, etc)
>> and putting them in a v6?
>
>
> I already did (see
> http://lists.gnu.org/archive/html/qemu-riscv/2019-01/msg00147.html) :)

Sorry, my mail latency got a bit high.  So I'm good here, just pending any 
other testing we might have floating around.  I just sent up a PR with a 
handful of little things so we can avoid mixing too much stuff together, but I 
don't see any reason not to include this in the next round.

Thanks!
