Received: from eggs.gnu.org ([2001:4830:134:3::10]:36165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csoHo-00007g-Ut
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csoHo-0001Nr-4z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:23:36 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csoHn-0001NY-UV
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:23:36 -0400
Received: by mail-wr0-x234.google.com with SMTP id l43so97042933wre.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 03:23:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1b4e550d-2a0a-e155-c78e-d6fd0a87cc08@physik.fu-berlin.de>
References: <CAFEAcA-t7xRo-2CkipmYKE_vUxp8oUBML8ss7G8U_pVhM79H6w@mail.gmail.com>
	<1b4e550d-2a0a-e155-c78e-d6fd0a87cc08@physik.fu-berlin.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 11:23:14 +0100
Message-ID: <CAFEAcA82odNuxkA+QtYbm=3h+j9SZmMbWHiKrmU1bDbbM17KkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] packed structures and unaligned accesses (sparc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Knut Omang <knut.omang@oracle.com>

On 28 March 2017 at 11:19, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 03/27/2017 07:34 PM, Peter Maydell wrote:
>> That all makes sense in isolation, but shouldn't something have
>> at least warned that "&h.size" isn't actually a uint32_t* in
>> the sense of being something you can validly pass to a
>> function that takes a uint32_t* ?
>
> It turns out that clang actually emits a warning in this case:
>
> root@deb4g:~# clang-4.0 packed.c -o packed
> packed.c:18:18: warning: taking address of packed member 'size' of class or structure 'hdr' may result in an unaligned pointer value
>       [-Waddress-of-packed-member]
>   return getval(&h.size);
>                  ^~~~~~
> 1 warning generated.
> root@deb4g:~#

Ah, good. (Unfortunately my clang isn't new enough for that,
being 3.8.)

thanks
-- PMM
