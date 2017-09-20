Received: from eggs.gnu.org ([2001:4830:134:3::10]:37090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1duk8e-0007J5-2s
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1duk8b-0003uv-01
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:54:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:62389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1duk8a-0003p0-Mb
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:54:20 -0400
References: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
	<20170919230643.87425-1-carenas@gmail.com>
	<20170919230643.87425-2-carenas@gmail.com>
	<d8115e2d-7409-c6ea-3c8d-3aead5b5fa87@vivier.eu>
	<CAPUEspjdyJ8_cwGPZFOAKs3NE83kdwXV-Ji6TTFYJf7MFQxvBg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <46de309a-ae79-e15c-6f34-c9b8cf458d6b@vivier.eu>
Date: Wed, 20 Sep 2017 20:53:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAPUEspjdyJ8_cwGPZFOAKs3NE83kdwXV-Ji6TTFYJf7MFQxvBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] linux-user: add SO_LINGER to setsockopt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carlo Arenas <carenas@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, gang.chen.5i5j@gmail.com, riku.voipio@iki.fi, rth@twiddle.net

Le 20/09/2017 à 19:29, Carlo Arenas a écrit :
> On Wed, Sep 20, 2017 at 1:39 AM, Laurent Vivier <laurent@vivier.eu
> <mailto:laurent@vivier.eu>> wrote:
> 
>     Why did you remove "optname = SO_LINGER" and "if (optlen !=
>     sizeof(struct target_linger))"?
> 
> 
> the optname assignment is not really needed, since it is only used for
> the setsockopt call and that call is clearer using SO_LINGER directly,
> so to avoid hard to see bugs like :
> 
>   http://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg00980.html 

Okay

> the test for optlen is replaced by passing optlen to the underlying
> setsockopt call directly, who would do the test and return the right error.

You can't do that, because sizeof(struct linger) may be different from
sizeof(struct target_linger).

> as an interesting note, I noticed when testing (in ubuntu artful x86_64)
> that regardless of how you interpret the documentation, setsockopt won't
> fail just because the len is smaller than the size of the struct, and

Right, see:

http://elixir.free-electrons.com/linux/latest/source/net/core/sock.c#L830

> therefore that code was not equivalent to the setsockopt it was trying
> to emulate, and therefore this change doesn't only make the code simpler
> but also more correct IMHO
Next time add a revision history in your series explaining your changes
(and don't reply to the previous patch series for the new series, it's
better to start a new email thread).

Thanks,
Laurent
