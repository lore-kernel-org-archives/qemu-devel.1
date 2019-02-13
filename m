Received: from eggs.gnu.org ([209.51.188.92]:56457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gtusR-0002dR-DO
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gtusQ-0000gk-QT
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:47:03 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:46039)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gtusQ-0000f8-Dq
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:47:02 -0500
From: Laurent Vivier <laurent@vivier.eu>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
	<20190118213122.22865-48-richard.henderson@linaro.org>
	<86bae9b3-75c8-64df-92d1-b4efc35b646c@vivier.eu>
Message-ID: <c1dc5dbc-cbc7-16a3-9d14-c93b52c362fd@vivier.eu>
Date: Wed, 13 Feb 2019 14:46:59 +0100
MIME-Version: 1.0
In-Reply-To: <86bae9b3-75c8-64df-92d1-b4efc35b646c@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 48/49] linux-user: Split out ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 13/02/2019 14:09, Laurent Vivier wrote:
> Hi,
> 
> this one is really a cut'n'paste but it introduces a problem with 
> qemu-alpha, I don't know how/why:
> 
>   $ sudo unshare --ipc --uts --pid --fork --kill-child --mount chroot chroot/alpha/sid/
>   Unsupported ioctl: cmd=0x80047476
> 
> And then it hangs.
> 
> I'll try to debug.

In fact it happens with sid, with ppc64 too, but not with m68k and sh4.

And only with "unshare --pid --fork".

Without "unshare", the result is:

  Unsupported ioctl: cmd=0x80047476
  bash: cannot set terminal process group (11507): Function not implemented
  bash: no job control in this shell
  Unsupported ioctl: cmd=0x80087467
  Unsupported ioctl: cmd=0x80087467
  Unsupported ioctl: cmd=0x802c7415

Thanks,
Laurent
