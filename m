Received: from eggs.gnu.org ([2001:4830:134:3::10]:47812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyMSV-0003Gd-Hf
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyMSU-0004PB-Sw
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:58:07 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyMSU-0004P4-NY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:58:06 -0400
Received: by mail-oi0-x242.google.com with SMTP id c3-v6so2267879oib.5
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:58:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tvtawpk2.wl-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-11-lukeshu@lukeshu.com>
	<CAFEAcA9joyBcXSOqDu=hWRUZPKA1wEKMpYhRr5+p0YCKQOs5Kw@mail.gmail.com>
	<87tvtawpk2.wl-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 18:57:45 +0000
Message-ID: <CAFEAcA_wdnmOSb1VKfnj3QGzSEZZiSb65YD9G7Vc1mbcE2p80g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/10] linux-user: init_guest_space: Try to
 make ARM space+commpage continuous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Paul Brook <paul@codesourcery.com>

On 20 March 2018 at 18:49, Luke Shumaker <lukeshu@lukeshu.com> wrote:
> On Fri, 02 Mar 2018 09:13:12 -0500,
> Peter Maydell wrote:
>> On 28 December 2017 at 18:08, Luke Shumaker <lukeshu@lukeshu.com> wrote:
>> > +        guest_full_size =
>> > +            (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;
>                         ^
>> I think this is probably more clearly written as 0x100000000ULL,
>> since rounding down to the host-page-size then adding the host-page-size
>> gets us the full 32-bit size of the guest address space.
>
> Wait, is that right?  Isn't that only true if qemu_host_page_size is
> at least 8KiB (16 bits), enough to fill the zero in the middle?  Won't
> a typical qemu_host_page_size be only 4KiB?

Yeah, I just got the arithmetic wrong here because I had it
stuck in my head that the commpage was the top page of the
guest address space.

-- PMM
