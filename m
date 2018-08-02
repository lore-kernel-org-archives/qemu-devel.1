Received: from eggs.gnu.org ([2001:4830:134:3::10]:44327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1flKpI-0006yP-1C
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 17:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1flKpC-0006kq-SL
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 17:08:01 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1flKpC-0006kg-L8
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 17:07:58 -0400
Received: by mail-pf1-x441.google.com with SMTP id e13-v6so2003669pff.7
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 14:07:58 -0700 (PDT)
Date: Thu, 02 Aug 2018 14:07:56 -0700 (PDT)
In-Reply-To: <CAKmqyKNmBeY0BZNuQ3o+XTzdtN6QCm8qPhi1VHz4XTNg=Q3=Ng@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-7a78b931-d225-4006-bbc7-707c9d471ef0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] RISC-V platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com, programmingkidx@gmail.com
Cc: alistair.francis@wdc.com, qemu-devel@nongnu.org

On Fri, 29 Jun 2018 14:20:34 PDT (-0700), alistair23@gmail.com wrote:
> On Fri, Jun 29, 2018 at 2:05 PM, G 3 <programmingkidx@gmail.com> wrote:
>> Hi, I noticed your RISC-V patches on the mailing list and had a question
>> that I think you may be able to answer. Has anyone defined a RISC-V platform
>> yet? What I mean is defining what devices would be found on a RISC-V
>> motherboard. I do hope to see RISC-V based desktop systems one day. But
>> before that day can come the platform for this chip would have to be
>> established. Could the SiFive board be the basis for such a standard?
>
> It really depends what you mean by a standard platform. At the moment
> the SiFive HiFive Unleased board is the only ASIC that can boot Linux.
> So that really is the "standard" RISC-V board. It is a pretty basic
> embedded board though, so it can't be considered a "standard" RISC-V
> desktop. There is a virt board in QEMU (which is similar to the HiFive
> Unleashed) that is a good go to for QEMU work.

The HiFive Unleashed is the defacto standard RISC-V embedded Linux platform 
right now, but there will be a RISC-V platform specification that defines 
proper standard platforms of various types.  This effort hasn't been started 
yet, but it should be done sooner rather than later.
