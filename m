Received: from eggs.gnu.org ([2001:4830:134:3::10]:37160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWrqd-0006KC-Ti
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 18:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dWrqc-0002yY-QU
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 18:17:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dWrqc-0002os-K4
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 18:17:06 -0400
Date: Mon, 17 Jul 2017 00:16:52 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170716221652.noiv6jpa5xzbogpl@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-7-rth@twiddle.net>
	<20170715221412.3yprwf5i3te4gdxa@aurel32.net>
	<65cb9165-42a1-9648-7519-0bd893c1ac13@twiddle.net>
	<20170716151802.cmaz3zhucqlgaq5r@aurel32.net>
	<e19112df-a491-2e34-61a7-3a514622df3e@twiddle.net>
	<20170716214345.n4ehbjkfq454bvwh@aurel32.net>
	<b7bbed7e-143a-1d30-ec14-4a921f534077@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7bbed7e-143a-1d30-ec14-4a921f534077@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 06/27] target/sh4: Handle user-space
 atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: bruno@clisp.org, qemu-devel@nongnu.org, glaubitz@debian.org, laurent@vivier.eu

On 2017-07-16 11:59, Richard Henderson wrote:
> On 07/16/2017 11:43 AM, Aurelien Jarno wrote:
> > Indeed, if the same atomic code is used often it might be better to have
> > it cached. That said it's only true for TB that are recognized, as IIRC
> > TB with the exclusive lock are not cached.
> 
> At the moment they are not.
> 
> But in Emilio's multi-threaded tcg v2 patch set, posted just today, we
> change that by adding a CF_PARALLEL flag to TB->cflags, and incorporating
> that into the tb hash.

Thanks for the hint, I'll have a look. Unfortunately I have one week
backlog on the mailing list...

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
