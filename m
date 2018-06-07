Received: from eggs.gnu.org ([2001:4830:134:3::10]:41463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1Lc-0002Pp-5n
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fR1LZ-0000IT-0S
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:17:28 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fR1LY-0000Bx-MF
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 16:17:24 -0400
References: <152839776057.447.4308730223123096@d39dc562802a>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b4fe23eb-70a3-3f71-7b53-daca08aba6b4@vivier.eu>
Date: Thu, 7 Jun 2018 22:17:17 +0200
MIME-Version: 1.0
In-Reply-To: <152839776057.447.4308730223123096@d39dc562802a>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/4] linux-user: syscall number fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: famz@redhat.com

Le 07/06/2018 à 20:56, no-reply@patchew.org a écrit :
...
> === OUTPUT BEGIN ===
> Checking PATCH 1/4: linux-user/alpha: Fix epoll syscalls...
> ERROR: code indent should never use tabs
> #22: FILE: linux-user/alpha/syscall_nr.h:346:
> +#define TARGET_NR_epoll_create^I^I407$
> 
> ERROR: code indent should never use tabs
> #23: FILE: linux-user/alpha/syscall_nr.h:347:
> +#define TARGET_NR_epoll_ctl^I^I408$
> 
> ERROR: code indent should never use tabs
> #24: FILE: linux-user/alpha/syscall_nr.h:348:
> +#define TARGET_NR_epoll_wait^I^I409$
> 
> total: 3 errors, 0 warnings, 27 lines checked
...
> ERROR: code indent should never use tabs
> #18: FILE: linux-user/microblaze/syscall_nr.h:366:
> +#define TARGET_NR_accept4^I^I362 /* new */$
> 

If you agree, I will remove tabs when I'll commit the patches for the
pull-request.

Thanks,
Laurent
