Received: from eggs.gnu.org ([2001:4830:134:3::10]:52692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYuIV-0006Xs-G8
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYuIR-0006xB-GQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:22:51 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYuIR-0006tM-52
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:22:47 -0400
References: <20180625111935.26108-1-alex.bennee@linaro.org>
	<20180625111935.26108-10-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a4292b7c-cc74-f593-246e-64d1a482ab3c@vivier.eu>
Date: Fri, 29 Jun 2018 16:22:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180625111935.26108-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 09/10] linux-user: introduce
 preexit_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 25/06/2018 à 13:19, Alex Bennée a écrit :
> To avoid repeating ourselves move our preexit clean-up code into a
> helper function. I figured the continuing effort to split of the
> syscalls made it worthwhile creating a new file for it now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/Makefile.objs |  2 +-
>  linux-user/exit.c        | 28 ++++++++++++++++++++++++++++
>  linux-user/qemu.h        |  8 ++++++++
>  linux-user/syscall.c     | 10 ++--------
>  4 files changed, 39 insertions(+), 9 deletions(-)
>  create mode 100644 linux-user/exit.c

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
