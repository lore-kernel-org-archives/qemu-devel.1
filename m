Received: from eggs.gnu.org ([2001:4830:134:3::10]:45856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPdv1-0003rH-2t
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPduy-0006bS-0M
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:04:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:32775)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPdux-0006bF-MO
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:04:15 -0400
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
Date: Mon, 4 Jun 2018 03:04:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180531224911.23725-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to
 implement interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, evgreen@chromium.org

On 01/06/2018 00:49, Richard Henderson wrote:
> If the interp_prefix is a complete chroot, it may have a *lot* of files.
> Setting up the cache for this is quite expensive.
> 
> For the most part, we can use the *at versions of various syscalls to
> attempt the operation in the prefix.  For the few cases that remain,
> attempt the operation in the prefix via concatenation and then retry
> if that fails.
> 

I like the idea, but it breaks real chroot.

You can test it with:

wget
https://github.com/vivier/linux-user-test-scrips/raw/master/create_chroot.sh

then

sudo sh ./create_chroot.sh /path/to/static/qemu-s390x stretch

It fails with:

Reading package lists... Done
E: Method /usr/lib/apt/methods/http did not start correctly
E: Failed to fetch http://ftp.us.debian.org/debian/dists/stretch/InRelease
E: Some index files failed to download. They have been ignored, or old
ones used instead.
stretch s390x FAILED


Thanks,
Laurent
