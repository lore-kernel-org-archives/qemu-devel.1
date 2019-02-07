Received: from eggs.gnu.org ([209.51.188.92]:45252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grjK0-0007WK-D4
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grjJs-0006k3-Tu
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:02:27 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:49387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1grjJs-0006jY-Fr
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:02:20 -0500
References: <154953942151.29184.7694211057153536439@ebba9967afc0>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <211054d1-50ff-f5db-b235-2bd8fb33894b@vivier.eu>
Date: Thu, 7 Feb 2019 14:01:55 +0100
MIME-Version: 1.0
In-Reply-To: <154953942151.29184.7694211057153536439@ebba9967afc0>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/3] Linux user for 4.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, riku.voipio@iki.fi, Peter Maydell <peter.maydell@linaro.org>

I'm going to resend an updated series.

Thanks,
Laurent

On 07/02/2019 12:37, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190207105347.22337-1-laurent@vivier.eu/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PULL 0/3] Linux user for 4.0 patches
> Type: series
> Message-id: 20190207105347.22337-1-laurent@vivier.eu
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  t [tag update]            patchew/20190206181725.14337-1-armbru@redhat.com -> patchew/20190206181725.14337-1-armbru@redhat.com
>  * [new tag]               patchew/20190207105347.22337-1-laurent@vivier.eu -> patchew/20190207105347.22337-1-laurent@vivier.eu
> Switched to a new branch 'test'
> 11efd0b554 linux-user: add new netlink types
> a7c0a6a696 linux-user: Check sscanf return value in open_net_route()
> e1edb0bc04 Fix linux-user crashes in ioctl(SIOCGIFCONF) when ifc_buf is NULL.
> 
> === OUTPUT BEGIN ===
> 1/3 Checking commit e1edb0bc04af (Fix linux-user crashes in ioctl(SIOCGIFCONF) when ifc_buf is NULL.)
> WARNING: Block comments use a leading /* on a separate line
> #48: FILE: linux-user/syscall.c:4200:
> +            /* We can't fit all the extents into the fixed size buffer.
> 
> ERROR: "(foo*)" should be "(foo *)"
> #62: FILE: linux-user/syscall.c:4210:
> +        host_ifc_buf = (char*)host_ifconf + sizeof(*host_ifconf);
> 
> total: 1 errors, 1 warnings, 73 lines checked
> 
> Patch 1/3 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 2/3 Checking commit a7c0a6a696f8 (linux-user: Check sscanf return value in open_net_route())
> 3/3 Checking commit 11efd0b55422 (linux-user: add new netlink types)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20190207105347.22337-1-laurent@vivier.eu/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 
