Received: from eggs.gnu.org ([2001:4830:134:3::10]:48303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcaJO-0003Nj-T5
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcaJL-0001W6-P8
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:50:58 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fcaJL-0001Vp-IU
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:50:55 -0400
Received: by mail-pl0-x241.google.com with SMTP id s24-v6so6367817plq.6
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 10:50:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180709155826.18993-1-peter.maydell@linaro.org>
	<c2311584-618a-b880-d42a-637a9333702a@linaro.org>
	<CAFEAcA9g3NCcodB8H3m5MsCL=JD56HO6D-utLyUKvY_Nwv-0Jg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a7caddb3-038e-a97c-26db-13a7ad05576e@twiddle.net>
Date: Mon, 9 Jul 2018 10:50:51 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9g3NCcodB8H3m5MsCL=JD56HO6D-utLyUKvY_Nwv-0Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] exec.c: Replace
 memory_region_is_unassigned() with memory_region_is_ram_backed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 07/09/2018 10:33 AM, Peter Maydell wrote:
>> Well... ok.  We should document that this, surprisingly, does not include
>> actual ram.  Just things that are ram with caveats.
> 
> I think it must include actual RAM, or we would not be able to
> execute from actual RAM ? The only way to get to get_page_addr_code()'s
> "here's the ram_addr_t for this" exit path is if memory_region_is_unassigned()
> returns false.
> 
>>> -    return mr != &io_mem_rom && mr != &io_mem_notdirty && !mr->rom_device
>>> -        && mr != &io_mem_watch;

Huh.  I don't follow how this old expression excludes ram,
and so assumed that must be checked separately earlier.

There's clearly still something here I don't understand.


r~
