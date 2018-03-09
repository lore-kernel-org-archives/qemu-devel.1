Received: from eggs.gnu.org ([2001:4830:134:3::10]:48230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1euQXc-0006kj-Ks
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1euQXY-0005NU-7t
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:31:08 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1euQXY-0005N7-1S
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:31:04 -0500
Received: by mail-pf0-x242.google.com with SMTP id j20so1856761pfi.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 14:31:03 -0800 (PST)
Date: Fri, 09 Mar 2018 14:31:01 -0800 (PST)
In-Reply-To: <20180309214957.GA32140@flamenco>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-7257de0b-ff7e-455a-86e2-4fee6df5c250@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org
Cc: Michael Clark <mjc@sifive.com>, sorear2@gmail.com, peter.maydell@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org

On Fri, 09 Mar 2018 13:49:57 PST (-0800), cota@braap.org wrote:
> On Fri, Mar 09, 2018 at 11:34:56 +0000, Michael Clark wrote:
> Isn't Cc'ing riscv-patches an obvious use case for using the --cc flag?
> (BTW You can add as many --cc's as you want, and these apply to all patches
> in a series.)

FWIW, that's what I do with my patches.  I generally only add CC lines to the
patches if the address won't be found by the normal means (ie,
scripts/get_maintainer.pl) -- for example, maybe someone helped out a lot with
the patch but hasn't provided a reviewed-by yet.  Everyone else should come out
of the script, which makes it easy to avoid forgetting :).

Of course, that's all for my Linux stuff.  While I haven't really submitted any
QEMU patches, the flow seems very similar to Linux.  The GNU flow is a bit
different, but the git-send-email flow is very similar (without
get_maintainers).
